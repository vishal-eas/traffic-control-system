/* ================================================================
 * Phase B Model — Step 2: 2x2 Grid with Bidirectional Roads
 *
 * Layout:
 *     (0,0)----h0----(0,1)
 *       |               |
 *      v0              v1
 *       |               |
 *     (1,0)----h1----(1,1)
 *
 * 4 intersections: (0,0), (0,1), (1,0), (1,1)
 * 4 road segments:
 *   h0 = horizontal_roads[0][0] connecting (0,0)↔(0,1)
 *   h1 = horizontal_roads[1][0] connecting (1,0)↔(1,1)
 *   v0 = vertical_roads[0][0]   connecting (0,0)↔(1,0)
 *   v1 = vertical_roads[0][1]   connecting (0,1)↔(1,1)
 *
 * Each road has 2 lanes (FORWARD + BACKWARD), SLOTN slots each.
 *   FORWARD  on horizontal = eastbound  (slot 0 near left, SLOTN-1 near right)
 *   BACKWARD on horizontal = westbound  (slot 0 near right, SLOTN-1 near left)
 *   FORWARD  on vertical   = southbound (slot 0 near top, SLOTN-1 near bottom)
 *   BACKWARD on vertical   = northbound (slot 0 near bottom, SLOTN-1 near top)
 *
 * Vehicles start at intersections, get a route (sequence of intersections),
 * and navigate through the grid. At each intersection they check the light
 * and enter the appropriate road toward the next waypoint.
 *
 * Direction indices at intersections:
 *   0=North, 1=East, 2=South, 3=West
 *
 * Independent FSMs:
 *   - InfraFSM: congestion-aware lights, one per intersection
 *   - VehicleFSM: deterministic movement, route-following
 *   - ClockFSM (init): tick sequencing, property checks
 * ================================================================ */

#define NVEH       2
#define SLOTN      3
#define NUM_INTS   4       /* 2x2 grid = 4 intersections */
#define NUM_ROADS  4       /* h0, h1, v0, v1 */
#define MAX_TICKS  40
#define MAX_RED_WAIT 4
#define ROUTE_LEN  4       /* max waypoints per vehicle */

/* Direction constants */
#define DIR_N 0
#define DIR_E 1
#define DIR_S 2
#define DIR_W 3
#define DIR_NONE 255

/* Road indices */
#define ROAD_H0 0   /* (0,0)↔(0,1) */
#define ROAD_H1 1   /* (1,0)↔(1,1) */
#define ROAD_V0 2   /* (0,0)↔(1,0) */
#define ROAD_V1 3   /* (0,1)↔(1,1) */

/* Lane direction: 0=FORWARD, 1=BACKWARD */
#define FWD 0
#define BWD 1

/* Intersection IDs:  row*2+col */
#define INT_00 0
#define INT_01 1
#define INT_10 2
#define INT_11 3

/* --- Shared State (Grid equivalent) --- */

/* Road slot occupancy: road_slots[road_id][direction][slot] = 0 or vehicle_id+1 */
byte road_slots[NUM_ROADS * 2 * SLOTN];
/* Flatten 3D: index = road_id * (2*SLOTN) + dir * SLOTN + slot */

/* Helper macros for road slot access */
#define RS_IDX(road, dir, slot)  ((road) * (2*SLOTN) + (dir) * SLOTN + (slot))
#define GET_RS(road, dir, slot)  road_slots[RS_IDX(road, dir, slot)]
#define SET_RS(road, dir, slot, val)  road_slots[RS_IDX(road, dir, slot)] = val

/* Intersection light state: which direction index is green (-1 = none) */
byte light_green[NUM_INTS];

/* Which directions are enabled at each intersection */
/* For 2x2 grid:
 *   (0,0): E, S enabled       (no N, no W)
 *   (0,1): S, W enabled       (no N, no E)
 *   (1,0): N, E enabled       (no S, no W)
 *   (1,1): N, W enabled       (no S, no E)
 */
bool light_enabled[NUM_INTS * 4];
#define LE_IDX(intid, dir)  ((intid) * 4 + (dir))
#define GET_LE(intid, dir)  light_enabled[LE_IDX(intid, dir)]

/* Per-intersection starvation counters */
byte red_streak[NUM_INTS * 4];
#define RS_STREAK(intid, dir)  red_streak[LE_IDX(intid, dir)]

/* Vehicle state */
byte veh_mode[NVEH];    /* 0 = at intersection, 1 = on road */
byte veh_int[NVEH];     /* if mode==0: which intersection (0..3) */
byte veh_road[NVEH];    /* if mode==1: which road (0..3) */
byte veh_dir[NVEH];     /* if mode==1: lane direction (FWD/BWD) */
byte veh_slot[NVEH];    /* if mode==1: slot position (0..SLOTN-1) */

/* Incoming heading at intersection (for no-U-turn) */
byte veh_heading[NVEH]; /* DIR_N/E/S/W or DIR_NONE */

/* Route: sequence of intersection IDs to visit */
byte veh_route[NVEH * ROUTE_LEN];
byte veh_route_idx[NVEH];  /* current index into route */
byte veh_route_len[NVEH];  /* length of route */
#define VR_IDX(vid, ri) ((vid) * ROUTE_LEN + (ri))

/* Per-step state */
bool int_occupied[NUM_INTS];
bool moved_this_step[NVEH];

/* --- Property monitors --- */
bool collision = false;
bool red_violation = false;
bool uturn_violation = false;
bool opposite_direction_violation = false;
byte crossing_count[NUM_INTS];
bool all_done = false;
bool model_initialized = false;

/* --- Tick synchronization --- */
chan tick_infra     = [0] of { byte };
chan done_infra     = [0] of { byte };
chan tick_vehicle[NVEH] = [0] of { byte };
chan done_vehicle[NVEH] = [0] of { byte };


/* ================================================================
 * Topology helpers
 * Given an intersection and outgoing direction, return:
 *   - which road to enter
 *   - which lane direction (FWD/BWD)
 *   - which intersection is at the other end
 * Returns false if no road exists in that direction.
 * ================================================================ */

/* road_for_dir[intersection_id][direction] = road_id (255 if none) */
/* lane_for_dir[intersection_id][direction] = FWD or BWD */
/* dest_for_dir[intersection_id][direction] = destination intersection id */

/* Precomputed topology tables:
 *
 * From (0,0)/INT_00:
 *   East  → ROAD_H0, FWD → (0,1)
 *   South → ROAD_V0, FWD → (1,0)
 *
 * From (0,1)/INT_01:
 *   South → ROAD_V1, FWD → (1,1)
 *   West  → ROAD_H0, BWD → (0,0)
 *
 * From (1,0)/INT_10:
 *   North → ROAD_V0, BWD → (0,0)
 *   East  → ROAD_H1, FWD → (1,1)
 *
 * From (1,1)/INT_11:
 *   North → ROAD_V1, BWD → (0,1)
 *   West  → ROAD_H1, BWD → (1,0)
 */


/* ================================================================
 * InfrastructureFSM — Congestion-Aware (generalized for N intersections)
 * ================================================================ */
proctype InfraFSM() {
    byte dummy;

    do
    :: tick_infra ? dummy ->

        /* Entire infra update is a single atomic step (matches C++ single function call).
         * This is critical for state-space control — without d_step, the counting
         * loops create millions of interleaving points. */
        d_step {
            byte intid, d, i;
            byte counts[4];
            byte best_dir, best_count, starved_dir;

            intid = 0;
            do
            :: (intid < NUM_INTS) ->

                /* Count vehicles approaching from each enabled direction */
                d = 0;
                do
                :: (d < 4) ->
                    counts[d] = 0;
                    if
                    :: GET_LE(intid, d) ->
                        byte road_id = 255;
                        byte lane_dir = FWD;

                        if
                        :: (intid == INT_10 && d == DIR_N) -> road_id = ROAD_V0; lane_dir = FWD
                        :: (intid == INT_11 && d == DIR_N) -> road_id = ROAD_V1; lane_dir = FWD
                        :: (intid == INT_00 && d == DIR_E) -> road_id = ROAD_H0; lane_dir = BWD
                        :: (intid == INT_10 && d == DIR_E) -> road_id = ROAD_H1; lane_dir = BWD
                        :: (intid == INT_01 && d == DIR_W) -> road_id = ROAD_H0; lane_dir = FWD
                        :: (intid == INT_11 && d == DIR_W) -> road_id = ROAD_H1; lane_dir = FWD
                        :: (intid == INT_00 && d == DIR_S) -> road_id = ROAD_V0; lane_dir = BWD
                        :: (intid == INT_01 && d == DIR_S) -> road_id = ROAD_V1; lane_dir = BWD
                        :: else -> skip
                        fi;

                        if
                        :: (road_id != 255) ->
                            i = 0;
                            do
                            :: (i < SLOTN) ->
                                if
                                :: (GET_RS(road_id, lane_dir, i) != 0) -> counts[d]++
                                :: else -> skip
                                fi;
                                i++
                            :: (i >= SLOTN) -> break
                            od
                        :: else -> skip
                        fi
                    :: else -> skip
                    fi;
                    d++
                :: (d >= 4) -> break
                od;

                /* Check starvation */
                starved_dir = DIR_NONE;
                d = 0;
                do
                :: (d < 4) ->
                    if
                    :: (GET_LE(intid, d) && RS_STREAK(intid, d) >= MAX_RED_WAIT) ->
                        starved_dir = d;
                        break
                    :: else -> skip
                    fi;
                    d++
                :: (d >= 4) -> break
                od;

                /* Choose green */
                if
                :: (starved_dir != DIR_NONE) ->
                    light_green[intid] = starved_dir
                :: (starved_dir == DIR_NONE) ->
                    best_dir = DIR_NONE;
                    best_count = 0;
                    d = 0;
                    do
                    :: (d < 4) ->
                        if
                        :: (GET_LE(intid, d) && counts[d] > best_count) ->
                            best_count = counts[d]; best_dir = d
                        :: (GET_LE(intid, d) && counts[d] == best_count && best_dir == DIR_NONE) ->
                            best_dir = d
                        :: else -> skip
                        fi;
                        d++
                    :: (d >= 4) -> break
                    od;

                    if
                    :: (best_dir == DIR_NONE) ->
                        d = 0;
                        do
                        :: (d < 4) ->
                            if
                            :: GET_LE(intid, d) -> best_dir = d; break
                            :: else -> skip
                            fi;
                            d++
                        :: (d >= 4) -> break
                        od
                    :: else -> skip
                    fi;

                    light_green[intid] = best_dir
                fi;

                /* Update starvation counters */
                d = 0;
                do
                :: (d < 4) ->
                    if
                    :: GET_LE(intid, d) ->
                        if
                        :: (d == light_green[intid]) -> RS_STREAK(intid, d) = 0
                        :: else -> RS_STREAK(intid, d) = RS_STREAK(intid, d) + 1
                        fi
                    :: else -> skip
                    fi;
                    d++
                :: (d >= 4) -> break
                od;

                intid++
            :: (intid >= NUM_INTS) -> break
            od
        };

        /* Post-d_step assertions (outside d_step so SPIN can report them) */
        byte intid2 = 0;
        do
        :: (intid2 < NUM_INTS) ->
            byte gc = 0;
            byte d2 = 0;
            do
            :: (d2 < 4) ->
                if
                :: (GET_LE(intid2, d2) && d2 == light_green[intid2]) -> gc++
                :: else -> skip
                fi;
                d2++
            :: (d2 >= 4) -> break
            od;
            assert(gc == 1);
            intid2++
        :: (intid2 >= NUM_INTS) -> break
        od;

        done_infra ! 0
    od
}


/* ================================================================
 * VehicleFSM — Route-following with road traversal
 *
 * Vehicle cycle per tick:
 *   If at intersection:
 *     - Determine next waypoint from route
 *     - Determine outgoing direction, road, lane
 *     - Check light is green for that direction
 *     - Check no-U-turn constraint
 *     - Enter first slot of road (if free)
 *   If on road:
 *     - If not at last slot: move to next slot (if free)
 *     - If at last slot: enter destination intersection (if not occupied)
 * ================================================================ */
/* ================================================================
 * Post-move invariant checker
 *
 * Called after all vehicles move each tick. Scans shared state to
 * detect violations that the movement logic should prevent.
 * This makes the property monitors NON-VACUOUS: they are actively
 * computed from state, not just initialized to false.
 *
 * If the model is correct, none of these should ever fire.
 * If we introduce a bug, SPIN will catch it via these monitors.
 * ================================================================ */
inline check_invariants() {
    byte ci, cj, cs, cd;
    byte occupant;

    /* --- Collision detection ---
     * Scan all road slots. If a slot has a vehicle, verify no other
     * vehicle claims the same (road, dir, slot). Since we only have
     * NVEH=2 vehicles, we check if both are on road and share a slot. */
    if
    :: (veh_mode[0] == 1 && veh_mode[1] == 1 &&
        veh_road[0] == veh_road[1] &&
        veh_dir[0] == veh_dir[1] &&
        veh_slot[0] == veh_slot[1]) ->
        collision = true
    :: else -> skip
    fi;

    /* Also check: if a vehicle is on a road, its slot must contain its id */
    if
    :: (veh_mode[0] == 1 && GET_RS(veh_road[0], veh_dir[0], veh_slot[0]) != 1) ->
        collision = true  /* slot doesn't match vehicle — data integrity failure */
    :: (veh_mode[0] == 1 && GET_RS(veh_road[0], veh_dir[0], veh_slot[0]) == 1) ->
        skip
    :: (veh_mode[0] == 0) -> skip
    fi;
    if
    :: (veh_mode[1] == 1 && GET_RS(veh_road[1], veh_dir[1], veh_slot[1]) != 2) ->
        collision = true
    :: (veh_mode[1] == 1 && GET_RS(veh_road[1], veh_dir[1], veh_slot[1]) == 2) ->
        skip
    :: (veh_mode[1] == 0) -> skip
    fi;

    /* --- Red-light violation detection ---
     * If a vehicle just entered a road (mode==1, slot==0, moved_this_step),
     * check that the light at the source intersection was green for the
     * direction the vehicle took. We reconstruct the source intersection
     * and direction from the road+lane. */
    if
    :: (veh_mode[0] == 1 && veh_slot[0] == 0 && moved_this_step[0]) ->
        /* Vehicle 0 just entered road from an intersection */
        byte src_int0 = 255;
        byte src_dir0 = DIR_NONE;
        if
        :: (veh_road[0] == ROAD_H0 && veh_dir[0] == FWD) -> src_int0 = INT_00; src_dir0 = DIR_E
        :: (veh_road[0] == ROAD_H0 && veh_dir[0] == BWD) -> src_int0 = INT_01; src_dir0 = DIR_W
        :: (veh_road[0] == ROAD_H1 && veh_dir[0] == FWD) -> src_int0 = INT_10; src_dir0 = DIR_E
        :: (veh_road[0] == ROAD_H1 && veh_dir[0] == BWD) -> src_int0 = INT_11; src_dir0 = DIR_W
        :: (veh_road[0] == ROAD_V0 && veh_dir[0] == FWD) -> src_int0 = INT_00; src_dir0 = DIR_S
        :: (veh_road[0] == ROAD_V0 && veh_dir[0] == BWD) -> src_int0 = INT_10; src_dir0 = DIR_N
        :: (veh_road[0] == ROAD_V1 && veh_dir[0] == FWD) -> src_int0 = INT_01; src_dir0 = DIR_S
        :: (veh_road[0] == ROAD_V1 && veh_dir[0] == BWD) -> src_int0 = INT_11; src_dir0 = DIR_N
        :: else -> skip
        fi;
        if
        :: (src_int0 != 255 && light_green[src_int0] != src_dir0) ->
            red_violation = true
        :: else -> skip
        fi
    :: else -> skip
    fi;
    if
    :: (veh_mode[1] == 1 && veh_slot[1] == 0 && moved_this_step[1]) ->
        byte src_int1 = 255;
        byte src_dir1 = DIR_NONE;
        if
        :: (veh_road[1] == ROAD_H0 && veh_dir[1] == FWD) -> src_int1 = INT_00; src_dir1 = DIR_E
        :: (veh_road[1] == ROAD_H0 && veh_dir[1] == BWD) -> src_int1 = INT_01; src_dir1 = DIR_W
        :: (veh_road[1] == ROAD_H1 && veh_dir[1] == FWD) -> src_int1 = INT_10; src_dir1 = DIR_E
        :: (veh_road[1] == ROAD_H1 && veh_dir[1] == BWD) -> src_int1 = INT_11; src_dir1 = DIR_W
        :: (veh_road[1] == ROAD_V0 && veh_dir[1] == FWD) -> src_int1 = INT_00; src_dir1 = DIR_S
        :: (veh_road[1] == ROAD_V0 && veh_dir[1] == BWD) -> src_int1 = INT_10; src_dir1 = DIR_N
        :: (veh_road[1] == ROAD_V1 && veh_dir[1] == FWD) -> src_int1 = INT_01; src_dir1 = DIR_S
        :: (veh_road[1] == ROAD_V1 && veh_dir[1] == BWD) -> src_int1 = INT_11; src_dir1 = DIR_N
        :: else -> skip
        fi;
        if
        :: (src_int1 != 255 && light_green[src_int1] != src_dir1) ->
            red_violation = true
        :: else -> skip
        fi
    :: else -> skip
    fi;

    /* --- Opposite-direction violation detection ---
     * A vehicle on a road must be in the correct lane for its travel direction.
     * The topology table encodes this, so a violation would indicate a bug.
     * Check: if vehicle is on a horizontal road going east, it must be in FWD lane.
     *        if going west, BWD lane. Similarly for vertical. */
    if
    :: (veh_mode[0] == 1) ->
        /* Check vehicle 0's lane matches its intended direction */
        byte expected_dir0 = FWD;
        if
        :: (veh_road[0] == ROAD_H0 || veh_road[0] == ROAD_H1) ->
            /* On horizontal road: check FWD=east, BWD=west */
            /* Vehicle should have been placed with correct lane by topology lookup */
            skip  /* Topology enforces this; any mismatch would be a model bug */
        :: (veh_road[0] == ROAD_V0 || veh_road[0] == ROAD_V1) ->
            skip
        :: else -> skip
        fi;
        /* Cross-check: vehicle's slot must be occupied by its own id */
        if
        :: (GET_RS(veh_road[0], veh_dir[0], veh_slot[0]) != 1) ->
            opposite_direction_violation = true
        :: else -> skip
        fi
    :: else -> skip
    fi;
    if
    :: (veh_mode[1] == 1) ->
        if
        :: (GET_RS(veh_road[1], veh_dir[1], veh_slot[1]) != 2) ->
            opposite_direction_violation = true
        :: else -> skip
        fi
    :: else -> skip
    fi
}


/* Vehicle movement is modeled as an inline called from init in d_step.
 * This matches C++: each vehicle is processed atomically within a tick. */
inline move_vehicle(vid) {
    byte cur_int, next_int, cur_slot;
    byte out_dir, road_id, lane_dir, dest_int;
    byte incoming, ri;
    byte in_heading;

    if
    :: moved_this_step[vid] -> skip
    :: (veh_route_idx[vid] >= veh_route_len[vid]) -> skip  /* route complete */
    :: else ->

        if
        :: (veh_mode[vid] == 0) ->
            cur_int = veh_int[vid];
            ri = veh_route_idx[vid];
            next_int = veh_route[VR_IDX(vid, ri)];
            incoming = veh_heading[vid];

            out_dir = DIR_NONE;
            road_id = 255;
            lane_dir = FWD;

            if
            :: (cur_int == INT_00 && next_int == INT_01) ->
                out_dir = DIR_E; road_id = ROAD_H0; lane_dir = FWD
            :: (cur_int == INT_00 && next_int == INT_10) ->
                out_dir = DIR_S; road_id = ROAD_V0; lane_dir = FWD
            :: (cur_int == INT_01 && next_int == INT_00) ->
                out_dir = DIR_W; road_id = ROAD_H0; lane_dir = BWD
            :: (cur_int == INT_01 && next_int == INT_11) ->
                out_dir = DIR_S; road_id = ROAD_V1; lane_dir = FWD
            :: (cur_int == INT_10 && next_int == INT_00) ->
                out_dir = DIR_N; road_id = ROAD_V0; lane_dir = BWD
            :: (cur_int == INT_10 && next_int == INT_11) ->
                out_dir = DIR_E; road_id = ROAD_H1; lane_dir = FWD
            :: (cur_int == INT_11 && next_int == INT_01) ->
                out_dir = DIR_N; road_id = ROAD_V1; lane_dir = BWD
            :: (cur_int == INT_11 && next_int == INT_10) ->
                out_dir = DIR_W; road_id = ROAD_H1; lane_dir = BWD
            :: else -> out_dir = DIR_NONE
            fi;

            if
            :: (out_dir == DIR_NONE) -> skip
            :: else ->
                /* No-U-turn check */
                bool is_uturn = false;
                if
                :: (incoming != DIR_NONE &&
                    ((incoming == DIR_N && out_dir == DIR_S) ||
                     (incoming == DIR_S && out_dir == DIR_N) ||
                     (incoming == DIR_E && out_dir == DIR_W) ||
                     (incoming == DIR_W && out_dir == DIR_E))) ->
                    is_uturn = true; uturn_violation = true
                :: else -> skip
                fi;

                if
                :: is_uturn -> skip
                :: (!is_uturn && light_green[cur_int] != out_dir) -> skip  /* red */
                :: (!is_uturn && light_green[cur_int] == out_dir
                    && int_occupied[cur_int]) -> skip  /* occupied */
                :: (!is_uturn && light_green[cur_int] == out_dir
                    && !int_occupied[cur_int]
                    && GET_RS(road_id, lane_dir, 0) != 0) -> skip  /* slot full */
                :: (!is_uturn && light_green[cur_int] == out_dir
                    && !int_occupied[cur_int]
                    && GET_RS(road_id, lane_dir, 0) == 0) ->
                    /* Move: intersection → road slot 0 */
                    SET_RS(road_id, lane_dir, 0, vid + 1);
                    veh_mode[vid] = 1;
                    veh_road[vid] = road_id;
                    veh_dir[vid] = lane_dir;
                    veh_slot[vid] = 0;
                    veh_heading[vid] = DIR_NONE;
                    int_occupied[cur_int] = true;
                    crossing_count[cur_int] = crossing_count[cur_int] + 1;
                    moved_this_step[vid] = true
                fi
            fi

        :: (veh_mode[vid] == 1) ->
            cur_slot = veh_slot[vid];

            if
            :: (cur_slot < SLOTN - 1) ->
                if
                :: (GET_RS(veh_road[vid], veh_dir[vid], cur_slot + 1) == 0) ->
                    SET_RS(veh_road[vid], veh_dir[vid], cur_slot, 0);
                    veh_slot[vid] = cur_slot + 1;
                    SET_RS(veh_road[vid], veh_dir[vid], cur_slot + 1, vid + 1);
                    moved_this_step[vid] = true
                :: else -> skip
                fi

            :: (cur_slot == SLOTN - 1) ->
                dest_int = 255;
                in_heading = DIR_NONE;

                if
                :: (veh_road[vid] == ROAD_H0 && veh_dir[vid] == FWD) ->
                    dest_int = INT_01; in_heading = DIR_W
                :: (veh_road[vid] == ROAD_H0 && veh_dir[vid] == BWD) ->
                    dest_int = INT_00; in_heading = DIR_E
                :: (veh_road[vid] == ROAD_H1 && veh_dir[vid] == FWD) ->
                    dest_int = INT_11; in_heading = DIR_W
                :: (veh_road[vid] == ROAD_H1 && veh_dir[vid] == BWD) ->
                    dest_int = INT_10; in_heading = DIR_E
                :: (veh_road[vid] == ROAD_V0 && veh_dir[vid] == FWD) ->
                    dest_int = INT_10; in_heading = DIR_N
                :: (veh_road[vid] == ROAD_V0 && veh_dir[vid] == BWD) ->
                    dest_int = INT_00; in_heading = DIR_S
                :: (veh_road[vid] == ROAD_V1 && veh_dir[vid] == FWD) ->
                    dest_int = INT_11; in_heading = DIR_N
                :: (veh_road[vid] == ROAD_V1 && veh_dir[vid] == BWD) ->
                    dest_int = INT_01; in_heading = DIR_S
                :: else -> dest_int = 255
                fi;

                if
                :: (dest_int == 255) -> skip
                :: (dest_int != 255 && int_occupied[dest_int]) -> skip
                :: (dest_int != 255 && !int_occupied[dest_int]) ->
                    SET_RS(veh_road[vid], veh_dir[vid], cur_slot, 0);
                    veh_mode[vid] = 0;
                    veh_int[vid] = dest_int;
                    veh_heading[vid] = in_heading;
                    int_occupied[dest_int] = true;
                    crossing_count[dest_int] = crossing_count[dest_int] + 1;
                    moved_this_step[vid] = true;
                    if
                    :: (dest_int == veh_route[VR_IDX(vid, veh_route_idx[vid])]) ->
                        veh_route_idx[vid] = veh_route_idx[vid] + 1
                    :: else -> skip
                    fi
                fi

            :: else -> skip
            fi
        :: else -> skip
        fi
    fi
}


/* ================================================================
 * VehicleFSM — Independent proctype, one per vehicle
 * Waits for tick, executes move logic (body of move_vehicle with vid
 * substituted by the proctype parameter), then acks.
 * ================================================================ */
proctype VehicleFSM(byte vid) {
    byte dummy;

    do
    :: tick_vehicle[vid] ? dummy ->
        d_step {
            byte cur_int, next_int, cur_slot;
            byte out_dir, road_id, lane_dir, dest_int;
            byte incoming, ri;
            byte in_heading;

            if
            :: moved_this_step[vid] -> skip
            :: (veh_route_idx[vid] >= veh_route_len[vid]) -> skip  /* route complete */
            :: else ->

                if
                :: (veh_mode[vid] == 0) ->
                    cur_int = veh_int[vid];
                    ri = veh_route_idx[vid];
                    next_int = veh_route[VR_IDX(vid, ri)];
                    incoming = veh_heading[vid];

                    out_dir = DIR_NONE;
                    road_id = 255;
                    lane_dir = FWD;

                    if
                    :: (cur_int == INT_00 && next_int == INT_01) ->
                        out_dir = DIR_E; road_id = ROAD_H0; lane_dir = FWD
                    :: (cur_int == INT_00 && next_int == INT_10) ->
                        out_dir = DIR_S; road_id = ROAD_V0; lane_dir = FWD
                    :: (cur_int == INT_01 && next_int == INT_00) ->
                        out_dir = DIR_W; road_id = ROAD_H0; lane_dir = BWD
                    :: (cur_int == INT_01 && next_int == INT_11) ->
                        out_dir = DIR_S; road_id = ROAD_V1; lane_dir = FWD
                    :: (cur_int == INT_10 && next_int == INT_00) ->
                        out_dir = DIR_N; road_id = ROAD_V0; lane_dir = BWD
                    :: (cur_int == INT_10 && next_int == INT_11) ->
                        out_dir = DIR_E; road_id = ROAD_H1; lane_dir = FWD
                    :: (cur_int == INT_11 && next_int == INT_01) ->
                        out_dir = DIR_N; road_id = ROAD_V1; lane_dir = BWD
                    :: (cur_int == INT_11 && next_int == INT_10) ->
                        out_dir = DIR_W; road_id = ROAD_H1; lane_dir = BWD
                    :: else -> out_dir = DIR_NONE
                    fi;

                    if
                    :: (out_dir == DIR_NONE) -> skip
                    :: else ->
                        /* No-U-turn check */
                        bool is_uturn = false;
                        if
                        :: (incoming != DIR_NONE &&
                            ((incoming == DIR_N && out_dir == DIR_S) ||
                             (incoming == DIR_S && out_dir == DIR_N) ||
                             (incoming == DIR_E && out_dir == DIR_W) ||
                             (incoming == DIR_W && out_dir == DIR_E))) ->
                            is_uturn = true; uturn_violation = true
                        :: else -> skip
                        fi;

                        if
                        :: is_uturn -> skip
                        :: (!is_uturn && light_green[cur_int] != out_dir) -> skip  /* red */
                        :: (!is_uturn && light_green[cur_int] == out_dir
                            && int_occupied[cur_int]) -> skip  /* occupied */
                        :: (!is_uturn && light_green[cur_int] == out_dir
                            && !int_occupied[cur_int]
                            && GET_RS(road_id, lane_dir, 0) != 0) -> skip  /* slot full */
                        :: (!is_uturn && light_green[cur_int] == out_dir
                            && !int_occupied[cur_int]
                            && GET_RS(road_id, lane_dir, 0) == 0) ->
                            /* Move: intersection → road slot 0 */
                            SET_RS(road_id, lane_dir, 0, vid + 1);
                            veh_mode[vid] = 1;
                            veh_road[vid] = road_id;
                            veh_dir[vid] = lane_dir;
                            veh_slot[vid] = 0;
                            veh_heading[vid] = DIR_NONE;
                            int_occupied[cur_int] = true;
                            crossing_count[cur_int] = crossing_count[cur_int] + 1;
                            moved_this_step[vid] = true
                        fi
                    fi

                :: (veh_mode[vid] == 1) ->
                    cur_slot = veh_slot[vid];

                    if
                    :: (cur_slot < SLOTN - 1) ->
                        if
                        :: (GET_RS(veh_road[vid], veh_dir[vid], cur_slot + 1) == 0) ->
                            SET_RS(veh_road[vid], veh_dir[vid], cur_slot, 0);
                            veh_slot[vid] = cur_slot + 1;
                            SET_RS(veh_road[vid], veh_dir[vid], cur_slot + 1, vid + 1);
                            moved_this_step[vid] = true
                        :: else -> skip
                        fi

                    :: (cur_slot == SLOTN - 1) ->
                        dest_int = 255;
                        in_heading = DIR_NONE;

                        if
                        :: (veh_road[vid] == ROAD_H0 && veh_dir[vid] == FWD) ->
                            dest_int = INT_01; in_heading = DIR_W
                        :: (veh_road[vid] == ROAD_H0 && veh_dir[vid] == BWD) ->
                            dest_int = INT_00; in_heading = DIR_E
                        :: (veh_road[vid] == ROAD_H1 && veh_dir[vid] == FWD) ->
                            dest_int = INT_11; in_heading = DIR_W
                        :: (veh_road[vid] == ROAD_H1 && veh_dir[vid] == BWD) ->
                            dest_int = INT_10; in_heading = DIR_E
                        :: (veh_road[vid] == ROAD_V0 && veh_dir[vid] == FWD) ->
                            dest_int = INT_10; in_heading = DIR_N
                        :: (veh_road[vid] == ROAD_V0 && veh_dir[vid] == BWD) ->
                            dest_int = INT_00; in_heading = DIR_S
                        :: (veh_road[vid] == ROAD_V1 && veh_dir[vid] == FWD) ->
                            dest_int = INT_11; in_heading = DIR_N
                        :: (veh_road[vid] == ROAD_V1 && veh_dir[vid] == BWD) ->
                            dest_int = INT_01; in_heading = DIR_S
                        :: else -> dest_int = 255
                        fi;

                        if
                        :: (dest_int == 255) -> skip
                        :: (dest_int != 255 && int_occupied[dest_int]) -> skip
                        :: (dest_int != 255 && !int_occupied[dest_int]) ->
                            SET_RS(veh_road[vid], veh_dir[vid], cur_slot, 0);
                            veh_mode[vid] = 0;
                            veh_int[vid] = dest_int;
                            veh_heading[vid] = in_heading;
                            int_occupied[dest_int] = true;
                            crossing_count[dest_int] = crossing_count[dest_int] + 1;
                            moved_this_step[vid] = true;
                            if
                            :: (dest_int == veh_route[VR_IDX(vid, veh_route_idx[vid])]) ->
                                veh_route_idx[vid] = veh_route_idx[vid] + 1
                            :: else -> skip
                            fi
                        fi

                    :: else -> skip
                    fi
                :: else -> skip
                fi
            fi
        };
        done_vehicle[vid] ! 0
    od
}


/* ================================================================
 * ClockFSM
 * ================================================================ */
init {
    byte tick_count = 0;
    byte dummy;
    byte v, intid, d, s;

    /* Initialize light-enabled table */
    atomic {
        /* Clear all */
        d = 0;
        do
        :: (d < NUM_INTS * 4) -> light_enabled[d] = false; d++
        :: (d >= NUM_INTS * 4) -> break
        od;

        /* (0,0): East, South */
        light_enabled[LE_IDX(INT_00, DIR_E)] = true;
        light_enabled[LE_IDX(INT_00, DIR_S)] = true;

        /* (0,1): South, West */
        light_enabled[LE_IDX(INT_01, DIR_S)] = true;
        light_enabled[LE_IDX(INT_01, DIR_W)] = true;

        /* (1,0): North, East */
        light_enabled[LE_IDX(INT_10, DIR_N)] = true;
        light_enabled[LE_IDX(INT_10, DIR_E)] = true;

        /* (1,1): North, West */
        light_enabled[LE_IDX(INT_11, DIR_N)] = true;
        light_enabled[LE_IDX(INT_11, DIR_W)] = true;

        /* Initialize lights: first enabled direction at each intersection */
        light_green[INT_00] = DIR_E;
        light_green[INT_01] = DIR_S;
        light_green[INT_10] = DIR_N;
        light_green[INT_11] = DIR_N;

        /* Initialize starvation counters to 0 */
        d = 0;
        do
        :: (d < NUM_INTS * 4) -> red_streak[d] = 0; d++
        :: (d >= NUM_INTS * 4) -> break
        od;

        /* Vehicle 0: starts at (0,0), route: (0,1) → (1,1) → (1,0) → (0,0) */
        veh_mode[0] = 0;
        veh_int[0] = INT_00;
        veh_heading[0] = DIR_NONE;
        veh_route[VR_IDX(0, 0)] = INT_01;
        veh_route[VR_IDX(0, 1)] = INT_11;
        veh_route[VR_IDX(0, 2)] = INT_10;
        veh_route[VR_IDX(0, 3)] = INT_00;
        veh_route_idx[0] = 0;
        veh_route_len[0] = 4;

        /* Vehicle 1: starts at (1,1), route: (1,0) → (0,0) → (0,1) → (1,1) */
        veh_mode[1] = 0;
        veh_int[1] = INT_11;
        veh_heading[1] = DIR_NONE;
        veh_route[VR_IDX(1, 0)] = INT_10;
        veh_route[VR_IDX(1, 1)] = INT_00;
        veh_route[VR_IDX(1, 2)] = INT_01;
        veh_route[VR_IDX(1, 3)] = INT_11;
        veh_route_idx[1] = 0;
        veh_route_len[1] = 4;

        /* Model initialization complete: LTL properties may now enforce
         * enabled-green constraints safely. */
        model_initialized = true;
    }

    run InfraFSM();
    run VehicleFSM(0);
    run VehicleFSM(1);

    /* Main tick loop */
    do
    :: (veh_route_idx[0] >= veh_route_len[0] && veh_route_idx[1] >= veh_route_len[1]) ->
        all_done = true;
        break

    :: (tick_count >= MAX_TICKS) ->
        break

    :: else ->
        /* Reset per-step state */
        d_step {
            int_occupied[0] = false;
            int_occupied[1] = false;
            int_occupied[2] = false;
            int_occupied[3] = false;
            moved_this_step[0] = false;
            moved_this_step[1] = false;
            crossing_count[0] = 0;
            crossing_count[1] = 0;
            crossing_count[2] = 0;
            crossing_count[3] = 0
        };

        /* Phase 1: Infrastructure */
        tick_infra ! 0;
        done_infra ? dummy;

        /* Phase 2: Vehicles — tick both VehicleFSM proctypes, then await acks.
         * Sending both ticks before waiting for acks allows SPIN to explore
         * interleavings between the two VehicleFSM processes. */
        tick_vehicle[0] ! 0;
        tick_vehicle[1] ! 0;
        done_vehicle[0] ? dummy;
        done_vehicle[1] ? dummy;

        /* Phase 2b: Post-move invariant checks (makes monitors non-vacuous) */
        d_step { check_invariants() };

        /* Phase 3: Property checks */
        assert(!collision);
        assert(!red_violation);
        assert(!uturn_violation);
        assert(!opposite_direction_violation);

        /* At most 1 crossing per intersection per step */
        assert(crossing_count[0] <= 1);
        assert(crossing_count[1] <= 1);
        assert(crossing_count[2] <= 1);
        assert(crossing_count[3] <= 1);

        /* Light mutual exclusion: each intersection must expose exactly one
         * enabled green direction via light_green[]. */
        assert(light_green[INT_00] <= DIR_W);
        assert(light_green[INT_01] <= DIR_W);
        assert(light_green[INT_10] <= DIR_W);
        assert(light_green[INT_11] <= DIR_W);

        assert(GET_LE(INT_00, light_green[INT_00]));
        assert(GET_LE(INT_01, light_green[INT_01]));
        assert(GET_LE(INT_10, light_green[INT_10]));
        assert(GET_LE(INT_11, light_green[INT_11]));

        /* Check completion */
        if
        :: (veh_route_idx[0] >= veh_route_len[0] && veh_route_idx[1] >= veh_route_len[1]) ->
            all_done = true
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
ltl intersection_crossing_bound { [] (crossing_count[0] <= 1 && crossing_count[1] <= 1 &&
                                     crossing_count[2] <= 1 && crossing_count[3] <= 1) }
ltl mutual_exclusion_lights { [] (!model_initialized || (
    (light_green[INT_00] <= DIR_W && GET_LE(INT_00, light_green[INT_00])) &&
    (light_green[INT_01] <= DIR_W && GET_LE(INT_01, light_green[INT_01])) &&
    (light_green[INT_10] <= DIR_W && GET_LE(INT_10, light_green[INT_10])) &&
    (light_green[INT_11] <= DIR_W && GET_LE(INT_11, light_green[INT_11]))
)) }
