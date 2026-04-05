# SPIN Full Implementation Plan (Vehicle + Signal FSMs)

## Objective
Implement the actual model with independent infrastructure and vehicle FSMs that communicate in a clean, reproducible way while preserving the project constraints.

## Recommended Style (Best + Easiest)
Use a hybrid style:

1. Shared-state data model (Grid-like arrays) for world state.
2. Synchronous tick/barrier channels for process coordination.

Why this is best for this project:

1. Matches your C++ architecture (agents communicate through shared Grid state).
2. Keeps behavior deterministic and easier to debug.
3. Avoids the complexity and state explosion of pure message-passing traffic dynamics.
4. Lets us keep infrastructure and vehicles as truly separate FSM processes.

## Process Decomposition

1. `proctype ClockFSM()`
   - Drives global time steps.
   - Resets per-step counters.
   - Triggers infrastructure and vehicles.
   - Waits for completion acknowledgments.
   - Runs global assertions.

2. `proctype InfrastructureFSM()`
   - Updates intersection light states every tick.
   - Enforces one-green-per-intersection rule.

3. `proctype VehicleFSM(byte vid)` (one per vehicle)
   - Reads shared state.
   - Computes move intent (wait/advance/cross/turn).
   - Writes intent output for arbitration.
   - Applies committed move outcome.

4. Optional `proctype MonitorFSM()`
   - Tracks counters and debugging flags.
   - Not required initially (can be in `ClockFSM`).

## Communication Pattern

### Control communication (channels)
Use rendezvous channels for strict lock-step synchronization:

1. `tick_infra` and `done_infra` for infrastructure step.
2. `tick_vehicle[vid]` and shared `done_vehicle` for vehicle steps.
3. Optional `tick_arbiter` and `done_arbiter` if arbitration is a separate process.

### Data communication (shared variables)
Use shared arrays and flags for state:

1. Road/lane occupancy arrays.
2. Intersection light arrays.
3. Per-step intersection crossing occupancy.
4. Vehicle state arrays:
   - location mode (at intersection or on road)
   - road id, slot, direction
   - current node
   - incoming heading
   - post-square forbidden heading
   - destination/tour progress

## FSM Behavior Design

### InfrastructureFSM states

1. `WAIT_TICK`
2. `UPDATE_LIGHTS`
3. `ACK_DONE`

Transition logic:

1. On tick, compute next light phase for each intersection.
2. Ensure at most one green light per intersection.
3. Return done signal.

### VehicleFSM states

1. `WAIT_TICK`
2. `SENSE`
3. `PLAN_INTENT`
4. `WAIT_COMMIT` (or direct apply in first version)
5. `ACK_DONE`

Transition logic:

1. Read signal and occupancy.
2. If on road and next slot free, request `ADVANCE`.
3. If at slot 29 and crossing allowed, request `CROSS_INTERSECTION`.
4. If at intersection, choose next edge by route policy while enforcing:
   - no U-turn
   - no opposite-direction lane
   - no red-light crossing
5. Apply only committed safe move.

## Conflict Handling (Important)

Use two-phase step semantics to avoid order bias between vehicles:

1. Intent phase: every vehicle proposes one move.
2. Arbitration phase: resolve conflicts globally.
3. Commit phase: apply accepted moves simultaneously.

This is the simplest correct way to enforce:

1. At most one crossing per intersection per step.
2. No two vehicles in same target slot after a step.

## Implementation Roadmap

### Step 1: Refactor mini-model to separate proctypes

1. Keep one intersection and two vehicles.
2. Split into `ClockFSM`, `InfrastructureFSM`, `VehicleFSM`.
3. Keep properties from `simple_test.pml` passing.

### Step 2: Add intent/arbitration/commit flow

1. Introduce move-intent arrays.
2. Add arbiter logic in `ClockFSM` first (simpler than separate process).
3. Verify safety properties again.

### Step 3: Expand to network topology

1. Add 3x3 intersections and road indexing.
2. Add square nodes A/B/C/D and legal topology edges.
3. Add route/tour-progress variables per vehicle.

### Step 4: Add full constraint checks

1. No collision.
2. No red-light violation.
3. No opposite-direction lane usage.
4. No U-turn.
5. At most one crossing per intersection per step.
6. Liveness: eventual tour completion (bounded or unbounded variants).

## Property Set (LTL + Assertions)

Assertions each step:

1. Slot occupancy uniqueness.
2. Green-light exclusivity per intersection.
3. Crossing count per intersection <= 1.

LTL examples:

1. `[] !collision`
2. `[] !red_violation`
3. `[] !opposite_direction_violation`
4. `[] !uturn_violation`
5. `<> completed_tour[v]` (vehicle liveness)

## Suggested File Layout

1. `verification/spin/simple_test.pml` (existing sanity mini-model)
2. `verification/spin/full_model_v1.pml` (separate FSMs, one intersection)
3. `verification/spin/full_model_v2.pml` (topology expansion)
4. `verification/spin/implementation_plan.md` (this document)

## Command Workflow

Use the same SPIN pipeline for each model file:

```bash
spin -a verification/spin/<model>.pml
cc -O2 -o pan pan.c
./pan -m1000000 -a -N <property_name>
```

## Practical Recommendation

Start with `full_model_v1.pml` as one-intersection but process-separated FSMs. This gives architectural correctness first, then topology scale second.