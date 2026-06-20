# Server-Side Request Forgery (SSRF)

> 🟡 Quick-Reference | Subcategoria de [Web-Attacks](../README.md)

## Descrição Técnica

**Definição:** Vulnerabilidade que permite ao atacante induzir o servidor da aplicação a fazer requisições HTTP(S) para um destino de sua escolha — incluindo recursos internos não expostos diretamente à internet, como o Instance Metadata Service em ambientes cloud.

**Objetivo do atacante:** Acesso a recursos internos (rede interna, serviços não expostos), e — criticamente em ambientes cloud — roubo de credenciais temporárias via Instance Metadata Service (ver `Cloud-Intrusion/`).

**Impacto esperado:** Confidencialidade (acesso a serviço interno/credenciais), possível escalonamento para comprometimento de conta cloud completa.

**Vetores de entrada:** Funcionalidades que fazem requisição a URL fornecida pelo usuário (webhooks, geração de PDF a partir de URL, importação de imagem por URL, integrações).

**IOCs típicos:**
- Parâmetro de URL apontando para `169.254.169.254`, `localhost`, `127.0.0.1`, ou range de IP interno
- Requisição da aplicação para destino interno fora do padrão normal de uso

**TTPs (MITRE ATT&CK):**
| Tática | Técnica | ID |
|---|---|---|
| Initial Access | Exploit Public-Facing Application | T1190 |
| Credential Access | Unsecured Credentials: Cloud Instance Metadata API | T1552.005 |

---

## Fluxo de Investigação (resumido)

| Fase | Ação-chave |
|---|---|
| Identificação | WAF, log de aplicação mostrando requisição a destino interno suspeito |
| Coleta | Payload/parâmetro completo, logs de requisição da aplicação para o destino interno |
| Análise | Qual recurso interno foi acessado; se credenciais cloud foram expostas |
| Contenção | Bloquear o padrão de payload, restringir saída de rede da aplicação (egress filtering) |
| Erradicação | Validar/whitelist de destinos permitidos na funcionalidade vulnerável |
| Recuperação | Se IMDS foi acessado: rotacionar credenciais da role/instância imediatamente |
| Pós-Incidente | IMDSv2 obrigatório (AWS), segmentação de rede, validação de URL allowlist |

---

## Checklist Operacional

- [ ] Destino interno acessado via SSRF identificado
- [ ] Verificado se Instance Metadata Service foi alvo
- [ ] Se IMDS acessado: credenciais da instância/role rotacionadas (ver `Cloud-Intrusion/`)
- [ ] Egress filtering/allowlist implementado na funcionalidade vulnerável
- [ ] Outros endpoints com funcionalidade similar (fetch de URL) varridos

---

## Evidências Relevantes

| Ambiente | Fontes principais |
|---|---|
| Aplicação | Log de requisições outbound da aplicação |
| Cloud | Logs de acesso ao IMDS (se disponível), CloudTrail (uso de credencial obtida) |

---

## Ferramentas Recomendadas
WAF, Burp Suite (validação autorizada), análise de logs de egress da aplicação

---

## Caso Real
SSRF explorando o Instance Metadata Service é um padrão recorrente em incidentes de comprometimento de ambiente cloud documentados publicamente — uma vulnerabilidade de SSRF aparentemente de baixo impacto em uma aplicação web torna-se crítica quando hospedada em instância com role IAM privilegiada anexada. Ver detalhamento em [`Cloud-Intrusion/README.md`](../../Cloud-Intrusion/README.md), seção "Casos Reais".

---

## Referências
- MITRE ATT&CK: [T1190](https://attack.mitre.org/techniques/T1190/), [T1552.005](https://attack.mitre.org/techniques/T1552/005/)
- OWASP Top 10 — Server-Side Request Forgery

> 📌 Para expandir para Full Playbook, use `Templates/Full-Playbook-Template.md`.
