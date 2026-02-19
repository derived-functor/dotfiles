#!/bin/bash

PYTHON_EVAL='
import math, cmath, operator, sys

SAFE_NS = {k: v for k, v in vars(math).items() if not k.startswith("_")}
SAFE_NS.update({"abs": abs, "round": round, "sum": sum,
                "min": min, "max": max, "pow": pow})

expr = sys.stdin.read().strip()
try:
    result = eval(expr, {"__builtins__": {}}, SAFE_NS)
    if isinstance(result, float) and result == int(result):
        print(int(result))
    elif isinstance(result, float):
        print(f"{result:.10g}")
    else:
        print(result)
except ZeroDivisionError:
    print("Zero division!")
except Exception as e:
    print(f"Error: {e}")
'

# ─── History ──────────────────────────────────────────────────────────────

HISTORY_FILE="${XDG_CACHE_HOME:-$HOME/.cache}/wofi_calc_history"
touch "$HISTORY_FILE"

# ─── Main Loop ────────────────────────────────────────────────────────────
calc_loop() {
    local prompt="  = "
    local extra_entries=""

    while true; do
        local menu
        menu=$(printf '%s\n' \
            "── History ─────────────────────" \
            ; tac "$HISTORY_FILE" | head -20
        )

        local input
        input=$(echo "$menu" | wofi \
            --show dmenu \
            --prompt "$prompt" \
            --style ~/.config/wofi/style.css
        )

        [[ -z "$input" ]]   && break
        [[ "$input" == ──* ]] && continue

        local result
        result=$(echo "$input" | python3 -c "$PYTHON_EVAL")

        grep -qxF "$input" "$HISTORY_FILE" || echo "$input" >> "$HISTORY_FILE"

        prompt="$input = $result  |  "
    done
}

calc_loop
