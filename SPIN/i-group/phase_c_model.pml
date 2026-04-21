/* ================================================================
 * Phase C Model — 3×3 Grid with Square Node A
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
 *   sq A <- r12 -> (0,0)   FWD=west(toward A), BWD=east(toward (0,0))
 *
 * Node IDs (0..9):
 *   (0,0)=0  (0,1)=1  D=(0,2)=2
 *   (1,0)=3  (1,1)=4  (1,2)=5
 *   B=(2,0)=6  (2,1)=7  C=(2,2)=8
 *   sq A = 9  (ONLY square node -- no signal)
 *
 * Roads (0..12):
 *   Horizontal: r0=(0,0)-(0,1)  r1=(0,1)-(0,2)  r2=(1,0)-(1,1)
 *               r3=(1,1)-(1,2)  r4=(2,0)-(2,1)  r5=(2,1)-(2,2)
 *   Vertical:   r6=(0,0)-(1,0)  r7=(0,1)-(1,1)  r8=(0,2)-(1,2)
 *               r9=(1,0)-(2,0)  r10=(1,1)-(2,1) r11=(1,2)-(2,2)
 *   Square:     r12=(0,0)-sqA
 *
 * Direction indices: 0=North, 1=East, 2=South, 3=West
 *
 * Phase C-2 additions:
 *   - next_hop[src*NUM_NODES+dst]: precomputed BFS table (no U-turn)
 *   - Vehicles start at sq A, tour B/C/D in fixed orderings, return to sq A
 *   - visited_B/C/D[vid] flags set on arrival at nodes 6/8/2
 *   - all_tours_done set when both vehicles visited B,C,D and returned to sq A
 *   - post-sq-A forbidden heading: cannot re-enter sq A the tick after leaving it
 * ================================================================ */

#define NVEH          2
#define SLOTN         3
#define SLOTN_SQ      1
#define NUM_INTS      9
#define NUM_SQ        1
#define NUM_NODES     10
#define NUM_ROADS     13
#define NUM_INT_ROADS 12
#define MAX_TICKS     120
#define MAX_RED_WAIT  4
#define ROUTE_LEN     20

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
 *   inc_idx: 0=N,1=E,2=S,3=W,4=NONE(no constraint)
 * = first node to move to from src (with given incoming heading) toward dst.
 * Self-entry (src==dst) = src.  255 = unreachable given heading constraint.
 * Generated offline; verified for all tour orderings.
 * ================================================================ */
#define NH_IDX(src,inc,dst) ((src)*50 + (inc)*10 + (dst))
#define DIR_NONE_IDX 4   /* inc_idx for no constraint */

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

/* Road slot occupancy: 0=empty, vehicle_id+1 otherwise */
/* Index: road * (2*SLOTN) + dir * SLOTN + slot */
byte road_slots[NUM_ROADS * 2 * SLOTN];
#define RS_IDX(road,dir,slot)      ((road)*(2*SLOTN)+(dir)*SLOTN+(slot))
#define GET_RS(road,dir,slot)      road_slots[RS_IDX(road,dir,slot)]
#define SET_RS(road,dir,slot,val)  road_slots[RS_IDX(road,dir,slot)] = val

/* Intersection light state: which direction index is green */
byte light_green[NUM_NODES];

/* Which directions are enabled at each node */
bool light_enabled[NUM_NODES * 4];
#define LE_IDX(n,d)    ((n)*4+(d))
#define GET_LE(n,d)    light_enabled[LE_IDX(n,d)]

/* Per-node starvation counters */
byte red_streak[NUM_NODES * 4];
#define RS_STREAK(n,d) red_streak[LE_IDX(n,d)]

/* Vehicle state */
byte veh_mode[NVEH];       /* 0=at node, 1=on road */
byte veh_node[NVEH];       /* if mode==0: which node (0..9) */
byte veh_road[NVEH];       /* if mode==1: which road */
byte veh_dir[NVEH];        /* if mode==1: lane direction FWD/BWD */
byte veh_slot[NVEH];       /* if mode==1: slot position */
byte veh_heading[NVEH];    /* incoming direction at node, or DIR_NONE */

/* Tour state */
byte veh_dest[NVEH];       /* current tour destination node */
byte veh_dest_idx[NVEH];   /* index into tour_stops[vid] (0..3) */
bool visited_B[NVEH];      /* has vehicle visited N_B? */
bool visited_C[NVEH];      /* has vehicle visited N_C? */
bool visited_D[NVEH];      /* has vehicle visited N_D? */
bool returned_A[NVEH];     /* has vehicle returned to SQ_A after visiting all? */

/* Tour waypoints per vehicle:
 *   V0: SQ_A -> N_B -> N_C -> N_D -> SQ_A  (B->C->D ordering)
 *   V1: SQ_A -> N_D -> N_C -> N_B -> SQ_A  (D->C->B ordering)
 * Stored as sequence of destination nodes (not full path nodes).
 */
byte tour_stops[NVEH * 4];   /* 4 stops per vehicle (B/C/D + return) */
#define TS_IDX(vid,i) ((vid)*4+(i))

/* Post-sq-A forbidden heading: set to DIR_W when leaving sq A, cleared on next intersection */
byte sq_a_forbidden[NVEH];   /* DIR_W = cannot re-enter sq A; DIR_NONE = no restriction */

/* Per-step state */
bool node_occupied[NUM_NODES];
bool moved_this_step[NVEH];
byte crossing_count[NUM_NODES];

/* --- Property monitors --- */
bool collision = false;
bool red_violation = false;
bool uturn_violation = false;
bool opposite_direction_violation = false;
bool all_tours_done = false;
bool model_initialized = false;

/* --- Tick synchronization --- */
chan tick_infra       = [0] of { byte };
chan done_infra       = [0] of { byte };
chan tick_vehicle[NVEH] = [0] of { byte };
chan done_vehicle[NVEH] = [0] of { byte };


/* ================================================================
 * InfrastructureFSM -- Congestion-aware lights for nodes 0..8
 * Node 9 (sq A) has no signal and is skipped.
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

                /* Count vehicles approaching from each enabled direction */
                d = 0;
                do
                :: (d < 4) ->
                    counts[d] = 0;
                    if
                    :: GET_LE(nid, d) ->
                        road_id = 255;
                        lane_dir = FWD;

                        /* Approach counting: (node, direction) -> (road_id, lane_dir) */
                        if
                        /* node 0 (0,0) */
                        :: (nid == N00 && d == DIR_E) -> road_id = ROAD_H00; lane_dir = BWD
                        :: (nid == N00 && d == DIR_S) -> road_id = ROAD_V00; lane_dir = BWD
                        :: (nid == N00 && d == DIR_W) -> road_id = ROAD_SQ_A; lane_dir = BWD
                        /* node 1 (0,1) */
                        :: (nid == N01 && d == DIR_E) -> road_id = ROAD_H01; lane_dir = BWD
                        :: (nid == N01 && d == DIR_S) -> road_id = ROAD_V01; lane_dir = BWD
                        :: (nid == N01 && d == DIR_W) -> road_id = ROAD_H00; lane_dir = FWD
                        /* node 2 D=(0,2) */
                        :: (nid == N_D && d == DIR_S) -> road_id = ROAD_V02; lane_dir = BWD
                        :: (nid == N_D && d == DIR_W) -> road_id = ROAD_H01; lane_dir = FWD
                        /* node 3 (1,0) */
                        :: (nid == N10 && d == DIR_N) -> road_id = ROAD_V00; lane_dir = FWD
                        :: (nid == N10 && d == DIR_E) -> road_id = ROAD_H10; lane_dir = BWD
                        :: (nid == N10 && d == DIR_S) -> road_id = ROAD_V10; lane_dir = BWD
                        /* node 4 (1,1) */
                        :: (nid == N11 && d == DIR_N) -> road_id = ROAD_V01; lane_dir = FWD
                        :: (nid == N11 && d == DIR_E) -> road_id = ROAD_H11; lane_dir = BWD
                        :: (nid == N11 && d == DIR_S) -> road_id = ROAD_V11; lane_dir = BWD
                        :: (nid == N11 && d == DIR_W) -> road_id = ROAD_H10; lane_dir = FWD
                        /* node 5 (1,2) */
                        :: (nid == N12 && d == DIR_N) -> road_id = ROAD_V02; lane_dir = FWD
                        :: (nid == N12 && d == DIR_S) -> road_id = ROAD_V12; lane_dir = BWD
                        :: (nid == N12 && d == DIR_W) -> road_id = ROAD_H11; lane_dir = FWD
                        /* node 6 B=(2,0) */
                        :: (nid == N_B && d == DIR_N) -> road_id = ROAD_V10; lane_dir = FWD
                        :: (nid == N_B && d == DIR_E) -> road_id = ROAD_H20; lane_dir = BWD
                        /* node 7 (2,1) */
                        :: (nid == N21 && d == DIR_N) -> road_id = ROAD_V11; lane_dir = FWD
                        :: (nid == N21 && d == DIR_E) -> road_id = ROAD_H21; lane_dir = BWD
                        :: (nid == N21 && d == DIR_W) -> road_id = ROAD_H20; lane_dir = FWD
                        /* node 8 C=(2,2) */
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

                /* Check starvation */
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

                /* Choose green */
                if
                :: (starved_dir != DIR_NONE) ->
                    light_green[nid] = starved_dir
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

                    light_green[nid] = best_dir
                fi;

                /* Update starvation counters */
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
            /* node 9 (sq A) has no signal -- skipped */
        };

        /* Post-d_step: assert exactly 1 green per intersection (nodes 0..8) */
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
 * check_invariants -- Post-move property checking
 * ================================================================ */
inline check_invariants() {
    /* --- Collision detection --- */
    if
    :: (veh_mode[0] == 1 && veh_mode[1] == 1 &&
        veh_road[0] == veh_road[1] &&
        veh_dir[0]  == veh_dir[1]  &&
        veh_slot[0] == veh_slot[1]) ->
        collision = true
    :: else -> skip
    fi;

    if
    :: (veh_mode[0] == 1 && GET_RS(veh_road[0], veh_dir[0], veh_slot[0]) != 1) ->
        collision = true
    :: (veh_mode[0] == 1 && GET_RS(veh_road[0], veh_dir[0], veh_slot[0]) == 1) -> skip
    :: (veh_mode[0] == 0) -> skip
    fi;
    if
    :: (veh_mode[1] == 1 && GET_RS(veh_road[1], veh_dir[1], veh_slot[1]) != 2) ->
        collision = true
    :: (veh_mode[1] == 1 && GET_RS(veh_road[1], veh_dir[1], veh_slot[1]) == 2) -> skip
    :: (veh_mode[1] == 0) -> skip
    fi;

    /* --- Red-light violation detection ---
     * If a vehicle just entered a road (mode==1, slot==0, moved_this_step),
     * check source node and direction from (road, lane_dir).
     * sq A (node 9) has no signal -- road 12 BWD exit is always free. */
    if
    :: (veh_mode[0] == 1 && veh_slot[0] == 0 && moved_this_step[0]) ->
        byte src_n0 = 255;
        byte src_d0 = DIR_NONE;
        if
        :: (veh_road[0] == ROAD_H00 && veh_dir[0] == FWD) -> src_n0 = N00;  src_d0 = DIR_E
        :: (veh_road[0] == ROAD_H00 && veh_dir[0] == BWD) -> src_n0 = N01;  src_d0 = DIR_W
        :: (veh_road[0] == ROAD_H01 && veh_dir[0] == FWD) -> src_n0 = N01;  src_d0 = DIR_E
        :: (veh_road[0] == ROAD_H01 && veh_dir[0] == BWD) -> src_n0 = N_D;  src_d0 = DIR_W
        :: (veh_road[0] == ROAD_H10 && veh_dir[0] == FWD) -> src_n0 = N10;  src_d0 = DIR_E
        :: (veh_road[0] == ROAD_H10 && veh_dir[0] == BWD) -> src_n0 = N11;  src_d0 = DIR_W
        :: (veh_road[0] == ROAD_H11 && veh_dir[0] == FWD) -> src_n0 = N11;  src_d0 = DIR_E
        :: (veh_road[0] == ROAD_H11 && veh_dir[0] == BWD) -> src_n0 = N12;  src_d0 = DIR_W
        :: (veh_road[0] == ROAD_H20 && veh_dir[0] == FWD) -> src_n0 = N_B;  src_d0 = DIR_E
        :: (veh_road[0] == ROAD_H20 && veh_dir[0] == BWD) -> src_n0 = N21;  src_d0 = DIR_W
        :: (veh_road[0] == ROAD_H21 && veh_dir[0] == FWD) -> src_n0 = N21;  src_d0 = DIR_E
        :: (veh_road[0] == ROAD_H21 && veh_dir[0] == BWD) -> src_n0 = N_C;  src_d0 = DIR_W
        :: (veh_road[0] == ROAD_V00 && veh_dir[0] == FWD) -> src_n0 = N00;  src_d0 = DIR_S
        :: (veh_road[0] == ROAD_V00 && veh_dir[0] == BWD) -> src_n0 = N10;  src_d0 = DIR_N
        :: (veh_road[0] == ROAD_V01 && veh_dir[0] == FWD) -> src_n0 = N01;  src_d0 = DIR_S
        :: (veh_road[0] == ROAD_V01 && veh_dir[0] == BWD) -> src_n0 = N11;  src_d0 = DIR_N
        :: (veh_road[0] == ROAD_V02 && veh_dir[0] == FWD) -> src_n0 = N_D;  src_d0 = DIR_S
        :: (veh_road[0] == ROAD_V02 && veh_dir[0] == BWD) -> src_n0 = N12;  src_d0 = DIR_N
        :: (veh_road[0] == ROAD_V10 && veh_dir[0] == FWD) -> src_n0 = N10;  src_d0 = DIR_S
        :: (veh_road[0] == ROAD_V10 && veh_dir[0] == BWD) -> src_n0 = N_B;  src_d0 = DIR_N
        :: (veh_road[0] == ROAD_V11 && veh_dir[0] == FWD) -> src_n0 = N11;  src_d0 = DIR_S
        :: (veh_road[0] == ROAD_V11 && veh_dir[0] == BWD) -> src_n0 = N21;  src_d0 = DIR_N
        :: (veh_road[0] == ROAD_V12 && veh_dir[0] == FWD) -> src_n0 = N12;  src_d0 = DIR_S
        :: (veh_road[0] == ROAD_V12 && veh_dir[0] == BWD) -> src_n0 = N_C;  src_d0 = DIR_N
        :: (veh_road[0] == ROAD_SQ_A && veh_dir[0] == FWD) -> src_n0 = N00;  src_d0 = DIR_W
        :: (veh_road[0] == ROAD_SQ_A && veh_dir[0] == BWD) -> src_n0 = 255; src_d0 = DIR_NONE
        :: else -> skip
        fi;
        if
        :: (src_n0 != 255 && light_green[src_n0] != src_d0) ->
            red_violation = true
        :: else -> skip
        fi
    :: else -> skip
    fi;
    if
    :: (veh_mode[1] == 1 && veh_slot[1] == 0 && moved_this_step[1]) ->
        byte src_n1 = 255;
        byte src_d1 = DIR_NONE;
        if
        :: (veh_road[1] == ROAD_H00 && veh_dir[1] == FWD) -> src_n1 = N00;  src_d1 = DIR_E
        :: (veh_road[1] == ROAD_H00 && veh_dir[1] == BWD) -> src_n1 = N01;  src_d1 = DIR_W
        :: (veh_road[1] == ROAD_H01 && veh_dir[1] == FWD) -> src_n1 = N01;  src_d1 = DIR_E
        :: (veh_road[1] == ROAD_H01 && veh_dir[1] == BWD) -> src_n1 = N_D;  src_d1 = DIR_W
        :: (veh_road[1] == ROAD_H10 && veh_dir[1] == FWD) -> src_n1 = N10;  src_d1 = DIR_E
        :: (veh_road[1] == ROAD_H10 && veh_dir[1] == BWD) -> src_n1 = N11;  src_d1 = DIR_W
        :: (veh_road[1] == ROAD_H11 && veh_dir[1] == FWD) -> src_n1 = N11;  src_d1 = DIR_E
        :: (veh_road[1] == ROAD_H11 && veh_dir[1] == BWD) -> src_n1 = N12;  src_d1 = DIR_W
        :: (veh_road[1] == ROAD_H20 && veh_dir[1] == FWD) -> src_n1 = N_B;  src_d1 = DIR_E
        :: (veh_road[1] == ROAD_H20 && veh_dir[1] == BWD) -> src_n1 = N21;  src_d1 = DIR_W
        :: (veh_road[1] == ROAD_H21 && veh_dir[1] == FWD) -> src_n1 = N21;  src_d1 = DIR_E
        :: (veh_road[1] == ROAD_H21 && veh_dir[1] == BWD) -> src_n1 = N_C;  src_d1 = DIR_W
        :: (veh_road[1] == ROAD_V00 && veh_dir[1] == FWD) -> src_n1 = N00;  src_d1 = DIR_S
        :: (veh_road[1] == ROAD_V00 && veh_dir[1] == BWD) -> src_n1 = N10;  src_d1 = DIR_N
        :: (veh_road[1] == ROAD_V01 && veh_dir[1] == FWD) -> src_n1 = N01;  src_d1 = DIR_S
        :: (veh_road[1] == ROAD_V01 && veh_dir[1] == BWD) -> src_n1 = N11;  src_d1 = DIR_N
        :: (veh_road[1] == ROAD_V02 && veh_dir[1] == FWD) -> src_n1 = N_D;  src_d1 = DIR_S
        :: (veh_road[1] == ROAD_V02 && veh_dir[1] == BWD) -> src_n1 = N12;  src_d1 = DIR_N
        :: (veh_road[1] == ROAD_V10 && veh_dir[1] == FWD) -> src_n1 = N10;  src_d1 = DIR_S
        :: (veh_road[1] == ROAD_V10 && veh_dir[1] == BWD) -> src_n1 = N_B;  src_d1 = DIR_N
        :: (veh_road[1] == ROAD_V11 && veh_dir[1] == FWD) -> src_n1 = N11;  src_d1 = DIR_S
        :: (veh_road[1] == ROAD_V11 && veh_dir[1] == BWD) -> src_n1 = N21;  src_d1 = DIR_N
        :: (veh_road[1] == ROAD_V12 && veh_dir[1] == FWD) -> src_n1 = N12;  src_d1 = DIR_S
        :: (veh_road[1] == ROAD_V12 && veh_dir[1] == BWD) -> src_n1 = N_C;  src_d1 = DIR_N
        :: (veh_road[1] == ROAD_SQ_A && veh_dir[1] == FWD) -> src_n1 = N00;  src_d1 = DIR_W
        :: (veh_road[1] == ROAD_SQ_A && veh_dir[1] == BWD) -> src_n1 = 255; src_d1 = DIR_NONE
        :: else -> skip
        fi;
        if
        :: (src_n1 != 255 && light_green[src_n1] != src_d1) ->
            red_violation = true
        :: else -> skip
        fi
    :: else -> skip
    fi;

    /* --- Opposite-direction violation: slot must hold correct vehicle id --- */
    if
    :: (veh_mode[0] == 1 && GET_RS(veh_road[0], veh_dir[0], veh_slot[0]) != 1) ->
        opposite_direction_violation = true
    :: else -> skip
    fi;
    if
    :: (veh_mode[1] == 1 && GET_RS(veh_road[1], veh_dir[1], veh_slot[1]) != 2) ->
        opposite_direction_violation = true
    :: else -> skip
    fi
}


/* ================================================================
 * VehicleFSM -- next_hop-driven tour with road traversal.
 *
 * Tour logic:
 *   veh_dest[vid]     = current destination node
 *   veh_dest_idx[vid] = which stop in tour_stops we're heading to
 *
 * When arriving at dest node:
 *   - mark visited_B/C/D if applicable
 *   - advance dest_idx, update veh_dest to next stop
 *   - if returned to SQ_A after all visited: set returned_A
 *
 * next_hop lookup at each node gives the next intermediate node.
 *
 * Special handling for sq A (node 9):
 *   - No light check, no U-turn check (dead end, one exit east)
 *   - Post-sq-A: after leaving sq A, cannot re-enter sq A for 1 step
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
            :: returned_A[vid] -> skip   /* tour complete, vehicle idles */
            :: else ->

                if
                /* ---- At a node (mode == 0) ---- */
                :: (veh_mode[vid] == 0) ->
                    cur_node = veh_node[vid];
                    incoming = veh_heading[vid];

                    /* Look up next hop toward current destination (heading-aware) */
                    byte inc_idx;
                    if
                    :: (incoming == DIR_NONE) -> inc_idx = DIR_NONE_IDX
                    :: else -> inc_idx = incoming
                    fi;
                    nh = next_hop_ha[NH_IDX(cur_node, inc_idx, veh_dest[vid])];

                    /* Special: sq A -- no signal, only exit east to N00 */
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
                            /* Set post-sq-A forbidden heading (cannot immediately re-enter sq A) */
                            sq_a_forbidden[vid] = DIR_W
                        :: else -> skip
                        fi

                    /* Normal intersection node */
                    :: else ->
                        out_dir  = DIR_NONE;
                        road_id  = 255;
                        lane_dir = FWD;

                        /* Exit lookup: (cur_node, nh) -> (out_dir, road_id, lane_dir) */
                        if
                        /* From N00 (0,0) */
                        :: (cur_node == N00 && nh == N01)  -> out_dir = DIR_E; road_id = ROAD_H00; lane_dir = FWD
                        :: (cur_node == N00 && nh == N10)  -> out_dir = DIR_S; road_id = ROAD_V00; lane_dir = FWD
                        :: (cur_node == N00 && nh == SQ_A) -> out_dir = DIR_W; road_id = ROAD_SQ_A; lane_dir = FWD
                        /* From N01 (0,1) */
                        :: (cur_node == N01 && nh == N_D)  -> out_dir = DIR_E; road_id = ROAD_H01; lane_dir = FWD
                        :: (cur_node == N01 && nh == N11)  -> out_dir = DIR_S; road_id = ROAD_V01; lane_dir = FWD
                        :: (cur_node == N01 && nh == N00)  -> out_dir = DIR_W; road_id = ROAD_H00; lane_dir = BWD
                        /* From N_D (0,2) */
                        :: (cur_node == N_D && nh == N12)  -> out_dir = DIR_S; road_id = ROAD_V02; lane_dir = FWD
                        :: (cur_node == N_D && nh == N01)  -> out_dir = DIR_W; road_id = ROAD_H01; lane_dir = BWD
                        /* From N10 (1,0) */
                        :: (cur_node == N10 && nh == N00)  -> out_dir = DIR_N; road_id = ROAD_V00; lane_dir = BWD
                        :: (cur_node == N10 && nh == N11)  -> out_dir = DIR_E; road_id = ROAD_H10; lane_dir = FWD
                        :: (cur_node == N10 && nh == N_B)  -> out_dir = DIR_S; road_id = ROAD_V10; lane_dir = FWD
                        /* From N11 (1,1) */
                        :: (cur_node == N11 && nh == N01)  -> out_dir = DIR_N; road_id = ROAD_V01; lane_dir = BWD
                        :: (cur_node == N11 && nh == N12)  -> out_dir = DIR_E; road_id = ROAD_H11; lane_dir = FWD
                        :: (cur_node == N11 && nh == N21)  -> out_dir = DIR_S; road_id = ROAD_V11; lane_dir = FWD
                        :: (cur_node == N11 && nh == N10)  -> out_dir = DIR_W; road_id = ROAD_H10; lane_dir = BWD
                        /* From N12 (1,2) */
                        :: (cur_node == N12 && nh == N_D)  -> out_dir = DIR_N; road_id = ROAD_V02; lane_dir = BWD
                        :: (cur_node == N12 && nh == N_C)  -> out_dir = DIR_S; road_id = ROAD_V12; lane_dir = FWD
                        :: (cur_node == N12 && nh == N11)  -> out_dir = DIR_W; road_id = ROAD_H11; lane_dir = BWD
                        /* From N_B (2,0) */
                        :: (cur_node == N_B && nh == N10)  -> out_dir = DIR_N; road_id = ROAD_V10; lane_dir = BWD
                        :: (cur_node == N_B && nh == N21)  -> out_dir = DIR_E; road_id = ROAD_H20; lane_dir = FWD
                        /* From N21 (2,1) */
                        :: (cur_node == N21 && nh == N11)  -> out_dir = DIR_N; road_id = ROAD_V11; lane_dir = BWD
                        :: (cur_node == N21 && nh == N_C)  -> out_dir = DIR_E; road_id = ROAD_H21; lane_dir = FWD
                        :: (cur_node == N21 && nh == N_B)  -> out_dir = DIR_W; road_id = ROAD_H20; lane_dir = BWD
                        /* From N_C (2,2) */
                        :: (cur_node == N_C && nh == N12)  -> out_dir = DIR_N; road_id = ROAD_V12; lane_dir = BWD
                        :: (cur_node == N_C && nh == N21)  -> out_dir = DIR_W; road_id = ROAD_H21; lane_dir = BWD
                        :: else -> out_dir = DIR_NONE
                        fi;

                        if
                        :: (out_dir == DIR_NONE) -> skip
                        :: else ->
                            /* No-U-turn check.
                             * in_heading = direction FROM WHICH vehicle arrived (source compass bearing).
                             * U-turn = going back toward that source, i.e. out_dir == incoming. */
                            bool is_uturn = false;
                            if
                            :: (incoming != DIR_NONE && out_dir == incoming) ->
                                is_uturn = true; uturn_violation = true
                            :: else -> skip
                            fi;

                            /* Post-sq-A forbidden heading check */
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
                                /* Clear post-sq-A forbidden heading once vehicle moves through an intersection */
                                sq_a_forbidden[vid] = DIR_NONE
                            fi
                        fi
                    fi

                /* ---- On a road (mode == 1) ---- */
                :: (veh_mode[vid] == 1) ->
                    cur_slot = veh_slot[vid];

                    /* sq road uses SLOTN_SQ=1 -> last_sl=0; other roads SLOTN=3 -> last_sl=2 */
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

                        /* Arrival lookup: (road, lane_dir) -> (dest_node, in_heading) */
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

                            /* --- Tour progress: check if we reached current destination --- */
                            if
                            :: (dest_node == veh_dest[vid]) ->
                                /* Mark visited flags */
                                if
                                :: (dest_node == N_B) -> visited_B[vid] = true
                                :: (dest_node == N_C) -> visited_C[vid] = true
                                :: (dest_node == N_D) -> visited_D[vid] = true
                                :: else -> skip
                                fi;

                                /* Advance to next stop */
                                if
                                :: (veh_dest_idx[vid] < 3) ->
                                    veh_dest_idx[vid] = veh_dest_idx[vid] + 1;
                                    veh_dest[vid] = tour_stops[TS_IDX(vid, veh_dest_idx[vid])]
                                :: (veh_dest_idx[vid] >= 3) ->
                                    /* At final stop = SQ_A, tour complete */
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
 * init -- ClockFSM + initialization
 * ================================================================ */
init {
    byte tick_count = 0;
    byte dummy;
    byte i;

    atomic {
        /* Clear all light_enabled */
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

        /* node 9 sq A: E only (InfraFSM skips it; set for completeness) */
        light_enabled[LE_IDX(SQ_A, DIR_E)] = true;

        /* Initial green = first enabled direction at each node */
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

        /* Clear starvation counters */
        i = 0;
        do
        :: (i < NUM_NODES * 4) -> red_streak[i] = 0; i++
        :: (i >= NUM_NODES * 4) -> break
        od;

        /* Tour stops (excluding starting SQ_A):
         *   V0: SQ_A -> N_B -> N_C -> N_D -> SQ_A
         *   V1: SQ_A -> N_D -> N_C -> N_B -> SQ_A
         * tour_stops[vid][0..3] = [first_waypoint, second, third, return=SQ_A]
         */
        tour_stops[TS_IDX(0,0)] = N_B;
        tour_stops[TS_IDX(0,1)] = N_C;
        tour_stops[TS_IDX(0,2)] = N_D;
        tour_stops[TS_IDX(0,3)] = SQ_A;

        tour_stops[TS_IDX(1,0)] = N_D;
        tour_stops[TS_IDX(1,1)] = N_C;
        tour_stops[TS_IDX(1,2)] = N_B;
        tour_stops[TS_IDX(1,3)] = SQ_A;

        /* Vehicle 0: starts at sq A, heading toward N_B */
        veh_mode[0]      = 0;
        veh_node[0]      = SQ_A;
        veh_heading[0]   = DIR_NONE;
        veh_dest[0]      = N_B;
        veh_dest_idx[0]  = 0;
        visited_B[0]     = false;
        visited_C[0]     = false;
        visited_D[0]     = false;
        returned_A[0]    = false;
        sq_a_forbidden[0] = DIR_NONE;

        /* Vehicle 1: starts at sq A, heading toward N_D */
        veh_mode[1]      = 0;
        veh_node[1]      = SQ_A;
        veh_heading[1]   = DIR_NONE;
        veh_dest[1]      = N_D;
        veh_dest_idx[1]  = 0;
        visited_B[1]     = false;
        visited_C[1]     = false;
        visited_D[1]     = false;
        returned_A[1]    = false;
        sq_a_forbidden[1] = DIR_NONE;

        model_initialized = true
    };

    run InfraFSM();
    run VehicleFSM(0);
    run VehicleFSM(1);

    /* Main tick loop */
    do
    :: (returned_A[0] && returned_A[1]) ->
        all_tours_done = true;
        break

    :: (tick_count >= MAX_TICKS) -> break

    :: else ->
        /* Reset per-step state */
        d_step {
            i = 0;
            do
            :: (i < NUM_NODES) ->
                node_occupied[i]  = false;
                crossing_count[i] = 0;
                i++
            :: (i >= NUM_NODES) -> break
            od;
            moved_this_step[0] = false;
            moved_this_step[1] = false
        };

        /* Phase 1: Infrastructure */
        tick_infra ! 0;
        done_infra ? dummy;

        /* Phase 2: Vehicles */
        tick_vehicle[0] ! 0;
        tick_vehicle[1] ! 0;
        done_vehicle[0] ? dummy;
        done_vehicle[1] ? dummy;

        /* Phase 2b: Post-move invariant checks */
        d_step { check_invariants() };

        /* Phase 3: Assert properties */
        assert(!collision);
        assert(!red_violation);
        assert(!uturn_violation);
        assert(!opposite_direction_violation);

        /* At most 1 crossing per node per step */
        assert(crossing_count[N00] <= 1);
        assert(crossing_count[N01] <= 1);
        assert(crossing_count[N_D] <= 1);
        assert(crossing_count[N10] <= 1);
        assert(crossing_count[N11] <= 1);
        assert(crossing_count[N12] <= 1);
        assert(crossing_count[N_B] <= 1);
        assert(crossing_count[N21] <= 1);
        assert(crossing_count[N_C] <= 1);

        /* Light mutual exclusion for intersections 0..8 */
        assert(light_green[N00] <= DIR_W && GET_LE(N00, light_green[N00]));
        assert(light_green[N01] <= DIR_W && GET_LE(N01, light_green[N01]));
        assert(light_green[N_D] <= DIR_W && GET_LE(N_D,  light_green[N_D]));
        assert(light_green[N10] <= DIR_W && GET_LE(N10, light_green[N10]));
        assert(light_green[N11] <= DIR_W && GET_LE(N11, light_green[N11]));
        assert(light_green[N12] <= DIR_W && GET_LE(N12, light_green[N12]));
        assert(light_green[N_B] <= DIR_W && GET_LE(N_B,  light_green[N_B]));
        assert(light_green[N21] <= DIR_W && GET_LE(N21, light_green[N21]));
        assert(light_green[N_C] <= DIR_W && GET_LE(N_C,  light_green[N_C]));

        /* Check tour completion */
        if
        :: (returned_A[0] && returned_A[1]) -> all_tours_done = true
        :: else -> skip
        fi;

        tick_count++
    od
}

/* ================================================================
 * LTL Properties
 * ================================================================ */
/* Safety properties (i-group + v-group shared) */
ltl no_collision          { [] !collision }
ltl no_red_violation      { [] !red_violation }
ltl no_opposite_direction { [] !opposite_direction_violation }
ltl no_uturn              { [] !uturn_violation }

/* I-3: every vehicle visits B, C, D */
ltl visit_all_bcd {
    <> (visited_B[0] && visited_C[0] && visited_D[0] &&
        visited_B[1] && visited_C[1] && visited_D[1])
}

/* I-5 (self-chosen): every vehicle that visits B,C,D eventually returns to sq A */
ltl tour_closure { <> (returned_A[0] && returned_A[1]) }

/* V-1/V-2 bounded version: each enabled direction gets green within the
 * starvation-prevention bound. For N enabled directions, the worst-case bound
 * is MAX_RED_WAIT + (N - 2). */
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

ltl fair_green_bounded { [] (!model_initialized || (
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

/* V-3: at most one green per intersection at any moment */
ltl mutual_exclusion_lights { [] (!model_initialized || (
    (light_green[0] <= 3 && GET_LE(0,light_green[0])) &&
    (light_green[1] <= 3 && GET_LE(1,light_green[1])) &&
    (light_green[2] <= 3 && GET_LE(2,light_green[2])) &&
    (light_green[3] <= 3 && GET_LE(3,light_green[3])) &&
    (light_green[4] <= 3 && GET_LE(4,light_green[4])) &&
    (light_green[5] <= 3 && GET_LE(5,light_green[5])) &&
    (light_green[6] <= 3 && GET_LE(6,light_green[6])) &&
    (light_green[7] <= 3 && GET_LE(7,light_green[7])) &&
    (light_green[8] <= 3 && GET_LE(8,light_green[8]))
)) }

/* V-4 (self-chosen): the light topology always matches the physical grid. */
ltl valid_light_topology { [] (!model_initialized || (
    !GET_LE(N00, DIR_N) &&  GET_LE(N00, DIR_E) &&  GET_LE(N00, DIR_S) &&  GET_LE(N00, DIR_W) &&
    !GET_LE(N01, DIR_N) &&  GET_LE(N01, DIR_E) &&  GET_LE(N01, DIR_S) &&  GET_LE(N01, DIR_W) &&
    !GET_LE(N_D, DIR_N) && !GET_LE(N_D, DIR_E) &&  GET_LE(N_D, DIR_S) &&  GET_LE(N_D, DIR_W) &&
     GET_LE(N10, DIR_N) &&  GET_LE(N10, DIR_E) &&  GET_LE(N10, DIR_S) && !GET_LE(N10, DIR_W) &&
     GET_LE(N11, DIR_N) &&  GET_LE(N11, DIR_E) &&  GET_LE(N11, DIR_S) &&  GET_LE(N11, DIR_W) &&
     GET_LE(N12, DIR_N) && !GET_LE(N12, DIR_E) &&  GET_LE(N12, DIR_S) &&  GET_LE(N12, DIR_W) &&
     GET_LE(N_B, DIR_N) &&  GET_LE(N_B, DIR_E) && !GET_LE(N_B, DIR_S) && !GET_LE(N_B, DIR_W) &&
     GET_LE(N21, DIR_N) &&  GET_LE(N21, DIR_E) && !GET_LE(N21, DIR_S) &&  GET_LE(N21, DIR_W) &&
     GET_LE(N_C, DIR_N) && !GET_LE(N_C, DIR_E) && !GET_LE(N_C, DIR_S) &&  GET_LE(N_C, DIR_W)
)) }
