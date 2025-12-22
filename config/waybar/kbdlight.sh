#!/usr/bin/env bash
set -euo pipefail

dev="kbd_backlight"

cur="$(brightnessctl -d "$dev" g)"
max="$(brightnessctl -d "$dev" m)"

if [ "$max" -eq 0 ]; then
  pct=0
else
  pct=$(( cur * 100 / max ))
fi

icon="󰌵"
class="on"
if [ "$cur" -eq 0 ]; then
  class="off"
fi

printf '{"text":"%s %d%%","class":"%s","percentage":%d}\n' "$icon" "$pct" "$class" "$pct"
