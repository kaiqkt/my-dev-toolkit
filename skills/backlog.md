# Skill: backlog

Cria e gerencia tarefas no backlog local do projeto seguindo uma estrutura hierárquica de features e contextos.

## Uso

```
/backlog [user story ou descrição da tarefa]
```

## Comportamento

Ao receber uma solicitação, o agente deve:

### 1. Coletar informações

Se o usuário não fornecer todos os dados necessários, pergunte:
- **Feature**: qual o agrupamento principal? (ex: `backend`, `frontend`, `infra`)
- **Contexto**: qual o subdiretório dentro da feature? Pode ser hierárquico (ex: `auth`, `modelagem-de-dados`, `pagamentos/pix`)
- **Título da tarefa**: nome curto e descritivo
- **Descrição**: detalhamento do que precisa ser feito
- **User Story**: no formato "Como [usuário], quero [ação] para que [benefício]."

Se o usuário já fornecer uma user story na solicitação, derive o título e a descrição a partir dela. Não pergunte o que já foi informado.

### 2. Estrutura de diretórios

O backlog fica sempre em `/docs/backlog/` relativo à raiz do projeto.

```
docs/backlog/
  index.md
  {feature}/
    {contexto}/
      tasks.md
```

Exemplos válidos:
- `docs/backlog/backend/auth/tasks.md`
- `docs/backlog/backend/modelagem-de-dados/tasks.md`
- `docs/backlog/frontend/dashboard/tasks.md`
- `docs/backlog/backend/pagamentos/pix/tasks.md`

Crie os diretórios que não existirem.

### 3. Formato de uma tarefa

Cada `tasks.md` agrupa as tarefas do contexto. Ao adicionar uma nova tarefa, siga este formato:

```markdown
## [Título da Tarefa]

**Status:** `todo`
**Descrição:** [Descrição objetiva do que precisa ser implementado]
**User Story:** Como [usuário], quero [ação] para que [benefício].
```

- Status inicial é sempre `todo`
- Se o arquivo `tasks.md` não existir, crie-o com o cabeçalho abaixo antes das tarefas:

```markdown
# [Nome do Contexto]

> Feature: [nome da feature]
```

- Se já existir, apenas acrescente a nova tarefa ao final do arquivo.

### 4. Atualizar o index.md

O arquivo `docs/backlog/index.md` é a visão geral do backlog. Deve sempre refletir o estado atual.

Se não existir, crie-o com esta estrutura:

```markdown
# Backlog

> Índice geral de features e tarefas do projeto.

## Visão Geral

| Feature | Contexto | Todo | In Progress | Done |
|---------|----------|------|-------------|------|

## Features

```

Ao adicionar ou atualizar uma tarefa:
1. Leia o `tasks.md` do contexto para contar tarefas por status
2. Atualize (ou insira) a linha correspondente na tabela `Visão Geral`
3. Se a feature ainda não aparece na seção `## Features`, adicione um link:

```markdown
### [feature]
- [contexto](feature/contexto/tasks.md)
```

### 5. Regras gerais

- Nomes de diretórios em **kebab-case** e **minúsculas** (ex: `modelagem-de-dados`, `auth`)
- Nunca sobrescreva tarefas existentes — apenas acrescente
- Sempre atualize o `index.md` após criar ou editar qualquer `tasks.md`
- Se a user story for vaga, mantenha-a como fornecida pelo usuário — não invente detalhes
