# GCP

> 🟡 Quick-Reference

## Descrição Técnica

**Definição:** Guia de investigação específico para incidentes em ambiente Google Cloud Platform, complementando a metodologia geral em [`Cloud-Intrusion/`](../Cloud-Intrusion/) e [`Cloud-Investigations/`](../../Cloud-Investigations/).

**Objetivo do atacante:** Comprometimento de Service Account, abuso de Compute Engine para cryptojacking, acesso a dados em Cloud Storage/BigQuery, escalonamento via permissões IAM mal configuradas.

**Impacto esperado:** Confidencialidade (dados em Storage/BigQuery), Financeiro (recursos compute abusados — GCP é alvo recorrente de cryptojacking em larga escala).

**Vetores de entrada:**
- Chave de Service Account (JSON) vazada
- SSRF → Compute Engine Metadata Server
- IAM binding excessivamente permissivo (`roles/owner` concedido amplamente)
- Bucket Cloud Storage com acesso público não intencional

**IOCs típicos:**
- Criação de instância Compute Engine em projeto/região incomum
- `serviceAccount` atuando fora do padrão de uso esperado
- Mudança de IAM policy binding por identidade não administrativa

**TTPs (MITRE ATT&CK):**
| Tática | Técnica | ID |
|---|---|---|
| Initial Access | Valid Accounts: Cloud Accounts | T1078.004 |
| Persistence | Additional Cloud Credentials | T1098.001 |
| Impact | Resource Hijacking | T1496 |

---

## Fluxo de Investigação (resumido)

| Fase | Ação-chave |
|---|---|
| Identificação | Security Command Center, billing alert |
| Coleta | Admin Activity + Data Access Audit Logs (confirmar se Data Access está habilitado) |
| Análise | Blast radius da Service Account/usuário (IAM Policy Analyzer) |
| Contenção | Desabilitar/rotacionar chave de Service Account, remover IAM binding |
| Erradicação | Remover recursos criados pelo atacante |
| Recuperação | Rotação ampla de credenciais relacionadas |
| Pós-Incidente | Habilitar Data Access Audit Logs, least privilege IAM |

---

## Checklist Operacional

- [ ] Confirmado se Data Access Audit Logs estava habilitado (frequentemente não está por padrão)
- [ ] Histórico de chamadas da identidade coletado
- [ ] Blast radius mapeado (IAM Policy Analyzer)
- [ ] Chave de Service Account rotacionada/revogada
- [ ] Recursos criados pelo atacante removidos
- [ ] Security Command Center revisado

---

## Evidências Relevantes

| Fonte | O que procurar |
|---|---|
| Admin Activity Audit Logs | Mudanças administrativas (sempre habilitado) |
| Data Access Audit Logs | Acesso a dados (requer habilitação explícita) |
| VPC Flow Logs | Tráfego de rede anômalo |
| Security Command Center | Findings correlacionados |

---

## Ferramentas Recomendadas
Prowler/ScoutSuite, gcloud CLI, BigQuery (para análise de log em escala)

---

## Caso Real
Cryptojacking via Service Account/chave vazada é consistentemente reportado pelo Google Cloud Threat Horizons Report como um dos vetores de comprometimento mais comuns observados em incidentes GCP — instâncias Compute Engine de alto desempenho são provisionadas em minutos após o vazamento de credencial, frequentemente em projetos/regiões fora do uso normal da organização, tornando alertas de billing um sinal de detecção precoce particularmente eficaz.

---

## Referências
- MITRE ATT&CK: [T1078.004](https://attack.mitre.org/techniques/T1078/004/), [T1496](https://attack.mitre.org/techniques/T1496/)
- Metodologia geral: [`Cloud-Intrusion/README.md`](../Cloud-Intrusion/README.md)

> 📌 Esta categoria está marcada como Quick-Reference. Para expandir para Full Playbook, use `Templates/Full-Playbook-Template.md`.
