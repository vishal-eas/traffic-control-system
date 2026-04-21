#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

MODEL="phase_c_model.pml"
PAN="./pan"

CLAIMS=(
  no_uturn
  no_red_violation
  visit_all_bcd
  no_collision
  tour_closure
)

spin -a "$MODEL"
cc -O2 -o pan pan.c

printf "claim,errors,states,depth\n"

run_claim() {
  local claim="$1"
  local output
  output="$($PAN -m2000000 -a -N "$claim" 2>&1)"
  local errors states depth
  errors="$(printf '%s\n' "$output" | sed -n 's/.*errors: \([0-9][0-9]*\).*/\1/p' | tail -1)"
  states="$(printf '%s\n' "$output" | sed -n 's/ *\([0-9][0-9]*\) states, stored.*/\1/p' | tail -1)"
  depth="$(printf '%s\n' "$output" | sed -n 's/State-vector .* depth reached \([0-9][0-9]*\), errors:.*/\1/p' | tail -1)"
  printf "%s,%s,%s,%s\n" "$claim" "${errors:-?}" "${states:-?}" "${depth:-?}"
}

for claim in "${CLAIMS[@]}"; do
  run_claim "$claim"
done
