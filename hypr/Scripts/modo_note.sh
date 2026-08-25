#!/bin/sh

outputs="$(hyprctl monitors all | awk '/^Monitor / { print $2 }')"
internals="$(printf '%s\n' "$outputs" | grep -E '^(eDP|LVDS|DSI)-' || true)"
externals="$(printf '%s\n' "$outputs" | grep -Ev '^(eDP|LVDS|DSI)-' || true)"

printf '%s\n' "$internals" | while IFS= read -r output; do
    [ -n "$output" ] && hyprctl keyword monitor "$output,preferred,auto,1"
done

sleep 1

printf '%s\n' "$externals" | while IFS= read -r output; do
    [ -n "$output" ] && hyprctl keyword monitor "$output,disable"
done

notify-send "Modo notebook" "Monitores externos desligados" -u low -r 998
