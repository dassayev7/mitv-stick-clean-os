#!/usr/bin/env bash
# ==============================================================================
# 02_debloat_safe.sh - Debloat Seguro e Otimização Extrema de RAM
# ==============================================================================
# Remove com segurança bloatware OEM, telemetria, jogos pesados de fábrica
# e desativa serviços em segundo plano desnecessários, mantendo 100% funcionais:
# DRM Widevine L1, Google Play Store, Disney+, Netflix, Prime Video e Controle BT.
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

echo "=== 1. Desinstalando Bloatware e Jogos Pesados (user 0) ==="
UNINSTALL_LIST=(
    "com.gameloft.android.HEP.GloftA8HM"       # Asphalt 8 (pesado)
    "com.gameloft.android.GloftA8HM"           # Asphalt 8
    "pl.idreams.SkyForceReloaded.googleplay"   # Sky Force
    "com.inlogic.golazo.atv"                   # Golazo
    "com.inlogic.footballleague.atv"           # Football League
    "com.mitv.tvhome.atv"                      # PatchWall Launcher (Xiaomi)
    "com.xiaomi.mitv.mediaexplorer"            # Mi Media Explorer
    "com.mitv.videoplayer"                     # Mi Video Player
    "com.xiaomi.mitv.tvchannel"                # Mi TV Channel
    "com.xiaomi.mitv.smartshare"               # Mi Smart Share
    "com.alphonso.alphonso_service"            # Alphonso Telemetria OEM
    "com.xiaomi.devicereport"                  # Xiaomi Device Report / Telemetria
    "com.xiaomi.statistic"                     # Xiaomi Analytics
    "com.google.android.feedback"              # Google Feedback
    "com.google.android.backuptransport"       # Backup em nuvem Google (consome RAM)
    "com.google.android.play.games"            # Google Play Games
    "com.google.android.videos"                # Google Play Filmes / TV
    "com.google.android.music"                 # Google Play Music obsoleto
    "com.android.printspooler"                 # Serviço de Impressão
    "com.android.documentsui"                  # Seletor de Arquivos OEM
)

for pkg in "${UNINSTALL_LIST[@]}"; do
    echo -n "Desinstalando $pkg: "
    "$ADB" -s "$TV_IP" shell pm uninstall --user 0 "$pkg" 2>/dev/null || echo "Já ausente ou ignorado"
done

echo ""
echo "=== 2. Desativando Serviços de Background Não Essenciais ==="
DISABLE_LIST=(
    "com.google.android.syncadapters.contacts" # Sincronização de contatos na TV
    "com.google.android.syncadapters.calendar" # Sincronização de calendário na TV
    "com.android.providers.contacts"           # Provedor de contatos
    "com.android.providers.calendar"           # Provedor de calendário
    "com.android.bookmarkprovider"             # Favoritos
    "com.android.emergency"                    # Alertas de emergência móvel
    "com.google.android.marvin.talkback"       # TalkBack acessibilidade (reativável se necessário)
    "com.android.dreams.phototable"            # Screensaver nativo do Android antigo
)

for pkg in "${DISABLE_LIST[@]}"; do
    echo -n "Desativando $pkg: "
    "$ADB" -s "$TV_IP" shell am force-stop "$pkg" 2>/dev/null || true
    "$ADB" -s "$TV_IP" shell pm disable-user --user 0 "$pkg" 2>/dev/null || echo "Ignorado"
done

echo ""
echo "=== 3. Desinstalando Launcher Original do Google TV para o Usuário 0 ==="
echo "Isso garante que a TV nunca volte ao launcher pesado da Xiaomi no boot."
"$ADB" -s "$TV_IP" shell pm uninstall --user 0 com.google.android.tvlauncher || true

echo ""
echo "=== Debloat concluído com sucesso! ==="
"$ADB" -s "$TV_IP" shell cat /proc/meminfo | grep -E "MemFree|MemAvailable|SwapFree"
