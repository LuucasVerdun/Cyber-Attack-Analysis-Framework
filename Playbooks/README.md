# Playbooks — Runbooks de Execução Rápida

> Diferente de `Attack-Categories/` (base de conhecimento técnica completa), os runbooks aqui são **sequências de ação direta**, otimizadas para serem seguidas sob pressão durante um incidente ativo. Cada runbook assume que o analista já validou o alerta e precisa agir nos próximos minutos.

## Formato Padrão

Todo runbook segue esta estrutura:

```markdown
# Runbook: [Cenário]

## Quando usar
[Critério objetivo de quando este runbook se aplica]

## Primeiros 15 minutos
1. [Ação imediata 1]
2. [Ação imediata 2]

## Contenção (próximas 1-2h)
1. [...]

## Escalonamento
- Acionar [papel] se [condição]

## Não fazer
- [Erro comum a evitar — ex.: desligar a máquina antes de capturar memória]

## Referência completa
→ Ver `Attack-Categories/<categoria>/README.md`
```

## Índice de Runbooks

| Runbook | Cenário | Categoria de referência |
|---|---|---|
| [Ransomware-Ativo.md](Ransomware-Ativo.md) | Criptografia em andamento detectada | `Attack-Categories/Ransomware/` |
| [BEC-Confirmado.md](BEC-Confirmado.md) | Comprometimento de e-mail corporativo confirmado | `Attack-Categories/BEC/` |
| [C2-Beacon-Detectado.md](C2-Beacon-Detectado.md) | Beacon de C2 identificado em host | `Attack-Categories/C2/` |

> 📌 Roadmap: expandir runbooks para todas as 16 categorias Full Playbook. Use o formato acima ao criar novos.
