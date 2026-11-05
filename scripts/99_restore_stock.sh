#!/usr/bin/env bash
# ==============================================================================
# 99_restore_stock.sh - Reversão Completa para o Estado Original de Fábrica
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

echo "Conectando ao dispositivo $TV_IP..."
"$ADB" connect "$TV_IP"

echo "=== Restaurando Launcher Oficial do Google TV ==="
"$ADB" -s "$TV_IP" shell cmd package install-existing --user 0 com.google.android.tvlauncher || true

echo "=== Restaurando Pacotes de Fábrica Desinstalados ==="
RESTORE_LIST=(
    "com.mitv.tvhome.atv"
    "com.google.android.videos"
    "com.google.android.play.games"
    "com.google.android.feedback"
    "com.google.android.backuptransport"
)

for pkg in "${RESTORE_LIST[@]}"; do
    echo "Restaurando $pkg..."
    "$ADB" -s "$TV_IP" shell cmd package install-existing --user 0 "$pkg" 2>/dev/null || true
done

echo "=== Reativando Serviços Desativados ==="
ENABLE_LIST=(
    "com.google.android.partnersetup"
    "com.google.android.syncadapters.contacts"
    "com.google.android.syncadapters.calendar"
    "com.google.android.marvin.talkback"
)

for pkg in "${ENABLE_LIST[@]}"; do
    echo "Reativando $pkg..."
    "$ADB" -s "$TV_IP" shell pm enable --user 0 "$pkg" 2>/dev/null || true
done

echo "=== Restaurando Escalas de Animação para 1.0 ==="
"$ADB" -s "$TV_IP" shell settings put global window_animation_scale 1
"$ADB" -s "$TV_IP" shell settings put global transition_animation_scale 1
"$ADB" -s "$TV_IP" shell settings put global animator_duration_scale 1

echo "=== Reiniciando para a Home Oficial ==="
"$ADB" -s "$TV_IP" shell am start -W -a android.intent.action.MAIN -c android.intent.category.HOME

echo "Restauração concluída!"
