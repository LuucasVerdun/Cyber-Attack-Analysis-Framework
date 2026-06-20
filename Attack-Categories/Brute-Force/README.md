# Brute-Force

> 🟡 Quick-Reference

## Descrição Técnica

**Definição:** Tentativa sistemática de autenticação testando múltiplas combinações de senha contra uma ou poucas contas-alvo, até encontrar a correta.

**Objetivo do atacante:** Obter credencial válida para acesso inicial ou escalonamento.

**Impacto esperado:** Confidencialidade (acesso não autorizado) — risco direto proporcional ao privilégio da conta-alvo.

**Vetores de entrada:**
- RDP/SSH exposto à internet
- Portal de aplicação web com autenticação
- API com endpoint de login sem rate limiting

**IOCs típicos:**
- Alto volume de falhas de autenticação (Event ID 4625) de uma única origem contra uma única conta
- Sucesso de login imediatamente após sequência de falhas

**TTPs (MITRE ATT&CK):**
| Tática | Técnica | ID |
|---|---|---|
| Credential Access | Brute Force: Password Guessing | T1110.001 |
| Credential Access | Brute Force: Credential Stuffing | T1110.004 |

---

## Fluxo de Investigação (resumido)

| Fase | Ação-chave |
|---|---|
| Identificação | Regra de threshold de falhas de login por conta/origem |
| Coleta | Event ID 4624/4625, logs de aplicação/WAF |
| Análise | Confirmar se houve sucesso após as falhas; origem (IP único vs. distribuído) |
| Contenção | Bloquear origem, lock da conta-alvo se necessário |
| Erradicação | Garantir rate limiting/lockout policy configurado |
| Recuperação | Resetar senha se sucesso confirmado |
| Pós-Incidente | MFA obrigatório, rate limiting, geo-blocking se aplicável |

---

## Checklist Operacional

- [ ] Volume e padrão de falhas confirmado
- [ ] Verificado se houve autenticação bem-sucedida
- [ ] Origem (IP/ASN) identificada e bloqueada
- [ ] Conta resetada se comprometida
- [ ] Rate limiting/account lockout validado

---

## Evidências Relevantes

| Ambiente | Fontes principais |
|---|---|
| Windows | Event ID 4625 (falha), 4624 (sucesso), 4740 (lockout) |
| Linux | `/var/log/auth.log` (`Failed password`, `Accepted password`) |
| Cloud | Azure AD Sign-in Logs (failure reason), CloudTrail `ConsoleLogin` |

---

## Ferramentas Recomendadas
SIEM com regra de threshold, Sigma, fail2ban (prevenção em Linux)

---

## Caso Real
**RDP exposto como vetor inicial de ransomware:** brute-force contra RDP exposto à internet é historicamente um dos vetores de acesso inicial mais comuns para operações de ransomware de baixa sofisticação/oportunistas, frequentemente precedendo o incidente principal por dias.

---

## Referências
- MITRE ATT&CK: [T1110.001](https://attack.mitre.org/techniques/T1110/001/), [T1110.004](https://attack.mitre.org/techniques/T1110/004/)

> 📌 Esta categoria está marcada como Quick-Reference. Para expandir para Full Playbook, use `Templates/Full-Playbook-Template.md`.
