# 📜 Histórico de Prompts e Fluxo de Instruções

Este arquivo registra a evolução cronológica dos comandos e requisitos enviados pelo usuário, ilustrando como o projeto foi concebido e refinado através de *pair programming* ágil.

---

### Fase 1: Diagnóstico e Otimização Inicial
- **Prompt:**
  > *"Você é um assistente técnico especializado em otimização de dispositivos Android e sistemas embarcados. Estou com um Xiaomi Mi TV Stick (Android 9 Pie) com 1 GB de RAM extremamente travado e lento. Quero fazer uma limpeza profunda (debloat), remover tudo o que não uso, liberar o máximo de memória RAM livre possível sem perder os apps de streaming e sem perder o controle remoto."*
- **Ação:** Coleta de inventário (`packages_all.txt`), identificação do IP local, análise de risco em 3 listas (A - Desinstalação Segura, B - Desativação Reversível, C - Protegidos do Sistema).

---

### Fase 2: Instalação e Troca da Launcher
- **Prompt:**
  > *"Utilize a opção 1 - CleanYourTV, pode seguir. Quero manter funcionando: YouTube, Netflix, Prime Video, Disney+, Globoplay, Apple TV."*
- **Ação:** Compilação do CleanYourTV, desinstalação definitiva da `com.google.android.tvlauncher` para o usuário 0, garantia de persistência e ativação de serviço de interceptação da tecla Home do controle remoto.

---

### Fase 3: Customização Visual e Wallpaper
- **Prompt:**
  > *"O 4, adicione uma pequena mensagem no canto direito inferior: '- Sistema modificado por Dassayev Rodrigues'. Retira um negrito do texto, altere para fonte San Francisco (macOS) e aumente mais um pouco o tamanho."*
- **Ação:** Modificação do wallpaper padrão Nature (`01-dusk-peaks.jpg`) via Pillow com a fonte San Francisco (`SFNS.ttf`), gerando arte personalizada e gravada no sistema.

---

### Fase 4: Descanso de Tela Estilo HTC Sense
- **Prompt:**
  > *"Consegue aplicar a opção 4 mas criando um relógio igual da htc do android antigo com aquele sol amarelo e a previsão do tempo? Consegue deixar ele mais alinhado a esquerda e do lado direito criar uma lista vertical com a temperatura por horário do dia e alerta de catastrofes naturais no mundo inteiro ou isso vai consumir muita ram ?"*
- **Ação:** Criação da `ClockActivity` com layout nativo de placas mecânicas (Flip Clock), sol dourado e coluna direita estática/leve (zero consumo de RAM em background).

---

### Fase 5: Widget Porta-Retratos Inteligente
- **Prompt:**
  > *"Conseguimos criar um widget desse na tela inicial sem consumir muito recurso ? Eu te mando as fotos por aqui, são poucas, e você cria o widget que deve ficar localizado abaixo da hora e data no canto esquerdo superior da tela. Você deverá comprimir o tamanho das fotos para não consumir muito recurso."*
- **Ação:** Otimização de 10 fotos pessoais de família para menos de 255 KB totais, carregamento via `Bitmap.Config.RGB_565` e ciclo de vida sincronizado com `onResume()` / `onPause()`.

---

### Fase 6: Refinamento de Layout e Alinhamento
- **Prompt:**
  > *"Realoque o widget para o lado direito da tela, abaixo das pílulas do wi-fi e configurações, o widget precisa ficar alinhado e as pílulas devem ficar alinhadas com o horário e data que ficam do lado esquerdo."*
  > *"Diminua um pouco o tamanho do widget de fotos e posicione um pouco mais abaixo das pílulas de wifi e configurações; Aplique um formato retangular com radius border 10 px nas pílulas de wifi e configurações;"*
  > *"Aplique um alinhamento vertical nos elementos Relógio/data, Wifi e Configurações. Estão levemente desalinhados na linha superior."*
- **Ação:** Ajuste milimétrico de coordenadas de layout: pílulas em 10px radius, widget em 135x100 dp, compensação de margem superior para 12 dp (diferença vertical de centro inferior a 0,5 pixel).

---

### Fase 7: Tipografia Apple San Francisco Global
- **Prompt:**
  > *"Você consegue implementar a tipografia do MacOS/iOS em toda a launcher ?"*
- **Ação:** Integração dos 4 pesos oficiais da fonte San Francisco (`San Francisco Text Regular/Medium` e `Display Light/Ultralight`) em formato OpenType nativo, padronizando 100% dos textos do launcher e screensaver.

---

### Fase 8: Sistema de Feedback Sonoro Tátil (SoundPool)
- **Prompt:**
  > *"É possível adicionar esse efeito sonoro ao utilizar o controle para selecionar os aplicativos na tela inicial? Vamos utilizar ao navegar entre os aplicativos (foco), quando finalizar vou te enviar o efeito para utilizar ao confirmar / abrir o aplicativo."*
  > *"O volume do efeito ainda está muito alto mesmo com o volume em 0, diminua em 60%"*
  > *"Utilize esse som para abertura dos apps, siga as regras de volume do efeito de foco."*
- **Ação:** Implementação de `SoundPool` de baixa latência em `USAGE_MEDIA`, desativação de cliques mecânicos padrão do Android, calibração sutil de volume e silêncio automático quando a TV está no mudo.

