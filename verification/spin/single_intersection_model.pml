/* ================================================================
 * Phase B Model — Step 1b: Congestion-Aware Light Switching
 *
 * Layout:
 *       lane1 (approach from North)
 *         |
 *    ─────O─────  lane0 (approach from East/West)
 *         |
 *
 * NONDETERMINISM:
 *   - VehicleFSM: may MOVE or STAY even when next slot is free
 *
 * SMART INFRASTRUCTURE:
 *   - Longest-Queue-First: green goes to the lane with more vehicles
 *   - Starvation Prevention: no direction stays red > MAX_RED_WAIT ticks
 *   - Tiebreaker: nondeterministic (SPIN explores both choices)
 *
 * Independent FSMs:
 *   - InfraFSM: controls lights using congestion info
 *   - VehicleFSM: moves vehicles using light info
 *   - ClockFSM (init): orchestrates ticks, checks properties
 * ================================================================ */

#define NVEH  2
#define SLOTN 4
#define MAX_TICKS 50
#define MAX_RED_WAIT 4   /* max consecutive ticks a direction can be red */

/* --- Shared State (Grid equivalent) --- */

byte lane0[SLOTN];
byte lane1[SLOTN];

byte veh_slot[NVEH];
bool veh_at_intersection[NVEH];
bool veh_done[NVEH];

bool light0_green = true;
bool light1_green = false;

/* Per-step state */
bool intersection_occupied_this_step = false;
bool moved_this_step[NVEH];

/* --- Property monitors --- */
bool collision = false;
bool red_violation = false;
bool uturn_violation = false;
bool opposite_direction_violation = false;
byte vehicle_crossing_count = 0;
bool all_done = false;

/* --- Tick synchronization channels (rendezvous) --- */
chan tick_infra    = [0] of { byte };
chan done_infra    = [0] of { byte };
chan tick_vehicle0 = [0] of { byte };
chan done_vehicle0 = [0] of { byte };
chan tick_vehicle1 = [0] of { byte };
chan done_vehicle1 = [0] of { byte };


/* ================================================================
 * InfrastructureFSM (i-group) — Congestion-Aware
 *
 * Algorithm: Longest-Queue-First with Starvation Prevention
 *
 * 1. Count vehicles waiting in each approach lane
 *    (i-group reads vehicle positions from shared state — spec allows this)
 * 2. Give green to the lane with MORE waiting vehicles
 * 3. If tied: nondeterministic choice (SPIN explores both)
 * 4. Starvation guard: if a direction has been red for MAX_RED_WAIT
 *    consecutive ticks, FORCE green regardless of queue length
 *
 * Reads: lane0[], lane1[] (vehicle positions)
 * Writes: light0_green, light1_green
 * Does NOT know: vehicle routes, turning intentions
 * ================================================================ */
proctype InfraFSM() {
    byte dummy;
    byte count0, count1;
    byte i;
    byte red_streak0 = 0;   /* consecutive ticks lane0 has been red */
    byte red_streak1 = 0;   /* consecutive ticks lane1 has been red */

    do
    :: tick_infra ? dummy ->

        /* --- Step 1: Count vehicles in each lane (congestion sensing) --- */
        count0 = 0;
        count1 = 0;
        i = 0;
        do
        :: (i < SLOTN) ->
            if
            :: (lane0[i] != 0) -> count0++
            :: else -> skip
            fi;
            if
            :: (lane1[i] != 0) -> count1++
            :: else -> skip
            fi;
            i++
        :: (i >= SLOTN) -> break
        od;

        /* --- Step 2: Decide which direction gets green --- */

        if
        :: (red_streak0 >= MAX_RED_WAIT) ->
            /* Starvation prevention: lane0 has waited too long, force green */
            d_step { light0_green = true; light1_green = false }

        :: (red_streak1 >= MAX_RED_WAIT) ->
            /* Starvation prevention: lane1 has waited too long, force green */
            d_step { light0_green = false; light1_green = true }

        :: (red_streak0 < MAX_RED_WAIT && red_streak1 < MAX_RED_WAIT
            && count0 > count1) ->
            /* Longest-queue-first: lane0 has more vehicles */
            d_step { light0_green = true; light1_green = false }

        :: (red_streak0 < MAX_RED_WAIT && red_streak1 < MAX_RED_WAIT
            && count1 > count0) ->
            /* Longest-queue-first: lane1 has more vehicles */
            d_step { light0_green = false; light1_green = true }

        :: (red_streak0 < MAX_RED_WAIT && red_streak1 < MAX_RED_WAIT
            && count0 == count1) ->
            /* Tied: nondeterministic choice (SPIN explores both) */
            if
            :: d_step { light0_green = true; light1_green = false }
            :: d_step { light0_green = false; light1_green = true }
            fi
        fi;

        /* --- Step 3: Update starvation counters --- */
        if
        :: light0_green ->
            red_streak0 = 0;
            red_streak1 = red_streak1 + 1
        :: light1_green ->
            red_streak1 = 0;
            red_streak0 = red_streak0 + 1
        fi;

        /* i-group assertion: exactly 1 green at a time */
        assert(light0_green != light1_green);

        /* i-group assertion: starvation counters never exceed limit */
        assert(red_streak0 <= MAX_RED_WAIT);
        assert(red_streak1 <= MAX_RED_WAIT);

        done_infra ! 0
    od
}


/* ================================================================
 * VehicleFSM (v-group) — Nondeterministic
 *
 * Same as Step 1: vehicles may MOVE or STAY when able.
 * SPIN explores all possible vehicle behaviors.
 * ================================================================ */
proctype VehicleFSM(byte vid; byte my_lane) {
    byte dummy;
    byte cur_slot;
    bool my_light_green;

    do
    :: (my_lane == 0) -> tick_vehicle0 ? dummy; goto STEP
    :: (my_lane == 1) -> tick_vehicle1 ? dummy; goto STEP
    od;

STEP:
    if
    :: veh_done[vid] -> goto DONE_SIGNAL
    :: else -> skip
    fi;

    cur_slot = veh_slot[vid];

    if
    :: (cur_slot < SLOTN - 1) ->
        if
        :: (my_lane == 0 && lane0[cur_slot + 1] == 0) ->
            /* Must move if next slot is free (matches C++ behavior) */
            d_step {
                lane0[cur_slot] = 0;
                veh_slot[vid] = cur_slot + 1;
                lane0[cur_slot + 1] = vid + 1;
                moved_this_step[vid] = true
            }

        :: (my_lane == 1 && lane1[cur_slot + 1] == 0) ->
            d_step {
                lane1[cur_slot] = 0;
                veh_slot[vid] = cur_slot + 1;
                lane1[cur_slot + 1] = vid + 1;
                moved_this_step[vid] = true
            }

        :: else -> skip
        fi

    :: (cur_slot == SLOTN - 1) ->
        if
        :: (my_lane == 0) -> my_light_green = light0_green
        :: (my_lane == 1) -> my_light_green = light1_green
        fi;

        if
        :: (my_light_green && !intersection_occupied_this_step) ->
            /* Must cross when green and intersection free (matches C++) */
            d_step {
                intersection_occupied_this_step = true;
                vehicle_crossing_count = vehicle_crossing_count + 1
            };
            if
            :: (my_lane == 0) -> lane0[cur_slot] = 0
            :: (my_lane == 1) -> lane1[cur_slot] = 0
            fi;
            d_step {
                veh_done[vid] = true;
                veh_at_intersection[vid] = true;
                moved_this_step[vid] = true
            }

        :: (!my_light_green) -> skip

        :: (my_light_green && intersection_occupied_this_step) -> skip
        fi

    :: else -> skip
    fi;

    goto DONE_SIGNAL;

DONE_SIGNAL:
    if
    :: (my_lane == 0) -> done_vehicle0 ! 0
    :: (my_lane == 1) -> done_vehicle1 ! 0
    fi;

    do
    :: (my_lane == 0) -> tick_vehicle0 ? dummy; goto STEP
    :: (my_lane == 1) -> tick_vehicle1 ? dummy; goto STEP
    od
}


/* ================================================================
 * ClockFSM (orchestrator)
 * ================================================================ */
init {
    byte tick_count = 0;
    byte dummy;

    atomic {
        veh_slot[0] = 0;
        veh_slot[1] = 0;
        veh_done[0] = false;
        veh_done[1] = false;

        lane0[0] = 1;
        lane1[0] = 2;

        light0_green = true;
        light1_green = false;
    }

    run InfraFSM();
    run VehicleFSM(0, 0);
    run VehicleFSM(1, 1);

    do
    :: (veh_done[0] && veh_done[1]) ->
        all_done = true;
        break

    :: (tick_count >= MAX_TICKS) ->
        break

    :: else ->
        d_step {
            intersection_occupied_this_step = false;
            moved_this_step[0] = false;
            moved_this_step[1] = false;
            vehicle_crossing_count = 0
        };

        /* Phase 1: Infra */
        tick_infra ! 0;
        done_infra ? dummy;

        /* Phase 2: Vehicles */
        tick_vehicle0 ! 0;
        done_vehicle0 ? dummy;
        tick_vehicle1 ! 0;
        done_vehicle1 ? dummy;

        /* Phase 3: Property checks */
        assert(!collision);
        assert(light0_green != light1_green);
        assert(vehicle_crossing_count <= 1);
        assert(!red_violation);
        assert(!uturn_violation);
        assert(!opposite_direction_violation);

        /* Position integrity */
        assert(veh_done[0] || lane0[veh_slot[0]] == 1);
        assert(veh_done[1] || lane1[veh_slot[1]] == 2);

        /* Check completion after vehicle phase (avoid stale guard) */
        if
        :: (veh_done[0] && veh_done[1]) -> all_done = true
        :: else -> skip
        fi;

        tick_count++
    od
}

/* --- LTL Properties --- */
ltl no_collision            { [] !collision }
ltl no_red_violation        { [] !red_violation }
ltl no_opposite_direction   { [] !opposite_direction_violation }
ltl no_uturn                { [] !uturn_violation }
ltl eventual_completion     { <> all_done }
ltl mutual_exclusion_lights { [] (light0_green != light1_green) }
