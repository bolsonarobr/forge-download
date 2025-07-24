# FORGE_APP - REGRAS DE PROJETO PARA IA

## INSTRUÇÕES DIRETAS PARA IA

### CONTEXTO DO PROJETO
Sistema cliente-servidor: aplicativo Android (Kotlin/Compose) + servidor Python (Flask/Tkinter)
Comunicação: HTTP via rede local com descoberta automática (Zeroconf)
Objetivo: Painel de controle remoto para executar scripts AutoHotkey no PC

### REGRAS OBRIGATÓRIAS DE DESENVOLVIMENTO

#### 1. PRINCÍPIOS FUNDAMENTAIS
- MINIMALISMO: Criar mínimo código possível. Soluções simples e diretas
- REUTILIZAÇÃO: Verificar lógica existente antes de criar nova
- EFICIÊNCIA: Evitar arquivos/dependências desnecessárias
- ORGANIZAÇÃO: Código bem estruturado, nomes em português

#### 2. COMUNICAÇÃO
- IDIOMA: Exclusivamente Português
- CONCISÃO: Respostas resumidas e diretas
- SEM COMENTÁRIOS: Não adicionar comentários ao código

#### 3. FLUXO DE TRABALHO
- CONFIRMAÇÃO OBRIGATÓRIA: Sempre confirmar entendimento antes de modificar
- VALIDAÇÃO INICIAL: Máximo 3 perguntas curtas para confirmar pedido
- TRABALHO EM ETAPAS: Dividir em passos lógicos pequenos
- ANÁLISE PÓS-ALTERAÇÃO: Verificar código alterado para remover obsoletos

#### 4. REGRAS DE CODIFICAÇÃO
- SEM EXECUÇÃO AUTOMÁTICA: Nunca executar testes/comandos automaticamente
- SEM TRATAMENTO DE ERROS: Não implementar try/except ou lógica de falhas
- SEM DEPURAÇÃO: Não incluir print, console.log ou saídas de debug

### PADRÕES TÉCNICOS

#### BACKEND (Python)
- Rotas Flask: `@app.route('/rota', methods=['GET/POST'])`
- Funções auxiliares: Prefixo `_` (ex: `_carregar_contas()`)
- Respostas JSON: Usar `jsonify()`
- Validação: Verificar dados de entrada

#### FRONTEND (Kotlin/Compose)
- Componentes: Usar `TouchButton` para todos os botões, garantindo a animação "squeezy" padronizada.
- Estados: Usar `rememberSaveable` para persistência
- Coroutines: Usar `scope.launch` para operações assíncronas
- Cores: Usar constantes de `Color.kt`

### ESTRUTURA ATUAL

#### BACKEND (FORGE_APP/FORGE/)
- `servidor.py` - Servidor principal com GUI Tkinter
- `contas.json` - Dados das contas (nome, caminho)
- `ahk/` - Scripts AutoHotkey
- **Funcionalidades implementadas:**
  - **Validação de Licença:** Verificação de chave de licença online na inicialização.
  - **Verificação de Ambiente:** Checagem e instalação automática do AutoHotkey.
  - **Ajuste de Resolução:** Detecção e sugestão de ajuste para a resolução de tela recomendada.
  - **Instância Única:** Garante que apenas uma instância do servidor seja executada.
  - **Validação de Atalho:** Confirma a existência do caminho do atalho (.lnk) ao adicionar conta.
- Rotas da API:
  - `GET /contas` - Listar contas
  - `POST /contas` - Adicionar conta
  - `POST /executar_conta` - Executar atalho
  - `POST /renomear_conta` - Renomear conta
  - `POST /excluir_conta` - Excluir conta
  - `GET /comando/<nome>` - Comandos gerais

#### FRONTEND (FORGE_APP/app/)
- `MainScreen.kt` - Interface principal com menu esquerdo (BOT, CONTAS)
- `NetworkService.kt` - Comunicação de rede com Ktor
- `Color.kt` - Definições de cores
- Funcionalidades implementadas:
  - Descoberta automática do servidor
  - Painel de contas com botões dinâmicos
  - Adição, renomeação e exclusão de contas

### PRÓXIMAS FUNCIONALIDADES PENDENTES
1. Interface de configuração do servidor

### ARQUIVOS CRÍTICOS PARA MODIFICAÇÃO
- `FORGE_APP/FORGE/servidor.py` - Lógica do servidor
- `FORGE_APP/app/src/main/java/com/tiago/forgeapp/MainScreen.kt` - Interface
- `FORGE_APP/app/src/main/java/com/tiago/forgeapp/NetworkService.kt` - Rede
- `FORGE_APP/app/build.gradle.kts` - Dependências Android
- `FORGE_APP/gradle/libs.versions.toml` - Versões

### COMANDOS PARA IA
- ANALISAR: "analise as regras e o projeto"
- IMPLEMENTAR: "implementar funcionalidade X"
- CORRIGIR: "corrigir erro Y"
- ATUALIZAR: "atualizar prompt/documentação"

### VALIDAÇÕES OBRIGATÓRIAS
- Verificar se código segue padrões estabelecidos
- Confirmar que não há código obsoleto após modificações
- Garantir que nomes estão em português
- Validar que estrutura de arquivos foi mantida

### FALHAS SILENCIOSAS
- Se operação falhar, deve falhar silenciosamente
- Não implementar retry ou tratamento de erro
- Não adicionar logs ou mensagens de debug
- Manter código mínimo e direto 