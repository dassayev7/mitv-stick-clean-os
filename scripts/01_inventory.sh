#!/usr/bin/env bash
# ==============================================================================
# 01_inventory.sh - Inventário de Hardware e Telemetria do Mi TV Stick
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
    else
        echo "Erro: ADB não encontrado no PATH nem em ~/android-tools/platform-tools/adb"
        exit 1
    fi
fi

echo "Conectando a $TV_IP..."
"$ADB" connect "$TV_IP"

echo "=== INFORMAÇÕES DO DISPOSITIVO ==="
MODEL=$("$ADB" -s "$TV_IP" shell getprop ro.product.model)
DEVICE=$("$ADB" -s "$TV_IP" shell getprop ro.product.device)
ANDROID_VER=$("$ADB" -s "$TV_IP" shell getprop ro.build.version.release)
SDK_VER=$("$ADB" -s "$TV_IP" shell getprop ro.build.version.sdk)
ABI=$("$ADB" -s "$TV_IP" shell getprop ro.product.cpu.abi)

echo "Dispositivo: $MODEL ($DEVICE)"
echo "Android: $ANDROID_VER (API $SDK_VER)"
echo "Arquitetura: $ABI"

echo ""
echo "=== MEMÓRIA RAM ATUAL ==="
"$ADB" -s "$TV_IP" shell cat /proc/meminfo | grep -E "MemTotal|MemFree|MemAvailable|SwapTotal|SwapFree"

echo ""
echo "=== LAUNCHER PADRÃO ATUAL ==="
"$ADB" -s "$TV_IP" shell cmd package resolve-activity --brief -a android.intent.action.MAIN -c android.intent.category.HOME
