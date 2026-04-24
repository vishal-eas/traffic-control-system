#!/bin/bash
# ================================================================
# run_phase_c.sh — Phase C SPIN verification runner
#
# Usage:
#   ./run_phase_c.sh           # run all claims
#   ./run_phase_c.sh safety    # safety-only pass (no LTL)
#   ./run_phase_c.sh <claim>   # run one specific claim
#
# Model: phase_c_model.pml
# Parameters: SLOTN=30, MAX_TICKS=120, all 6 tour orderings
# Verification: bitstate hashing (-DBITSTATE), depth 2000000
# ================================================================

set -e

MODEL="phase_c_model.pml"
PAN_BS="./pan_bs"
DEPTH=2000000
RESULTS_FILE="phase_c_results.txt"
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

CLAIMS=(
    no_collision
    no_red_violation
    no_opposite_direction
    no_uturn
    visit_all_bcd
    tour_closure
    mutual_exclusion_lights
    eventual_green
    fair_green
    conditional_liveness
)

# ----------------------------------------------------------------
# Helpers
# ----------------------------------------------------------------

log() { echo "$1" | tee -a "$RESULTS_FILE"; }

check_deps() {
    if ! command -v spin &>/dev/null; then
        echo "ERROR: spin not found. Install SPIN first." >&2
        exit 1
    fi
    if ! command -v cc &>/dev/null; then
        echo "ERROR: cc not found." >&2
        exit 1
    fi
}

build() {
    echo "==> Generating verifier from $MODEL ..."
    spin -a "$MODEL" 2>&1 | grep -v "^ltl" | grep -v "^$"

    echo "==> Compiling bitstate verifier ..."
    cc -O2 -DBITSTATE -o pan_bs pan.c

    echo "==> Compiling safety-only verifier ..."
    cc -O2 -DSAFETY -o pan_safety pan.c

    echo ""
}

run_claim() {
    local claim="$1"
    local start end elapsed result errors depth states
    start=$(date +%s)
    result=$($PAN_BS -m$DEPTH -a -N "$claim" 2>&1)
    end=$(date +%s)
    elapsed=$((end - start))

    errors=$(echo "$result" | grep -oE 'errors: [0-9]+' | head -1)
    depth=$(echo "$result"  | grep -oE 'depth reached [0-9]+' | grep -oE '[0-9]+$' | head -1)
    states=$(echo "$result" | grep -oE 'States=\s+[0-9.e+]+' | tail -1 | grep -oE '[0-9.e+]+$')
    memory=$(echo "$result" | grep -oE 'Memory=\s+[0-9.]+' | tail -1 | grep -oE '[0-9.]+$')

    local status="PASS"
    [[ "$errors" != "errors: 0" ]] && status="FAIL"

    printf "%-30s  %-6s  %-12s  depth=%-8s  states=%-10s  mem=%-8s  time=%ds\n" \
        "$claim" "$status" "$errors" "${depth:--}" "${states:--}" "${memory:--}MB" "$elapsed" \
        | tee -a "$RESULTS_FILE"

    # If failed, save counterexample info
    if [[ "$status" == "FAIL" ]]; then
        echo "" | tee -a "$RESULTS_FILE"
        echo "  --- Counterexample for $claim ---" | tee -a "$RESULTS_FILE"
        echo "$result" | grep -A5 "error" | tee -a "$RESULTS_FILE"
        echo "  Run: spin -t -p $MODEL  to replay the trail" | tee -a "$RESULTS_FILE"
        echo "" | tee -a "$RESULTS_FILE"
    fi
}

run_safety() {
    echo "==> Safety-only pass (no LTL) ..."
    local start end elapsed result errors
    start=$(date +%s)
    result=$(./pan_safety -m$DEPTH 2>&1)
    end=$(date +%s)
    elapsed=$((end - start))
    errors=$(echo "$result" | grep -oE 'errors: [0-9]+' | head -1)

    local status="PASS"
    [[ "$errors" != "errors: 0" ]] && status="FAIL"

    printf "%-30s  %-6s  %-12s  time=%ds\n" "safety_assertions" "$status" "$errors" "$elapsed" \
        | tee -a "$RESULTS_FILE"
    echo ""
}

print_header() {
    log "================================================================"
    log "  Phase C SPIN Verification — $TIMESTAMP"
    log "  Model  : $MODEL"
    log "  Method : bitstate hashing (-DBITSTATE), depth $DEPTH"
    log "================================================================"
    log ""
    printf "%-30s  %-6s  %-12s  %-14s  %-16s  %-10s  %s\n" \
        "Property" "Result" "Errors" "Depth" "States" "Memory" "Time" \
        | tee -a "$RESULTS_FILE"
    log "-------------------------------  ------  ------------  --------------  ----------------  ----------  ------"
}

print_footer() {
    log ""
    log "================================================================"
    log "  Throughput note:"
    log "  SPIN simulation (MAX_TICKS steps, 2 vehicles) reports total_tours"
    log "  completed within the bounded window. Run:"
    log "    spin -l $MODEL | grep total_tours"
    log "  C++ simulation reference: 75 tours/hour (1800 steps, 2 vehicles)"
    log "================================================================"
}

# ----------------------------------------------------------------
# Main
# ----------------------------------------------------------------

check_deps
cd "$(dirname "$0")"

# Reset results file
echo "" > "$RESULTS_FILE"

build

print_header

case "${1:-all}" in
    safety)
        run_safety
        ;;
    all)
        run_safety
        for claim in "${CLAIMS[@]}"; do
            run_claim "$claim"
        done
        ;;
    *)
        # Single named claim
        valid=false
        for c in "${CLAIMS[@]}"; do
            [[ "$c" == "$1" ]] && valid=true && break
        done
        if ! $valid; then
            echo "Unknown claim '$1'. Valid claims: ${CLAIMS[*]}" >&2
            exit 1
        fi
        run_claim "$1"
        ;;
esac

print_footer

echo ""
echo "Results saved to: $(pwd)/$RESULTS_FILE"
