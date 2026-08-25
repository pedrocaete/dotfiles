#!/usr/bin/env bash
# ~/.config/hypr/scripts/screenshot.sh

case "$1" in
    screenshot)
        grim -g "$(slurp)" ~/Pictures/Screenshots/$(date +%Y-%m-%d-%H-%M-%S).png
        ;;
    annotate)
        grim -g "$(slurp)" - | swappy -f -
        ;;
    record)
        notify-send "Gravacao..." -u low -r 999
        pkill wf-recorder || wf-recorder -g "$(slurp)" -f ~/Videos/Screenshots/$(date +%Y-%m-%d-%H-%M-%S).mp4
        ;;
esac
