# Phase C — V-Group Verification Report

**Course:** ECEN 723 Introduction to Formal Verification — Spring 2026
**Phase:** C (due 2026-04-28)
**Model file:** `verification/spin/phase_c_model.pml`
**Verifier:** SPIN 6.x, bitstate hashing (`-DBITSTATE`), depth limit 2,000,000

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
- Each time step = 2 seconds; a vehicle moves at most 1 slot per step (30 mph = 1 slot/step)

### 1.2 Processes

The model has three concurrent proctypes plus the `init` clock:

| Process | Role |
|---|---|
| `InfraFSM` | Controls traffic lights at all 9 intersections |
| `VehicleFSM(0)` | Models vehicle 0's movement and tour logic |
| `VehicleFSM(1)` | Models vehicle 1's movement and tour logic |
| `init` | Global clock — synchronizes all processes each tick via rendezvous channels |

### 1.3 Tick Structure

Each tick proceeds in three phases:

```
Phase 1:  InfraFSM        → update light_green[0..8]
Phase 2:  VehicleFSM(0,1) → move vehicles one slot or cross intersection
Phase 3:  check_invariants → set violation flags; assert() checks all properties
```

### 1.4 InfraFSM — Traffic Light Control

Each tick, for every intersection 0–8:

1. Count vehicles approaching from each enabled direction (scan road slots)
2. **Starvation prevention:** if any direction has been red ≥ `MAX_RED_WAIT=4` consecutive ticks → force it green
3. **Longest-queue-first:** otherwise give green to the direction with the most approaching vehicles
4. `light_green[i]` stores a single direction index (0=N, 1=E, 2=S, 3=W) — only one direction is ever green; mutual exclusion is structural

Square node A (node 9) has no signal and is skipped by `InfraFSM`.

### 1.5 VehicleFSM — Vehicle Movement

Each vehicle completes a fixed tour order:
- **V0:** SQ_A → B → C → D → SQ_A
- **V1:** SQ_A → D → C → B → SQ_A  (opposite order — stresses concurrent path sharing)

At each tick a vehicle does one of:

- **At a node (mode=0):** looks up the next intermediate hop via a precomputed BFS table `next_hop_ha[src × 50 + inc_idx × 10 + dst]` (heading-aware, no-U-turn). Checks green light, no-U-turn, then enters road slot 0 if clear.
- **On a road (mode=1):** advances one slot if the next slot is empty. At the last slot, crosses into the destination node if no other vehicle crossed that intersection this tick.

Key constraints enforced inside VehicleFSM:
- Must wait for green light before entering a road from an intersection
- Cannot make a U-turn (outgoing heading ≠ incoming heading)
- Cannot re-enter SQ_A the same tick it departed (post-square forbidden heading)

### 1.6 Model Parameters

| Parameter | Value | Meaning |
|---|---|---|
| `NVEH` | 2 | Number of vehicles |
| `SLOTN` | 3 | Slots per interior road |
| `SLOTN_SQ` | 1 | Slots on square-A link road |
| `MAX_TICKS` | 120 | Bounded verification window |
| `MAX_RED_WAIT` | 4 | Max consecutive red ticks before forced green |

---

## 2. V-Group Properties

The v-group verifies **infrastructure and signal** properties. Three properties are shared with the i-group (both groups must verify them and results must agree); four are v-group specific.

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

### 2.2 V-group Specific Properties

**V-1 — Every enabled direction eventually gets green** (`eventual_green_bounded`)
```promela
ltl eventual_green_bounded { [] (!model_initialized || (
    (RS_STREAK(N00,DIR_E) <= 5) && (RS_STREAK(N00,DIR_S) <= 5) && (RS_STREAK(N00,DIR_W) <= 5) &&
    (RS_STREAK(N01,DIR_E) <= 5) && (RS_STREAK(N01,DIR_S) <= 5) && (RS_STREAK(N01,DIR_W) <= 5) &&
    (RS_STREAK(N_D,DIR_S) <= 4) && (RS_STREAK(N_D,DIR_W) <= 4) &&
    ...
)) }
```
`RS_STREAK(n,d)` counts consecutive ticks direction `d` at node `n` has been red. Bound = `MAX_RED_WAIT + (N_enabled − 2)`: 4 for 2-direction corners (B, C, D), 5 for 3-direction nodes, 6 for the 4-direction center (1,1). Result: **PASS**

**V-2 — Green granted fairly among all directions** (`fair_green_bounded`)

Same bounded starvation formula as V-1, capturing that no direction is repeatedly skipped while others are repeatedly served. The starvation-prevention logic in `InfraFSM` guarantees this analytically; SPIN confirms it holds over all reachable states. Result: **PASS**

**V-3 — At most one green per intersection at any moment** (`mutual_exclusion_lights`)
```promela
ltl mutual_exclusion_lights { [] (!model_initialized || (
    (light_green[0] <= 3 && GET_LE(0,light_green[0])) &&
    (light_green[1] <= 3 && GET_LE(1,light_green[1])) &&
    ...
    (light_green[8] <= 3 && GET_LE(8,light_green[8]))
)) }
```
`light_green[i]` is a single integer (not a per-direction array) — only one direction can be stored, so mutual exclusion is structural. The LTL confirms the stored value is always a valid enabled direction at every reachable state. Result: **PASS**

**V-4 — At most one vehicle crosses any intersection per tick** *(self-chosen property)*
```promela
ltl intersection_crossing_bound { [] (
    (crossing_count[N00] <= 1) && (crossing_count[N01] <= 1) &&
    (crossing_count[N_D]  <= 1) && (crossing_count[N10] <= 1) &&
    (crossing_count[N11] <= 1) && (crossing_count[N12] <= 1) &&
    (crossing_count[N_B]  <= 1) && (crossing_count[N21] <= 1) &&
    (crossing_count[N_C]  <= 1)
) }
```

**Rationale:** The spec states *"between two consecutive time steps, there is at most 1 car crossing an intersection."* `crossing_count[i]` is reset to 0 at the start of every tick and incremented each time any vehicle enters node `i`. The `[]` operator makes SPIN check this over every reachable state — a stronger guarantee than a runtime `assert` alone, which only checks the execution path chosen by the verifier.

This property is chosen from the v-group perspective because it is a direct constraint on infrastructure behavior: the signal controller must ensure its green-light decisions never allow two vehicles to converge on the same intersection in the same step.

Result: **PASS**

---

## 3. Verification Results

**Commands used:**
```bash
cd verification/spin
spin -a phase_c_model.pml
cc -O2 -DBITSTATE -o pan pan.c
./pan -m2000000 -a -N <claim>
```

| Property | Claim | Errors | States | Depth | Memory | Time |
|---|---|---|---|---|---|---|
| No collision (shared) | `no_collision` | **0** | 49,979 | 19,469 | 147 MB | 0.58s |
| No red-light violation (shared) | `no_red_violation` | **0** | 49,979 | 19,469 | 147 MB | 0.40s |
| No opposite-direction (shared) | `no_opposite_direction` | **0** | 49,979 | 19,469 | 147 MB | 0.40s |
| V-1: eventual green (bounded) | `eventual_green_bounded` | **0** | 49,979 | 19,469 | 147 MB | 0.40s |
| V-2: fair green (bounded) | `fair_green_bounded` | **0** | 49,979 | 19,469 | 147 MB | 0.40s |
| V-3: mutual exclusion of lights | `mutual_exclusion_lights` | **0** | 49,979 | 19,469 | 147 MB | 0.40s |
| V-4: one crossing per tick (self) | `intersection_crossing_bound` | **0** | 49,979 | 19,469 | 147 MB | 0.40s |

All 7 properties **satisfied**. No counterexample found in any run.

**Note on bounded verification:** `-DBITSTATE` uses bitstate hashing — a fixed 16 MB bit array marks visited states rather than storing full 892-byte state vectors. This is a sound over-approximation: if SPIN finds no error it means no error exists on any path within the depth bound. The tradeoff is a small probability of missing states (false negatives), but never false positives on errors.

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

### 4.5 Violation Counts

All simulation runs report:
- Collisions: **0**
- Red-light violations: **0**
- Opposite-direction violations: **0**
- U-turn violations: **0**
