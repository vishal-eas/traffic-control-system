# Phase C TODO Checklist

Purpose: scale the Phase B baseline (2x2, 2 vehicles, inline vehicle logic) into the full Phase C model (3x3 grid + sq A only, B/C/D as corner intersections, 2 vehicles on A→{B,C,D}→A tours, independent i-group / v-group FSMs), verify all spec-mandated properties in SPIN, and produce two submission reports (i-group and v-group).

**Topology decision (2026-04-19):** Only sq A is a real square node (linked to corner (0,0) by a 1-slot road). B=(2,0), C=(2,2), D=(0,2) are ordinary 3×3 corner intersections — visited when a vehicle reaches that intersection. No sq B/C/D link roads. Total: 10 nodes, 13 roads.

Deadline: **2026-04-28 16:00** (Phase C submission, Canvas).

References:
- Phase C-2 spec: `Spec/723Spring26ProjectPhaseC-2.pdf`
- Project overview: `Spec/723Spring26ProjectOverview.adoc`
- Execution plan: `verification/spin/full_implementation_execution_plan.md`
- Phase B baseline: `verification/spin/phase_b_model.pml`
- Phase B open items: `verification/spin/phaseB_todo.md` (Priority 2 still open)

---

## Priority 0: Phase B Carry-Over (prerequisite)

- [x] **P2 from Phase B — split vehicle logic into independent `VehicleFSM` proctypes.** ✅ DONE
  - `phase_b_model.pml` now has `proctype VehicleFSM(byte vid)` with `tick_vehicle[NVEH]`/`done_vehicle[NVEH]` rendezvous channels.
  - All 7 LTL claims pass. Negative test confirms synchronization is non-vacuous.
  - Report: `verification/spin/phaseB_p2_test_report.md`

---

## Priority 1: Phase C-1 — Topology Expansion (REVISED)

**Revised topology (2026-04-19):**
```
Nodes (10 total):
  (0,0)=0  (0,1)=1  (0,2)=D=2
  (1,0)=3  (1,1)=4  (1,2)=5
  (2,0)=B=6  (2,1)=7  (2,2)=C=8
  sq A = 9  (only square node; linked to (0,0) via 1-slot road)

Roads (13 total):
  h[0][0]=0:(0,0)↔(0,1)  h[0][1]=1:(0,1)↔(0,2)
  h[1][0]=2:(1,0)↔(1,1)  h[1][1]=3:(1,1)↔(1,2)
  h[2][0]=4:(2,0)↔(2,1)  h[2][1]=5:(2,1)↔(2,2)
  v[0][0]=6:(0,0)↔(1,0)  v[0][1]=7:(0,1)↔(1,1)  v[0][2]=8:(0,2)↔(1,2)
  v[1][0]=9:(1,0)↔(2,0)  v[1][1]=10:(1,1)↔(2,1) v[1][2]=11:(1,2)↔(2,2)
  sq_A=12:(0,0)↔sqA  (SLOTN_SQ=1)

Enabled directions:
  (0,0)=0: E, S, W(→sqA)       (0,1)=1: E, S, W
  D=(0,2)=2: S, W              (1,0)=3: N, E, S
  (1,1)=4: N, E, S, W          (1,2)=5: N, S, W
  B=(2,0)=6: N, E              (2,1)=7: N, E, W
  C=(2,2)=8: N, W              sqA=9: E only (no signal)

B/C/D corners: forced exit by U-turn rule (only 2 enabled dirs; incoming
heading eliminates one, leaving exactly 1 valid exit).
```

- [x] **Create `verification/spin/phase_c_model.pml`** ✅ DONE (initial version with 4 sq nodes)
- [x] **Rewrite `phase_c_model.pml` with revised topology** (sq A only, B/C/D as intersections) ✅ DONE
  - Update `NUM_NODES=10`, `NUM_ROADS=13`, `NUM_SQ=1`
  - Update `light_enabled` init: remove sq B/C/D directions from corners
  - Update `InfraFSM` congestion table: remove sq B/C/D approach counting
  - Update `VehicleFSM` topology lookup: remove sq B/C/D exit/arrival entries
  - Update `check_invariants` red-light reverse lookup: remove sq B/C/D road entries
  - Update `init`: remove sq B/C/D node initialization
  - Gate: `spin -a` + `cc -O2` + `./pan -m2000000 -a` all `errors: 0`

- [ ] **Recompute `NVEH`, bounds, channel sizes.**
  - Start with `NVEH=2`, grow to `NVEH=3` only if state space stays within bitstate budget.
  - `MAX_TICKS` sized to allow the longest tour (A→B→C→D→A is ~12 intersection hops in the worst ordering) × some slack for reds.

- [ ] **Gate C-1:** `spin -a phase_c_model.pml && cc -O2 -o pan pan.c && ./pan -m2000000 -a` runs to completion (bounded search OK). No compile errors, no trivial-vacuous assertion failures.

---

## Priority 2: Phase C-2 — Routing and Tours

- [x] **Precomputed `next_hop_ha[src*50 + inc_idx*10 + dst]` heading-aware table.** ✅ DONE
  - Generated offline with BFS + no-U-turn (Python script); inc_idx 0=N,1=E,2=S,3=W,4=NONE.
  - Heading-aware required because corner nodes (N_C, N_D) have only 2 exits; naive table sent vehicles into U-turns at those corners.
  - Embedded as `byte next_hop_ha[NUM_NODES * 5 * NUM_NODES]` (500 bytes).

- [x] **Tour orderings.** ✅ DONE
  - V0: SQ_A → N_B → N_C → N_D → SQ_A
  - V1: SQ_A → N_D → N_C → N_B → SQ_A  (opposite ordering — stresses concurrent path sharing)
  - Fixed permutations chosen (not nondeterministic) to keep state space tractable.

- [x] **`all_tours_done` flag.** ✅ DONE
  - `returned_A[vid]` set when vehicle arrives at SQ_A after visiting all B, C, D.
  - `all_tours_done = true` when both returned_A[0] && returned_A[1].

- [x] **Post-square forbidden-heading constraint.** ✅ DONE
  - `sq_a_forbidden[vid]` set to DIR_W when vehicle leaves SQ_A; cleared on next intersection departure.
  - Prevents vehicle from immediately re-entering SQ_A on the same tick it departed.
  - sq A arrivals use `in_heading=DIR_NONE` so the heading-aware table gets no-constraint lookup at N00.

- [x] **Gate C-2:** ✅ DONE
  - All 7 LTL claims: errors: 0, depth ~19469.
  - Simulation confirms both vehicles complete full B/C/D tours and return to SQ_A (`all_tours_done=1`).

---

## Priority 3: Phase C-3 — Property Verification (Two Reports)

Phase C-2 spec requires **two separated reports**, one per group, each verifying a different property list. Our team must produce both (same model file, different LTL claim sets and different narratives).

### 3a. i-group report properties (mandatory per spec)

The i-group verifies **vehicles**:

- [ ] **I-1 No vehicle takes any U-turn.**
  - Reuse existing `no_uturn` LTL from Phase B — already passes. Confirm it still passes on the 3x3 model.

- [ ] **I-2 No vehicle enters an intersection at red light.**
  - Reuse `no_red_violation` — confirm on 3x3.

- [ ] **I-3 Every vehicle must visit all of points B, C and D.**
  - New LTL: `ltl visit_all_squares { <> (visited_B[0] && visited_C[0] && visited_D[0] && visited_B[1] && visited_C[1] && visited_D[1]) }`
  - Bounded variant: wrap in `MAX_TICKS` guard if full liveness blows up.
  - Per-vehicle `visited_B[vid]`, `visited_C[vid]`, `visited_D[vid]` bool arrays, set in the VehicleFSM when it transitions into the square node.

- [ ] **I-4 No collision between any two vehicles.**
  - Reuse `no_collision` — confirm on 3x3.

- [ ] **I-5 Self-chosen property (i-group).** Pick ONE and document rationale:
  - Option A: "Every vehicle that has not yet completed its tour eventually moves" — non-starvation of a vehicle.
  - Option B: "A vehicle that has visited B, C, D eventually returns to A" — tour closure (stronger than I-3 alone).
  - Option C: "No two vehicles cross the same intersection in the same tick" — restates the spec's "at most 1 car crossing per step" rule.
  - **Recommended: Option B** (directly maps to the spec's tour-completion metric).

### 3b. v-group report properties (mandatory per spec)

The v-group verifies **infrastructure / signals**:

- [ ] **V-1 At every intersection, every direction eventually gets green.**
  - LTL per intersection × direction: `[] <> (light_green[i] == d)` for each enabled `(i, d)`.
  - Bounded version (if full liveness too expensive): `[] (red_streak[i][d] <= MAX_RED_WAIT)` — this is already in the Phase B model via `red_streak`.

- [ ] **V-2 Green signal granted fairly among all directions.**
  - Interpret as "no direction is starved while another is served repeatedly".
  - LTL: for each intersection i, each enabled direction d: `[] <> (light_green[i] == d)` (same form as V-1).
  - Stronger bounded version: bound `red_streak[i][d]` by `MAX_RED_WAIT + (num_enabled - 1)` (the analytical bound from Phase B Priority 4 test).

- [ ] **V-3 At most one green per intersection at any moment.**
  - Reuse `mutual_exclusion_lights` LTL from Phase B Priority 3. Confirm it still passes on 3x3.

- [ ] **V-4 Self-chosen property (v-group).** Pick ONE and document:
  - Option A: "If a direction has a waiting vehicle, it eventually gets green" — conditional liveness, closer to real fairness.
  - Option B: "Infrastructure never enables a disabled direction" — sanity on the enabled-map (runtime assertion already in Phase B; promote to LTL for the report).
  - Option C: "Every tick, at most one vehicle crosses any intersection" — crossing-count bound.
  - **Recommended: Option A** — it is the only one that exercises the congestion-aware policy the infrastructure actually implements.

### 3c. i-group / v-group consistency (spec overview §81-83)

- [ ] Maintain `infra_collision_count`, `vehicle_collision_count`, and the same for red-light and opposite-direction. Assert equality each tick (already scaffolded in execution plan §9). Phase C report must state that both views agree.

---

## Priority 4: Reporting and Deliverables

- [ ] **Generate property verification table.**
  - Columns: property name, LTL formula, pass/fail, states explored, depth, memory, wall time.
  - Run every LTL with `./pan -m2000000 -a -N <claim>` and capture the trailing summary. Automate with a shell script (`verification/spin/run_phase_c.sh`) so the table is regenerable.

- [ ] **Capture screenshots of SPIN runs** (Phase C-2 spec explicitly requires this).
  - Terminal screenshot per property showing the `errors: 0` line plus state/depth/memory stats.
  - Store under `verification/spin/phase_c_screenshots/`.

- [ ] **If any property fails, capture the counterexample.**
  - `spin -t -p phase_c_model.pml` trace, saved to `phase_c_model.pml.trail` + a narrative explanation of the failure in the report.

- [ ] **Throughput + violation counts from C++ simulation.**
  - Spec requires reporting (per simulated time period): tours/hour, collisions, illegal-direction count, U-turn count, red-light violations.
  - Source: existing C++ simulation outputs (`outputs/`). Re-run the simulation to capture fresh numbers against the current code.
  - If Phase A throughput has been improved by later Phase B C++ congestion work (which it has — see `src/infrastructure/InfrastructureAgent.cpp` square-node congestion additions), document the delta in the report.

- [ ] **Write `verification/spin/phase_c_igroup_report.md`.**
  - Sections: (1) model description, (2) properties I-1..I-5 with LTL formulas, (3) verification results table, (4) screenshots, (5) any counterexamples, (6) throughput + violation counts, (7) changes vs Phase A.

- [ ] **Write `verification/spin/phase_c_vgroup_report.md`.**
  - Same sections, V-1..V-4 properties.

- [ ] **Final consistency pass.**
  - Both reports reference the same `phase_c_model.pml` and same state-count numbers for shared properties (no_collision, etc.).
  - File names per spec: `<TeamID>_igroup.zip` / `<TeamID>_vgroup.zip`.

---

## Priority 5: State-Space Risk Management

The 3x3 + square model with `NVEH=3` is the #1 risk factor (execution plan §5). Mitigations to apply from the start:

- [ ] Keep `SLOTN=3` for interior roads, `SLOTN_SQ=1` for square links.
- [ ] `d_step { ... }` around light-cycling and property-check sequences to collapse interleavings that don't affect correctness.
- [ ] Always `byte`, never `int` / `short`.
- [ ] If exhaustive search blows memory: fall back to bitstate hashing (`cc -O2 -DBITSTATE -o pan pan.c`) and report it in the "bounded verification" section of each report, as the spec allows.
- [ ] Run safety-only (`-DSAFETY`) first for quick feedback before each LTL claim run.

---

## Validation Runbook (after each priority block)

1. **C++ regression:** `cd build && cmake --build . -j4 && ctest --output-on-failure` — confirm no C++ breakage from any shared-config changes.
2. **SPIN compile:** `cd verification/spin && spin -a phase_c_model.pml && cc -O2 -o pan pan.c`
3. **Safety pass:** `./pan -m2000000 -a` (all runtime assertions, no LTL claim)
4. **Per-claim runs:**
   - i-group: `./pan -m2000000 -a -N no_uturn`, `no_red_violation`, `visit_all_squares`, `no_collision`, `<I-5 claim>`
   - v-group: `./pan -m2000000 -a -N eventual_green`, `fair_green`, `mutual_exclusion_lights`, `<V-4 claim>`
5. **Simulate for trace sanity:** `spin -p -g -l phase_c_model.pml` — one tour visible in the transcript.

---

## Suggested Sequence (working order)

1. P0 (Phase B P2 carry-over) — 1 session
2. P1 (topology to 3x3 + squares) — 1-2 sessions
3. P2 (routing + tours) — 1-2 sessions
4. P3a + P3b (property verification, both reports' worth of LTL) — 1 session
5. P4 (two reports + screenshots + throughput) — 1 session
6. P5 (state-space mitigations applied continuously, not a separate step)

Budget: ~6-7 focused sessions from today (2026-04-19) to the deadline (2026-04-28) leaves slack for debugging counterexamples, which is the most likely schedule risk.
