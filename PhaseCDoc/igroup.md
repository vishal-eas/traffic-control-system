# Phase C Report — i-group

## 1. Scope

This report is the i-group Phase C submission for the integrated traffic-control system. According to the Phase C specification, the i-group is responsible for verifying the vehicle-side properties of the merged design. In addition, the report summarizes the integrated simulator throughput and the changes made to improve throughput relative to the earlier implementation.

The vehicle-side properties required by the specification are:

- No vehicle takes any U-turn.
- No vehicle enters an intersection at red light.
- Every vehicle visits all of points `B`, `C`, and `D`.
- No collision occurs between any two vehicles.
- One additional property chosen by the group.

For the additional property, this report verifies that every vehicle that completes the required visit sequence eventually returns to `A`. This property is named `tour_closure` in the SPIN model.

## 2. Model And Verification Setup

The bounded SPIN model used for this report is:

- `SPIN/i-group/phase_c_model.pml`

The vehicle-side verification runner is:

- `SPIN/i-group/run_i_group.sh`

The Promela model abstracts the integrated simulator into:

- bounded road-slot occupancy,
- light-controlled intersections,
- vehicle movement over roads and intersections,
- route progress through required square nodes, and
- explicit monitors for vehicle safety and progress properties.

The abstraction is intentionally bounded so that SPIN can exhaustively explore the relevant finite state space while still preserving the main safety and liveness obligations from the project.

## 3. Claim Mapping

The required i-group properties are mapped to the following LTL claims in the model:

| Specification requirement | SPIN claim |
|---|---|
| No vehicle takes any U-turn | `no_uturn` |
| No vehicle enters an intersection at red light | `no_red_violation` |
| Every vehicle visits `B`, `C`, and `D` | `visit_all_bcd` |
| No collision occurs between any two vehicles | `no_collision` |
| Additional property: every completed tour returns to `A` | `tour_closure` |

## 4. How To Run The SPIN Verification

From the repository root:

```bash
cd SPIN/i-group
./run_i_group.sh
```

The script performs the following steps:

1. Runs `spin -a phase_c_model.pml` to generate `pan.c`.
2. Compiles the SPIN verifier.
3. Executes each vehicle-side LTL claim individually.
4. Prints a CSV-style summary containing the claim name, error count, stored states, and reached depth.

## 5. SPIN Results

Observed results from `./run_i_group.sh`:

| Claim | Errors | States | Depth |
|---|---:|---:|---:|
| `no_uturn` | 0 | 49979 | 19469 |
| `no_red_violation` | 0 | 49979 | 19469 |
| `visit_all_bcd` | 0 | 24033 | 13731 |
| `no_collision` | 0 | 49979 | 19469 |
| `tour_closure` | 0 | 49590 | 19406 |

All required i-group properties were satisfied in the current bounded SPIN model.

## 6. Interpretation Of Results

The verification results show that, within the bounded abstraction:

- vehicles do not perform U-turns,
- vehicles do not enter on red,
- vehicles do complete the required visit sequence through `B`, `C`, and `D`,
- no collisions are detected in the modeled state space, and
- vehicles eventually close the tour by returning to `A`.

The additional property is useful because it checks not only safety, but also completion of the intended tour behavior. It complements `visit_all_bcd` by showing that the route logic does not stall permanently after the required intermediate destinations are reached.

## 7. Simulator Build And Test Procedure

The integrated C++ simulator can be built and tested with:

```bash
cmake -S . -B build
cmake --build build -j
ctest --test-dir build --output-on-failure
```

The throughput benchmark executable is:

- `build/throughput_bench`

## 8. How To Run The Throughput Simulation

Example benchmark runs:

```bash
./build/throughput_bench 48 28800 7200 mixed
./build/throughput_bench 48 28800 7200 balanced
```

Argument meaning:

- argument 1: number of vehicles
- argument 2: total simulation steps
- argument 3: warmup steps excluded from the throughput window
- argument 4: route mode

## 9. Throughput Results

Current measured throughput after the simulator revisions:

| Mode | Vehicles | Throughput |
|---|---:|---:|
| `mixed` | 48 | `88.00 tours/hour` |
| `balanced` | 48 | `124.17 tours/hour` |

The `mixed` result is the more conservative integrated-system figure because it uses a broader mixture of tours. The `balanced` result is the highest observed benchmark result after deliberately splitting vehicles between clockwise and counterclockwise perimeter tours.

## 10. Throughput Discussion

The dominant throughput bottleneck in the project is not the number of intersections alone, but the repeated use of the corner around `A`. Every valid tour must:

1. start from `A`,
2. visit `B`, `C`, and `D`, and
3. return to `A`.

That repeatedly loads the lanes connected to the `A` corner and makes them the critical bottleneck of the system.

Using the project constraints, a practical theoretical ceiling is about `116.13 tours/hour`. This estimate is based on:

- 2-second control steps,
- one lane per direction,
- the visibility/headway constraint, and
- the repeated need to use the `A` corner outbound and inbound lanes.

The measured `mixed` result remains below that ceiling. The measured `balanced` result exceeds it slightly, which suggests that the current simulator is still somewhat more permissive than the full specification on cross-intersection headway visibility. This is important to acknowledge in the final report.

## 11. Changes Made To Improve Throughput

Several implementation changes were made to improve throughput:

1. Vehicles now preserve their configured square-node visit order across repeated tours instead of resetting every completed tour to the same hard-coded route.
2. Square-node connector roads were updated to 2 slots so the geometry more closely matches the project specification.
3. A `balanced` benchmark mode was added so the system can better use both clockwise and counterclockwise perimeter traffic patterns.
4. The congestion-aware signal controller was retained and exercised under the improved route distribution.

These changes improved the measured throughput substantially:

- before the fixes, the simulator plateaued around `62 tours/hour`,
- after the fixes, the simulator reached about `88 tours/hour` in `mixed` mode, and
- under intentionally balanced perimeter assignment, it reached about `124 tours/hour`.

## 12. Submission Notes

When preparing the final PDF submission, it is helpful to include:

- screenshots of the SPIN output from `SPIN/i-group/run_i_group.sh`,
- screenshots of the throughput benchmark output,
- a short explanation of the bounded abstraction used in the Promela model, and
- the throughput caveat that the `balanced` result slightly exceeds the strict spec-derived theoretical ceiling.
