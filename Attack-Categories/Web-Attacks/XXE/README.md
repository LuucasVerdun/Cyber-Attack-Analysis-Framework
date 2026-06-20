# XML External Entity (XXE)

> 🟡 Quick-Reference | Subcategoria de [Web-Attacks](../README.md)

## Descrição Técnica

**Definição:** Vulnerabilidade em parsers XML configurados para processar entidades externas, permitindo ao atacante incluir referências que levam à leitura de arquivos locais do servidor, SSRF, ou negação de serviço (billion laughs attack).

**Objetivo do atacante:** Leitura de arquivo arbitrário no servidor (incluindo arquivos de configuração com credenciais), SSRF como vetor secundário.

**Impacto esperado:** Confidencialidade (leitura de arquivo sensível), possível pivô para SSRF.

**Vetores de entrada:** Qualquer endpoint que aceite e processe XML (upload de arquivo, SOAP API, processamento de documento Office/SVG que internamente usa XML).

**IOCs típicos:**
- Payload contendo `<!DOCTYPE` com declaração `<!ENTITY` referenciando arquivo local (`file://`) ou URL externa
- Erros de parsing XML em log de aplicação correlacionados com payload suspeito

**TTPs (MITRE ATT&CK):**
| Tática | Técnica | ID |
|---|---|---|
| Initial Access | Exploit Public-Facing Application | T1190 |

---

## Fluxo de Investigação (resumido)

| Fase | Ação-chave |
|---|---|
| Identificação | WAF, erro de parsing XML em log de aplicação |
| Coleta | Payload XML completo enviado |
| Análise | Qual arquivo/recurso foi referenciado na entidade externa; se a leitura foi bem-sucedida |
| Contenção | Bloquear origem, desabilitar endpoint se crítico |
| Erradicação | Desabilitar resolução de entidades externas no parser XML (configuração padrão deve ser segura) |
| Recuperação | Validar se algum arquivo sensível foi exposto e rotacionar credenciais nele contidas |
| Pós-Incidente | Hardening de parser XML em toda a stack, SAST |

---

## Checklist Operacional

- [ ] Payload XXE completo capturado
- [ ] Arquivo/recurso alvo da entidade externa identificado
- [ ] Confirmado se a leitura foi bem-sucedida (resposta vazou conteúdo?)
- [ ] Se credencial foi exposta no arquivo lido: rotacionada
- [ ] Resolução de entidade externa desabilitada no parser

---

## Evidências Relevantes

| Ambiente | Fontes principais |
|---|---|
| Aplicação | Log de erro de parsing, request body completo |
| Sistema de arquivos | Confirmar quais arquivos locais poderiam ter sido lidos (configuração, secrets) |

---

## Ferramentas Recomendadas
WAF, Burp Suite (validação autorizada), revisão de configuração de parser (libxml2, etc.)

---

## Caso Real
Vulnerabilidades XXE são recorrentes em integrações que processam upload de documentos Office (`.docx`, `.xlsx` são arquivos ZIP contendo XML internamente) ou SVG sem desabilitar resolução de entidade externa — a maioria dos parsers XML modernos tem essa proteção disponível mas não habilitada por padrão em versões mais antigas, tornando upgrade de biblioteca uma mitigação tão importante quanto correção de código.

---

## Referências
- MITRE ATT&CK: [T1190](https://attack.mitre.org/techniques/T1190/)
- OWASP Top 10 — XML External Entities

> 📌 Para expandir para Full Playbook, use `Templates/Full-Playbook-Template.md`.
