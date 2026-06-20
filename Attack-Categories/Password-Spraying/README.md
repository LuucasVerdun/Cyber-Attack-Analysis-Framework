# Password-Spraying

> 🟡 Quick-Reference

## Descrição Técnica

**Definição:** Variante de brute-force que testa **uma ou poucas senhas comuns** (ex.: `Outono2026!`) contra **muitas contas diferentes**, evitando lockout por tentativa excessiva em uma única conta — desenhado especificamente para evadir políticas de bloqueio tradicionais.

**Objetivo do atacante:** Obter ao menos uma credencial válida em ambiente com muitas contas, explorando o fato estatístico de que sempre há usuários com senhas fracas/previsíveis.

**Impacto esperado:** Confidencialidade — acesso inicial a pelo menos uma conta válida.

**Vetores de entrada:**
- Portal SSO/M365/Azure AD exposto
- VPN com autenticação baseada em senha
- Qualquer serviço com política de lockout per-account (que o spraying contorna)

**IOCs típicos:**
- Múltiplas contas diferentes com 1-2 falhas de login na mesma janela de tempo, da mesma origem
- Padrão "low and slow" (poucas tentativas por conta, mas distribuído ao longo de muitas contas)

**TTPs (MITRE ATT&CK):**
| Tática | Técnica | ID |
|---|---|---|
| Credential Access | Brute Force: Password Spraying | T1110.003 |

---

## Fluxo de Investigação (resumido)

| Fase | Ação-chave |
|---|---|
| Identificação | Regra: N contas distintas com falha na mesma janela, mesma origem |
| Coleta | Azure AD Sign-in Logs / Event ID 4625 em escala |
| Análise | Quais contas tiveram sucesso após a campanha de spray |
| Contenção | Bloquear origem, forçar reset nas contas com sucesso |
| Erradicação | Validar política de senha forte e MFA |
| Recuperação | Reset de senha + revogação de sessão das contas comprometidas |
| Pós-Incidente | MFA obrigatório, Smart Lockout / Conditional Access |

---

## Checklist Operacional

- [ ] Padrão de spray confirmado (múltiplas contas, mesma origem, baixo volume/conta)
- [ ] Contas com sucesso identificadas
- [ ] Origem bloqueada
- [ ] Contas comprometidas resetadas + sessões revogadas
- [ ] MFA validado/forçado para todas as contas

---

## Evidências Relevantes

| Ambiente | Fontes principais |
|---|---|
| Windows | Event ID 4625/4624 correlacionado em escala por origem |
| Linux | `/var/log/auth.log` |
| Cloud | Azure AD Sign-in Logs (`Failure reason: Invalid Password` em múltiplas contas) |

---

## Ferramentas Recomendadas
SIEM com correlação por origem/janela de tempo, KQL (Azure AD), Sigma

---

## Caso Real
**Password Spraying contra portais M365/Azure AD:** técnica amplamente reportada por CISA e Microsoft como vetor recorrente usado por diversos atores (incluindo atribuídos a estado-nação) contra organizações com MFA não universalmente aplicado — contas de serviço e contas legadas sem MFA são alvos preferenciais.

---

## Referências
- MITRE ATT&CK: [T1110.003](https://attack.mitre.org/techniques/T1110/003/)

> 📌 Esta categoria está marcada como Quick-Reference. Para expandir para Full Playbook, use `Templates/Full-Playbook-Template.md`.
