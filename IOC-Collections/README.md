# IOC Collections

Repositório de indicadores de comprometimento (IOCs) organizados por incidente e por categoria, gerados a partir de `Templates/IOC-Tracking-Template.md` preenchidos durante investigações reais.

## Estrutura Recomendada

```
IOC-Collections/
├── <Categoria>/
│   ├── <ID-do-incidente>.csv
│   └── <ID-do-incidente>.md      ← contexto do IOC, se necessário
└── Feeds-Externos/                ← IOCs importados de TI feeds (MISP, OSINT, vendor reports)
```

## Formato Padrão (CSV)

```csv
ioc_type,value,context,first_seen,confidence,status,source
sha256,<hash>,"Payload inicial - phishing attachment",2026-06-19T14:32:00Z,high,blocked,internal_analysis
domain,evil-c2[.]example,"C2 callback domain",2026-06-19T15:10:00Z,high,blocked,internal_analysis
```

> Use notação `[.]` ao documentar domínios/IPs maliciosos em texto corrido (Markdown) para evitar clique acidental e ativação de defanging automático de ferramentas de e-mail/chat. **No CSV/dados estruturados, usar o valor real sem defang**, já que será ingerido por ferramentas de bloqueio automatizado.

## Política de Compartilhamento (TLP)

| Nível TLP | Uso |
|---|---|
| TLP:RED | Não compartilhar fora do time de IR direto |
| TLP:AMBER | Compartilhável internamente com necessidade de saber |
| TLP:GREEN | Compartilhável com comunidade de confiança (ISAC, parceiros) |
| TLP:CLEAR | Compartilhável publicamente |

Classifique cada arquivo de IOC com o nível apropriado antes de qualquer compartilhamento externo (MISP, ISAC, threat intel sharing).

## Ciclo de Vida do IOC

1. **Extração** durante investigação (via `Templates/IOC-Tracking-Template.md`)
2. **Enriquecimento** (VirusTotal, MISP, vendor TI) — confirmar contexto e confiança
3. **Distribuição** para controles (EDR, firewall, proxy, e-mail gateway, SIEM watchlist)
4. **Arquivamento** aqui, com metadado de incidente associado
5. **Expiração/revisão** — IOCs de infraestrutura (IP/domínio) têm vida útil curta; revisar periodicamente e marcar como obsoletos

## Referência Cruzada
- Template de origem: [`Templates/IOC-Tracking-Template.md`](../Templates/IOC-Tracking-Template.md)
- Programa de Threat Intel: [`Threat-Intel/`](../Threat-Intel/)
