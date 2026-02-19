#!/usr/bin/env bash
set -e

COLORS_DIR="$HOME/.config/colors"

# Getting themes
mapfile -t THEMES < <(printf '%s\n' "$COLORS_DIR"/themes/*.sh | xargs -n1 basename | sed 's/\.sh$//' | sort)

if ((${#THEMES[@]} == 0)); then
    notify-send "Theme switcher" "Theme not found at $COLORS_DIR/themes"
    exit 1
fi

CURRENT="$(basename "$(readlink "$COLORS_DIR/current" 2>/dev/null)" .sh 2>/dev/null || true)"

CHOICE=$(printf '%s\n' "${THEMES[@]}" | wofi --dmenu --prompt "Theme" --insensitive)

if [[ -z "$CHOICE" ]]; then
    exit 0
fi

if [[ "$CHOICE" == "$CURRENT" ]]; then
    exit 0
fi

"$COLORS_DIR/apply.sh" "$CHOICE"
