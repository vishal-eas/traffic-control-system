# SPIN Full Implementation Execution Plan

## 1. Goal
Build a formal Promela model with **independent** infrastructure and vehicle FSMs communicating through shared state, verify all spec-required safety/liveness properties, and scale from a one-intersection demo (Phase B) to a full 3x3 + square-node model (Phase C).

## 2. Authoritative References

### Spec and requirement source
1. `Spec/723Spring26ProjectOverview.adoc`

### Current C++ architecture references
1. Shared state container (Grid): `include/common/Grid.h`
2. Infrastructure agent (light cycling): `src/infrastructure/InfrastructureAgent.cpp`
3. Vehicle agent (routing + movement): `src/vehicle/VehicleAgent.cpp`
4. Domain types: `include/common/Point.h`, `include/common/Road.h`, `include/common/Intersection.h`, `include/common/Vehicle.h`
5. Tests encoding expected behavior: `tests/test_vehicle_agent.cpp`

### Existing SPIN artifacts
1. `verification/spin/simple_test.pml` — single-intersection baseline (monolithic, to be replaced)

## 3. Core Architecture: Independent i-group / v-group FSMs

### The spec requirement
> "An i-group will develop a software simulating road infrastructure... Each v-group will develop a software simulating a number of vehicles..."

Both groups operate **independently** but communicate through shared state (the Grid). This is exactly how our C++ works: `InfrastructureAgent` and `VehicleAgent` both read/write to `Grid`.

### Promela architecture

```
┌─────────────────────────────────────────────────────┐
│                    ClockFSM                          │
│  (orchestrates tick phases, checks properties)       │
│                                                      │
│  Each tick:                                          │
│    1. tick_infra ! 0  ──→  InfraFSM runs             │
│       done_infra ? 0  ←──  InfraFSM done             │
│                                                      │
│    2. tick_vehicle ! 0 ──→  VehicleFSMs run          │
│       done_vehicle ? 0 ←──  all vehicles done        │
│                                                      │
│    3. assert_properties()                            │
│       reset_step_state()                             │
└─────────────────────────────────────────────────────┘
```

Three process types:
1. **ClockFSM** (`init`): Global tick sequencer. Enforces phase ordering, runs property checks.
2. **InfrastructureFSM** (`proctype`): Reads vehicle positions from shared state, decides which light to set green. Runs independently — does NOT know vehicle routes or turning intentions.
3. **VehicleFSM** (`proctype`, one per vehicle): Reads light state from shared state, decides whether to move. Runs independently — does NOT control lights.

### Communication contract: shared arrays (Grid equivalent)

```promela
/* --- Shared state (the "Grid") --- */

/* Traffic lights: which direction index is green at each intersection */
/* -1 = all red, 0=N, 1=E, 2=S, 3=W */
byte light_green[NUM_INTERSECTIONS];

/* Road slot occupancy: 0=empty, else vehicle_id+1 */
byte road_slots[NUM_ROADS][2][SLOTN];    /* [road_id][direction][slot] */

/* Vehicle state */
byte veh_node[NVEH];          /* which intersection/square node (-1 if on road) */
byte veh_road[NVEH];          /* which road segment */
byte veh_dir[NVEH];           /* 0=FORWARD, 1=BACKWARD */
byte veh_slot[NVEH];          /* position within road */
bool veh_at_intersection[NVEH];

/* Per-step guards */
bool intersection_occupied[NUM_INTERSECTIONS];
bool moved_this_step[NVEH];
```

### Why this design
1. **Mirrors C++**: Both agents read/write Grid state. Promela globals = Grid arrays.
2. **True independence**: InfraFSM and VehicleFSMs are separate `proctype`s. SPIN explores interleavings within each phase.
3. **Tick synchronization**: Rendezvous channels enforce the phase order (infra first, then vehicles) — same as C++ `main()` calling `infra.step()` then `vehicle.step()`.
4. **Scalable**: Adding vehicles means more `VehicleFSM` instances, not rewriting the model.

## 4. What InfraFSM Knows vs. What VehicleFSM Knows

This separation is critical — it matches the spec's i-group / v-group split:

| | InfraFSM (i-group) | VehicleFSM (v-group) |
|---|---|---|
| **Reads** | Vehicle positions, speeds, directions (from shared state) | Light states at intersections (from shared state) |
| **Does NOT know** | Vehicle routes, turning intentions | When lights will change |
| **Writes** | `light_green[intersection]` | Vehicle position arrays |
| **Decides** | Which direction gets green | Whether to move, which direction to go |
| **Verifies** | No two greens at same intersection, signal timing | No collision, no red-light entry, no U-turn |

### How infra reads vehicle info (spec: "receive vehicle signals from v-group")
```promela
/* InfraFSM reads congestion from shared state */
inline count_waiting_vehicles(intersection_id, direction) {
    /* scan road_slots approaching this intersection on this direction */
    /* count vehicles in last N slots (near intersection) that didn't move */
}
```

### How vehicles read congestion map (spec: "receive traffic congestion map")
```promela
/* VehicleFSM reads light state from shared state */
inline can_enter_intersection(vid, intersection_id) {
    /* check light_green[intersection_id] matches vehicle's approach direction */
    /* check !intersection_occupied[intersection_id] */
}
```

## 5. State-Space Control Strategy (CRITICAL)

### The #1 risk: state space explosion

| Factor | Full system | Reduced for SPIN |
|---|---|---|
| Slots per road | 30 | **3-5** (abstract, preserves queuing behavior) |
| Road segments | 24 (12 horiz + 12 vert) | Start with 2-4, scale to full |
| Vehicles | 3+ | **2-3** (sufficient to find concurrency bugs) |
| Intersections | 9 | Start with 1, scale to 4, then 9 |
| Light phases | variable cycle | **2-4 deterministic phases** |

### Rules
1. **NEVER use 30 slots in SPIN.** Use `SLOTN=3` to `SLOTN=5`. The abstraction preserves: queuing/blocking, red-light stopping, slot-level collision detection.
2. Keep vehicles at 2-3. Two vehicles are enough to find mutual exclusion bugs.
3. Use `d_step` for deterministic sequences (light cycling, property checks) to collapse states.
4. Use `byte` everywhere, never `int` or `short`.
5. Bitstate hashing (`-DBITSTATE`) for larger models as secondary evidence.

## 6. C++ to Promela Conversion Matrix

| C++ concept | C++ location | Promela representation |
|---|---|---|
| Grid shared state | `include/common/Grid.h` | Global arrays (see Section 3) |
| Intersection lights | `Intersection.h` | `light_green[i]` + `light_enabled[i][d]` |
| Light cycle strategy | `InfrastructureAgent.cpp:16` | `InfrastructureFSM` with phase counter |
| Vehicle position | `Vehicle.h` | Parallel arrays `veh_node`, `veh_slot`, etc. |
| Road dual lanes | `Road.h` | `road_slots[road][dir][slot]` |
| Movement logic | `VehicleAgent.cpp:320-500` | `VehicleFSM` transition guards |
| Intersection lock | `Grid.cpp` | `intersection_occupied[i]` reset each tick |
| Collision detection | `Grid.cpp:detectCollisions` | Per-tick assertion scanning all slots |
| No-U-turn | `VehicleAgent.cpp:387` | `incoming_heading[vid]` + opposite check |
| Route planning | `VehicleAgent.cpp:152` | Precomputed next-hop table (NOT runtime BFS) |

## 7. Topology Encoding

### Node IDs
- Intersections: `0..8` from `row*3 + col`
- Square nodes: `9=A, 10=B, 11=C, 12=D`

### Road IDs (for reduced models, subset of these)
- Horizontal roads: `h_road(row, col)` for row 0..2, col 0..1
- Vertical roads: `v_road(row, col)` for row 0..1, col 0..2
- Square links: `sq_road(0..3)` for A, B, C, D

### Light-direction mapping per intersection
```promela
/* Direction index: 0=N, 1=E, 2=S, 3=W */
/* Corner intersections have only 2 enabled directions */
/* e.g., (0,0) has only E(1) and S(2) enabled, plus W(3) for square A link */
```

## 8. Route Logic

### Approach: precomputed next-hop tables
Runtime BFS in Promela would explode the state space. Instead:
1. For Phase B: hardcoded fixed routes (vehicle goes A→B→C→D→A on a known path).
2. For Phase C: precomputed `next_hop[current_node][destination]` lookup table.

This is a valid abstraction — the BFS in C++ always produces the same shortest path for a given (node, heading, destination), so we can precompute and embed the results.

### Constraint preservation
- No-U-turn: `incoming_heading[vid]` checked before allowing intersection crossing.
- Post-square forbidden heading: `forbidden_heading[vid]` set after visiting square node.

## 9. Properties to Verify

### Safety (assertions, checked every tick)
| Property | Promela check |
|---|---|
| No collision | `assert` no two vehicles share `(road, dir, slot)` |
| No red-light violation | `assert` vehicle only enters intersection when its approach light is GREEN |
| At most 1 crossing per intersection per step | `assert(crossing_count[i] <= 1)` per intersection |
| At most 1 green per intersection | `assert` only one `light_enabled[i][d]` is GREEN |
| No opposite-direction lane use | `assert` vehicle direction matches lane direction |
| No U-turn | `assert` outgoing heading != opposite of incoming heading |

### LTL (temporal properties)
```promela
ltl no_collision       { [] !collision }
ltl no_red_violation   { [] !red_violation }
ltl no_opposite_dir    { [] !opposite_direction_violation }
ltl no_uturn           { [] !uturn_violation }
ltl tour_completion    { <> all_tours_done }  /* bounded liveness */
```

### i-group / v-group consistency (spec requirement)
> "The three constraints: no collision, no violation of red light signal, no run of opposite direction lane, should be verified in both i-group and v-group. And the verification results should match."

Maintain separate monitor counters:
```promela
byte infra_collision_count;    /* InfraFSM's view */
byte vehicle_collision_count;  /* VehicleFSM's view */
/* Assert equality each tick */
assert(infra_collision_count == vehicle_collision_count);
```

## 10. Execution Phases with Deliverables

### Phase B Deliverable (Due April 14): Small Demo
**Goal**: Demonstrate SPIN verifying a meaningful example.

#### Phase B-1: Two-Process Single Intersection
1. Create `verification/spin/phase_b_model.pml`
2. Separate `proctype InfraFSM` and `proctype VehicleFSM` (replaces monolithic `init`)
3. Rendezvous channels for tick synchronization
4. 1 intersection, 2 approach roads, 2 vehicles, `SLOTN=4`
5. **Gate**: All 6 safety assertions pass. SPIN reports 0 errors.

#### Phase B-2: Add Nondeterminism
1. Make vehicle movement nondeterministic (move OR stay)
2. Make light switching nondeterministic (within constraints)
3. **Gate**: Properties still hold under all explored interleavings. Report states explored.

#### Phase B-3: Report
1. Run transcript showing: command sequence, states explored, memory used, properties verified
2. Document in `verification/spin/phase_b_report.md`

### Phase C Deliverable (Due April 28): Full Verification

#### Phase C-1: Expand Topology
1. Create `verification/spin/phase_c_model.pml`
2. Full 3x3 grid (9 intersections) with `SLOTN=3`
3. Square nodes A, B, C, D with links
4. **Gate**: Model compiles and bounded search completes.

#### Phase C-2: Add Routing and Tours
1. Precomputed next-hop tables for all routes
2. 2-3 vehicles running A→{B,C,D}→A tours
3. No-U-turn and post-square constraints
4. **Gate**: Tours complete, all safety properties hold.

#### Phase C-3: Full Property Verification + Report
1. Verify all 6 safety properties + tour completion liveness
2. i-group / v-group consistency check
3. Generate property table: property name, pass/fail, states explored, time
4. Document in `verification/spin/phase_c_report.md`

## 11. Command Runbook

```bash
# Simulate (debug/sanity check)
spin verification/spin/phase_b_model.pml
spin -p -g -l verification/spin/phase_b_model.pml

# Generate and compile verifier
spin -a verification/spin/phase_b_model.pml
gcc -O2 -o pan pan.c

# Verify all assertions (safety)
./pan -m100000

# Verify specific LTL property
./pan -m100000 -a -N no_collision
./pan -m100000 -a -N no_red_violation
./pan -m100000 -a -N eventual_completion

# Counterexample replay
spin -t -p verification/spin/phase_b_model.pml

# Large model with bitstate hashing
gcc -O2 -DBITSTATE -o pan pan.c
./pan -m1000000

# Safety-only (faster, no LTL)
gcc -O2 -DSAFETY -o pan pan.c
./pan
```

## 12. Traceability Matrix (Spec → C++ → SPIN)

| Requirement | Spec source | C++ implementation | SPIN check |
|---|---|---|---|
| No collision | spec line 48-49 | `Grid::detectCollisions()` | Assertion + `ltl no_collision` |
| No red-light violation | spec line 49-50 | `VehicleAgent.cpp:398` | Assertion + `ltl no_red_violation` |
| No opposite-direction lane | spec line 73-74 | `Road.h` dual lanes | Assertion + `ltl no_opposite_dir` |
| No U-turn | spec line 76 | `VehicleAgent.cpp:387` | Assertion + `ltl no_uturn` |
| At most 1 crossing per step | spec line 47-48 | `Grid::isIntersectionOccupiedThisStep` | Assertion `crossing_count <= 1` |
| At most 1 green per intersection | spec line 66 | `InfrastructureAgent.cpp:34` | Assertion per intersection |
| Tour completion | spec line 51-52 | `SimulationStats` | `ltl tour_completion` |
| i/v group verification match | spec line 81-83 | Both agents check | Dual counter assertion |

## 13. Definition of Done

### Phase B
- [ ] `phase_b_model.pml` has separate `InfraFSM` and `VehicleFSM` proctypes
- [ ] Tick-synchronized via rendezvous channels
- [ ] All 6 safety properties pass under exhaustive search
- [ ] Report with command transcript and state counts

### Phase C
- [ ] `phase_c_model.pml` models full 3x3 grid + square nodes
- [ ] 2-3 vehicles complete A→{B,C,D}→A tours
- [ ] All safety + liveness properties verified
- [ ] i-group / v-group consistency verified
- [ ] Final report with full property table
