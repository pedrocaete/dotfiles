#!/bin/bash

while true
do
  sleep 5400 # 90 minutos em segundos
  notify-send "Descanso" "Pare por 15 minutos" -u critical -t 150000
done
