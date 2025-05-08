#!/usr/bin/env bash
# ~/.config/hypr/scripts/screenshot.sh

# tecla F10 → screenshot
if [[ $1 == screenshot ]]; then
  grim -g "$(slurp)" -output ~/Pictures/Screenshots/$(date +%Y-%m-%d-%H-%M-%S).png
# tecla Print → screenshot + swappy
elif [[ $1 == annotate ]]; then
  grim -g "$(slurp)" - | swappy -f - -o ~/Pictures/Screenshots/$(date +%Y-%m-%d-%H-%M-%S).png
# tecla F8 → gravação de vídeo
elif [[ $1 == record ]]; then
  pkill wf-recorder || wf-recorder -g "$(slurp)" -f ~/Videos/Screenshots/$(date +%Y-%m-%d-%H-%M-%S).mp4
fi
