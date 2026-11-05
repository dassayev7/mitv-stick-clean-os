#!/usr/bin/env bash
# ==============================================================================
# 04_install_launcher.sh - Instalação e Ativação do CleanYourTV Modificado
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

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
APK_PATH="$SCRIPT_DIR/../bin/cleanyourtv-release.apk"

if [[ ! -f "$APK_PATH" ]]; then
    echo "Erro: APK não encontrado em $APK_PATH"
    exit 1
fi

echo "Conectando ao dispositivo $TV_IP..."
"$ADB" connect "$TV_IP"

echo "Instalando o launcher CleanYourTV..."
"$ADB" -s "$TV_IP" install -r "$APK_PATH"

echo "Iniciando como tela inicial principal..."
"$ADB" -s "$TV_IP" shell am force-stop com.gathin.tvhome || true
"$ADB" -s "$TV_IP" shell am start -W -n com.gathin.tvhome/.MainActivity -a android.intent.action.MAIN -c android.intent.category.HOME

echo "Launcher instalado e ativo com sucesso!"
