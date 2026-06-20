# IOC Tracking — IR-[AAAA]-[NNNN]

> Formato compatível com exportação para CSV/STIX para ingestão em SIEM/TIP/EDR.

## Indicadores

| ID | Tipo | Valor | Contexto | Primeira observação (UTC) | Confiança | Status do bloqueio | Fonte |
|---|---|---|---|---|---|---|---|
| IOC-001 | Hash SHA256 | | | | Alta/Média/Baixa | Bloqueado/Pendente | Análise interna / TI feed |
| IOC-002 | Domínio | | | | | | |
| IOC-003 | IP | | | | | | |
| IOC-004 | URL | | | | | | |
| IOC-005 | E-mail (remetente) | | | | | | |
| IOC-006 | Caminho de arquivo | | | | | | |
| IOC-007 | Chave de registro | | | | | | |
| IOC-008 | Nome de mutex | | | | | | |
| IOC-009 | User-Agent | | | | | | |
| IOC-010 | Certificado (thumbprint) | | | | | | |

---

## Tipos de Indicador — Referência

| Categoria | Exemplos de tipo |
|---|---|
| Arquivo | SHA256, SHA1, MD5, nome de arquivo, tamanho, imphash |
| Rede | IP, domínio, URL, User-Agent, JA3/JA3S, certificado TLS |
| Host | Chave de registro, caminho, mutex, nome de serviço, named pipe |
| E-mail | Remetente, assunto, header `Message-ID`, hash de anexo |
| Identidade | Conta comprometida, SPN (Kerberoasting), Client ID (cloud) |

---

## Distribuição / Bloqueio

| IOC | Plataforma de bloqueio | Data do bloqueio | Responsável |
|---|---|---|---|
| | EDR / Firewall / Proxy / E-mail Gateway / SIEM watchlist | | |

---

## Enriquecimento (Threat Intel)

| IOC | Associado a (ator/campanha/malware) | Fonte de enriquecimento | Link/referência |
|---|---|---|---|
| | | VirusTotal / MISP / vendor TI / OSINT | |

> Ao fechar o incidente, exportar esta tabela para `IOC-Collections/<categoria>/<id-do-incidente>.csv` e, se aplicável, compartilhar com a comunidade (ISAC, MISP) respeitando políticas de TLP.
