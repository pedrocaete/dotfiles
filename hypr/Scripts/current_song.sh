#!/bin/sh

class=$(playerctl metadata --player=spotify --format '{{lc(status)}}')
icon=""

if [[ $class == "playing" ]]; then
  info=$(playerctl metadata --player=spotify --format '{{artist}} - {{title}}')
  if [[ ${#info} > 40 ]]; then
    info=$(echo $info | cut -c1-40)"..."
  fi
  echo $info" "$icon
elif [[ $class == "paused" ]]; then
  echo $icon
elif [[ $class == "stopped" ]]; then
  echo ""
fi
