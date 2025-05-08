#!/bin/bash

# Caminho completo pro log
LOG_FILE="/tmp/battery-notify.log"
STATE_FILE="/tmp/battery_notification_sent"

# Testa se o log está funcionando
echo "$(date): Script iniciado" >> "$LOG_FILE"

while true; do
    battery_level=$(cat /sys/class/power_supply/BAT*/capacity)
    battery_status=$(cat /sys/class/power_supply/BAT*/status)

    echo "$(date): Bateria: ${battery_level}%, Status: ${battery_status}" >> "$LOG_FILE"

    if [[ "$battery_level" -le 15 && "$battery_status" == "Discharging" ]]; then
        if [ ! -f "$STATE_FILE" ]; then
            notify-send "⚠️ Bateria baixa" "Nível de bateria em ${battery_level}%" -u critical
            echo "$(date): Notificação enviada" >> "$LOG_FILE"
            touch "$STATE_FILE"
        fi
    else
        [ -f "$STATE_FILE" ] && rm "$STATE_FILE"
    fi

    sleep 60
done
