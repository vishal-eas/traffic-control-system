# SPIN Model: Step-by-Step Implementation Plan

## Current State
- `phase_b_model.pml`: 1 intersection, 2 roads, 2 vehicles, deterministic, all 6 properties pass (305 states)

## Steps

### Step 1: Add Nondeterminism ← CURRENT
- **Vehicle**: nondeterministic choice — move forward OR stay (even when next slot is free)
- **Infra**: nondeterministic — pick any valid single green direction (not fixed cycle)
- SPIN explores all interleavings
- Gate: all 6 properties still pass

### Step 2: Expand to 4-Intersection (2x2) Grid with Bidirectional Roads
- 4 intersections, 4 road segments (2 horizontal, 2 vertical)
- Each road has FORWARD and BACKWARD lanes
- Generalize `road_slots[NUM_ROADS][2][SLOTN]` array structure
- Gate: collision and light properties pass

### Step 3: Add Intersection Turning (Multi-Exit)
- Vehicle at intersection chooses exit direction (nondeterministic or route-driven)
- Light check: vehicle can only exit on GREEN direction
- Intersection→slot-0 transition (enter road from intersection)
- Slot-(SLOTN-1)→intersection transition (enter intersection from road)
- Gate: crossing constraint (at most 1 per step) holds

### Step 4: Add Heading Tracking and No-U-Turn
- `incoming_heading[vid]` set when entering intersection
- Outgoing heading != opposite of incoming heading
- Gate: `no_uturn` property verified

### Step 5: Expand to Full 3x3 Grid + Square Nodes A,B,C,D
- 9 intersections, 12 road segments, 4 square links
- Square node entry/exit logic
- Corner intersection light-enabled masks (only 2-3 directions)
- `post_square_forbidden_heading` constraint
- Gate: model compiles, bounded search completes

### Step 6: Add Precomputed Route Tables and Tour Progress
- `next_hop[current_node][destination]` lookup table
- Tour state: vehicle follows A→{B,C,D}→A sequence
- Gate: `eventual_completion` — all vehicles finish tour

### Step 7: Final Property Pack and Reporting
- All 6 safety + LTL properties verified
- i-group / v-group dual-counter consistency
- Property table: states explored, time, pass/fail

---

## Smart Algorithm Notes

### Infrastructure: Adaptive Light Switching
The current C++ `simpleCycleStrategy()` is a fixed-time cycle — it rotates green every 2 ticks regardless of traffic. For both the C++ simulation and the SPIN model, we should develop a smarter strategy:

**Congestion-aware switching (spec requirement)**:
> "A v-group knows the number of cars stopping at each intersection as congestion information."

The i-group should use vehicle queue lengths to decide which direction gets green. Algorithm ideas:
1. **Longest-queue-first**: Count vehicles in last N slots of each approach road. Give green to the direction with the most waiting vehicles.
2. **Starvation prevention**: Never let a direction wait more than K ticks without getting green.
3. **Throughput-optimized**: If a direction has 0 vehicles waiting, skip it and give green to a direction that does have vehicles.

In SPIN, this can be modeled as: InfraFSM reads `road_slots` to count vehicles near intersection, then nondeterministically picks green among directions that have waiting vehicles (or any direction if none are waiting). The nondeterminism lets SPIN verify properties hold under ALL valid scheduling choices.

### Vehicle: Smart Route Planning
The current C++ uses BFS shortest path. For the SPIN model and potential C++ improvements:

1. **Congestion-aware routing**: When multiple shortest paths exist to a destination, prefer routes through less congested intersections. The spec says vehicles can see congestion info.
2. **Adaptive re-routing**: If a vehicle's planned path is heavily congested (many vehicles queued on next road segment), consider an alternative path even if slightly longer.
3. **Cooperative spacing**: Vehicles departing from SQUARE_A should stagger their routes — if vehicle 1 goes B→C→D, vehicle 2 should go D→C→B to spread load.

In SPIN, route planning is precomputed (lookup tables), so the "smart" aspect is in which precomputed routes we embed. We can verify that different route assignments all satisfy safety properties, then pick the one with best throughput in the C++ simulation.

### Where to Implement
- **C++ first**: Implement and test adaptive light switching and congestion-aware routing in the C++ simulation. Measure throughput improvement.
- **SPIN second**: Encode the algorithm's decision logic in InfraFSM/VehicleFSM. Use nondeterminism to abstract any decision the algorithm COULD make, so SPIN verifies safety holds for all possible decisions, not just one trace.
