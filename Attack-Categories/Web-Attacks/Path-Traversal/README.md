# Path Traversal

> 🟡 Quick-Reference | Subcategoria de [Web-Attacks](../README.md)

## Descrição Técnica

**Definição:** Vulnerabilidade que permite ao atacante acessar arquivos/diretórios fora do escopo pretendido pela aplicação, manipulando referências de caminho de arquivo (ex.: `../../../etc/passwd`).

**Objetivo do atacante:** Leitura (e em alguns casos escrita) de arquivo arbitrário no sistema de arquivos do servidor — credenciais de configuração, código-fonte, dados de outros usuários.

**Impacto esperado:** Confidencialidade (leitura de arquivo sensível), possível escalonamento se arquivo de configuração com credencial for exposto.

**Vetores de entrada:** Parâmetros de download/visualização de arquivo (`?file=relatorio.pdf`), funcionalidades de template/include dinâmico.

**IOCs típicos:**
- Sequências `../`, `..\\`, ou variantes codificadas (`%2e%2e%2f`) em parâmetros de URL
- Tentativa de acesso a arquivos sensíveis conhecidos (`/etc/passwd`, `web.config`, `.env`)

**TTPs (MITRE ATT&CK):**
| Tática | Técnica | ID |
|---|---|---|
| Initial Access | Exploit Public-Facing Application | T1190 |

---

## Fluxo de Investigação (resumido)

| Fase | Ação-chave |
|---|---|
| Identificação | WAF, log de aplicação com padrão de traversal |
| Coleta | Payload completo, resposta retornada (confirmar se leitura foi bem-sucedida) |
| Análise | Quais arquivos foram acessados, se contêm dado sensível |
| Contenção | Bloquear padrão no WAF |
| Erradicação | Sanitizar/validar input de caminho, usar allowlist de arquivos permitidos |
| Recuperação | Rotacionar qualquer credencial exposta em arquivo lido |
| Pós-Incidente | Hardening de validação de path, princípio de least privilege no filesystem |

---

## Checklist Operacional

- [ ] Payload de traversal capturado
- [ ] Confirmado se a leitura foi bem-sucedida e qual(is) arquivo(s) foram acessados
- [ ] Credenciais expostas (se houver) rotacionadas
- [ ] Validação de path implementada (allowlist, não apenas blocklist de `../`)

---

## Evidências Relevantes

| Ambiente | Fontes principais |
|---|---|
| Aplicação | Access log com parâmetro completo, resposta HTTP |
| Sistema de arquivos | Confirmar quais arquivos eram acessíveis pelo processo da aplicação |

---

## Ferramentas Recomendadas
WAF, Burp Suite (validação autorizada)

---

## Caso Real
Path Traversal continua sendo uma vulnerabilidade recorrente em funcionalidades de "download de arquivo" implementadas sem validação adequada — frequentemente combinada com Local File Inclusion (LFI) para escalonamento a RCE quando o atacante consegue incluir um arquivo de log que ele mesmo "envenenou" previamente (log poisoning).

---

## Referências
- MITRE ATT&CK: [T1190](https://attack.mitre.org/techniques/T1190/)
- OWASP — Path Traversal

> 📌 Para expandir para Full Playbook, use `Templates/Full-Playbook-Template.md`.
