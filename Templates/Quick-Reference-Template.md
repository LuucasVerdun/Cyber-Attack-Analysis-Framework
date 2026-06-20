# [Nome da Categoria de Ataque]

> Template para **Quick-Reference**. Copie para `Attack-Categories/<Categoria>/README.md`. Mais enxuto que o Full Playbook, mas deve ser suficiente para um analista N1/N2 agir sem precisar consultar outra fonte.

---

## Descrição Técnica

**Definição:** [O que é, em 2-3 frases.]

**Objetivo do atacante:** [Acesso inicial / escalonamento / persistência / exfiltração / impacto.]

**Impacto esperado:** [CIA — qual(is) pilar(es) afetado(s).]

**Vetores de entrada:**
- [Vetor 1]
- [Vetor 2]

**IOCs típicos:**
- [Tipo de indicador 1]
- [Tipo de indicador 2]

**TTPs (MITRE ATT&CK):**
| Tática | Técnica | ID |
|---|---|---|
| [Tática] | [Técnica] | T.... |

---

## Fluxo de Investigação (resumido)

| Fase | Ação-chave |
|---|---|
| Identificação | [Como detectar — fonte/regra principal] |
| Coleta | [Artefato/evidência prioritária] |
| Análise | [O que procurar primeiro] |
| Contenção | [Ação imediata] |
| Erradicação | [Remoção da causa raiz] |
| Recuperação | [Critério de retorno seguro] |
| Pós-Incidente | [Detecção/hardening a implementar] |

---

## Checklist Operacional

- [ ] Alerta validado
- [ ] IOCs coletados e registrados
- [ ] Escopo determinado
- [ ] Contenção aplicada
- [ ] Causa raiz removida
- [ ] Ambiente validado
- [ ] Lições aprendidas documentadas

---

## Evidências Relevantes

| Ambiente | Fontes principais |
|---|---|
| Windows | [Event IDs, Sysmon, Registry, etc.] |
| Linux | [auth.log, auditd, etc.] |
| Cloud | [CloudTrail / Activity Logs / Audit Logs] |

---

## Ferramentas Recomendadas
[Lista enxuta — DFIR / Malware / Network / Threat Hunting conforme aplicável.]

---

## Caso Real
**[Nome do caso]:** [1-3 frases de aplicação prática, com fonte pública.]

---

## Referências
- MITRE ATT&CK: [técnica(s)]
- [Outras fontes]

> 📌 Esta categoria está marcada como Quick-Reference. Para expandir para Full Playbook, use `Templates/Full-Playbook-Template.md`.
