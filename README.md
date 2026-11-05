# 🚀 Mi TV Stick Clean OS & Custom Launcher

<div align="center">

![Android TV 9](https://img.shields.io/badge/Android%20TV-9.0%20(Pie)-3DDC84?style=for-the-badge&logo=android&logoColor=white)
![RAM Boost](https://img.shields.io/badge/RAM%20Livre-%2B60.3%25-blue?style=for-the-badge)
![Apple San Francisco](https://img.shields.io/badge/Typography-Apple%20SF%20Pro-white?style=for-the-badge&logo=apple&logoColor=black)
![DRM L1](https://img.shields.io/badge/DRM-Widevine%20L1%201080p-gold?style=for-the-badge)
![License](https://img.shields.io/badge/License-GPL%20v3-green?style=for-the-badge)

<p align="center">
  <b>Transformação completa e otimização cirúrgica para o Xiaomi Mi TV Stick (1 GB RAM).</b><br>
  Interface veloz estilo Apple TV, debloat seguro sem perda de DRM, efeitos sonoros com latência zero e tipografia San Francisco.
</p>

</div>

---

## ⚡ Visão Geral

O **Xiaomi Mi TV Stick (1 GB RAM)** é um dispositivo reconhecido pelo hardware modesto que frequentemente sofre com lentidão, engasgos no controle remoto e congelamento de aplicativos devido ao peso do launcher original e bloatwares de fábrica.

Este projeto consolida o processo completo de engenharia reversa, scripts de otimização automatizados e uma versão customizada de alta fidelidade do **CleanYourTV**, projetada para operar com consumo ultra-reduzido de memória.

---

## 📊 Benchmark de Desempenho (Antes vs. Depois)

Medições reais colhidas diretamente via kernel (`/proc/meminfo`) no dispositivo:

| Métrica | Padrão de Fábrica | Clean OS (Modificado) | Ganho |
| :--- | :---: | :---: | :---: |
| **Memória RAM Disponível** | 199.7 MB | **320 ~ 365 MB** | **+60,3% a +82%** 🚀 |
| **zRAM (Swap) Comprimida** | 299 MB em uso | **41 MB em uso** | **-86,3% de esforço de CPU** 🧊 |
| **Pegada do Launcher** | ~140 MB | **~28 MB** | **-80% de consumo** ⚡ |
| **Escalas de Animação** | 1.0x (lentas) | **0.0x (instantâneas)** | **Resposta imediata** ⏱️ |

---

## ✨ Principais Funcionalidades

### 1. 🔤 Tipografia Apple San Francisco (SF Pro) Global
- Toda a interface (dock, relógio, menus, pílulas de status e configurações) utiliza a fonte oficial do ecossistema macOS / iOS / tvOS.
- Pesos nativos em `.otf` compacto: **Text Regular**, **Text Medium**, **Display Light** e **Display Ultralight**.

### 2. 🔊 Efeitos Sonoros Táteis via `SoundPool` Nativo
- **Foco / Navegação:** Som suave e tátil de transição a cada clique nas setas do controle remoto.
- **Abertura de Apps:** Efeito digital moderno ao pressionar o botão **OK / Enter**.
- **Canal de Áudio Inteligente (`USAGE_MEDIA`):** Respeita ativamente o botão de mute e o volume da TV (silêncio total se o volume estiver no zero).
- **Sem ruídos do sistema:** Desativação dos bips mecânicos antigos do Android TV.

### 3. 🖼️ Widget Porta-Retratos Inteligente (Zero RAM Leak)
- Carrossel de fotos no canto superior direito que alterna a cada 30 segundos.
- Decodificação eficiente em `Bitmap.Config.RGB_565` (50% menos memória que o padrão).
- **Gerenciamento de Ciclo de Vida:** Pausa automática no `onPause()` ao entrar em qualquer filme ou jogo, garantindo 100% da RAM dedicada ao streaming.

### 4. 🕰️ Screensaver HTC Sense Flip Clock
- Relógio mecânico de abas inspirado na lendária interface HTC Sense.
- Sol dourado clássico e coluna meteorológica com baixo consumo de processamento.

### 5. 🛡️ Debloat Seguro com Reversibilidade Total
- Remove **28 pacotes pesados** (jogos da Gameloft, PatchWall, telemetria Alphonso e Xiaomi).
- Desativa **16 serviços de background** desnecessários para TV (sincronização de contatos, impressora, etc.).
- **Preservação Crítica:** Mantém 100% funcionais o DRM Widevine L1 (Netflix e Prime Video em Full HD), a Google Play Store, o Bluetooth do controle remoto e a biblioteca BAM-SDK essencial para o **Disney+**.

---

## 📁 Estrutura do Repositório

```text
├── bin/
│   └── cleanyourtv-release.apk      # APK final compilado e pronto para instalar
├── docs/
│   ├── FLUXO_E_ENGENHARIA.md        # Documentação profunda de arquitetura e decisões técnicas
│   └── PROMPT_HISTORICO.md          # Histórico de requisitos e prompts utilizados
├── launcher/                        # Código-fonte completo do app Android (CleanYourTV modificado)
│   ├── app/src/main/java/           # MainActivity com SoundPool, widget de fotos e alinhamentos
│   └── app/src/main/res/            # Fontes San Francisco (.otf), áudios (.mp3) e drawables
├── scripts/
│   ├── 01_inventory.sh              # Diagnóstico e telemetria inicial do stick
│   ├── 02_debloat_safe.sh           # Remoção de bloatwares e desativação de serviços
│   ├── 03_optimize_speed.sh         # Ajuste das escalas de animação para 0x
│   ├── 04_install_launcher.sh       # Instalação e definição como Home padrão
│   └── 99_restore_stock.sh          # Script de reversão completa para o estado original
└── README.md
```

---

## 🤖 Instalação Automática via Agente de IA (Antigravity, Claude, Cursor)

Você pode instalar e configurar todo o projeto automaticamente utilizando qualquer agente de IA com acesso a terminal (como **Google Antigravity**, **Claude Code**, **Cursor**, etc.).

Basta copiar o prompt abaixo, substituir pelo IP da sua TV e colar no seu agente:

```markdown
Você é um especialista em sistemas Android embarcados e automação via ADB.
Sua missão é realizar a otimização extrema, debloat seguro e instalação do sistema customizado no meu Xiaomi Mi TV Stick (Android TV 9 - 1 GB RAM), utilizando como base o repositório público: https://github.com/dassayev7/mitv-stick-clean-os.git

IP do meu dispositivo na rede local: <IP_DA_SUA_TV>:5555

Por favor, siga rigorosamente o fluxo de trabalho:
1. Conecte ao dispositivo via ADB ('adb connect <IP_DA_SUA_TV>:5555') e rode o inventário com 'bash scripts/01_inventory.sh <IP_DA_SUA_TV>:5555'.
2. Execute o debloat seguro com 'bash scripts/02_debloat_safe.sh <IP_DA_SUA_TV>:5555' (preservando Widevine L1, Play Store e Disney+ com partnersetup).
3. Ajuste animações para 0x com 'bash scripts/03_optimize_speed.sh <IP_DA_SUA_TV>:5555'.
4. Instale e inicie o launcher com 'bash scripts/04_install_launcher.sh <IP_DA_SUA_TV>:5555'.
5. Valide o foco da Home e apresente o ganho de memória RAM livre final obtido.
```

> 📖 **Guia Completo para Agentes:** Veja mais detalhes e instruções avançadas no documento [docs/HOW_TO_AI_AGENT.md](docs/HOW_TO_AI_AGENT.md).

---

## 🚀 Como Utilizar Manualmente (Linha de Comando)

### Pré-requisitos
- Xiaomi Mi TV Stick conectado à mesma rede Wi-Fi do computador.
- Depuração USB ativada nas opções de desenvolvedor da TV.
- Ferramenta `adb` instalada no computador.

### Passo 1: Conexão e Diagnóstico
```bash
./scripts/01_inventory.sh 192.168.100.32:5555
```

### Passo 2: Otimização de RAM (Debloat Seguro)
```bash
./scripts/02_debloat_safe.sh 192.168.100.32:5555
```

### Passo 3: Ativação das Animações Instantâneas (0x)
```bash
./scripts/03_optimize_speed.sh 192.168.100.32:5555
```

### Passo 4: Instalação do Launcher Personalizado
```bash
./scripts/04_install_launcher.sh 192.168.100.32:5555
```

*(Opcional)* Se desejar reverter tudo para o padrão de fábrica da Xiaomi:
```bash
./scripts/99_restore_stock.sh 192.168.100.32:5555
```

---

## 🛠️ Como Compilar o Código-Fonte
Se desejar fazer alterações no código Java ou nos layouts XML:

```bash
cd launcher
./gradlew assembleRelease
```
O APK gerado estará em:
`launcher/app/build/outputs/apk/release/app-release.apk`.

---

## 📄 Licença e Créditos

- Base do launcher: [CleanYourTV](https://github.com/Gathin23/cleanyourtv) sob licença GPL-3.0.
- Tipografia: Apple San Francisco (SF Pro).
- Modificações, engenharia reversa e otimização por **Dassayev Rodrigues**.

