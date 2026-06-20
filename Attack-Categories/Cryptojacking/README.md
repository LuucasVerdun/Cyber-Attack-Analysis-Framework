# Cryptojacking

> 🟡 Quick-Reference

## Descrição Técnica

**Definição:** Uso não autorizado de recursos computacionais da vítima (CPU/GPU) para mineração de criptomoeda em benefício do atacante — pode ocorrer em endpoints, servidores, containers/Kubernetes, ou diretamente via navegador (cryptojacking web/in-browser).

**Objetivo do atacante:** Monetização direta via mineração, sem necessidade de interação adicional após o comprometimento inicial — modelo de ataque "silencioso" e de baixa complexidade operacional comparado a ransomware/exfiltração.

**Impacto esperado:** Disponibilidade (degradação severa de performance), Financeiro (custo de energia/recursos cloud abusados — pode ser substancial em ambientes cloud com auto-scaling).

**Vetores de entrada:** Exploração de vulnerabilidade em serviço exposto (especialmente em Kubernetes/containers, ver `Kubernetes/`), credencial cloud vazada usada para provisionar instâncias de mineração, extensão de navegador maliciosa, malware genérico com módulo de mineração.

**IOCs típicos:**
- Uso de CPU/GPU constantemente próximo de 100% sem justificativa de carga de trabalho
- Conexão para pool de mineração conhecido (porta 3333/4444/etc., domínios de mining pool)
- Processo com nome mascarado de processo legítimo do sistema, consumindo recursos elevados
- Custo de billing cloud anômalo (instâncias de alto desempenho não provisionadas pela equipe)

**TTPs (MITRE ATT&CK):**
| Tática | Técnica | ID |
|---|---|---|
| Impact | Resource Hijacking | T1496 |
| Execution | Command and Scripting Interpreter | T1059 |

---

## Fluxo de Investigação (resumido)

| Fase | Ação-chave |
|---|---|
| Identificação | Alerta de performance/billing, EDR sinalizando minerador conhecido |
| Coleta | Processo/binário do minerador, configuração (pool, wallet), logs de provisionamento (se cloud) |
| Análise | Vetor de acesso inicial, escopo (quantos hosts/instâncias afetados) |
| Contenção | Matar processo, isolar host, deletar instâncias não autorizadas (cloud) |
| Erradicação | Remover binário e persistência, corrigir vetor de acesso (patch, credencial) |
| Recuperação | Validar performance normal restaurada |
| Pós-Incidente | Monitoramento de billing/uso de recursos, hardening do vetor de entrada |

---

## Checklist Operacional

- [ ] Processo/binário de mineração identificado e analisado
- [ ] Pool de mineração e wallet associados extraídos (úteis para correlação com outros incidentes)
- [ ] Escopo completo determinado (todos os hosts/instâncias afetados)
- [ ] Vetor de acesso inicial identificado e corrigido
- [ ] Instâncias cloud não autorizadas removidas
- [ ] Performance/billing validados como normalizados

---

## Evidências Relevantes

| Fonte | O que procurar |
|---|---|
| EDR/monitoramento de performance | Processo consumindo CPU/GPU constantemente |
| Sysmon (Windows) / auditd (Linux) | Execução do binário minerador, conexão de rede para pool |
| CloudTrail/Activity Logs | Criação de instância de alto desempenho não autorizada |

---

## Ferramentas Recomendadas
EDR, Sysmon + Sigma, ferramentas de monitoramento de billing cloud nativo

---

## Caso Real
Cryptojacking via credencial cloud vazada (chave AWS/GCP em repositório público) é um dos cenários de monetização mais rápidos observados em incidentes cloud — atacantes automatizados frequentemente provisionam instâncias de mineração de alto desempenho em múltiplas regiões simultaneamente, minutos após a exposição da credencial, antes que qualquer alerta de billing tradicional (que opera com atraso de horas) seja capaz de notificar a vítima.

---

## Referências
- MITRE ATT&CK: [T1496](https://attack.mitre.org/techniques/T1496/)

> 📌 Esta categoria está marcada como Quick-Reference. Para expandir para Full Playbook, use `Templates/Full-Playbook-Template.md`.
