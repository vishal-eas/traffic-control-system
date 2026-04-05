# Phase B SPIN Mini-Model Plan

## Purpose
Create a small SPIN model first (single intersection) to validate the verification workflow end-to-end. After this passes, scale to the full 3x3 topology and square-node tour behavior.

## Requirements Covered (Phase B)
The mini-model should verify these properties before we scale up:

1. No collision.
2. No red-light violation.
3. No opposite-direction lane usage.
4. No U-turn.
5. At most one vehicle crossing the intersection per time step.
6. Basic liveness/progress: at least one vehicle eventually completes crossing.

## Installation and Dependencies

### macOS
1. Install Xcode command-line tools:

```bash
xcode-select --install
```

2. Install Homebrew (if not present):

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

3. Install SPIN:

```bash
brew install spin
```

4. Optional visualization utility:

```bash
brew install graphviz
```

5. Verify installation:

```bash
spin -V
cc --version
dot -V   # optional
```

### Ubuntu/Debian (reference)

```bash
sudo apt-get update
sudo apt-get install -y spin build-essential graphviz
spin -V
cc --version
```

## Files

1. Promela model: verification/spin/simple_test.pml
2. This plan: verification/spin/phase_b_plan.md

## Mini-Model Design

### System abstraction
1. One controlled intersection.
2. Two incoming lanes (orthogonal conflict case).
3. Each lane has small bounded slots (default: 4).
4. Two vehicles, one on each approach.
5. Single-light-green policy (mutually exclusive signal state).

### State variables (Promela)
1. Lane occupancy arrays.
2. Vehicle lane/slot/done flags.
3. Traffic light state per approach.
4. Per-step crossing counter.
5. Violation flags for all required safety properties.

### Step order (synchronous tick)
1. Reset per-step crossing counter.
2. Infrastructure step updates lights.
3. Vehicles attempt movement.
4. Assertions check safety invariants.

## How to Write the Code (Implementation Recipe)
1. Define constants (`NVEH`, `SLOTN`) and light enum (`RED`, `GREEN`).
2. Encode occupancy and vehicle state as bounded arrays.
3. Write `infra_step` inline function:
   - exactly one approach is green at a time.
4. Write `move_one` inline function:
   - if not at stop-line: move one slot if next slot is free.
   - if at stop-line: cross only when own approach light is green and crossing counter is zero.
   - otherwise wait.
5. Track violations through explicit flags and assert they remain false.
6. Add LTL properties for each requirement.
7. Keep the model deterministic for first pass (easier debugging).

## SPIN Workflow (End-to-End)
Run from repository root.

1. Quick simulation trace:

```bash
spin -p -g -l verification/spin/simple_test.pml
```

2. Generate verifier:

```bash
spin -a verification/spin/simple_test.pml
```

3. Compile verifier:

```bash
cc -O2 -o pan pan.c
```

4. Exhaustive run:

```bash
./pan -m1000000
```

5. Named property checks:

```bash
./pan -m1000000 -N no_collision
./pan -m1000000 -N no_red_violation
./pan -m1000000 -N no_opposite_direction
./pan -m1000000 -N no_uturn
./pan -m1000000 -N eventual_completion
```

6. Counterexample replay (if any property fails):

```bash
spin -t -p -g verification/spin/simple_test.pml
```

## Acceptance Criteria for Phase B
1. Model compiles via SPIN (`spin -a`) and C compiler (`cc -O2`).
2. No assertion failures in exhaustive run.
3. All named LTL properties pass.
4. Workflow is reproducible from a clean clone with the commands above.

## Next After Phase B Passes
1. Expand to full 3x3 intersection topology.
2. Add square nodes A/B/C/D and tour-order states.
3. Reuse same safety checks at larger scale.
4. Add stronger liveness properties per vehicle/tour.