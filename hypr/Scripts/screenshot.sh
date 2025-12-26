#!/usr/bin/env bash
# ~/.config/hypr/scripts/screenshot.sh

# tecla F10 → screenshot (salva direto)
if [[ $1 == screenshot ]]; then
  grim -g "$(slurp)" ~/Pictures/Screenshots/$(date +%Y-%m-%d-%H-%M-%S).png
# tecla Print → screenshot + swappy (para salvar manualmente)
elif [[ $1 == annotate ]]; then
  # CORRIGIDO: Removida a flag "-o" para permitir o salvamento manual dentro do swappy
  grim -g "$(slurp)" - | swappy -f -
# tecla F8 → gravação de vídeo
elif [[ $1 == record ]]; then
  pkill wf-recorder || wf-recorder -g "$(slurp)" -f ~/Videos/Screenshots/$(date +%Y-%m-%d-%H-%M-%S).mp4
fi
