# Priority 5 Abstraction Rationale: MAX_RED_WAIT Mismatch

## Decision

Keep different starvation thresholds for now:

1. C++ infrastructure model uses `MAX_RED_WAIT = 6` in `include/infrastructure/InfrastructureAgent.h`.
2. SPIN 2x2 Phase B model uses `MAX_RED_WAIT = 4` in `verification/spin/phase_b_model.pml`.

This mismatch is accepted as an intentional abstraction for Phase B.

## Why this is acceptable in Phase B

1. Phase B objective is tool demonstration with a bounded model and core safety/liveness checks, not exact timing fidelity.
2. The SPIN model uses reduced topology and reduced slot count (`SLOTN=3`), so shorter red-wait threshold keeps starvation behavior observable in a smaller state space.
3. The key property class is preserved: starvation prevention remains active and bounded, and one direction cannot stay red forever.

## What semantics are preserved

1. Longest-queue-first selection still applies when no starvation condition is active.
2. Starvation prevention still forces service once red streak reaches threshold.
3. Mutual exclusion of green direction is still enforced per intersection.

## What semantics are not preserved exactly

1. Absolute service latency in ticks is not numerically identical between C++ and SPIN.
2. Throughput and fairness timing values are therefore not directly comparable between the two models.

## Risk and mitigation

1. Risk: readers may interpret SPIN timing as implementation-equivalent.
2. Mitigation: document this mismatch explicitly in reports and TODO, and align values before final phase if timing equivalence is required.

## Alignment trigger

Align SPIN and C++ thresholds when either of these becomes required:

1. Quantitative timing comparison between implementation and model.
2. Final verification report requiring parameter-level equivalence.

## Recommended next step

For Phase C or pre-final verification:

1. Set SPIN `MAX_RED_WAIT` to 6.
2. Re-run full property suite and compare state-space impact.
