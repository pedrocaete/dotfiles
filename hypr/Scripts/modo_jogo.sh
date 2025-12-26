#!/bin/sh

# Verifica se o HDMI está conectado
if hyprctl monitors all| grep -q "HDMI-A-1"; then
    # Desliga a tela do notebook e ativa HDMI
    hyprctl keyword monitor "eDP-1,disable"
    hyprctl keyword monitor "HDMI-A-1,preferred,auto,1"
else
    # Mantém a tela interna ligada para evitar tela preta
    hyprctl keyword monitor "eDP-1,preferred,auto,1"
fi
