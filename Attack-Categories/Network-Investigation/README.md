# Network-Investigation

> 🟡 Quick-Reference — Metodologia

## Descrição Técnica

**Definição:** Procedimento genérico de investigação network-based, aplicável como ponto de partida quando a primeira evidência de um incidente vem de uma fonte de rede (NetFlow, proxy, firewall, IDS/IPS) em vez de um host específico.

**Quando usar:** Como primeiro passo de qualquer investigação que começa com "tráfego suspeito foi observado", antes de saber qual host/categoria específica está envolvida.

---

## Triagem Inicial de Rede (primeiros passos)

```mermaid
flowchart TD
    A[Alerta de rede<br/>IDS/Proxy/Firewall] --> B[Identificar host(s)<br/>interno(s)<br/>envolvido(s)]
    B --> C[Classificar tipo de<br/>tráfego suspeito]
    C --> D{Tipo identificado?}
    D -->|C2/Beaconing| E[Direcionar para C2/]
    D -->|Exfiltração| F[Direcionar para<br/>Data-Exfiltration/]
    D -->|Movimento Lateral| G[Direcionar para<br/>Lateral-Movement/]
    D -->|DDoS/Volume| H[Direcionar para DDoS/]
    D -->|Não claro| I[Triagem ampliada -<br/>ver checklist abaixo]
```

## Checklist de Triagem Rápida

| Pergunta | Onde verificar |
|---|---|
| O tráfego é periódico (beaconing)? | NetFlow/Zeek, ferramenta de detecção (RITA) |
| Há volume anômalo de saída (possível exfiltração)? | NetFlow, proxy |
| Há comunicação entre hosts internos não usual (lateral movement)? | NetFlow interno, logs de firewall interno |
| Destino está em TI feed conhecido? | Lookup contra `IOC-Collections/` e feeds externos |
| Protocolo/porta é consistente com a aplicação esperada? | Zeek `conn.log` (serviço identificado vs. porta usada) |

---

## Checklist Operacional

- [ ] Host(s) interno(s) envolvido(s) identificado(s)
- [ ] Tipo de tráfego classificado
- [ ] Destino verificado contra TI feeds/IOC conhecidos
- [ ] Categoria de ataque específica determinada
- [ ] Investigação direcionada ao playbook correspondente
- [ ] Captura de PCAP iniciada se ainda não disponível e investigação continuada

---

## Evidências Relevantes (referência rápida)

| Fonte | Granularidade | Uso |
|---|---|---|
| NetFlow/IPFIX | Metadados de fluxo | Hunting retroativo, baixo custo de storage |
| Zeek logs | Metadados ricos por protocolo | Investigação sem custo de full PCAP |
| Full PCAP | Payload completo | Extração de objeto/sessão quando disponível |
| Logs de proxy/firewall | URL, ação, categoria | Investigação de acesso web |

---

## Ferramentas Recomendadas
Wireshark, Zeek, Suricata, Arkime, RITA

---

## Referência Cruzada
- Metodologia completa de forense de rede: [`Network-Forensics/README.md`](../../Network-Forensics/README.md)
- A partir daqui, direcionar para a categoria específica identificada (C2, Data-Exfiltration, Lateral-Movement, DDoS, etc.)

> 📌 Esta categoria está marcada como Quick-Reference. Para expandir para Full Playbook, use `Templates/Full-Playbook-Template.md`.
