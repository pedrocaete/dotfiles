#!/bin/sh

outputs="$(hyprctl monitors all | awk '/^Monitor / { print $2 }')"
internals="$(printf '%s\n' "$outputs" | grep -E '^(eDP|LVDS|DSI)-' || true)"
externals="$(printf '%s\n' "$outputs" | grep -Ev '^(eDP|LVDS|DSI)-' || true)"

if [ -z "$externals" ]; then
    printf '%s\n' "$internals" | while IFS= read -r output; do
        [ -n "$output" ] && hyprctl keyword monitor "$output,preferred,auto,1"
    done
    notify-send "Modo monitor externo" "Nenhum monitor externo conectado" -u low -r 998
    exit 0
fi

printf '%s\n' "$externals" | while IFS= read -r output; do
    [ -n "$output" ] && hyprctl keyword monitor "$output,preferred,auto,1"
done

sleep 1

printf '%s\n' "$internals" | while IFS= read -r output; do
    [ -n "$output" ] && hyprctl keyword monitor "$output,disable"
done

notify-send "Modo monitor externo" "Tela do notebook desligada" -u low -r 998
