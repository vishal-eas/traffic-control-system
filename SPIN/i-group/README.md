# i-group SPIN Checks

Per the Phase C spec, this folder contains the properties the i-group verifies about the vehicle logic.

Required spec properties and claim mapping:

- No vehicle takes any U-turn: `no_uturn`
- No vehicle enters an intersection at red light: `no_red_violation`
- Every vehicle must visit all of points `B`, `C`, and `D`: `visit_all_bcd`
- There is no collision between any two vehicles: `no_collision`
- Another property at your own choice: `tour_closure`

Run:

```bash
./run_i_group.sh
```

This prints a CSV-style summary:

- `claim`
- `errors`
- `states`
- `depth`
