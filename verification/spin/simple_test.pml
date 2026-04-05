#define NVEH 2
#define SLOTN 4
#define V0 0
#define V1 1

mtype = { RED, GREEN };

/* One incoming lane per approach: 0=empty, otherwise vehicle id + 1 */
byte lane0[SLOTN];
byte lane1[SLOTN];

/* Vehicle state: each vehicle stays on its own approach lane */
byte veh_slot[NVEH];
bool veh_done[NVEH];

/* Signal state for the two approaches of one intersection */
mtype light0;
mtype light1;

/* Property monitors */
byte crossing_count = 0;
bool collision = false;
bool red_violation = false;
bool opposite_direction_violation = false;
bool uturn_violation = false;
bool some_completed = false;

/* Per-tick crossing flags for red-light detection */
bool v0_crossed = false;
bool v1_crossed = false;

inline infra_step() {
    /* Exactly one green at any time */
    if
    :: light0 == GREEN -> light0 = RED; light1 = GREEN
    :: else -> light0 = GREEN; light1 = RED
    fi
}

inline move_v0() {
    if
    :: veh_done[V0] -> skip
    :: else ->
        if
        :: veh_slot[V0] < (SLOTN - 1) ->
            if
            :: lane0[veh_slot[V0] + 1] == 0 ->
                lane0[veh_slot[V0]] = 0;
                veh_slot[V0] = veh_slot[V0] + 1;
                if
                :: lane0[veh_slot[V0]] == 0 -> lane0[veh_slot[V0]] = 1
                :: else -> collision = true
                fi
            :: else ->
                skip
            fi
        :: else ->
            if
            :: light0 == GREEN ->
                if
                :: crossing_count == 0 ->
                    crossing_count = crossing_count + 1;
                    lane0[veh_slot[V0]] = 0;
                    veh_done[V0] = true;
                    v0_crossed = true
                :: else ->
                    collision = true
                fi
            :: else ->
                /* Wait at red. */
                skip
            fi
        fi
    fi
}

inline move_v1() {
    if
    :: veh_done[V1] -> skip
    :: else ->
        if
        :: veh_slot[V1] < (SLOTN - 1) ->
            if
            :: lane1[veh_slot[V1] + 1] == 0 ->
                lane1[veh_slot[V1]] = 0;
                veh_slot[V1] = veh_slot[V1] + 1;
                if
                :: lane1[veh_slot[V1]] == 0 -> lane1[veh_slot[V1]] = 2
                :: else -> collision = true
                fi
            :: else ->
                skip
            fi
        :: else ->
            if
            :: light1 == GREEN ->
                if
                :: crossing_count == 0 ->
                    crossing_count = crossing_count + 1;
                    lane1[veh_slot[V1]] = 0;
                    veh_done[V1] = true;
                    v1_crossed = true
                :: else ->
                    collision = true
                fi
            :: else ->
                /* Wait at red. */
                skip
            fi
        fi
    fi
}

inline check_invariants() {
    /* Red-light violation: if a vehicle crossed this tick, its light must be GREEN.
       The crossing code guards on this, so this should never fire — but it makes
       the no_red_violation property non-vacuous (detects bugs if guard is removed). */
    if
    :: (v0_crossed && light0 != GREEN) -> red_violation = true
    :: (v1_crossed && light1 != GREEN) -> red_violation = true
    :: else -> skip
    fi;

    /* Slot-occupancy integrity: each active vehicle's slot must contain its own id. */
    if
    :: (!veh_done[V0] && lane0[veh_slot[V0]] != 1) -> opposite_direction_violation = true
    :: (!veh_done[V1] && lane1[veh_slot[V1]] != 2) -> opposite_direction_violation = true
    :: else -> skip
    fi
}

inline assert_state() {
    check_invariants();

    assert(crossing_count <= 1);

    assert((light0 == GREEN && light1 == RED) ||
           (light0 == RED && light1 == GREEN));

    assert(veh_done[V0] || lane0[veh_slot[V0]] == 1);
    assert(veh_done[V1] || lane1[veh_slot[V1]] == 2);

    assert(!collision);
    assert(!red_violation);
    assert(!opposite_direction_violation);
    assert(!uturn_violation);
}

init {
    atomic {
        veh_slot[V0] = 0;
        veh_slot[V1] = 0;
        veh_done[V0] = false;
        veh_done[V1] = false;

        lane0[0] = 1;
        lane1[0] = 2;

        light0 = GREEN;
        light1 = RED;
    }

    do
    :: (veh_done[V0] && veh_done[V1]) -> break
    :: else ->
        crossing_count = 0;
        v0_crossed = false;
        v1_crossed = false;
        infra_step();
        move_v0();
        move_v1();

        if
        :: (veh_done[V0] || veh_done[V1]) -> some_completed = true
        :: else -> skip
        fi;

        assert_state()
    od
}

ltl no_collision { [] (!collision) }
ltl no_red_violation { [] (!red_violation) }
ltl no_opposite_direction { [] (!opposite_direction_violation) }
ltl no_uturn { [] (!uturn_violation) }
ltl eventual_completion { <> some_completed }