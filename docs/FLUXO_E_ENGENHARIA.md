# 🛠️ Engenharia Reversa e Otimização Extrema - Xiaomi Mi TV Stick (1 GB RAM)

Este documento descreve detalhadamente as restrições de arquitetura de hardware, os gargalos identificados no sistema Android TV da Xiaomi e todas as decisões de engenharia adotadas para transformar o aparelho em uma central rápida, fluida e personalizada.

---

## 1. Especificações de Hardware e Diagnóstico Inicial

- **Dispositivo:** Xiaomi Mi TV Stick (`MiTV-AESP0` / Codinome `aquaman`)
- **SoC:** Amlogic S805Y Quad-Core Cortex-A53 @ 1.2 GHz
- **GPU:** ARM Mali-450 MP3
- **Memória RAM:** 1 GB DDR4 (apenas **980 MB** utilizáveis pelo kernel)
- **Sistema Operacional:** Android TV 9.0 (Pie) - API 28
- **Arquitetura de CPU:** 32-bit (`armeabi-v7a`)

### 🔴 O Problema Crítico de RAM Original
No estado original de fábrica:
- **`MemAvailable`:** Oscilava entre **180 MB e 204 MB**.
- **`zRAM` / Swap em uso:** **299 MB** ativos (o sistema passava até 40% dos ciclos de CPU comprimindo páginas de memória na RAM em tempo real, causando engasgos severos, congelamentos no controle remoto e fechamento súbito de apps).
- **Launcher Stock:** O launcher oficial da Xiaomi / Google TV carregava carrosséis de trailers em vídeo, recomendações em segundo plano e serviços de telemetria (Alphonso, Xiaomi Analytics), consumindo mais de **140 MB de RAM** sozinhos.

---

## 2. Metodologia de Debloat Seguro e Persistente Sem Root

### A. Desinstalação para o Usuário 0 (`pm uninstall --user 0`)
Ao invés de rootear o aparelho (o que quebraria a certificação DRM Widevine L1 da Netflix e Prime Video), utilizamos a desinstalação isolada no perfil de usuário principal:
```bash
pm uninstall --user 0 <pacote>
```
Isso garante:
1. **Total reversibilidade:** Os binários continuam intactos na partição de sistema `/system` e podem ser reativados a qualquer momento via `cmd package install-existing --user 0 <pacote>`.
2. **Preservação do DRM Widevine L1:** Permite reprodução em 1080p nativo em todos os streamings.
3. **Persistência pós-reboot:** A Xiaomi não consegue reviver os pacotes após a reinicialização da TV.

### B. O Caso Especial do Disney+ (`com.google.android.partnersetup`)
Durante a limpeza, o Disney+ travou na tela inicial de apresentação. Ao analisar os logs do `logcat`:
```
BAM-SDK: Partner setup service check failed
```
Constatamos que o SDK de autenticação da Disney exige a presença de `com.google.android.partnersetup`. Ao manter esse pacote ativo, o Disney+ abriu normalmente com erro nulo (`error=null`).

---

## 3. Arquitetura do Launcher Customizado (CleanYourTV)

O launcher base selecionado foi o **CleanYourTV** (`com.gathin.tvhome`), compilado localmente com as seguintes customizações de baixo consumo:

### A. Tipografia do macOS / iOS (Apple San Francisco)
Substituição da fonte genérica do sistema pelas fontes oficiais da família Apple San Francisco:
- `San Francisco Text Regular`: Rótulos de apps e navegação.
- `San Francisco Text Medium`: Pílulas e botões de cabeçalho.
- `San Francisco Display Light / Ultralight`: Relógio digital e data.
- **Peso das fontes:** Apenas ~190 KB por peso, compilados em `.otf` nativo com decodificação rápida sem overhead de fontes variáveis.

### B. Efeitos Sonoros com Latência Zero (`SoundPool` + `USAGE_MEDIA`)
Para dar um feedback tátil de alta fidelidade:
- **Navegação (Foco):** Som suave de transição (`focus_switch.mp3`).
- **Abertura de Apps:** Efeito digital moderno (`launch_sound.mp3`).
- **Engenharia de Áudio:**
  - Emprego de `SoundPool` pré-carregado (latência < 5 ms).
  - Canal de áudio configurado para `AudioAttributes.USAGE_MEDIA`.
  - Verificação de volume em tempo real: se `getStreamVolume(STREAM_MUSIC) == 0`, o som silencia completamente no mudo.
  - Supressão dos bips padrão de fábrica do Android (`setSoundEffectsEnabled(false)`).

### C. Widget Porta-Retratos Inteligente com Zero Leak de RAM
- **Decodificação de Imagem:** Uso estrito de `Bitmap.Config.RGB_565` (consome **metade** da memória do formato `ARGB_8888`).
- **Ciclo de Vida Consciencioso:**
  - Carrossel pausa automaticamente no `onPause()` quando o usuário entra em qualquer app/filme, liberando o garbage collector.
  - Retoma no `onResume()` ao retornar à tela inicial.
- **Tamanho e Proporção:** 135 x 100 dp, posicionado no canto superior direito abaixo das pílulas de Wi-Fi e Configurações.

### D. Screensaver HTC Sense Flip Clock
Para descanso de tela:
- Relógio de abas mecânicas (Flip Clock) da lendária interface HTC Sense.
- Sol dourado clássico e painel meteorológico vertical.
- Modo estático com translação suave para prevenção de burn-in em telas OLED/LED.

---

## 4. Resultados Medidos de Desempenho

| Métrica | Antes (Padrão de Fábrica) | Depois (Otimizado) | Ganho Real |
| :--- | :---: | :---: | :---: |
| **Memória RAM Disponível** | 199.7 MB | **320 ~ 365 MB** | **+60,3% a +82%** |
| **zRAM Comprimida em Uso** | 299 MB | **41 MB** | **-86,3% de pressão de CPU** |
| **Escalas de Animação** | 1.0x (lentas) | **0.0x (instantâneas)** | **100% imediato** |
| **Consumo do Launcher** | ~140 MB | **~28 MB** | **-80% de pegada de memória** |
