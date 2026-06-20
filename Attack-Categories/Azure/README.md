# Azure

> 🟡 Quick-Reference

## Descrição Técnica

**Definição:** Guia de investigação específico para incidentes em ambiente Microsoft Azure, complementando a metodologia geral em [`Cloud-Intrusion/`](../Cloud-Intrusion/) e [`Cloud-Investigations/`](../../Cloud-Investigations/).

**Objetivo do atacante:** Comprometimento de identidade Azure AD (frequentemente integrada a M365 — ver `BEC/`), abuso de recursos compute, acesso a dados em Storage/SQL, persistência via Service Principal/App Registration.

**Impacto esperado:** Confidencialidade (dados, e-mail via integração M365), Financeiro (recursos abusados), risco elevado pela integração nativa entre identidade Azure AD e produtividade (M365).

**Vetores de entrada:**
- Comprometimento de conta de usuário (phishing, password spray)
- Service Principal com credencial vazada
- Consent phishing (OAuth app malicioso)
- Conditional Access mal configurado/ausente

**IOCs típicos:**
- "Impossible travel" em Sign-in Logs
- Criação de App Registration com permissão de alto escopo
- Atribuição de role `Owner`/`Global Admin` fora de processo

**TTPs (MITRE ATT&CK):**
| Tática | Técnica | ID |
|---|---|---|
| Initial Access | Valid Accounts: Cloud Accounts | T1078.004 |
| Persistence | Additional Cloud Roles | T1098.003 |
| Credential Access | Steal Application Access Token | T1528 |

---

## Fluxo de Investigação (resumido)

| Fase | Ação-chave |
|---|---|
| Identificação | Microsoft Defender for Cloud, Azure AD Identity Protection, Sign-in risk |
| Coleta | Azure AD Sign-in + Audit Logs, Activity Logs (Resource Manager) |
| Análise | Blast radius da identidade (roles RBAC + App permissions) |
| Contenção | Revogar sessão, desabilitar conta/Service Principal, Conditional Access de bloqueio |
| Erradicação | Remover App Registration/role não autorizada |
| Recuperação | Rotação de credenciais relacionadas |
| Pós-Incidente | Conditional Access enforcement, PIM (Privileged Identity Management) |

---

## Checklist Operacional

- [ ] Sign-in Logs (90+ dias) coletados
- [ ] App Registrations/Service Principals da identidade revisados
- [ ] Roles RBAC atribuídas mapeadas
- [ ] Sessão/token revogados
- [ ] App malicioso/role não autorizada removida
- [ ] Conditional Access revisado

---

## Evidências Relevantes

| Fonte | O que procurar |
|---|---|
| Azure AD Sign-in Logs | IP, dispositivo, localização, MFA challenge |
| Azure AD Audit Logs | Mudanças de configuração, criação de objeto |
| Activity Logs | Operações em recursos (Resource Manager) |
| Microsoft Defender for Cloud | Alertas correlacionados |

---

## Ferramentas Recomendadas
Microsoft Defender for Cloud, KQL/Log Analytics, ScoutSuite, Azure CLI

---

## Caso Real
Consent phishing (atacante induz usuário a aprovar um OAuth app malicioso com permissões de leitura de e-mail/arquivos) é um padrão crescente em campanhas direcionadas a ambientes Azure AD/M365 — diferente de roubo de senha tradicional, o acesso obtido via OAuth consent sobrevive a reset de senha, exigindo revogação explícita do consent como parte obrigatória da contenção.

---

## Referências
- MITRE ATT&CK: [T1078.004](https://attack.mitre.org/techniques/T1078/004/), [T1528](https://attack.mitre.org/techniques/T1528/)
- Metodologia geral: [`Cloud-Intrusion/README.md`](../Cloud-Intrusion/README.md)

> 📌 Esta categoria está marcada como Quick-Reference. Para expandir para Full Playbook, use `Templates/Full-Playbook-Template.md`.
