#!/bin/bash

SPECIAL_SINK="bluez_output.AE_2A_D9_60_69_59.1"
RATIO="0.50"
STEP=5
LIMIT="1.4"

case "$1" in
    up)
        DIRECTION="+"
        ;;
    down)
        DIRECTION="-"
        ;;
    *)
        exit 1
        ;;
esac

DEFAULT_SINK=$(pactl get-default-sink 2>/dev/null)

if [[ "$DEFAULT_SINK" != "$SPECIAL_SINK" ]]; then
    wpctl set-volume -l "$LIMIT" @DEFAULT_AUDIO_SINK@ "${STEP}%${DIRECTION}"
    exit $?
fi

LEFT=$(
    pactl get-sink-volume "$SPECIAL_SINK" |
        awk '/front-left:/ {
            for (i = 1; i <= NF; i++) {
                if ($i ~ /^[0-9]+%$/) {
                    gsub("%", "", $i)
                    print $i
                    exit
                }
            }
        }'
)

[[ -z "$LEFT" ]] && exit 1

case "$1" in
    up)
        LEFT=$((LEFT + STEP))
        ;;
    down)
        LEFT=$((LEFT - STEP))
        ;;
esac

((LEFT > 100)) && LEFT=100
((LEFT < 0)) && LEFT=0

RIGHT=$(awk -v left="$LEFT" -v ratio="$RATIO" \
    'BEGIN { printf "%.0f", left * ratio }')

pactl set-sink-volume "$SPECIAL_SINK" "$LEFT%" "$RIGHT%"
