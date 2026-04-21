# Phase C Submission Checklist

## 1. Files To Submit

- One PDF report for the i-group
- One PDF report for the v-group
- If submitting a zip file, ensure the filename includes the team ID and group type as required by the spec

## 2. Recommended Source Drafts

- i-group draft: `PhaseCDoc/igroup.md`
- v-group draft: `PhaseCDoc/vgroup.md`

## 3. Required Sections In Each Report

- Team ID and group type on the front page
- Brief description of the model used for verification
- Clear list of required properties verified
- Clear statement of the self-chosen additional property
- Verification results for each property
- Whether each property is satisfied or not
- If any property is not satisfied, include a counterexample
- Throughput results from the integrated simulator
- Counts for collisions, illegal running directions, U-turns, and red-light violations
- Description of any changes made to improve throughput compared to the earlier implementation

## 4. SPIN Commands To Run

### i-group report

```bash
cd SPIN/i-group
./run_i_group.sh
```

### v-group report

```bash
cd SPIN/v-group
./run_v_group.sh
```

## 5. Simulator Commands To Run

Build and test:

```bash
cmake -S . -B build
cmake --build build -j
ctest --test-dir build --output-on-failure
```

Example throughput runs:

```bash
./build/throughput_bench 48 28800 7200 mixed
./build/throughput_bench 48 28800 7200 balanced
```

## 6. Screenshots To Capture

For the i-group PDF:

- Terminal output of `SPIN/i-group/run_i_group.sh`
- Terminal output showing the throughput benchmark run
- Optional screenshot of the relevant LTL claims in `SPIN/i-group/phase_c_model.pml`

For the v-group PDF:

- Terminal output of `SPIN/v-group/run_v_group.sh`
- Terminal output showing the throughput benchmark run
- Optional screenshot of the relevant LTL claims in `SPIN/v-group/phase_c_model.pml`

## 7. Property Mapping To Double-Check

### i-group

- `no_uturn`
- `no_red_violation`
- `visit_all_bcd`
- `no_collision`
- `tour_closure`

### v-group

- `eventual_green_bounded`
- `fair_green_bounded`
- `mutual_exclusion_lights`
- `valid_light_topology`

## 8. Throughput Points To Mention

- The earlier simulator plateau was about `62 tours/hour`
- The revised simulator reached about `88 tours/hour` in `mixed` mode
- The `balanced` benchmark reached about `124.17 tours/hour`
- The stricter spec-derived theoretical ceiling is about `116.13 tours/hour`
- The `balanced` benchmark slightly exceeds that ceiling, so the report should explicitly note that the simulator still abstracts some cross-intersection headway behavior more loosely than the full spec

## 9. Final Review Before Exporting PDF

- Confirm the correct group ownership in each report
- Confirm the self-chosen property is clearly labeled
- Confirm all SPIN results shown in the report match current script output
- Confirm throughput numbers match the benchmark output you plan to cite
- Confirm screenshots are readable
- Confirm the front page includes the correct team ID and group type
- Confirm the PDF filename follows the course submission naming requirement
