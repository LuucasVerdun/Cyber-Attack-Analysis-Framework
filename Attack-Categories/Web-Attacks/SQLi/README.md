# SQL Injection (SQLi)

> 🟡 Quick-Reference | Subcategoria de [Web-Attacks](../README.md)

## Descrição Técnica

**Definição:** Injeção de comandos SQL através de campos de entrada não sanitizados, permitindo ao atacante manipular a query executada pela aplicação contra o banco de dados.

**Objetivo do atacante:** Extração de dados (incluindo credenciais), bypass de autenticação, escrita de arquivo (em alguns SGBDs), ou execução de comando no SO subjacente (ex.: `xp_cmdshell` no MSSQL).

**Impacto esperado:** Confidencialidade (dump de banco), Integridade (UPDATE/DELETE não autorizado).

**Vetores de entrada:** Formulários web, parâmetros de URL, headers HTTP, APIs que constroem query SQL via concatenação de string não parametrizada.

**IOCs típicos:**
- Padrões de payload: `' OR '1'='1`, `UNION SELECT`, `; DROP TABLE`, comentários SQL (`--`, `/*`)
- Erros de sintaxe SQL retornados pela aplicação (indício de SQLi exploratório/error-based)
- Tempo de resposta anômalo (indício de blind SQLi time-based)

**TTPs (MITRE ATT&CK):**
| Tática | Técnica | ID |
|---|---|---|
| Initial Access | Exploit Public-Facing Application | T1190 |

---

## Fluxo de Investigação (resumido)

| Fase | Ação-chave |
|---|---|
| Identificação | Regra de WAF, erro de SQL em log de aplicação |
| Coleta | Request completo (incluindo payload), logs de query do banco |
| Análise | Tipo de SQLi (union-based, error-based, blind, time-based), dados acessados |
| Contenção | Bloquear origem no WAF, desabilitar endpoint vulnerável se crítico |
| Erradicação | Corrigir código (queries parametrizadas/prepared statements) |
| Recuperação | Validar correção, varrer outros endpoints pelo mesmo padrão de vulnerabilidade |
| Pós-Incidente | SAST/DAST no pipeline de CI/CD, treinamento de desenvolvimento seguro |

---

## Checklist Operacional

- [ ] Payload completo capturado e analisado
- [ ] Tipo de SQLi identificado
- [ ] Escopo de dados acessados determinado (verificar logs do banco/aplicação)
- [ ] Endpoint corrigido com prepared statements
- [ ] Outros endpoints similares varridos pela mesma classe de vulnerabilidade

---

## Evidências Relevantes

| Ambiente | Fontes principais |
|---|---|
| Aplicação | Access log do servidor web, application log (stack trace) |
| Banco de dados | Query log (se habilitado), audit log |
| Cloud | WAF logs (AWS WAF, Cloudflare, Azure Front Door) |

---

## Ferramentas Recomendadas
WAF, SIEM, Burp Suite (validação autorizada)

---

## Caso Real
SQLi permanece uma das classes de vulnerabilidade mais exploradas em aplicações web legadas/mal mantidas, frequentemente usada como vetor de acesso inicial em violações de dados em larga escala documentadas publicamente ao longo dos anos — a causa raiz quase sempre é construção de query via concatenação de string em vez de parametrização.

---

## Referências
- MITRE ATT&CK: [T1190](https://attack.mitre.org/techniques/T1190/)
- OWASP Top 10 — Injection

> 📌 Para expandir para Full Playbook, use `Templates/Full-Playbook-Template.md`.
