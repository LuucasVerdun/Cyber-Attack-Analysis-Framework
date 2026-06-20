# AWS

> 🟡 Quick-Reference

## Descrição Técnica

**Definição:** Guia de investigação específico para incidentes em ambiente Amazon Web Services, complementando a metodologia geral em [`Cloud-Intrusion/`](../Cloud-Intrusion/) e [`Cloud-Investigations/`](../../Cloud-Investigations/) com detalhes específicos da plataforma.

**Objetivo do atacante:** Acesso a dados em S3, abuso de compute (EC2/Lambda) para cryptojacking, escalonamento de privilégio via IAM, persistência via chaves de acesso.

**Impacto esperado:** Confidencialidade (dados em S3/RDS), Financeiro (recursos compute abusados), Integridade (modificação de infraestrutura via IaC comprometido).

**Vetores de entrada:**
- Chave de acesso IAM vazada (GitHub, log, código)
- SSRF → IMDS (ver `Web-Attacks/SSRF/`)
- Política IAM excessivamente permissiva
- Bucket S3 público não intencional

**IOCs típicos:**
- `userAgent` de SDK incomum em CloudTrail
- `AssumeRole` em cadeia anômala (role-hopping)
- Criação de instância em região nunca usada pela organização

**TTPs (MITRE ATT&CK):**
| Tática | Técnica | ID |
|---|---|---|
| Initial Access | Valid Accounts: Cloud Accounts | T1078.004 |
| Credential Access | Unsecured Credentials: Cloud Instance Metadata API | T1552.005 |
| Impact | Resource Hijacking | T1496 |

---

## Fluxo de Investigação (resumido)

| Fase | Ação-chave |
|---|---|
| Identificação | GuardDuty, billing alert, CloudTrail anomaly |
| Coleta | CloudTrail (Management + Data Events), VPC Flow Logs |
| Análise | Blast radius da identidade (IAM policy simulator), recursos criados/acessados |
| Contenção | Desabilitar access key, revogar sessão STS, aplicar SCP de quarentena |
| Erradicação | Remover recursos/políticas criadas pelo atacante |
| Recuperação | Rotação de credenciais relacionadas |
| Pós-Incidente | GuardDuty habilitado em todas as contas, least privilege IAM |

---

## Checklist Operacional

- [ ] CloudTrail Data Events confirmado habilitado para o recurso afetado (S3, Lambda)
- [ ] Histórico completo de chamadas da identidade coletado
- [ ] Blast radius mapeado (IAM Policy Simulator / Access Analyzer)
- [ ] Access keys/sessões STS revogadas
- [ ] Recursos criados pelo atacante removidos
- [ ] GuardDuty/Security Hub revisado

---

## Evidências Relevantes

| Fonte | O que procurar |
|---|---|
| CloudTrail | Toda chamada de API, origem (IP/userAgent), região |
| VPC Flow Logs | Tráfego de rede de/para instâncias afetadas |
| GuardDuty | Findings correlacionados |
| S3 Access Logs | Acesso a objeto específico (se habilitado) |
| IAM Access Analyzer | Exposição externa não intencional |

---

## Ferramentas Recomendadas
Prowler, ScoutSuite, AWS CLI, CloudTrail Lake, GuardDuty

---

## Caso Real
Abuso de chave de acesso IAM vazada em repositório público de código é um padrão recorrente e bem documentado — atacantes automatizados varrem GitHub/GitLab continuamente em busca de padrões de chave AWS (`AKIA...`) commitadas acidentalmente, frequentemente resultando em criação imediata de instâncias EC2 de alto custo para mineração de criptomoeda em questão de minutos após o vazamento.

---

## Referências
- MITRE ATT&CK: [T1078.004](https://attack.mitre.org/techniques/T1078/004/), [T1496](https://attack.mitre.org/techniques/T1496/)
- Metodologia geral: [`Cloud-Intrusion/README.md`](../Cloud-Intrusion/README.md)

> 📌 Esta categoria está marcada como Quick-Reference. Para expandir para Full Playbook, use `Templates/Full-Playbook-Template.md`.
