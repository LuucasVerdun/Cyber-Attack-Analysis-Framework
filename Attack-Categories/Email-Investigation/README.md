# Email-Investigation

> 🟡 Quick-Reference

## Descrição Técnica

**Definição:** Metodologia de investigação focada em e-mail como vetor — complementa `Phishing/`, `Spear-Phishing/` e `BEC/` com o processo técnico detalhado de análise de cabeçalho, autenticação de domínio e rastreamento de entrega.

**Quando usar:** Sempre que um e-mail suspeito precisar de análise técnica aprofundada — seja para confirmar phishing, validar legitimidade de remetente, ou rastrear o caminho de entrega completo.

**IOCs típicos:**
- Falha de SPF/DKIM/DMARC
- Domínio do remetente recém-registrado (NRD — Newly Registered Domain)
- Cadeia de `Received` headers com salto incomum/origem geográfica inconsistente com o suposto remetente

**TTPs (MITRE ATT&CK):**
| Tática | Técnica | ID |
|---|---|---|
| Initial Access | Phishing | T1566 |
| Collection | Email Collection | T1114 |

---

## Análise de Header — Checklist Técnico

| Campo | O que verificar |
|---|---|
| `Authentication-Results` | SPF=pass/fail, DKIM=pass/fail, DMARC=pass/fail |
| `Received` (cadeia completa, de baixo para cima) | Caminho real do e-mail desde a origem; primeiro salto é o mais confiável |
| `Return-Path` vs. `From` | Discrepância pode indicar spoofing |
| `Reply-To` | Frequentemente usado para redirecionar resposta para domínio do atacante, diferente do `From` exibido |
| `Message-ID` | Formato consistente com a infraestrutura legítima do suposto remetente? |
| `X-Originating-IP` (se presente) | IP real de origem, quando não removido pelo gateway |

---

## Fluxo de Investigação (resumido)

| Fase | Ação-chave |
|---|---|
| Identificação | Relato do usuário, sandbox de e-mail |
| Coleta | E-mail original (.eml) com headers completos — nunca um encaminhamento |
| Análise | Checklist de header acima + sandbox de link/anexo |
| Contenção | Remediação em massa (remover de todas as caixas) |
| Erradicação | Bloqueio de IOC em e-mail gateway |
| Recuperação | Confirmar remoção completa |
| Pós-Incidente | Ajuste de regra de SPF/DKIM/DMARC enforcement, treinamento |

---

## Checklist Operacional

- [ ] Arquivo `.eml` original obtido (não encaminhado)
- [ ] Resultado de SPF/DKIM/DMARC verificado
- [ ] Cadeia de `Received` analisada para origem real
- [ ] Link/anexo submetido a sandbox
- [ ] Message Trace executado para identificar todos os destinatários
- [ ] E-mail removido de todas as caixas via remediação em massa

---

## Evidências Relevantes

| Fonte | O que procurar |
|---|---|
| M365 Message Trace / Defender | Caminho completo, ação tomada, todos os destinatários |
| Google Workspace Admin | Logs de e-mail equivalentes |
| E-mail gateway (Proofpoint/Mimecast) | Veredito de sandbox, score de spam/phishing |

---

## Ferramentas Recomendadas
MXToolbox, análise manual de header, sandbox de e-mail, URLScan.io

---

## Referência Cruzada
- Phishing em massa: [`Phishing/README.md`](../Phishing/README.md)
- Phishing direcionado: [`Spear-Phishing/README.md`](../Spear-Phishing/README.md)
- Comprometimento de conta de e-mail: [`BEC/README.md`](../BEC/README.md)

> 📌 Esta categoria está marcada como Quick-Reference. Para expandir para Full Playbook, use `Templates/Full-Playbook-Template.md`.
