/* ================================================================
 * Phase C Model — 3×3 Grid with Square Node A
 * Option 3: Non-deterministic vehicle spawn via Environment process
 *
 * Layout (row, col):
 *     (0,0)--r0--(0,1)--r1--(0,2)=D
 *       |          |           |
 *      r6         r7          r8
 *       |          |           |
 *     (1,0)--r2--(1,1)--r3--(1,2)
 *       |          |           |
 *      r9         r10         r11
 *       |          |           |
 *     (2,0)=B-r4-(2,1)--r5--(2,2)=C
 *
 *   Square node A = node 9, connected to (0,0) via road 12
 *
 * Node IDs (0..9):
 *   (0,0)=0  (0,1)=1  D=(0,2)=2
 *   (1,0)=3  (1,1)=4  (1,2)=5
 *   B=(2,0)=6  (2,1)=7  C=(2,2)=8
 *   sq A = 9  (ONLY square node -- no signal)
 *
 * Non-determinism: Environment process spawns VehicleFSM instances
 * at any tick (up to MAX_ACTIVE). SPIN explores all possible spawn
 * timings, verifying properties hold for any vehicle count/arrival.
 * ================================================================ */

#define MAX_ACTIVE    3      /* maximum concurrent vehicles */
#define SLOTN         3
#define SLOTN_SQ      1
#define NUM_INTS      9
#define NUM_SQ        1
#define NUM_NODES     10
#define NUM_ROADS     13
#define NUM_INT_ROADS 12
#define MAX_TICKS     60
#define MAX_RED_WAIT  4

/* Direction constants */
#define DIR_N    0
#define DIR_E    1
#define DIR_S    2
#define DIR_W    3
#define DIR_NONE 255

/* Lane direction */
#define FWD 0
#define BWD 1

/* Node IDs */
#define N00  0
#define N01  1
#define N_D  2
#define N10  3
#define N11  4
#define N12  5
#define N_B  6
#define N21  7
#define N_C  8
#define SQ_A 9

/* Road IDs */
#define ROAD_H00  0
#define ROAD_H01  1
#define ROAD_H10  2
#define ROAD_H11  3
#define ROAD_H20  4
#define ROAD_H21  5
#define ROAD_V00  6
#define ROAD_V01  7
#define ROAD_V02  8
#define ROAD_V10  9
#define ROAD_V11  10
#define ROAD_V12  11
#define ROAD_SQ_A 12

/* ================================================================
 * Heading-aware next_hop table (BFS, no-U-turn).
 * Index: next_hop_ha[src*50 + inc_idx*10 + dst]
 * ================================================================ */
#define NH_IDX(src,inc,dst) ((src)*50 + (inc)*10 + (dst))
#define DIR_NONE_IDX 4

byte next_hop_ha[NUM_NODES * 5 * NUM_NODES] = {
    /* N00  inc=N */ 0, 1, 1, 3, 1, 1, 3, 1, 1, 9,
    /* N00  inc=E */ 0, 3, 3, 3, 3, 3, 3, 3, 3, 9,
    /* N00  inc=S */ 0, 1, 1, 1, 1, 1, 1, 1, 1, 9,
    /* N00  inc=W */ 0, 1, 1, 3, 1, 1, 3, 1, 1, 1,
    /* N00  inc=* */ 0, 1, 1, 3, 1, 1, 3, 1, 1, 9,
    /* N01  inc=N */ 0, 1, 2, 4, 4, 2, 4, 4, 2, 0,
    /* N01  inc=E */ 0, 1, 4, 4, 4, 4, 4, 4, 4, 0,
    /* N01  inc=S */ 0, 1, 2, 0, 2, 2, 0, 2, 2, 0,
    /* N01  inc=W */ 4, 1, 2, 4, 4, 2, 4, 4, 2, 4,
    /* N01  inc=* */ 0, 1, 2, 4, 4, 2, 4, 4, 2, 0,
    /* N_D  inc=N */ 1, 1, 2, 5, 5, 5, 5, 5, 5, 1,
    /* N_D  inc=E */ 1, 1, 2, 5, 5, 5, 5, 5, 5, 1,
    /* N_D  inc=S */ 1, 1, 2, 1, 1, 1, 1, 1, 1, 1,
    /* N_D  inc=W */ 5, 5, 2, 5, 5, 5, 5, 5, 5, 5,
    /* N_D  inc=* */ 1, 1, 2, 5, 5, 5, 5, 5, 5, 1,
    /* N10  inc=N */ 4, 4, 4, 3, 4, 4, 6, 4, 4, 4,
    /* N10  inc=E */ 0, 0, 0, 3, 0, 0, 6, 6, 6, 0,
    /* N10  inc=S */ 0, 0, 0, 3, 4, 4, 4, 4, 4, 0,
    /* N10  inc=W */ 0, 0, 0, 3, 4, 4, 6, 4, 4, 0,
    /* N10  inc=* */ 0, 0, 0, 3, 4, 4, 6, 4, 4, 0,
    /* N11  inc=N */ 3, 5, 5, 3, 4, 5, 7, 7, 5, 3,
    /* N11  inc=E */ 1, 1, 1, 3, 4, 1, 7, 7, 7, 1,
    /* N11  inc=S */ 1, 1, 1, 3, 4, 5, 3, 5, 5, 1,
    /* N11  inc=W */ 1, 1, 1, 1, 4, 5, 7, 7, 5, 1,
    /* N11  inc=* */ 1, 1, 1, 3, 4, 5, 7, 7, 5, 1,
    /* N12  inc=N */ 4, 4, 4, 4, 4, 5, 8, 8, 8, 4,
    /* N12  inc=E */ 2, 2, 2, 4, 4, 5, 8, 8, 8, 2,
    /* N12  inc=S */ 2, 2, 2, 4, 4, 5, 4, 4, 4, 2,
    /* N12  inc=W */ 2, 2, 2, 2, 2, 5, 8, 8, 8, 2,
    /* N12  inc=* */ 2, 2, 2, 4, 4, 5, 8, 8, 8, 2,
    /* N_B  inc=N */ 7, 7, 7, 7, 7, 7, 6, 7, 7, 7,
    /* N_B  inc=E */ 3, 3, 3, 3, 3, 3, 6, 3, 3, 3,
    /* N_B  inc=S */ 3, 3, 3, 3, 3, 3, 6, 7, 7, 3,
    /* N_B  inc=W */ 3, 3, 3, 3, 3, 3, 6, 7, 7, 3,
    /* N_B  inc=* */ 3, 3, 3, 3, 3, 3, 6, 7, 7, 3,
    /* N21  inc=N */ 6, 8, 8, 6, 8, 8, 6, 7, 8, 6,
    /* N21  inc=E */ 4, 4, 4, 4, 4, 4, 6, 7, 4, 4,
    /* N21  inc=S */ 4, 4, 4, 4, 4, 4, 6, 7, 8, 4,
    /* N21  inc=W */ 4, 4, 4, 4, 4, 4, 4, 7, 8, 4,
    /* N21  inc=* */ 4, 4, 4, 4, 4, 4, 6, 7, 8, 4,
    /* N_C  inc=N */ 7, 7, 7, 7, 7, 7, 7, 7, 8, 7,
    /* N_C  inc=E */ 5, 5, 5, 5, 5, 5, 7, 7, 8, 5,
    /* N_C  inc=S */ 5, 5, 5, 5, 5, 5, 7, 7, 8, 5,
    /* N_C  inc=W */ 5, 5, 5, 5, 5, 5, 5, 5, 8, 5,
    /* N_C  inc=* */ 5, 5, 5, 5, 5, 5, 7, 7, 8, 5,
    /* SQ_A inc=N */ 0, 0, 0, 0, 0, 0, 0, 0, 0, 9,
    /* SQ_A inc=E */ 255,255,255,255,255,255,255,255,255, 9,
    /* SQ_A inc=S */ 0, 0, 0, 0, 0, 0, 0, 0, 0, 9,
    /* SQ_A inc=W */ 0, 0, 0, 0, 0, 0, 0, 0, 0, 9,
    /* SQ_A inc=* */ 0, 0, 0, 0, 0, 0, 0, 0, 0, 9,
    0  /* sentinel */
};

/* --- Shared State --- */

byte road_slots[NUM_ROADS * 2 * SLOTN];
#define RS_IDX(road,dir,slot)      ((road)*(2*SLOTN)+(dir)*SLOTN+(slot))
#define GET_RS(road,dir,slot)      road_slots[RS_IDX(road,dir,slot)]
#define SET_RS(road,dir,slot,val)  road_slots[RS_IDX(road,dir,slot)] = val

byte light_green[NUM_NODES];

bool light_enabled[NUM_NODES * 4];
#define LE_IDX(n,d)    ((n)*4+(d))
#define GET_LE(n,d)    light_enabled[LE_IDX(n,d)]

byte red_streak[NUM_NODES * 4];
#define RS_STREAK(n,d) red_streak[LE_IDX(n,d)]

/* Vehicle state — indexed by vid (0..MAX_ACTIVE-1) */
byte veh_mode[MAX_ACTIVE];        /* 0=at node, 1=on road, 2=inactive */
byte veh_node[MAX_ACTIVE];
byte veh_road[MAX_ACTIVE];
byte veh_dir[MAX_ACTIVE];
byte veh_slot[MAX_ACTIVE];
byte veh_heading[MAX_ACTIVE];
byte veh_dest[MAX_ACTIVE];
byte veh_dest_idx[MAX_ACTIVE];
bool visited_B[MAX_ACTIVE];
bool visited_C[MAX_ACTIVE];
bool visited_D[MAX_ACTIVE];
bool returned_A[MAX_ACTIVE];
byte sq_a_forbidden[MAX_ACTIVE];
bool moved_this_step[MAX_ACTIVE];
bool veh_active[MAX_ACTIVE];      /* true once spawned */

/* Tour templates: alternating orderings assigned by vid parity
 *   even vid: N_B -> N_C -> N_D -> SQ_A
 *   odd  vid: N_D -> N_C -> N_B -> SQ_A
 */
byte tour_stops[MAX_ACTIVE * 4];
#define TS_IDX(vid,i) ((vid)*4+(i))

/* Active vehicle count (monotonically increases as Environment spawns) */
byte active_count = 0;

/* Per-step state */
bool node_occupied[NUM_NODES];
byte crossing_count[NUM_NODES];

/* Per-direction green booleans — one per (node, direction).
 * Mirrors light_green[] but as explicit booleans so mutual exclusion
 * can be expressed as a count: sum of dir_green[n*4+0..3] <= 1.
 * Updated atomically with light_green by InfraFSM each tick. */
bool dir_green[NUM_NODES * 4];
#define DG_IDX(n,d)   ((n)*4+(d))
#define GET_DG(n,d)   dir_green[DG_IDX(n,d)]

/* --- Property monitors --- */
bool collision = false;
bool red_violation = false;
bool uturn_violation = false;
bool opposite_direction_violation = false;
bool model_initialized = false;

/* --- Tick synchronization --- */
chan tick_infra        = [0] of { byte };
chan done_infra        = [0] of { byte };
chan tick_env          = [0] of { byte };
chan done_env          = [0] of { byte };
chan tick_vehicle[MAX_ACTIVE] = [0] of { byte };
chan done_vehicle[MAX_ACTIVE] = [0] of { byte };


/* ================================================================
 * InfrastructureFSM -- Congestion-aware lights for nodes 0..8
 * ================================================================ */
proctype InfraFSM() {
    byte dummy;

    do
    :: tick_infra ? dummy ->

        d_step {
            byte nid, d, i;
            byte counts[4];
            byte best_dir, best_count, starved_dir;
            byte road_id, lane_dir;

            nid = 0;
            do
            :: (nid < NUM_INTS) ->

                d = 0;
                do
                :: (d < 4) ->
                    counts[d] = 0;
                    if
                    :: GET_LE(nid, d) ->
                        road_id = 255;
                        lane_dir = FWD;

                        if
                        :: (nid == N00 && d == DIR_E) -> road_id = ROAD_H00; lane_dir = BWD
                        :: (nid == N00 && d == DIR_S) -> road_id = ROAD_V00; lane_dir = BWD
                        :: (nid == N00 && d == DIR_W) -> road_id = ROAD_SQ_A; lane_dir = BWD
                        :: (nid == N01 && d == DIR_E) -> road_id = ROAD_H01; lane_dir = BWD
                        :: (nid == N01 && d == DIR_S) -> road_id = ROAD_V01; lane_dir = BWD
                        :: (nid == N01 && d == DIR_W) -> road_id = ROAD_H00; lane_dir = FWD
                        :: (nid == N_D && d == DIR_S) -> road_id = ROAD_V02; lane_dir = BWD
                        :: (nid == N_D && d == DIR_W) -> road_id = ROAD_H01; lane_dir = FWD
                        :: (nid == N10 && d == DIR_N) -> road_id = ROAD_V00; lane_dir = FWD
                        :: (nid == N10 && d == DIR_E) -> road_id = ROAD_H10; lane_dir = BWD
                        :: (nid == N10 && d == DIR_S) -> road_id = ROAD_V10; lane_dir = BWD
                        :: (nid == N11 && d == DIR_N) -> road_id = ROAD_V01; lane_dir = FWD
                        :: (nid == N11 && d == DIR_E) -> road_id = ROAD_H11; lane_dir = BWD
                        :: (nid == N11 && d == DIR_S) -> road_id = ROAD_V11; lane_dir = BWD
                        :: (nid == N11 && d == DIR_W) -> road_id = ROAD_H10; lane_dir = FWD
                        :: (nid == N12 && d == DIR_N) -> road_id = ROAD_V02; lane_dir = FWD
                        :: (nid == N12 && d == DIR_S) -> road_id = ROAD_V12; lane_dir = BWD
                        :: (nid == N12 && d == DIR_W) -> road_id = ROAD_H11; lane_dir = FWD
                        :: (nid == N_B && d == DIR_N) -> road_id = ROAD_V10; lane_dir = FWD
                        :: (nid == N_B && d == DIR_E) -> road_id = ROAD_H20; lane_dir = BWD
                        :: (nid == N21 && d == DIR_N) -> road_id = ROAD_V11; lane_dir = FWD
                        :: (nid == N21 && d == DIR_E) -> road_id = ROAD_H21; lane_dir = BWD
                        :: (nid == N21 && d == DIR_W) -> road_id = ROAD_H20; lane_dir = FWD
                        :: (nid == N_C && d == DIR_N) -> road_id = ROAD_V12; lane_dir = FWD
                        :: (nid == N_C && d == DIR_W) -> road_id = ROAD_H21; lane_dir = FWD
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

                starved_dir = DIR_NONE;
                d = 0;
                do
                :: (d < 4) ->
                    if
                    :: (GET_LE(nid, d) && RS_STREAK(nid, d) >= MAX_RED_WAIT) ->
                        starved_dir = d;
                        break
                    :: else -> skip
                    fi;
                    d++
                :: (d >= 4) -> break
                od;

                if
                :: (starved_dir != DIR_NONE) ->
                    light_green[nid] = starved_dir;
                    /* Update dir_green: clear all dirs, set only the chosen one */
                    dir_green[DG_IDX(nid,DIR_N)] = false;
                    dir_green[DG_IDX(nid,DIR_E)] = false;
                    dir_green[DG_IDX(nid,DIR_S)] = false;
                    dir_green[DG_IDX(nid,DIR_W)] = false;
                    dir_green[DG_IDX(nid,starved_dir)] = true
                :: (starved_dir == DIR_NONE) ->
                    best_dir = DIR_NONE;
                    best_count = 0;
                    d = 0;
                    do
                    :: (d < 4) ->
                        if
                        :: (GET_LE(nid, d) && counts[d] > best_count) ->
                            best_count = counts[d]; best_dir = d
                        :: (GET_LE(nid, d) && counts[d] == best_count && best_dir == DIR_NONE) ->
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
                            :: GET_LE(nid, d) -> best_dir = d; break
                            :: else -> skip
                            fi;
                            d++
                        :: (d >= 4) -> break
                        od
                    :: else -> skip
                    fi;

                    light_green[nid] = best_dir;
                    /* Update dir_green: clear all dirs, set only the chosen one */
                    dir_green[DG_IDX(nid,DIR_N)] = false;
                    dir_green[DG_IDX(nid,DIR_E)] = false;
                    dir_green[DG_IDX(nid,DIR_S)] = false;
                    dir_green[DG_IDX(nid,DIR_W)] = false;
                    dir_green[DG_IDX(nid,best_dir)] = true
                fi;

                d = 0;
                do
                :: (d < 4) ->
                    if
                    :: GET_LE(nid, d) ->
                        if
                        :: (d == light_green[nid]) -> RS_STREAK(nid, d) = 0
                        :: else -> RS_STREAK(nid, d) = RS_STREAK(nid, d) + 1
                        fi
                    :: else -> skip
                    fi;
                    d++
                :: (d >= 4) -> break
                od;

                nid++
            :: (nid >= NUM_INTS) -> break
            od
        };

        byte nid2 = 0;
        do
        :: (nid2 < NUM_INTS) ->
            byte gc = 0;
            byte d2 = 0;
            do
            :: (d2 < 4) ->
                if
                :: (GET_LE(nid2, d2) && d2 == light_green[nid2]) -> gc++
                :: else -> skip
                fi;
                d2++
            :: (d2 >= 4) -> break
            od;
            assert(gc == 1);
            nid2++
        :: (nid2 >= NUM_INTS) -> break
        od;

        done_infra ! 0
    od
}


/* ================================================================
 * check_invariants -- loops over all active vehicles
 * ================================================================ */
inline check_invariants() {
    byte ci;
    ci = 0;
    do
    :: (ci < MAX_ACTIVE) ->
        if
        :: (!veh_active[ci]) -> skip
        :: (veh_active[ci] && veh_mode[ci] == 1) ->
            /* Collision: two active vehicles on same slot */
            byte cj;
            cj = 0;
            do
            :: (cj < MAX_ACTIVE) ->
                if
                :: (cj != ci && veh_active[cj] && veh_mode[cj] == 1 &&
                    veh_road[ci] == veh_road[cj] &&
                    veh_dir[ci]  == veh_dir[cj]  &&
                    veh_slot[ci] == veh_slot[cj]) ->
                    collision = true
                :: else -> skip
                fi;
                cj++
            :: (cj >= MAX_ACTIVE) -> break
            od;

            /* Slot must hold this vehicle's ID (opposite-direction check) */
            if
            :: (GET_RS(veh_road[ci], veh_dir[ci], veh_slot[ci]) != ci + 1) ->
                opposite_direction_violation = true
            :: else -> skip
            fi;

            /* Red-light check: vehicle just entered road at slot 0 */
            if
            :: (veh_slot[ci] == 0 && moved_this_step[ci]) ->
                byte src_n = 255;
                byte src_d = DIR_NONE;
                if
                :: (veh_road[ci] == ROAD_H00 && veh_dir[ci] == FWD) -> src_n = N00; src_d = DIR_E
                :: (veh_road[ci] == ROAD_H00 && veh_dir[ci] == BWD) -> src_n = N01; src_d = DIR_W
                :: (veh_road[ci] == ROAD_H01 && veh_dir[ci] == FWD) -> src_n = N01; src_d = DIR_E
                :: (veh_road[ci] == ROAD_H01 && veh_dir[ci] == BWD) -> src_n = N_D; src_d = DIR_W
                :: (veh_road[ci] == ROAD_H10 && veh_dir[ci] == FWD) -> src_n = N10; src_d = DIR_E
                :: (veh_road[ci] == ROAD_H10 && veh_dir[ci] == BWD) -> src_n = N11; src_d = DIR_W
                :: (veh_road[ci] == ROAD_H11 && veh_dir[ci] == FWD) -> src_n = N11; src_d = DIR_E
                :: (veh_road[ci] == ROAD_H11 && veh_dir[ci] == BWD) -> src_n = N12; src_d = DIR_W
                :: (veh_road[ci] == ROAD_H20 && veh_dir[ci] == FWD) -> src_n = N_B; src_d = DIR_E
                :: (veh_road[ci] == ROAD_H20 && veh_dir[ci] == BWD) -> src_n = N21; src_d = DIR_W
                :: (veh_road[ci] == ROAD_H21 && veh_dir[ci] == FWD) -> src_n = N21; src_d = DIR_E
                :: (veh_road[ci] == ROAD_H21 && veh_dir[ci] == BWD) -> src_n = N_C; src_d = DIR_W
                :: (veh_road[ci] == ROAD_V00 && veh_dir[ci] == FWD) -> src_n = N00; src_d = DIR_S
                :: (veh_road[ci] == ROAD_V00 && veh_dir[ci] == BWD) -> src_n = N10; src_d = DIR_N
                :: (veh_road[ci] == ROAD_V01 && veh_dir[ci] == FWD) -> src_n = N01; src_d = DIR_S
                :: (veh_road[ci] == ROAD_V01 && veh_dir[ci] == BWD) -> src_n = N11; src_d = DIR_N
                :: (veh_road[ci] == ROAD_V02 && veh_dir[ci] == FWD) -> src_n = N_D; src_d = DIR_S
                :: (veh_road[ci] == ROAD_V02 && veh_dir[ci] == BWD) -> src_n = N12; src_d = DIR_N
                :: (veh_road[ci] == ROAD_V10 && veh_dir[ci] == FWD) -> src_n = N10; src_d = DIR_S
                :: (veh_road[ci] == ROAD_V10 && veh_dir[ci] == BWD) -> src_n = N_B; src_d = DIR_N
                :: (veh_road[ci] == ROAD_V11 && veh_dir[ci] == FWD) -> src_n = N11; src_d = DIR_S
                :: (veh_road[ci] == ROAD_V11 && veh_dir[ci] == BWD) -> src_n = N21; src_d = DIR_N
                :: (veh_road[ci] == ROAD_V12 && veh_dir[ci] == FWD) -> src_n = N12; src_d = DIR_S
                :: (veh_road[ci] == ROAD_V12 && veh_dir[ci] == BWD) -> src_n = N_C; src_d = DIR_N
                :: (veh_road[ci] == ROAD_SQ_A && veh_dir[ci] == FWD) -> src_n = N00; src_d = DIR_W
                :: (veh_road[ci] == ROAD_SQ_A && veh_dir[ci] == BWD) -> src_n = 255; src_d = DIR_NONE
                :: else -> skip
                fi;
                if
                :: (src_n != 255 && light_green[src_n] != src_d) ->
                    red_violation = true
                :: else -> skip
                fi
            :: else -> skip
            fi
        :: else -> skip
        fi;
        ci++
    :: (ci >= MAX_ACTIVE) -> break
    od
}


/* ================================================================
 * VehicleFSM -- identical movement logic, now parameterized by vid
 * Exits (idles) once returned_A[vid] is set.
 * ================================================================ */
proctype VehicleFSM(byte vid) {
    byte dummy;

    do
    :: tick_vehicle[vid] ? dummy ->
        d_step {
            byte cur_node, next_node, cur_slot;
            byte out_dir, road_id, lane_dir, dest_node;
            byte incoming;
            byte in_heading;
            byte last_sl;
            byte nh;

            if
            :: moved_this_step[vid] -> skip
            :: returned_A[vid] -> skip
            :: else ->

                if
                :: (veh_mode[vid] == 0) ->
                    cur_node = veh_node[vid];
                    incoming = veh_heading[vid];

                    byte inc_idx;
                    if
                    :: (incoming == DIR_NONE) -> inc_idx = DIR_NONE_IDX
                    :: else -> inc_idx = incoming
                    fi;
                    nh = next_hop_ha[NH_IDX(cur_node, inc_idx, veh_dest[vid])];

                    if
                    :: (cur_node == SQ_A) ->
                        if
                        :: (nh == N00 &&
                            !node_occupied[N00] &&
                            GET_RS(ROAD_SQ_A, BWD, 0) == 0) ->
                            SET_RS(ROAD_SQ_A, BWD, 0, vid + 1);
                            veh_mode[vid]    = 1;
                            veh_road[vid]    = ROAD_SQ_A;
                            veh_dir[vid]     = BWD;
                            veh_slot[vid]    = 0;
                            veh_heading[vid] = DIR_NONE;
                            node_occupied[SQ_A] = true;
                            crossing_count[SQ_A] = crossing_count[SQ_A] + 1;
                            moved_this_step[vid] = true;
                            sq_a_forbidden[vid] = DIR_W
                        :: else -> skip
                        fi

                    :: else ->
                        out_dir  = DIR_NONE;
                        road_id  = 255;
                        lane_dir = FWD;

                        if
                        :: (cur_node == N00 && nh == N01)  -> out_dir = DIR_E; road_id = ROAD_H00; lane_dir = FWD
                        :: (cur_node == N00 && nh == N10)  -> out_dir = DIR_S; road_id = ROAD_V00; lane_dir = FWD
                        :: (cur_node == N00 && nh == SQ_A) -> out_dir = DIR_W; road_id = ROAD_SQ_A; lane_dir = FWD
                        :: (cur_node == N01 && nh == N_D)  -> out_dir = DIR_E; road_id = ROAD_H01; lane_dir = FWD
                        :: (cur_node == N01 && nh == N11)  -> out_dir = DIR_S; road_id = ROAD_V01; lane_dir = FWD
                        :: (cur_node == N01 && nh == N00)  -> out_dir = DIR_W; road_id = ROAD_H00; lane_dir = BWD
                        :: (cur_node == N_D && nh == N12)  -> out_dir = DIR_S; road_id = ROAD_V02; lane_dir = FWD
                        :: (cur_node == N_D && nh == N01)  -> out_dir = DIR_W; road_id = ROAD_H01; lane_dir = BWD
                        :: (cur_node == N10 && nh == N00)  -> out_dir = DIR_N; road_id = ROAD_V00; lane_dir = BWD
                        :: (cur_node == N10 && nh == N11)  -> out_dir = DIR_E; road_id = ROAD_H10; lane_dir = FWD
                        :: (cur_node == N10 && nh == N_B)  -> out_dir = DIR_S; road_id = ROAD_V10; lane_dir = FWD
                        :: (cur_node == N11 && nh == N01)  -> out_dir = DIR_N; road_id = ROAD_V01; lane_dir = BWD
                        :: (cur_node == N11 && nh == N12)  -> out_dir = DIR_E; road_id = ROAD_H11; lane_dir = FWD
                        :: (cur_node == N11 && nh == N21)  -> out_dir = DIR_S; road_id = ROAD_V11; lane_dir = FWD
                        :: (cur_node == N11 && nh == N10)  -> out_dir = DIR_W; road_id = ROAD_H10; lane_dir = BWD
                        :: (cur_node == N12 && nh == N_D)  -> out_dir = DIR_N; road_id = ROAD_V02; lane_dir = BWD
                        :: (cur_node == N12 && nh == N_C)  -> out_dir = DIR_S; road_id = ROAD_V12; lane_dir = FWD
                        :: (cur_node == N12 && nh == N11)  -> out_dir = DIR_W; road_id = ROAD_H11; lane_dir = BWD
                        :: (cur_node == N_B && nh == N10)  -> out_dir = DIR_N; road_id = ROAD_V10; lane_dir = BWD
                        :: (cur_node == N_B && nh == N21)  -> out_dir = DIR_E; road_id = ROAD_H20; lane_dir = FWD
                        :: (cur_node == N21 && nh == N11)  -> out_dir = DIR_N; road_id = ROAD_V11; lane_dir = BWD
                        :: (cur_node == N21 && nh == N_C)  -> out_dir = DIR_E; road_id = ROAD_H21; lane_dir = FWD
                        :: (cur_node == N21 && nh == N_B)  -> out_dir = DIR_W; road_id = ROAD_H20; lane_dir = BWD
                        :: (cur_node == N_C && nh == N12)  -> out_dir = DIR_N; road_id = ROAD_V12; lane_dir = BWD
                        :: (cur_node == N_C && nh == N21)  -> out_dir = DIR_W; road_id = ROAD_H21; lane_dir = BWD
                        :: else -> out_dir = DIR_NONE
                        fi;

                        if
                        :: (out_dir == DIR_NONE) -> skip
                        :: else ->
                            bool is_uturn = false;
                            if
                            :: (incoming != DIR_NONE && out_dir == incoming) ->
                                is_uturn = true; uturn_violation = true
                            :: else -> skip
                            fi;

                            bool is_forbidden = false;
                            if
                            :: (sq_a_forbidden[vid] != DIR_NONE && out_dir == sq_a_forbidden[vid]) ->
                                is_forbidden = true
                            :: else -> skip
                            fi;

                            if
                            :: is_uturn -> skip
                            :: is_forbidden -> skip
                            :: (!is_uturn && !is_forbidden && light_green[cur_node] != out_dir) -> skip
                            :: (!is_uturn && !is_forbidden && light_green[cur_node] == out_dir
                                && node_occupied[cur_node]) -> skip
                            :: (!is_uturn && !is_forbidden && light_green[cur_node] == out_dir
                                && !node_occupied[cur_node]
                                && GET_RS(road_id, lane_dir, 0) != 0) -> skip
                            :: (!is_uturn && !is_forbidden && light_green[cur_node] == out_dir
                                && !node_occupied[cur_node]
                                && GET_RS(road_id, lane_dir, 0) == 0) ->
                                SET_RS(road_id, lane_dir, 0, vid + 1);
                                veh_mode[vid]    = 1;
                                veh_road[vid]    = road_id;
                                veh_dir[vid]     = lane_dir;
                                veh_slot[vid]    = 0;
                                veh_heading[vid] = DIR_NONE;
                                node_occupied[cur_node] = true;
                                crossing_count[cur_node] = crossing_count[cur_node] + 1;
                                moved_this_step[vid] = true;
                                sq_a_forbidden[vid] = DIR_NONE
                            fi
                        fi
                    fi

                :: (veh_mode[vid] == 1) ->
                    cur_slot = veh_slot[vid];

                    if
                    :: (veh_road[vid] >= NUM_INT_ROADS) -> last_sl = 0
                    :: else -> last_sl = SLOTN - 1
                    fi;

                    if
                    :: (cur_slot < last_sl) ->
                        if
                        :: (GET_RS(veh_road[vid], veh_dir[vid], cur_slot + 1) == 0) ->
                            SET_RS(veh_road[vid], veh_dir[vid], cur_slot, 0);
                            veh_slot[vid] = cur_slot + 1;
                            SET_RS(veh_road[vid], veh_dir[vid], cur_slot + 1, vid + 1);
                            moved_this_step[vid] = true
                        :: else -> skip
                        fi

                    :: (cur_slot == last_sl) ->
                        dest_node  = 255;
                        in_heading = DIR_NONE;

                        if
                        :: (veh_road[vid] == ROAD_H00 && veh_dir[vid] == FWD) -> dest_node = N01;  in_heading = DIR_W
                        :: (veh_road[vid] == ROAD_H00 && veh_dir[vid] == BWD) -> dest_node = N00;  in_heading = DIR_E
                        :: (veh_road[vid] == ROAD_H01 && veh_dir[vid] == FWD) -> dest_node = N_D;  in_heading = DIR_W
                        :: (veh_road[vid] == ROAD_H01 && veh_dir[vid] == BWD) -> dest_node = N01;  in_heading = DIR_E
                        :: (veh_road[vid] == ROAD_H10 && veh_dir[vid] == FWD) -> dest_node = N11;  in_heading = DIR_W
                        :: (veh_road[vid] == ROAD_H10 && veh_dir[vid] == BWD) -> dest_node = N10;  in_heading = DIR_E
                        :: (veh_road[vid] == ROAD_H11 && veh_dir[vid] == FWD) -> dest_node = N12;  in_heading = DIR_W
                        :: (veh_road[vid] == ROAD_H11 && veh_dir[vid] == BWD) -> dest_node = N11;  in_heading = DIR_E
                        :: (veh_road[vid] == ROAD_H20 && veh_dir[vid] == FWD) -> dest_node = N21;  in_heading = DIR_W
                        :: (veh_road[vid] == ROAD_H20 && veh_dir[vid] == BWD) -> dest_node = N_B;  in_heading = DIR_E
                        :: (veh_road[vid] == ROAD_H21 && veh_dir[vid] == FWD) -> dest_node = N_C;  in_heading = DIR_W
                        :: (veh_road[vid] == ROAD_H21 && veh_dir[vid] == BWD) -> dest_node = N21;  in_heading = DIR_E
                        :: (veh_road[vid] == ROAD_V00 && veh_dir[vid] == FWD) -> dest_node = N10;  in_heading = DIR_N
                        :: (veh_road[vid] == ROAD_V00 && veh_dir[vid] == BWD) -> dest_node = N00;  in_heading = DIR_S
                        :: (veh_road[vid] == ROAD_V01 && veh_dir[vid] == FWD) -> dest_node = N11;  in_heading = DIR_N
                        :: (veh_road[vid] == ROAD_V01 && veh_dir[vid] == BWD) -> dest_node = N01;  in_heading = DIR_S
                        :: (veh_road[vid] == ROAD_V02 && veh_dir[vid] == FWD) -> dest_node = N12;  in_heading = DIR_N
                        :: (veh_road[vid] == ROAD_V02 && veh_dir[vid] == BWD) -> dest_node = N_D;  in_heading = DIR_S
                        :: (veh_road[vid] == ROAD_V10 && veh_dir[vid] == FWD) -> dest_node = N_B;  in_heading = DIR_N
                        :: (veh_road[vid] == ROAD_V10 && veh_dir[vid] == BWD) -> dest_node = N10;  in_heading = DIR_S
                        :: (veh_road[vid] == ROAD_V11 && veh_dir[vid] == FWD) -> dest_node = N21;  in_heading = DIR_N
                        :: (veh_road[vid] == ROAD_V11 && veh_dir[vid] == BWD) -> dest_node = N11;  in_heading = DIR_S
                        :: (veh_road[vid] == ROAD_V12 && veh_dir[vid] == FWD) -> dest_node = N_C;  in_heading = DIR_N
                        :: (veh_road[vid] == ROAD_V12 && veh_dir[vid] == BWD) -> dest_node = N12;  in_heading = DIR_S
                        :: (veh_road[vid] == ROAD_SQ_A && veh_dir[vid] == FWD) -> dest_node = SQ_A; in_heading = DIR_NONE
                        :: (veh_road[vid] == ROAD_SQ_A && veh_dir[vid] == BWD) -> dest_node = N00;  in_heading = DIR_NONE
                        :: else -> dest_node = 255
                        fi;

                        if
                        :: (dest_node == 255) -> skip
                        :: (dest_node != 255 && node_occupied[dest_node]) -> skip
                        :: (dest_node != 255 && !node_occupied[dest_node]) ->
                            SET_RS(veh_road[vid], veh_dir[vid], cur_slot, 0);
                            veh_mode[vid]    = 0;
                            veh_node[vid]    = dest_node;
                            veh_heading[vid] = in_heading;
                            node_occupied[dest_node] = true;
                            crossing_count[dest_node] = crossing_count[dest_node] + 1;
                            moved_this_step[vid] = true;

                            if
                            :: (dest_node == veh_dest[vid]) ->
                                if
                                :: (dest_node == N_B) -> visited_B[vid] = true
                                :: (dest_node == N_C) -> visited_C[vid] = true
                                :: (dest_node == N_D) -> visited_D[vid] = true
                                :: else -> skip
                                fi;

                                if
                                :: (veh_dest_idx[vid] < 3) ->
                                    veh_dest_idx[vid] = veh_dest_idx[vid] + 1;
                                    veh_dest[vid] = tour_stops[TS_IDX(vid, veh_dest_idx[vid])]
                                :: (veh_dest_idx[vid] >= 3) ->
                                    if
                                    :: (dest_node == SQ_A &&
                                        visited_B[vid] && visited_C[vid] && visited_D[vid]) ->
                                        returned_A[vid] = true
                                    :: else -> skip
                                    fi
                                fi
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
 * Environment -- non-deterministically spawns vehicles each tick.
 * SPIN explores ALL possible spawn timings up to MAX_ACTIVE total.
 * This is the source of non-determinism: any tick, any number of
 * vehicles (bounded by MAX_ACTIVE) can enter the system.
 * ================================================================ */
proctype Environment() {
    byte dummy;
    bool do_spawn;
    byte vid;

    do
    :: tick_env ? dummy ->
        /* Non-det choice evaluated outside d_step so 'run' is legal */
        if
        :: (active_count < MAX_ACTIVE) -> do_spawn = true
        :: skip                        -> do_spawn = false
        fi;

        if
        :: do_spawn ->
            d_step {
                vid = active_count;

                if
                :: (vid % 2 == 0) ->
                    tour_stops[TS_IDX(vid,0)] = N_B;
                    tour_stops[TS_IDX(vid,1)] = N_C;
                    tour_stops[TS_IDX(vid,2)] = N_D;
                    tour_stops[TS_IDX(vid,3)] = SQ_A
                :: else ->
                    tour_stops[TS_IDX(vid,0)] = N_D;
                    tour_stops[TS_IDX(vid,1)] = N_C;
                    tour_stops[TS_IDX(vid,2)] = N_B;
                    tour_stops[TS_IDX(vid,3)] = SQ_A
                fi;

                veh_mode[vid]       = 0;
                veh_node[vid]       = SQ_A;
                veh_heading[vid]    = DIR_NONE;
                veh_dest[vid]       = tour_stops[TS_IDX(vid,0)];
                veh_dest_idx[vid]   = 0;
                visited_B[vid]      = false;
                visited_C[vid]      = false;
                visited_D[vid]      = false;
                returned_A[vid]     = false;
                sq_a_forbidden[vid] = DIR_NONE;
                moved_this_step[vid]= false;
                veh_active[vid]     = true;
                active_count++
            };
            run VehicleFSM(vid)
        :: else -> skip
        fi;

        done_env ! 0
    od
}


/* ================================================================
 * init -- ClockFSM + initialization
 * ================================================================ */
init {
    short tick_count = 0;
    byte dummy;
    byte i;

    atomic {
        /* Clear all veh_active flags */
        i = 0;
        do
        :: (i < MAX_ACTIVE) -> veh_active[i] = false; i++
        :: (i >= MAX_ACTIVE) -> break
        od;

        /* Clear dir_green */
        i = 0;
        do
        :: (i < NUM_NODES * 4) -> dir_green[i] = false; i++
        :: (i >= NUM_NODES * 4) -> break
        od;
        /* Set initial greens to match light_green initial values */
        dir_green[DG_IDX(N00, DIR_E)] = true;
        dir_green[DG_IDX(N01, DIR_E)] = true;
        dir_green[DG_IDX(N_D, DIR_S)] = true;
        dir_green[DG_IDX(N10, DIR_N)] = true;
        dir_green[DG_IDX(N11, DIR_N)] = true;
        dir_green[DG_IDX(N12, DIR_N)] = true;
        dir_green[DG_IDX(N_B, DIR_N)] = true;
        dir_green[DG_IDX(N21, DIR_N)] = true;
        dir_green[DG_IDX(N_C, DIR_N)] = true;

        /* Clear light_enabled */
        i = 0;
        do
        :: (i < NUM_NODES * 4) -> light_enabled[i] = false; i++
        :: (i >= NUM_NODES * 4) -> break
        od;

        /* node 0 (0,0): E, S, W */
        light_enabled[LE_IDX(N00, DIR_E)] = true;
        light_enabled[LE_IDX(N00, DIR_S)] = true;
        light_enabled[LE_IDX(N00, DIR_W)] = true;

        /* node 1 (0,1): E, S, W */
        light_enabled[LE_IDX(N01, DIR_E)] = true;
        light_enabled[LE_IDX(N01, DIR_S)] = true;
        light_enabled[LE_IDX(N01, DIR_W)] = true;

        /* node 2 D=(0,2): S, W */
        light_enabled[LE_IDX(N_D, DIR_S)] = true;
        light_enabled[LE_IDX(N_D, DIR_W)] = true;

        /* node 3 (1,0): N, E, S */
        light_enabled[LE_IDX(N10, DIR_N)] = true;
        light_enabled[LE_IDX(N10, DIR_E)] = true;
        light_enabled[LE_IDX(N10, DIR_S)] = true;

        /* node 4 (1,1): N, E, S, W */
        light_enabled[LE_IDX(N11, DIR_N)] = true;
        light_enabled[LE_IDX(N11, DIR_E)] = true;
        light_enabled[LE_IDX(N11, DIR_S)] = true;
        light_enabled[LE_IDX(N11, DIR_W)] = true;

        /* node 5 (1,2): N, S, W */
        light_enabled[LE_IDX(N12, DIR_N)] = true;
        light_enabled[LE_IDX(N12, DIR_S)] = true;
        light_enabled[LE_IDX(N12, DIR_W)] = true;

        /* node 6 B=(2,0): N, E */
        light_enabled[LE_IDX(N_B, DIR_N)] = true;
        light_enabled[LE_IDX(N_B, DIR_E)] = true;

        /* node 7 (2,1): N, E, W */
        light_enabled[LE_IDX(N21, DIR_N)] = true;
        light_enabled[LE_IDX(N21, DIR_E)] = true;
        light_enabled[LE_IDX(N21, DIR_W)] = true;

        /* node 8 C=(2,2): N, W */
        light_enabled[LE_IDX(N_C, DIR_N)] = true;
        light_enabled[LE_IDX(N_C, DIR_W)] = true;

        /* node 9 sq A */
        light_enabled[LE_IDX(SQ_A, DIR_E)] = true;

        light_green[N00]  = DIR_E;
        light_green[N01]  = DIR_E;
        light_green[N_D]  = DIR_S;
        light_green[N10]  = DIR_N;
        light_green[N11]  = DIR_N;
        light_green[N12]  = DIR_N;
        light_green[N_B]  = DIR_N;
        light_green[N21]  = DIR_N;
        light_green[N_C]  = DIR_N;
        light_green[SQ_A] = DIR_E;

        i = 0;
        do
        :: (i < NUM_NODES * 4) -> red_streak[i] = 0; i++
        :: (i >= NUM_NODES * 4) -> break
        od;

        model_initialized = true
    };

    run InfraFSM();
    run Environment();

    do
    :: (tick_count >= MAX_TICKS) -> break

    :: else ->
        atomic {
            i = 0;
            do
            :: (i < NUM_NODES) ->
                node_occupied[i]  = false;
                crossing_count[i] = 0;
                i++
            :: (i >= NUM_NODES) -> break
            od;
            i = 0;
            do
            :: (i < MAX_ACTIVE) -> moved_this_step[i] = false; i++
            :: (i >= MAX_ACTIVE) -> break
            od
        };

        /* Phase 1: Infrastructure */
        tick_infra ! 0;
        done_infra ? dummy;

        /* Phase 2a: Environment may spawn a new vehicle */
        tick_env ! 0;
        done_env ? dummy;

        /* Phase 2b: Tick all active vehicles (no d_step: rendezvous channels) */
        i = 0;
        do
        :: (i < MAX_ACTIVE) ->
            if
            :: veh_active[i] -> tick_vehicle[i] ! 0
            :: else -> skip
            fi;
            i++
        :: (i >= MAX_ACTIVE) -> break
        od;
        i = 0;
        do
        :: (i < MAX_ACTIVE) ->
            if
            :: veh_active[i] -> done_vehicle[i] ? dummy
            :: else -> skip
            fi;
            i++
        :: (i >= MAX_ACTIVE) -> break
        od;

        /* Phase 3: Post-move invariant checks */
        check_invariants();

        assert(!collision);
        assert(!red_violation);
        assert(!uturn_violation);
        assert(!opposite_direction_violation);

        assert(crossing_count[N00] <= 1);
        assert(crossing_count[N01] <= 1);
        assert(crossing_count[N_D] <= 1);
        assert(crossing_count[N10] <= 1);
        assert(crossing_count[N11] <= 1);
        assert(crossing_count[N12] <= 1);
        assert(crossing_count[N_B] <= 1);
        assert(crossing_count[N21] <= 1);
        assert(crossing_count[N_C] <= 1);

        assert(light_green[N00] <= DIR_W && GET_LE(N00, light_green[N00]));
        assert(light_green[N01] <= DIR_W && GET_LE(N01, light_green[N01]));
        assert(light_green[N_D] <= DIR_W && GET_LE(N_D,  light_green[N_D]));
        assert(light_green[N10] <= DIR_W && GET_LE(N10, light_green[N10]));
        assert(light_green[N11] <= DIR_W && GET_LE(N11, light_green[N11]));
        assert(light_green[N12] <= DIR_W && GET_LE(N12, light_green[N12]));
        assert(light_green[N_B] <= DIR_W && GET_LE(N_B,  light_green[N_B]));
        assert(light_green[N21] <= DIR_W && GET_LE(N21, light_green[N21]));
        assert(light_green[N_C] <= DIR_W && GET_LE(N_C,  light_green[N_C]));

        tick_count++
    od
}

/* ================================================================
 * LTL Properties
 * ================================================================ */
ltl no_collision          { [] !collision }
ltl no_red_violation      { [] !red_violation }
ltl no_opposite_direction { [] !opposite_direction_violation }
ltl no_uturn              { [] !uturn_violation }

/* V-3: at most one green per intersection at any moment.
 * Uses dir_green[] booleans (one per direction per node) so the count
 * is explicit — SPIN verifies no two directions are simultaneously true. */
ltl mutual_exclusion_lights { [] (!model_initialized || (
    (GET_DG(N00,DIR_N) + GET_DG(N00,DIR_E) + GET_DG(N00,DIR_S) + GET_DG(N00,DIR_W)) <= 1 &&
    (GET_DG(N01,DIR_N) + GET_DG(N01,DIR_E) + GET_DG(N01,DIR_S) + GET_DG(N01,DIR_W)) <= 1 &&
    (GET_DG(N_D,DIR_N) + GET_DG(N_D,DIR_E) + GET_DG(N_D,DIR_S) + GET_DG(N_D,DIR_W)) <= 1 &&
    (GET_DG(N10,DIR_N) + GET_DG(N10,DIR_E) + GET_DG(N10,DIR_S) + GET_DG(N10,DIR_W)) <= 1 &&
    (GET_DG(N11,DIR_N) + GET_DG(N11,DIR_E) + GET_DG(N11,DIR_S) + GET_DG(N11,DIR_W)) <= 1 &&
    (GET_DG(N12,DIR_N) + GET_DG(N12,DIR_E) + GET_DG(N12,DIR_S) + GET_DG(N12,DIR_W)) <= 1 &&
    (GET_DG(N_B,DIR_N) + GET_DG(N_B,DIR_E) + GET_DG(N_B,DIR_S) + GET_DG(N_B,DIR_W)) <= 1 &&
    (GET_DG(N21,DIR_N) + GET_DG(N21,DIR_E) + GET_DG(N21,DIR_S) + GET_DG(N21,DIR_W)) <= 1 &&
    (GET_DG(N_C,DIR_N) + GET_DG(N_C,DIR_E) + GET_DG(N_C,DIR_S) + GET_DG(N_C,DIR_W)) <= 1
)) }

ltl eventual_green_bounded { [] (!model_initialized || (
    (RS_STREAK(N00, DIR_E) <= 5) && (RS_STREAK(N00, DIR_S) <= 5) && (RS_STREAK(N00, DIR_W) <= 5) &&
    (RS_STREAK(N01, DIR_E) <= 5) && (RS_STREAK(N01, DIR_S) <= 5) && (RS_STREAK(N01, DIR_W) <= 5) &&
    (RS_STREAK(N_D, DIR_S) <= 4) && (RS_STREAK(N_D, DIR_W) <= 4) &&
    (RS_STREAK(N10, DIR_N) <= 5) && (RS_STREAK(N10, DIR_E) <= 5) && (RS_STREAK(N10, DIR_S) <= 5) &&
    (RS_STREAK(N11, DIR_N) <= 6) && (RS_STREAK(N11, DIR_E) <= 6) &&
    (RS_STREAK(N11, DIR_S) <= 6) && (RS_STREAK(N11, DIR_W) <= 6) &&
    (RS_STREAK(N12, DIR_N) <= 5) && (RS_STREAK(N12, DIR_S) <= 5) && (RS_STREAK(N12, DIR_W) <= 5) &&
    (RS_STREAK(N_B, DIR_N) <= 4) && (RS_STREAK(N_B, DIR_E) <= 4) &&
    (RS_STREAK(N21, DIR_N) <= 5) && (RS_STREAK(N21, DIR_E) <= 5) && (RS_STREAK(N21, DIR_W) <= 5) &&
    (RS_STREAK(N_C, DIR_N) <= 4) && (RS_STREAK(N_C, DIR_W) <= 4)
)) }

ltl intersection_crossing_bound { [] (
    (crossing_count[N00] <= 1) &&
    (crossing_count[N01] <= 1) &&
    (crossing_count[N_D] <= 1) &&
    (crossing_count[N10] <= 1) &&
    (crossing_count[N11] <= 1) &&
    (crossing_count[N12] <= 1) &&
    (crossing_count[N_B] <= 1) &&
    (crossing_count[N21] <= 1) &&
    (crossing_count[N_C] <= 1)
) }

/* V-5 (self-chosen): every signal is in exactly one of two states — green or red.
 * light_green[i] holds the single green direction (0..3).
 * dir_green[n*4+d] is true for exactly that direction, false for all others.
 * Together they must be consistent: dir_green[n*4+d] == (light_green[n] == d).
 * This rules out any third state (e.g. yellow, undefined, or corrupted value). */
ltl binary_light_state { [] (!model_initialized || (
    (GET_DG(N00,DIR_N) == (light_green[N00] == DIR_N)) &&
    (GET_DG(N00,DIR_E) == (light_green[N00] == DIR_E)) &&
    (GET_DG(N00,DIR_S) == (light_green[N00] == DIR_S)) &&
    (GET_DG(N00,DIR_W) == (light_green[N00] == DIR_W)) &&
    (GET_DG(N01,DIR_N) == (light_green[N01] == DIR_N)) &&
    (GET_DG(N01,DIR_E) == (light_green[N01] == DIR_E)) &&
    (GET_DG(N01,DIR_S) == (light_green[N01] == DIR_S)) &&
    (GET_DG(N01,DIR_W) == (light_green[N01] == DIR_W)) &&
    (GET_DG(N_D,DIR_N) == (light_green[N_D] == DIR_N)) &&
    (GET_DG(N_D,DIR_E) == (light_green[N_D] == DIR_E)) &&
    (GET_DG(N_D,DIR_S) == (light_green[N_D] == DIR_S)) &&
    (GET_DG(N_D,DIR_W) == (light_green[N_D] == DIR_W)) &&
    (GET_DG(N10,DIR_N) == (light_green[N10] == DIR_N)) &&
    (GET_DG(N10,DIR_E) == (light_green[N10] == DIR_E)) &&
    (GET_DG(N10,DIR_S) == (light_green[N10] == DIR_S)) &&
    (GET_DG(N10,DIR_W) == (light_green[N10] == DIR_W)) &&
    (GET_DG(N11,DIR_N) == (light_green[N11] == DIR_N)) &&
    (GET_DG(N11,DIR_E) == (light_green[N11] == DIR_E)) &&
    (GET_DG(N11,DIR_S) == (light_green[N11] == DIR_S)) &&
    (GET_DG(N11,DIR_W) == (light_green[N11] == DIR_W)) &&
    (GET_DG(N12,DIR_N) == (light_green[N12] == DIR_N)) &&
    (GET_DG(N12,DIR_E) == (light_green[N12] == DIR_E)) &&
    (GET_DG(N12,DIR_S) == (light_green[N12] == DIR_S)) &&
    (GET_DG(N12,DIR_W) == (light_green[N12] == DIR_W)) &&
    (GET_DG(N_B,DIR_N) == (light_green[N_B] == DIR_N)) &&
    (GET_DG(N_B,DIR_E) == (light_green[N_B] == DIR_E)) &&
    (GET_DG(N_B,DIR_S) == (light_green[N_B] == DIR_S)) &&
    (GET_DG(N_B,DIR_W) == (light_green[N_B] == DIR_W)) &&
    (GET_DG(N21,DIR_N) == (light_green[N21] == DIR_N)) &&
    (GET_DG(N21,DIR_E) == (light_green[N21] == DIR_E)) &&
    (GET_DG(N21,DIR_S) == (light_green[N21] == DIR_S)) &&
    (GET_DG(N21,DIR_W) == (light_green[N21] == DIR_W)) &&
    (GET_DG(N_C,DIR_N) == (light_green[N_C] == DIR_N)) &&
    (GET_DG(N_C,DIR_E) == (light_green[N_C] == DIR_E)) &&
    (GET_DG(N_C,DIR_S) == (light_green[N_C] == DIR_S)) &&
    (GET_DG(N_C,DIR_W) == (light_green[N_C] == DIR_W))
)) }

/* V-5: Unconditional infrastructure fairness — every enabled direction gets green
 * within MAX_STREAK cycles regardless of whether any vehicle is present.
 * RS_STREAK increments every red tick unconditionally; starvation prevention
 * fires on the counter alone, making fairness demand-independent. */
ltl unconditional_fair_green { [] (!model_initialized || (
    (RS_STREAK(N00,DIR_E) <= 5) && (RS_STREAK(N00,DIR_S) <= 5) && (RS_STREAK(N00,DIR_W) <= 5) &&
    (RS_STREAK(N01,DIR_E) <= 5) && (RS_STREAK(N01,DIR_S) <= 5) && (RS_STREAK(N01,DIR_W) <= 5) &&
    (RS_STREAK(N_D,DIR_S) <= 4) && (RS_STREAK(N_D,DIR_W) <= 4) &&
    (RS_STREAK(N10,DIR_N) <= 5) && (RS_STREAK(N10,DIR_E) <= 5) && (RS_STREAK(N10,DIR_S) <= 5) &&
    (RS_STREAK(N11,DIR_N) <= 6) && (RS_STREAK(N11,DIR_E) <= 6) &&
    (RS_STREAK(N11,DIR_S) <= 6) && (RS_STREAK(N11,DIR_W) <= 6) &&
    (RS_STREAK(N12,DIR_N) <= 5) && (RS_STREAK(N12,DIR_S) <= 5) && (RS_STREAK(N12,DIR_W) <= 5) &&
    (RS_STREAK(N_B,DIR_N) <= 4) && (RS_STREAK(N_B,DIR_E) <= 4) &&
    (RS_STREAK(N21,DIR_N) <= 5) && (RS_STREAK(N21,DIR_E) <= 5) && (RS_STREAK(N21,DIR_W) <= 5) &&
    (RS_STREAK(N_C,DIR_N) <= 4) && (RS_STREAK(N_C,DIR_W) <= 4)
)) }

/* V-6: Vehicle progress — every active vehicle waiting at an intersection (mode==0)
 * will not be starved. Checked by bounding the red streak of the current green
 * direction at the vehicle's node: if it has been green too long, the other
 * directions (including the one the vehicle needs) will be forced green soon.
 * Bound 6 covers the worst-case 4-direction center node. */
ltl vehicle_green_progress { [] (!model_initialized || (
    (!veh_active[0] || veh_mode[0] != 0 || RS_STREAK(veh_node[0], light_green[veh_node[0]]) <= 6) &&
    (!veh_active[1] || veh_mode[1] != 0 || RS_STREAK(veh_node[1], light_green[veh_node[1]]) <= 6) &&
    (!veh_active[2] || veh_mode[2] != 0 || RS_STREAK(veh_node[2], light_green[veh_node[2]]) <= 6)
)) }
