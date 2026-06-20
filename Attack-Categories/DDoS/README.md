# DDoS (Distributed Denial of Service)

> 🟡 Quick-Reference

## Descrição Técnica

**Definição:** Ataque que visa tornar um serviço indisponível sobrecarregando-o com tráfego/requisições, geralmente originado de múltiplas fontes distribuídas (botnet) simultaneamente.

**Objetivo do atacante:** Indisponibilidade do serviço-alvo — motivações variam de extorsão (pagamento para cessar o ataque), hacktivismo, cortina de fumaça para outro ataque simultâneo, a disputa comercial/pessoal.

**Impacto esperado:** Disponibilidade — impacto direto e mensurável em receita/operação durante a janela do ataque.

**Vetores de entrada:** Tráfego de rede em volume (volumetric — UDP flood, amplification), exaustão de protocolo (SYN flood), ou camada de aplicação (HTTP flood mimetizando tráfego legítimo).

**IOCs típicos:**
- Volume de tráfego muito acima do baseline normal, de múltiplas origens geograficamente dispersas
- Padrão de amplificação (DNS/NTP/Memcached reflection) — pacotes de resposta muito maiores que a requisição original
- Picos de requisição HTTP de User-Agents idênticos/genéricos em alto volume

**TTPs (MITRE ATT&CK):**
| Tática | Técnica | ID |
|---|---|---|
| Impact | Network Denial of Service | T1498 |
| Impact | Endpoint Denial of Service | T1499 |

---

## Fluxo de Investigação (resumido)

| Fase | Ação-chave |
|---|---|
| Identificação | Monitoramento de disponibilidade, alerta de volume de tráfego do provedor/CDN |
| Coleta | NetFlow do período, logs de mitigação do provedor (Cloudflare, AWS Shield, etc.) |
| Análise | Tipo de ataque (volumétrico/protocolo/aplicação), origem, se é cortina de fumaça |
| Contenção | Ativar mitigação (scrubbing center, rate limiting, blackhole de último recurso) |
| Erradicação | N/A — ataque cessa quando o atacante para ou mitigação é eficaz |
| Recuperação | Validar restauração de disponibilidade normal |
| Pós-Incidente | Revisão de capacidade de mitigação, contrato com provedor anti-DDoS |

> ⚠️ DDoS é frequentemente usado como **cortina de fumaça** — sempre verificar se houve atividade maliciosa adicional (intrusão, exfiltração) ocorrendo simultaneamente, aproveitando a atenção da equipe estar voltada para o ataque de disponibilidade.

---

## Checklist Operacional

- [ ] Tipo de DDoS classificado (volumétrico/protocolo/aplicação)
- [ ] Mitigação ativada (provedor/CDN/scrubbing)
- [ ] Verificado se há atividade maliciosa concorrente (cortina de fumaça)
- [ ] Disponibilidade normal restaurada e validada
- [ ] Capacidade de mitigação revisada pós-evento

---

## Evidências Relevantes

| Fonte | O que procurar |
|---|---|
| NetFlow / provedor de mitigação | Volume, origem, tipo de tráfego |
| Logs de aplicação/CDN | Padrão de requisição em camada 7, se aplicável |
| Logs internos durante a janela do ataque | Qualquer atividade anômala concorrente (cortina de fumaça) |

---

## Ferramentas Recomendadas
Serviços de mitigação (Cloudflare, AWS Shield, Akamai), NetFlow/sFlow analysis

---

## Caso Real
Ataques DDoS volumétricos via reflection/amplification (DNS, NTP, Memcached) continuam entre os vetores de maior volume registrado globalmente, frequentemente explorados por botnets compostas por dispositivos IoT mal protegidos (ver `Botnets/`) — a investigação pós-evento deve sempre avaliar se o incidente coincidiu com qualquer outra atividade suspeita na rede, dado o padrão documentado de uso de DDoS como distração.

---

## Referências
- MITRE ATT&CK: [T1498](https://attack.mitre.org/techniques/T1498/), [T1499](https://attack.mitre.org/techniques/T1499/)

> 📌 Esta categoria está marcada como Quick-Reference. Para expandir para Full Playbook, use `Templates/Full-Playbook-Template.md`.
