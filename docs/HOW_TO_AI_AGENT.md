# 🤖 Guia de Instalação Automática via Agente de IA (Antigravity, Claude, Cursor)

Este documento contém o **Prompt Mestre de Automação**. Ele foi projetado para que qualquer assistente de código inteligente baseado em agentes (como **Google Antigravity**, **Claude Code**, **Cursor**, **Aider** ou **ChatGPT Advanced Data Analysis**) execute de ponta a ponta a otimização, debloat seguro e instalação da launcher na sua Xiaomi Mi TV Stick sem necessidade de intervenção manual complexa.

---

## 📋 Como Utilizar

1. **Ligue a sua Xiaomi Mi TV Stick** na mesma rede Wi-Fi do seu computador.
2. Certifique-se de que a **Depuração USB / Depuração de Rede** está ativada nas *Opções de Desenvolvedor* da TV.
3. Descubra o IP da sua TV (ex: `192.168.100.32`).
4. **Copie o prompt abaixo**, substitua `<IP_DA_SUA_TV>` pelo IP real e envie para o seu agente de IA.

---

## 📋 Prompt para Copiar e Colar no Agente de IA

```markdown
Você é um especialista em sistemas Android embarcados e automação via ADB.
Sua missão é realizar a otimização extrema, debloat seguro e instalação do sistema customizado no meu Xiaomi Mi TV Stick (Android TV 9 - 1 GB RAM), utilizando como base o repositório público: https://github.com/dassayev7/mitv-stick-clean-os.git

IP do meu dispositivo na rede local: <IP_DA_SUA_TV>:5555

Por favor, siga rigorosamente o fluxo de trabalho abaixo:

### Passo 1: Preparação do Ambiente e Clonagem
1. Verifique se o binário do 'adb' está disponível no ambiente. Se não estiver no PATH, localize ou instrua como utilizar o Android platform-tools.
2. Clone o repositório 'https://github.com/dassayev7/mitv-stick-clean-os.git' em uma pasta temporária ou de trabalho local (caso ainda não esteja clonado).

### Passo 2: Conexão e Diagnóstico
1. Conecte ao dispositivo via ADB:
   adb connect <IP_DA_SUA_TV>:5555
2. Verifique o estado da conexão ('adb devices'). Se o dispositivo solicitar autorização de chave RSA na TV, alerte-me para marcar 'Sempre permitir deste computador'.
3. Execute o script de inventário:
   bash scripts/01_inventory.sh <IP_DA_SUA_TV>:5555
4. Registre o consumo de memória RAM inicial (MemAvailable e Swap em uso) para comparativo.

### Passo 3: Debloat Seguro e Otimização de Desempenho
1. Execute o script de debloat seguro:
   bash scripts/02_debloat_safe.sh <IP_DA_SUA_TV>:5555
   - REGRAS CRÍTICAS DE SEGURANÇA:
     * NUNCA remova pacotes de DRM (Widevine), Bluetooth do controle remoto ou Google Play Store.
     * Mantenha 'com.google.android.partnersetup' ativo (essencial para o funcionamento do Disney+).
2. Configure as escalas de animação do sistema para 0x (resposta instantânea):
   bash scripts/03_optimize_speed.sh <IP_DA_SUA_TV>:5555

### Passo 4: Instalação e Ativação do Launcher Personalizado
1. Instale o APK do launcher customizado contido no repositório:
   bash scripts/04_install_launcher.sh <IP_DA_SUA_TV>:5555
2. Certifique-se de que o 'com.gathin.tvhome' foi iniciado com sucesso como a Home padrão.

### Passo 5: Validação Final e Relatório
1. Verifique se a MainActivity do CleanYourTV está em foco na tela:
   adb -s <IP_DA_SUA_TV>:5555 shell dumpsys window | grep -E "mCurrentFocus|mFocusedApp"
2. Meça a memória RAM final disponível ('cat /proc/meminfo').
3. Apresente um resumo claro com o ganho de RAM obtido (antes vs. depois) e confirme que os streamings principais continuam preservados.
```

---

## 🛡️ O que o Agente de IA irá garantir:
- **Zero Risco de Brick:** Não altera arquivos da partição `/system`. Todas as remoções são feitas no escopo do usuário 0 (`pm uninstall --user 0`), permitindo reversão total com o script `99_restore_stock.sh`.
- **Compatibilidade com Disney+, Netflix e Prime Video:** Preserva os serviços de autenticação necessários para os streamings funcionarem em 1080p sem telas pretas.
- **Tipografia Apple San Francisco e Sons Táteis:** O launcher embutido no repositório já vem compilado com a fonte SF Pro e feedback de áudio nativo de baixa latência (`SoundPool`).
