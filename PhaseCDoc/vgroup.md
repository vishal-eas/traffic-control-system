# Phase C Report — v-group

## 1. Scope

This report is the v-group Phase C submission for the integrated traffic-control system. According to the Phase C specification, the v-group is responsible for verifying the infrastructure-side properties of the merged design. The report also summarizes integrated simulator throughput and the changes made to improve throughput.

The infrastructure-side properties required by the specification are:

- At every intersection, every vehicle eventually gets its turn of green signal.
- At every intersection, green is granted fairly among directions.
- At any moment at any intersection, only one light is green.
- One additional property chosen by the group.

For the additional property, this report verifies that the set of enabled light directions always matches the physical road topology of the grid. This property is named `valid_light_topology` in the SPIN model.

## 2. Model And Verification Setup

The bounded SPIN model used for this report is:

- `SPIN/v-group/phase_c_model.pml`

The infrastructure-side verification runner is:

- `SPIN/v-group/run_v_group.sh`

The Promela model abstracts the infrastructure into:

- one active green direction per intersection,
- enabled/disabled directions derived from grid topology,
- bounded red-streak counters for fairness and starvation checks, and
- explicit light-state monitors for safety and validity properties.

This bounded abstraction is suitable for Phase C because it preserves the main signal-control obligations while keeping the state space manageable for SPIN.

## 3. Claim Mapping

The required v-group properties are mapped to the following LTL claims:

| Specification requirement | SPIN claim |
|---|---|
| Every enabled direction eventually receives green | `eventual_green_bounded` |
| Green is granted fairly among directions | `fair_green_bounded` |
| At most one light is green at any intersection | `mutual_exclusion_lights` |
| Additional property: enabled signals match the road topology | `valid_light_topology` |

## 4. How To Run The SPIN Verification

From the repository root:

```bash
cd SPIN/v-group
./run_v_group.sh
```

The script performs the following steps:

1. Runs `spin -a phase_c_model.pml` to generate `pan.c`.
2. Compiles the SPIN verifier.
3. Executes each infrastructure-side LTL claim individually.
4. Prints a CSV-style summary containing the claim name, error count, stored states, and reached depth.

## 5. SPIN Results

Observed results from `./run_v_group.sh`:

| Claim | Errors | States | Depth |
|---|---:|---:|---:|
| `eventual_green_bounded` | 0 | 49979 | 19469 |
| `fair_green_bounded` | 0 | 49979 | 19469 |
| `mutual_exclusion_lights` | 0 | 49979 | 19469 |
| `valid_light_topology` | 0 | 49979 | 19469 |

All required v-group properties were satisfied in the current bounded SPIN model.

## 6. Interpretation Of Results

The verification results show that, within the bounded model:

- enabled approaches do not starve indefinitely,
- green service is granted fairly under the modeled controller,
- no intersection ever exposes more than one green signal at a time, and
- the signal system never enables a direction that does not correspond to a real road in the grid.

The additional property `valid_light_topology` is a good infrastructure-specific check because it confirms that the controller configuration is structurally correct. It complements `mutual_exclusion_lights`: a signal can be unique and still be invalid if it points to a nonexistent road, so both properties are useful.

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

## 9. Throughput Results

Current measured throughput after the simulator revisions:

| Mode | Vehicles | Throughput |
|---|---:|---:|
| `mixed` | 48 | `88.00 tours/hour` |
| `balanced` | 48 | `124.17 tours/hour` |

These benchmark runs reported:

- `0` collisions,
- `0` red-light violations,
- `0` opposite-direction violations, and
- `0` U-turn violations

in the current simulator statistics output.

## 10. Throughput Discussion

Although the project contains 9 intersections, throughput is limited mainly by repeated use of the `A` corner corridor rather than by total intersection count alone. Every valid tour must leave from `A`, traverse the network, and return to `A`, which concentrates load on the same critical lanes.

A practical theoretical throughput ceiling from the project constraints is about `116.13 tours/hour`. This figure is based on:

- 2-second control steps,
- one lane per direction,
- the visibility/headway rule, and
- the repeated use of the `A` corner approach and departure lanes.

The measured `mixed` result remains below this spec-derived ceiling. The measured `balanced` result exceeds it slightly, which suggests that the simulator still abstracts the full specification somewhat loosely on cross-intersection headway visibility. That caveat should be stated clearly in the final submission.

## 11. Changes Made To Improve Throughput

The integrated simulator was revised in several ways to improve throughput:

1. Vehicles now preserve their configured repeated square-node order instead of resetting to one shared hard-coded order after completing a tour.
2. Square-node connector roads were extended to 2 slots so the geometry more closely matches the specification.
3. A `balanced` benchmark mode was added so perimeter traffic can be distributed in both directions.
4. The congestion-aware, starvation-bounded signal strategy was retained and exercised under the improved route distribution.

These changes improved the measured throughput significantly:

- before the revisions, the simulator plateaued around `62 tours/hour`,
- after the revisions, it reached about `88 tours/hour` in `mixed` mode, and
- with intentionally balanced perimeter assignment, it reached about `124 tours/hour`.

## 12. Submission Notes

When preparing the final PDF submission, it is useful to include:

- screenshots of the SPIN output from `SPIN/v-group/run_v_group.sh`,
- screenshots of the throughput benchmark output,
- a concise explanation of the bounded fairness abstraction used in the model, and
- the note that the `balanced` benchmark slightly exceeds the stricter spec-derived ceiling because the current simulator still abstracts some headway behavior loosely.
