#!/usr/bin/env bash

BASE_DIR="$(cd "$(dirname "$0")" && pwd)"
MENU_DIR="$BASE_DIR/menu"

if [[ -z "$1" ]]; then
    for f in "$MENU_DIR"/*.sh; do
        basename "$f" .sh
    done
    exit 0
fi

selected="$1"
script="$MENU_DIR/$selected.sh"

if [[ -x "$script" ]]; then
    # Launch submenu slightly after this rofi exits
    "$script" >/dev/null 2>&1 &
else
    notify-send "Rofi" "Script not found or not executable: $script"
fi
