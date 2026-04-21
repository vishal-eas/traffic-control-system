# SPIN Verification Layout

This directory reorganizes the Phase C SPIN work by group responsibility from `Spec/723Spring26ProjectPhaseC-1.pdf`.

- `v-group/`: contains the properties the v-group must verify about the infrastructure/signal behavior
- `i-group/`: contains the properties the i-group must verify about the vehicle behavior

Each subdirectory is self-contained:

- `phase_c_model.pml`: SPIN model copied from `verification/spin/phase_c_model.pml`
- `README.md`: required properties mapped to LTL claims in the model
- `run_*.sh`: compiles `pan` and runs just that group's claims

The current Phase C model already includes these LTL claims:

- Vehicle-side claims: `no_uturn`, `no_red_violation`, `visit_all_bcd`, `no_collision`, `tour_closure`
- Infrastructure-side claims: `eventual_green_bounded`, `fair_green_bounded`, `mutual_exclusion_lights`, `valid_light_topology`
