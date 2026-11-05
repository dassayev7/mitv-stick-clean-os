#!/usr/bin/env bash
# ==============================================================================
# 03_optimize_speed.sh - Ajuste de Escalas de Animação para 0x (Resposta Instantânea)
# ==============================================================================
set -euo pipefail

TV_IP="${1:-}"

if [[ -z "$TV_IP" ]]; then
    echo "Uso: $0 <IP_DA_TV:PORTA>"
    echo "Exemplo: $0 192.168.100.32:5555"
    exit 1
fi

ADB="adb"
if ! command -v adb &>/dev/null; then
    if [[ -f "$HOME/android-tools/platform-tools/adb" ]]; then
        ADB="$HOME/android-tools/platform-tools/adb"
    fi
fi

echo "Configurando escalas de animação no sistema..."
"$ADB" -s "$TV_IP" shell settings put global window_animation_scale 0
"$ADB" -s "$TV_IP" shell settings put global transition_animation_scale 0
"$ADB" -s "$TV_IP" shell settings put global animator_duration_scale 0

echo "Escalas atuais:"
echo "Window: $($ADB -s "$TV_IP" shell settings get global window_animation_scale)"
echo "Transition: $($ADB -s "$TV_IP" shell settings get global transition_animation_scale)"
echo "Animator: $($ADB -s "$TV_IP" shell settings get global animator_duration_scale)"
echo "Concluído!"

