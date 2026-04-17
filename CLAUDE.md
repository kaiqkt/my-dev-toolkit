# my-skills

Repositório para armazenar, analisar e criar skills para uso com agents de IA.

## Estrutura

```
skills/   ← definições das skills (arquivos .md)
```

As skills são copiadas para `~/.claude/commands/` para uso global no Claude Code.

## Regras

### Após criar ou atualizar uma skill

Sempre realizar commit e push automaticamente após criar ou modificar qualquer arquivo em `skills/`. Usar o formato de commit convencional:

```
feat(skills): add <nome-da-skill>
```

ou para atualizações:

```
fix(skills): update <nome-da-skill>
```
