# Kubernetes

> 🟡 Quick-Reference

## Descrição Técnica

**Definição:** Investigação de comprometimento em clusters Kubernetes — desde acesso não autorizado à API server até escape de container para o node host.

**Objetivo do atacante:** Execução de código em pod/container, escalonamento para acesso ao node subjacente, movimento lateral entre namespaces/pods, abuso de recursos para cryptojacking.

**Impacto esperado:** Confidencialidade (secrets do cluster, dados de aplicação), Integridade (deploy de workload malicioso), potencial pivô para infraestrutura cloud subjacente se o node for comprometido.

**Vetores de entrada:**
- API server exposto sem autenticação adequada (dashboard exposto, RBAC mal configurado)
- Imagem de container maliciosa/vulnerável (CVE em dependência)
- Pod com privilégios excessivos (`privileged: true`, hostPath mount)
- Service Account token com permissão excessiva

**IOCs típicos:**
- Pod criado com `hostPID`/`hostNetwork`/`privileged: true` fora do padrão
- Execução de `kubectl exec` não autorizada
- Imagem de container puxada de registry não autorizado

**TTPs (MITRE ATT&CK)**

| Tática | Técnica | ID |
|---|---|---|
| Execution | Deploy Container | T1610 |
| Privilege Escalation | Escape to Host | T1611 |
| Persistence | Implant Internal Image | T1525 |

---

## Fluxo de Investigação (resumido)

| Fase | Ação-chave |
|---|---|
| Identificação | Falco/runtime security alert, audit log do API server |
| Coleta | Kubernetes Audit Logs, logs de pod afetado, manifesto YAML usado |
| Análise | Como o pod malicioso foi criado/comprometido, escopo de RBAC alcançado |
| Contenção | Isolar/deletar pod, revogar Service Account token, NetworkPolicy de bloqueio |
| Erradicação | Corrigir RBAC excessivo, remover imagem maliciosa do registry |
| Recuperação | Validar integridade dos demais workloads do cluster |
| Pós-Incidente | Pod Security Standards, admission controller, scan de imagem no CI/CD |

---

## Checklist Operacional

- [ ] Kubernetes Audit Logs do período coletados
- [ ] Manifesto/imagem do pod comprometido analisado
- [ ] RBAC/Service Account envolvido mapeado
- [ ] Verificado se houve escape para o node host
- [ ] Pod isolado/removido, token revogado
- [ ] NetworkPolicy/RBAC corrigido

---

## Evidências Relevantes

| Fonte | O que procurar |
|---|---|
| Kubernetes Audit Logs | Toda chamada à API server (`create`, `exec`, `get secrets`) |
| Runtime security (Falco) | Syscalls anômalas dentro do container |
| Container registry logs | Pull/push de imagem não autorizada |
| Node-level logs | Se houve escape, logs do node host (ver `DFIR/`) |

---

## Ferramentas Recomendadas
Falco, kubectl (auditoria), kube-bench, Trivy (scan de imagem)

---

## Caso Real
Dashboards Kubernetes expostos sem autenticação (uma má configuração recorrente, especialmente em ambientes de desenvolvimento/teste) são alvo direto de varreduras automatizadas em massa, frequentemente resultando em deploy imediato de pods de mineração de criptomoeda — um padrão de cryptojacking via Kubernetes amplamente documentado por pesquisadores de segurança cloud.

---

## Referências
- MITRE ATT&CK: [T1610](https://attack.mitre.org/techniques/T1610/), [T1611](https://attack.mitre.org/techniques/T1611/)
- Kubernetes official Audit Logging documentation

> 📌 Esta categoria está marcada como Quick-Reference. Para expandir para Full Playbook, use `Templates/Full-Playbook-Template.md`.
