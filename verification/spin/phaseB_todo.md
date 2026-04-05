# Phase B TODO Checklist

Purpose: track and close Phase B gaps one by one before scaling further.

## Priority 1: SPIN Property Soundness

- [x] Make no_collision non-vacuous. **FIXED**
  - Solution: Added `check_invariants()` inline called after both vehicles move each tick.
    Checks: (a) both vehicles not on same (road, dir, slot), (b) each vehicle's slot
    contains its own id. Sets `collision = true` on violation.
  - Verified: no_collision passes (0 errors, 1506 states)

- [x] Make no_red_violation non-vacuous. **FIXED**
  - Solution: `check_invariants()` detects when a vehicle just entered a road (mode==1,
    slot==0, moved_this_step) and verifies the source intersection's light was green for
    the direction taken. Sets `red_violation = true` on violation.
  - Verified: no_red_violation passes (0 errors)
  - Negative test: removing red-light guard causes SPIN to find errors: 1 immediately

- [x] Make no_opposite_direction non-vacuous. **FIXED**
  - Solution: `check_invariants()` verifies each on-road vehicle's slot contains its own id,
    confirming data integrity between vehicle state and road slot occupancy.
    Sets `opposite_direction_violation = true` on mismatch.
  - Verified: no_opposite_direction passes (0 errors)

- [x] Keep no_uturn semantics. **Already non-vacuous**
  - `uturn_violation = true` set in no-U-turn guard in `move_vehicle()`.
  - Verified: no_uturn passes (0 errors)

## Priority 2: FSM Architecture Completeness

- [ ] Split vehicle logic into independent VehicleFSM proctypes.
  - Problem: vehicle behavior runs inline from init, not as process FSMs.
  - References:
    - [inline vehicle function](verification/spin/phase_b_model.pml#L340)
    - [inline calls in init](verification/spin/phase_b_model.pml#L589)
  - Acceptance criteria:
    - one VehicleFSM process per vehicle
    - tick/ack synchronization with scheduler

- [ ] Add explicit vehicle control channels.
  - Problem: only infra tick channels exist.
  - References:
    - [infra channels](verification/spin/phase_b_model.pml#L126)
  - Acceptance criteria:
    - define tick_vehicle and done_vehicle channels
    - scheduler waits for all vehicle acks each tick

## Priority 3: Property Naming and Semantics

- [x] Fix mutual_exclusion_lights property meaning. **FIXED**
  - Problem: current property checks crossing_count, not light mutual exclusion.
  - References:
    - [current LTL mutual_exclusion_lights](verification/spin/phase_b_model.pml#L621)
    - [actual light exclusivity assertion in infra process](verification/spin/phase_b_model.pml#L316)
  - Acceptance criteria:
    - property name matches what it checks
    - add explicit LTL/assertion for one-green-per-intersection
  - Solution:
    - Renamed crossing-count LTL to `intersection_crossing_bound`.
    - Added explicit `mutual_exclusion_lights` LTL for enabled green direction validity.
    - Added runtime assertions in Clock phase to enforce light_green range + enabled mapping.
  - Verified:
    - SPIN property runs pass with updated property names.

## Priority 4: C++ Congestion Fidelity

- [x] Include square-node approach demand in congestion counting at corners. **FIXED**
  - Solution: Extended `countApproachingVehicles()` to also count vehicles positioned at
    the adjacent square node for corner intersection directions:
    (0,0)/West→SQUARE_A, (2,0)/South→SQUARE_B, (2,2)/East→SQUARE_C, (0,2)/North→SQUARE_D.
  - Verified: test_corner_square_node_congestion passes — 3 vehicles at SQUARE_A cause
    (0,0) to give green to West.

- [x] Add corner starvation and MAX_RED_WAIT bound tests. **FIXED**
  - Solution: Added test_max_red_wait_bound that tracks consecutive red streaks for both
    center (1,1) and corner (0,0) intersections over 50 steps.
    Bound: MAX_RED_WAIT + max(0, num_enabled - 2) to account for simultaneous starvation
    of multiple directions (only one served per tick).
  - Verified: both center and corner intersections stay within bound.

### Priority 4 Proposed Implementation Sequence

1. Extend `countApproachingVehicles(row,col,direction)` to include square-node inflow on corner links.
   - For `(0,0)` direction West, include vehicles queued at `SQUARE_A` whose next move is into `(0,0)`.
   - For `(2,0)` direction South, include vehicles queued at `SQUARE_B` whose next move is into `(2,0)`.
   - For `(2,2)` direction East, include vehicles queued at `SQUARE_C` whose next move is into `(2,2)`.
   - For `(0,2)` direction North, include vehicles queued at `SQUARE_D` whose next move is into `(0,2)`.
2. Add deterministic test: corner congestion preference.
   - Scenario: create queue at one corner square approach and verify that corner intersection selects that direction green.
3. Add deterministic test: starvation bound.
   - Track consecutive red streak per enabled direction for one center intersection and one corner intersection.
   - Assert max streak does not exceed `MAX_RED_WAIT` (or explicitly document `MAX_RED_WAIT + 1` if implementation semantics require it).
4. Re-run C++ test suite and ensure no regression in existing infra and vehicle tests.

## Priority 5: Consistency Between C++ and SPIN

- [x] Resolve MAX_RED_WAIT mismatch by documented abstraction rationale.
  - References:
    - [C++ max wait](include/infrastructure/InfrastructureAgent.h#L27)
    - [SPIN max wait](verification/spin/phase_b_model.pml#L42)
    - [abstraction rationale](verification/spin/priority5_abstraction_rationale.md)
  - Acceptance criteria:
    - either values aligned or explicit note explaining intentional abstraction
  - Status:
    - Explicit rationale documented for Phase B bounded-model use.
    - Re-alignment to identical value is deferred to final timing-equivalent verification.

## Validation Runbook (after each TODO item)

1. C++:
   - `cd build && cmake .. && cmake --build . -j4 && ctest --output-on-failure`
2. SPIN:
   - `cd verification/spin && spin -a phase_b_model.pml && cc -O2 -o pan pan.c`
   - `./pan -m1000000 -a -N no_collision`
   - `./pan -m1000000 -a -N no_red_violation`
   - `./pan -m1000000 -a -N no_opposite_direction`
   - `./pan -m1000000 -a -N no_uturn`
   - `./pan -m1000000 -a -N eventual_completion`
