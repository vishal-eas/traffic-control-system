# v-group SPIN Checks

Per the Phase C spec, this folder contains the properties the v-group verifies about the infrastructure/signal logic.

Required spec properties and claim mapping:

- At every intersection, every vehicle eventually gets its turn of green signal: `eventual_green_bounded`
- At every intersection, the green signal is granted unconditionally fairly among all directions: `fair_green_bounded`
- At any moment at any intersection, there is only one light green: `mutual_exclusion_lights`
- Another property at your own choice: `valid_light_topology`

Run:

```bash
./run_v_group.sh
```

This prints a CSV-style summary:

- `claim`
- `errors`
- `states`
- `depth`
