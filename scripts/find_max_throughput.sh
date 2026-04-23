#!/usr/bin/env bash
# Find maximum throughput by sweeping vehicle count and route modes.
# Usage: bash scripts/find_max_throughput.sh [build_dir]
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BUILD_DIR="${1:-$SCRIPT_DIR/../build}"
BIN="$BUILD_DIR/throughput_bench"

if [[ ! -x "$BIN" ]]; then
    echo "Building throughput_bench..."
    cmake --build "$BUILD_DIR" --target throughput_bench -j4
fi

# Simulation parameters
TOTAL_STEPS=7200    # 4 simulated hours
WARMUP_STEPS=1800   # discard first 1 hour (transient)
ROUTE_MODES=(mixed balanced perimeter)
VEHICLE_COUNTS=(1 2 3 5 8 10 15 20 30 50 75 100)

echo "================================================================"
echo "  Max Throughput Sweep"
echo "  total_steps=$TOTAL_STEPS  warmup_steps=$WARMUP_STEPS"
echo "  (measurement window = $((TOTAL_STEPS - WARMUP_STEPS)) steps = $((( TOTAL_STEPS - WARMUP_STEPS ) * 2 / 3600)) simulated hours)"
echo "================================================================"
printf "%-10s %-12s %-18s %-10s\n" "vehicles" "route_mode" "throughput(t/hr)" "tours"
echo "----------------------------------------------------------------"

best_throughput=0
best_config=""

for mode in "${ROUTE_MODES[@]}"; do
    prev_tp=0
    for n in "${VEHICLE_COUNTS[@]}"; do
        output=$("$BIN" "$n" "$TOTAL_STEPS" "$WARMUP_STEPS" "$mode" 2>&1)
        tp=$(echo "$output" | grep throughput_window | sed 's/.*throughput_window=\([0-9.]*\).*/\1/')
        tours=$(echo "$output" | grep throughput_window | sed 's/.*completed_tours_window=\([0-9]*\).*/\1/')

        printf "%-10s %-12s %-18s %-10s\n" "$n" "$mode" "$tp" "$tours"

        # Track global best
        if awk "BEGIN {exit !($tp > $best_throughput)}"; then
            best_throughput=$tp
            best_config="vehicles=$n route_mode=$mode"
        fi

        # Early stop: if throughput hasn't grown by >1% for this mode, road is saturated
        if awk "BEGIN {exit !($tp > 0 && $prev_tp > 0 && ($tp - $prev_tp) / $prev_tp < 0.01)}"; then
            echo "  --> saturated at vehicles=$n for mode=$mode"
            break
        fi
        prev_tp=$tp
    done
    echo ""
done

echo "================================================================"
echo "  BEST: throughput=${best_throughput} tours/hour  ($best_config)"
echo "================================================================"

# Confirm best config with a longer run (8 simulated hours)
echo ""
echo "Confirming best config with longer run (14400 steps = 8 simulated hours)..."
best_n=$(echo "$best_config" | sed 's/vehicles=\([0-9]*\).*/\1/')
best_mode=$(echo "$best_config" | sed 's/.*route_mode=\([a-z]*\)/\1/')
confirm=$("$BIN" "$best_n" 14400 1800 "$best_mode" 2>&1)
echo "$confirm"
