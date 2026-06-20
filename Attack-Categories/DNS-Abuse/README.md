# DNS-Abuse

> 🟡 Quick-Reference

## Descrição Técnica

**Definição:** Abuso do protocolo DNS para fins maliciosos — incluindo DNS tunneling (exfiltração/C2 disfarçados em queries DNS), DGA (Domain Generation Algorithm) usado por malware para gerar domínios de C2 dinamicamente, DNS hijacking, e cache poisoning.

**Objetivo do atacante:** Estabelecer canal de C2/exfiltração que atravessa controles de rede tradicionais (DNS é quase sempre permitido por firewalls, mesmo em redes restritivas), ou redirecionar tráfego legítimo para infraestrutura maliciosa.

**Impacto esperado:** Habilita C2/exfiltração furtivos (Confidencialidade), ou redirecionamento de usuários para phishing/malware via DNS hijacking (Integridade).

**Vetores de entrada:**
- Malware com módulo de comunicação via DNS (tunneling)
- Comprometimento de registrador de domínio/conta de DNS da organização (hijacking)
- Malware com DGA para resiliência de C2 (gera centenas/milhares de domínios candidatos diariamente)

**IOCs típicos:**
- Subdomínios anormalmente longos/alta entropia em queries DNS
- Volume muito alto de queries TXT/NULL de um único host
- Domínio com padrão de geração algorítmica (sequência de caracteres aparentemente aleatória, alta taxa de domínios não resolvidos consultados em sequência — característico de DGA)
- Mudança não autorizada de registro DNS (NS, A, MX) no painel do registrador

**TTPs (MITRE ATT&CK):**
| Tática | Técnica | ID |
|---|---|---|
| Command and Control | Application Layer Protocol: DNS | T1071.004 |
| Command and Control | Dynamic Resolution: Domain Generation Algorithms | T1568.002 |

---

## Fluxo de Investigação (resumido)

| Fase | Ação-chave |
|---|---|
| Identificação | Regra de detecção de tunneling/DGA (ver `Detection-Rules/Suricata/c2_dns_tunneling_T1071.004.rules`) |
| Coleta | Logs de DNS completos do host/período |
| Análise | Padrão de query, volume, entropia, resolução |
| Contenção | Bloquear domínio/sinkhole, isolar host de origem |
| Erradicação | Remover malware/processo gerador das queries |
| Recuperação | Validar cessação do tráfego anômalo |
| Pós-Incidente | Monitoramento contínuo de entropia/volume de DNS por host |

---

## Checklist Operacional

- [ ] Padrão de abuso classificado (tunneling, DGA, hijacking)
- [ ] Volume e entropia de queries analisados
- [ ] Domínio(s) envolvido(s) verificado(s) contra TI feeds
- [ ] Host de origem identificado e isolado
- [ ] Domínio bloqueado/sinkholed
- [ ] Se hijacking: acesso ao painel do registrador investigado e protegido (MFA, lock de domínio)

---

## Evidências Relevantes

| Fonte | O que procurar |
|---|---|
| Logs de DNS (resolver interno) | Volume, tipo de query (TXT/NULL/A), entropia do subdomínio |
| Zeek `dns.log` | Metadados ricos de cada query/resposta |
| Painel do registrador de domínio | Histórico de mudança de registro (se hijacking suspeito) |

---

## Ferramentas Recomendadas
Zeek, RITA (detecção de DGA/beaconing), Suricata (ver regra de exemplo no repositório)

---

## Caso Real
DNS tunneling é consistentemente citado como técnica de C2/exfiltração usada por diversos frameworks (incluindo ferramentas legítimas de pentest abusadas, como `dnscat2`) precisamente porque DNS raramente é bloqueado integralmente em redes corporativas — a investigação deve sempre considerar essa técnica quando exfiltração é suspeita mas nenhum tráfego HTTP/HTTPS anômalo é encontrado.

---

## Referências
- MITRE ATT&CK: [T1071.004](https://attack.mitre.org/techniques/T1071/004/), [T1568.002](https://attack.mitre.org/techniques/T1568/002/)

> 📌 Esta categoria está marcada como Quick-Reference. Para expandir para Full Playbook, use `Templates/Full-Playbook-Template.md`.
