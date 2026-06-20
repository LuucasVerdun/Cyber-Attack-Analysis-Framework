# Botnets

> 🟡 Quick-Reference

## Descrição Técnica

**Definição:** Investigação relacionada a hosts/dispositivos do ambiente que fazem parte de — ou foram recrutados para — uma rede de bots controlada remotamente por um operador (botmaster), tipicamente usada para DDoS, spam, fraude de clique, ou como infraestrutura de proxy para outros ataques.

**Objetivo do atacante:** Recrutar dispositivos (servidores, IoT, estações de trabalho) para uma rede de bots monetizável (aluguel de DDoS-as-a-Service, spam-as-a-Service, proxy residencial).

**Impacto esperado:** Disponibilidade (recurso do host consumido), Reputacional (IP da organização usado para atacar terceiros, podendo gerar blacklisting), risco de uso do host como pivô para ataques adicionais.

**Vetores de entrada:** Exploração de vulnerabilidade conhecida não corrigida (especialmente em dispositivos IoT/embarcados com patch raro), credenciais padrão não alteradas, malware genérico com módulo de recrutamento de botnet.

**IOCs típicos:**
- Comunicação periódica para infraestrutura de C2 de botnet conhecida (ver também `C2/`)
- Tráfego de saída em padrão de DDoS/spam não relacionado à função do host
- Dispositivo IoT/embarcado com tráfego de rede muito acima do esperado para sua função

**TTPs (MITRE ATT&CK):**
| Tática | Técnica | ID |
|---|---|---|
| Resource Development | Acquire Infrastructure: Botnet | T1583.005 |
| Command and Control | Application Layer Protocol | T1071 |
| Impact | Network Denial of Service | T1498 |

---

## Fluxo de Investigação (resumido)

| Fase | Ação-chave |
|---|---|
| Identificação | TI feed de infraestrutura de botnet conhecida, tráfego anômalo de dispositivo IoT |
| Coleta | NetFlow/Zeek, identificação do malware/processo recrutador |
| Análise | Família de botnet, escopo de dispositivos afetados no ambiente |
| Contenção | Isolar dispositivo(s), bloquear C2 da botnet |
| Erradicação | Remover malware, aplicar patch, alterar credencial padrão |
| Recuperação | Validar ausência de reinfecção |
| Pós-Incidente | Inventário/patch de dispositivos IoT, segmentação de rede para IoT |

---

## Checklist Operacional

- [ ] Família de botnet identificada (se possível, via TI)
- [ ] Todos os dispositivos comprometidos no ambiente identificados (não apenas o primeiro)
- [ ] C2 da botnet bloqueado
- [ ] Malware removido / dispositivo reconfigurado com credencial forte
- [ ] Patch aplicado se vetor foi vulnerabilidade conhecida
- [ ] Segmentação de rede para dispositivos IoT avaliada

---

## Evidências Relevantes

| Fonte | O que procurar |
|---|---|
| NetFlow / Zeek | Padrão de comunicação com C2 de botnet, volume de tráfego de saída anômalo |
| Logs do dispositivo (se disponível) | Processo/serviço malicioso em execução |
| TI feeds | Correlação de IP/domínio com infraestrutura de botnet conhecida |

---

## Ferramentas Recomendadas
Zeek, RITA, TI feeds (Spamhaus, abuse.ch), scanners de vulnerabilidade IoT

---

## Caso Real
Botnets compostas por dispositivos IoT com credenciais padrão não alteradas (câmeras, roteadores, DVRs) — no estilo Mirai e suas inúmeras variantes — continuam sendo recrutadas em massa para campanhas de DDoS volumétrico, devido ao volume de dispositivos vulneráveis expostos à internet com configuração de fábrica inalterada. **Aplicação:** a investigação de qualquer dispositivo IoT corporativo com tráfego anômalo deve verificar imediatamente se a credencial padrão de fábrica ainda está em uso, antes de assumir vetor de exploração mais sofisticado.

---

## Referências
- MITRE ATT&CK: [T1583.005](https://attack.mitre.org/techniques/T1583/005/), [T1498](https://attack.mitre.org/techniques/T1498/)

> 📌 Esta categoria está marcada como Quick-Reference. Para expandir para Full Playbook, use `Templates/Full-Playbook-Template.md`.
