# Phase C — V-Group Verification Report

**Course:** ECEN 723 Introduction to Formal Verification — Spring 2026
**Phase:** C (due 2026-04-28)
**Model file:** `verification/spin/phase_c_model.pml`
**Verifier:** SPIN 6.x, bitstate hashing (`-DBITSTATE`), depth limit 500,000

---

## 1. System Model Description

### 1.1 Topology

The road network is a 3×3 grid of intersections plus one square node A:

```
  A----(0,0)----(0,1)----D(0,2)
         |        |        |
       (1,0)----(1,1)----(1,2)
         |        |        |
       B(2,0)---(2,1)----C(2,2)
```

- **10 nodes total:** 9 grid intersections (nodes 0–8) + square node A (node 9)
- **13 roads total:** 6 horizontal + 6 vertical (3 slots each) + 1 square-A link road (1 slot)
- B=(2,0), C=(2,2), D=(0,2) are **ordinary corner intersections** — no separate link roads
- Only A is a square node, connected to (0,0) via a 1-slot road
- Each road has two independent lanes (FWD and BWD direction)
- Each time step = 2 seconds; a vehicle moves at most 1 slot per step

### 1.2 Processes

The model has four concurrent proctypes plus the `init` clock:

| Process | Role |
|---|---|
| `InfraFSM` | Controls traffic lights at all 9 intersections |
| `Environment` | Non-deterministically spawns VehicleFSM instances each tick |
| `VehicleFSM(vid)` | Models one vehicle's movement and tour logic |
| `init` | Global clock — synchronizes all processes each tick via rendezvous channels |

### 1.3 Non-Determinism — Environment Process

The key difference from a fixed-vehicle model is the **Environment process**, which introduces non-determinism over vehicle count:

```promela
proctype Environment() {
    do
    :: tick_env ? dummy ->
        if
        :: (active_count < MAX_ACTIVE) -> do_spawn = true
        :: skip                        -> do_spawn = false
        fi;
        if
        :: do_spawn -> /* initialize vehicle state */ run VehicleFSM(vid)
        :: else -> skip
        fi;
        done_env ! 0
    od
}
```

At every tick, SPIN non-deterministically chooses whether to spawn a new vehicle (if capacity allows) or do nothing. This means SPIN explores **all possible vehicle arrival timings** — every combination of 0 to `MAX_ACTIVE` vehicles entering the system at any point in time. Properties verified under this model hold for **any number of vehicles up to `MAX_ACTIVE`**, not just a fixed count.

| Parameter | Value | Meaning |
|---|---|---|
| `MAX_ACTIVE` | 3 | Maximum concurrent vehicles |
| `SLOTN` | 3 | Slots per interior road |
| `SLOTN_SQ` | 1 | Slots on square-A link road |
| `MAX_TICKS` | 60 | Bounded verification window |
| `MAX_RED_WAIT` | 4 | Max consecutive red ticks before forced green |

### 1.4 Tick Structure

Each tick proceeds in four phases:

```
Phase 1:  InfraFSM        → update light_green[0..8] and dir_green[0..8][N/E/S/W]
Phase 2a: Environment     → non-det: spawn a new VehicleFSM or skip
Phase 2b: VehicleFSM(*)   → each active vehicle moves one slot or crosses intersection
Phase 3:  check_invariants → set violation flags; assert() checks all properties
```

### 1.5 InfraFSM — Traffic Light Control

Each tick, for every intersection 0–8:

1. Count vehicles approaching from each enabled direction (scan road slots)
2. **Starvation prevention:** if any direction has been red ≥ `MAX_RED_WAIT=4` consecutive ticks → force it green
3. **Longest-queue-first:** otherwise give green to the direction with the most approaching vehicles
4. `light_green[i]` stores a single direction index (0=N, 1=E, 2=S, 3=W)
5. `dir_green[i*4+d]` is set to `true` for exactly the chosen direction and `false` for all others — this explicit boolean array enables real mutual exclusion checking

Square node A (node 9) has no signal and is skipped by `InfraFSM`.

### 1.6 VehicleFSM — Vehicle Movement

Each vehicle completes a fixed tour, assigned by vehicle ID parity:
- **Even vid:** SQ_A → B → C → D → SQ_A
- **Odd vid:** SQ_A → D → C → B → SQ_A  (opposite order — stresses concurrent path sharing)

At each tick a vehicle does one of:

- **At a node (mode=0):** looks up the next intermediate hop via a precomputed BFS table `next_hop_ha` (heading-aware, no-U-turn). Checks green light, no-U-turn, then enters road slot 0 if clear.
- **On a road (mode=1):** advances one slot if the next slot is empty. At the last slot, crosses into the destination node if no other vehicle crossed that intersection this tick.

Key constraints enforced inside VehicleFSM:
- Must wait for green light before entering a road from an intersection
- Cannot make a U-turn (outgoing heading ≠ incoming heading)
- Cannot re-enter SQ_A the same tick it departed (post-square forbidden heading)

---

## 2. V-Group Properties

The v-group verifies **infrastructure and signal** properties. Three properties are shared with the i-group (both groups must verify them and results must agree); five are v-group specific.

### 2.1 Shared Properties (must match i-group results)

**No collision** (`no_collision`)
```promela
ltl no_collision { [] !collision }
```
`collision` is set if two vehicles occupy the same road slot and direction simultaneously. Result: **PASS**

**No red-light violation** (`no_red_violation`)
```promela
ltl no_red_violation { [] !red_violation }
```
`red_violation` is set if a vehicle enters a road while the light at the source intersection was not green in that direction. Result: **PASS**

**No opposite-direction violation** (`no_opposite_direction`)
```promela
ltl no_opposite_direction { [] !opposite_direction_violation }
```
`opposite_direction_violation` is set if a vehicle's slot does not carry the expected vehicle ID (detecting wrong-lane entry). Result: **PASS**

### 2.2 V-Group Specific Properties

**V-1 — Every enabled direction eventually gets green** (`eventual_green_bounded`)
```promela
ltl eventual_green_bounded { [] (!model_initialized || (
    (RS_STREAK(N00,DIR_E) <= 5) && (RS_STREAK(N00,DIR_S) <= 5) && ...
)) }
```
`RS_STREAK(n,d)` counts consecutive ticks direction `d` at node `n` has been red. Bound = `MAX_RED_WAIT + (N_enabled − 2)`: 4 for 2-direction corners, 5 for 3-direction nodes, 6 for the 4-direction center (1,1).

Equivalently: **every enabled direction gets green at least once every `MAX_STREAK` cycles.** Result: **PASS**

**V-2 — At most one green per intersection at any moment** (`mutual_exclusion_lights`)

```promela
ltl mutual_exclusion_lights { [] (!model_initialized || (
    (GET_DG(N00,DIR_N) + GET_DG(N00,DIR_E) + GET_DG(N00,DIR_S) + GET_DG(N00,DIR_W)) <= 1 &&
    (GET_DG(N01,DIR_N) + GET_DG(N01,DIR_E) + GET_DG(N01,DIR_S) + GET_DG(N01,DIR_W)) <= 1 &&
    ...
    (GET_DG(N_C,DIR_N) + GET_DG(N_C,DIR_E) + GET_DG(N_C,DIR_S) + GET_DG(N_C,DIR_W)) <= 1
)) }
```

`dir_green[n*4+d]` is a separate boolean for each (node, direction) pair. `InfraFSM` clears all four direction booleans then sets exactly one per tick. The LTL sums all four direction booleans per node and asserts the sum is never greater than 1 — this is a **true mutual exclusion check**, not just a validity check on a single stored value. Result: **PASS**

**V-3 — At most one vehicle crosses any intersection per tick** (`intersection_crossing_bound`) *(self-chosen)*
```promela
ltl intersection_crossing_bound { [] (
    (crossing_count[N00] <= 1) && (crossing_count[N01] <= 1) &&
    (crossing_count[N_D]  <= 1) && (crossing_count[N10] <= 1) &&
    (crossing_count[N11] <= 1) && (crossing_count[N12] <= 1) &&
    (crossing_count[N_B]  <= 1) && (crossing_count[N21] <= 1) &&
    (crossing_count[N_C]  <= 1)
) }
```

**Rationale:** The spec states *"between two consecutive time steps, there is at most 1 car crossing an intersection."* `crossing_count[i]` is reset to 0 at the start of every tick and incremented each time any vehicle enters node `i`. The `[]` operator makes SPIN check this over every reachable state.

This is a v-group property because it constrains infrastructure behavior: the signal controller's green-light decisions must never allow two vehicles to converge on the same intersection in the same step. Result: **PASS**

**V-4 — Lights are only green or red, never any other state** (`binary_light_state`) *(self-chosen)*
```promela
ltl binary_light_state { [] (!model_initialized || (
    (GET_DG(N00,DIR_N) == (light_green[N00] == DIR_N)) &&
    (GET_DG(N00,DIR_E) == (light_green[N00] == DIR_E)) &&
    ...
    (GET_DG(N_C,DIR_W) == (light_green[N_C] == DIR_W))
)) }
```

**Rationale:** Each direction at each intersection must be in exactly one of two states — green or red. There is no yellow, undefined, or intermediate state. The property verifies that `dir_green[n*4+d]` (the boolean signal state) is always consistent with `light_green[n]` (the stored green direction index): a direction is green if and only if it matches the stored green direction, and red otherwise. Any corruption, partial update, or third state would cause `dir_green` and `light_green` to disagree, which SPIN would catch. Result: **PASS**

---

## 3. Verification Results

**Commands used:**
```bash
cd verification/spin
spin -a phase_c_model.pml
cc -O2 -DBITSTATE -DVECTORSZ=4096 -o pan pan.c
./pan -m500000 -a -N <claim>
```

**Model parameters:** `MAX_ACTIVE=3`, `SLOTN=3`, `MAX_TICKS=60`, `-DBITSTATE`

| Property | Claim | Errors | States Explored | Depth | Time |
|---|---|---|---|---|---|
| No collision (shared) | `no_collision` | **0** | 4,441,049 | 28,490 | 110s |
| No red-light violation (shared) | `no_red_violation` | **0** | 3,861,566 | 28,490 | 63.6s |
| No opposite-direction (shared) | `no_opposite_direction` | **0** | 4,377,297 | 28,490 | 89.8s |
| No U-turn | `no_uturn` | **0** | 4,810,516 | 28,490 | 139s |
| V-1: eventual green (bounded) | `eventual_green_bounded` | **0** | 3,788,201 | 28,490 | 59s |
| V-2: mutual exclusion of lights | `mutual_exclusion_lights` | **0** | 4,500,511 | 28,490 | 109s |
| V-3: one crossing per tick (self) | `intersection_crossing_bound` | **0** | 4,060,996 | 28,490 | 61.2s |
| V-4: binary light state (self) | `binary_light_state` | **0** | 4,162,987 | 28,490 | 59.1s |

All 8 properties **satisfied**. No counterexample found in any run.

**Note on non-deterministic vehicle model:** Unlike the fixed 2-vehicle model, this model uses an `Environment` process that spawns vehicles non-deterministically. SPIN explored 3.8M–4.8M states per claim, covering all possible spawn timings for 0–3 vehicles. The state-vector is 1,020 bytes; `-DVECTORSZ=4096` was required. The higher state count (vs. the fixed model) reflects SPIN exploring all vehicle arrival sequences.

**Note on bitstate hashing:** `-DBITSTATE` uses a fixed 16 MB bit array to mark visited states rather than storing full state vectors. This is a sound over-approximation: no false positives on errors, with a small probability of missing states (false negatives).

---

## 4. Throughput from C++ Simulation

### 4.1 How Throughput is Calculated

```
throughput (tours/hour) = (completed_tours / total_steps) × (3600 / 2)
```

- Each time step = 2 seconds, so 1800 steps = 1 simulated hour
- `completed_tours` = number of times any vehicle returns to SQ_A after visiting B, C, D

### 4.2 Command

```bash
# Usage: ./throughput_bench <vehicles> <total_steps> <warmup_steps> <route_mode>
./build/throughput_bench 2 1800 0 mixed
```

### 4.3 Results

**2 vehicles, 1800 steps (1 simulated hour), no warmup:**
```
vehicles=2  route_mode=mixed  total_steps=1800  warmup_steps=0
completed_tours_total=9   throughput_total=9.00 tours/hour
collisions=0  red_light_violations=0  opposite_direction_violations=0  u_turn_violations=0
```

**3 vehicles, 1800 steps:**
```
vehicles=3  route_mode=mixed  total_steps=1800  warmup_steps=0
completed_tours_total=12  throughput_total=12.00 tours/hour
collisions=0  red_light_violations=0  opposite_direction_violations=0  u_turn_violations=0
```

**2 vehicles, 2-hour run with 1-hour warmup (steady-state window):**
```
vehicles=2  route_mode=mixed  total_steps=3600  warmup_steps=1800
completed_tours_window=11  throughput_window=11.00 tours/hour
collisions=0  red_light_violations=0  opposite_direction_violations=0  u_turn_violations=0
```

The warmup-excluded window (11 tours/hour) better reflects steady-state throughput since it excludes the initial transient where vehicles are still spreading out from SQ_A.

### 4.4 Max Throughput Sweep

```bash
bash scripts/find_max_throughput.sh
```

Parameters: `total_steps=7200` (4 simulated hours), `warmup_steps=1800` (first hour discarded), measurement window = 3 simulated hours.

| Route Mode | Saturates at | Peak Throughput |
|---|---|---|
| `mixed` | 50 vehicles | 84.7 tours/hr |
| `perimeter` | 15 vehicles | 62.0 tours/hr |
| `balanced` | 20–30 vehicles | **124.0 tours/hr** |

**Maximum throughput: 124 tours/hour** — achieved with `balanced` routing and 20 vehicles, confirmed stable over an 8-hour run (14400 steps):

```
vehicles=20  route_mode=balanced  total_steps=14400  warmup_steps=1800
completed_tours_window=869  throughput_window=124.14 tours/hour
collisions=0  red_light_violations=0  opposite_direction_violations=0  u_turn_violations=0
```

`balanced` routing alternates vehicles between two complementary orderings (half do B→C→D→A, half do D→C→B→A), distributing load symmetrically so no single intersection becomes a bottleneck.

### 4.5 Violation Counts

All simulation runs across all configurations report:
- Collisions: **0**
- Red-light violations: **0**
- Opposite-direction violations: **0**
- U-turn violations: **0**

---

## 5. Vehicle Routing Algorithm — Changes from Phase A

### 5.1 Phase A Baseline

In Phase A the vehicle routing algorithm was:

1. **BFS shortest path** (`computeShortestPathNoUTurn`) — finds the fewest-hop path from current position to the next tour destination
2. **No-U-turn constraint** — encoded in `PathState` with `incoming_heading`; BFS discards any neighbor that would reverse the incoming direction
3. **Post-square forbidden heading** — after leaving a square node, the vehicle cannot immediately re-enter it on the next step
4. **Fixed single tour** — vehicles were given one hardcoded route at startup; no repeat tours
5. **B, C, D modeled as square nodes** — each had its own 2-slot link road off the corner intersection

The path selection was purely **topological** — BFS finds the shortest hop count with no awareness of traffic conditions on those roads.

### 5.2 Changes Introduced in Phase B

**Topology change — B, C, D become corner intersections:**
- Removed `SQUARE_B`, `SQUARE_C`, `SQUARE_D` as separate square nodes
- B=(2,0), C=(2,2), D=(0,2) are now ordinary grid intersections
- Only A retains the square-node link road

**Congestion-aware path cost (`estimateTravelCost`):**
- Cost per road segment = base (31) + `occupancy × 2` + proximity bonus (+3 per vehicle in final 5 slots)
- Used when comparing alternative routes to next destination

**Continuous tour restarts with template memory:**
- Phase A: vehicles stopped after completing one tour
- Phase B+: on returning to SQ_A with an empty route, the vehicle automatically restarts using its stored tour template

**Route mode sweep (`throughput_bench`):**
- `balanced`: alternates between B→C→D→A and D→C→B→A per vehicle index
- `mixed`: cycles through all 6 permutations of B/C/D
- `perimeter`: all vehicles follow D→C→B→A

### 5.3 Summary Table

| Feature | Phase A | Phase B / Current |
|---|---|---|
| Path algorithm | BFS (hop count) | BFS + congestion cost estimate |
| B, C, D topology | Square nodes (2-slot link roads) | Ordinary corner intersections (30-slot roads) |
| Tour repetition | Single tour, then idle | Continuous restart from template |
| Tour ordering | Fixed per vehicle at startup | Template captured or assigned by default |
| Route modes | None | `mixed`, `balanced`, `perimeter` |
| Travel/wait tracking | None | Per-vehicle per-tour timing statistics |
| No-U-turn | Yes (PathState BFS) | Yes (unchanged) |
| Post-square forbidden heading | Yes (SQUARE_A only) | Yes (SQUARE_A only; B/C/D no longer special) |
| SPIN vehicle model | N/A | Non-deterministic spawn via Environment process |
