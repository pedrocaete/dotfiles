#!/bin/bash

BATTERY_LEVEL=$(upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep "percentage" | awk '{print $2}' | sed 's/\%//')
BATTERY_STATUS=$(upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep "state" | awk '{print $2}')

if [ $BATTERY_STATUS = "charging" ]; then
  CHARGING_SYMBOL=""
else
  CHARGING_SYMBOL=""
fi


if [ $BATTERY_LEVEL -le 20 ]; then
  SYMBOL=""
elif [ $BATTERY_LEVEL -le 40 ]; then
  SYMBOL=""
elif [ $BATTERY_LEVEL -le 60 ]; then
  SYMBOL=""
elif [ $BATTERY_LEVEL -le 80 ]; then
  SYMBOL=""
else
  SYMBOL=""
fi

echo "$CHARGING_SYMBOL $SYMBOL $BATTERY_LEVEL%"
