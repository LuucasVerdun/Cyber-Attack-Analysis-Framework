# Cross-Site Scripting (XSS)

> 🟡 Quick-Reference | Subcategoria de [Web-Attacks](../README.md)

## Descrição Técnica

**Definição:** Injeção de script malicioso (geralmente JavaScript) em uma página web visualizada por outros usuários, executando no contexto/sessão da vítima. Tipos: Reflected (payload no request, refletido na resposta), Stored (payload persistido no servidor, afeta todos que visualizam o conteúdo), DOM-based (manipulação client-side sem ida ao servidor).

**Objetivo do atacante:** Roubo de sessão/cookie, keylogging no navegador, redirecionamento para phishing, ações no contexto autenticado da vítima (CSRF-like).

**Impacto esperado:** Confidencialidade (roubo de sessão), possível escalonamento para comprometimento de conta.

**Vetores de entrada:** Campos de input refletidos sem encoding (comentários, busca, perfil de usuário), parâmetros de URL.

**IOCs típicos:**
- Tags `<script>`, `onerror=`, `javascript:` em campos de input armazenados
- Requisições com payload de XSS conhecido em logs de WAF
- Tráfego de exfiltração de cookie para domínio externo

**TTPs (MITRE ATT&CK):**
| Tática | Técnica | ID |
|---|---|---|
| Initial Access | Drive-by Compromise | T1189 |
| Initial Access | Exploit Public-Facing Application | T1190 |

---

## Fluxo de Investigação (resumido)

| Fase | Ação-chave |
|---|---|
| Identificação | WAF, relato de usuário, comportamento anômalo de página |
| Coleta | Payload armazenado/refletido, lista de usuários expostos (se stored) |
| Análise | Tipo de XSS, escopo de usuários afetados, dados exfiltrados |
| Contenção | Remover payload armazenado, invalidar sessões potencialmente roubadas |
| Erradicação | Implementar output encoding / Content Security Policy (CSP) |
| Recuperação | Validar correção, varrer outros campos pelo mesmo padrão |
| Pós-Incidente | CSP, SAST/DAST, sanitização padronizada de output |

---

## Checklist Operacional

- [ ] Tipo de XSS identificado (reflected/stored/DOM)
- [ ] Payload completo capturado
- [ ] Escopo de usuários afetados determinado (se stored)
- [ ] Sessões/cookies potencialmente roubados invalidados
- [ ] Output encoding implementado no campo vulnerável
- [ ] CSP avaliado para implementação

---

## Evidências Relevantes

| Ambiente | Fontes principais |
|---|---|
| Aplicação | Access log, conteúdo armazenado em banco (campos de comentário/perfil) |
| Cliente | Logs de navegador/EDR se houver exfiltração confirmada |
| Cloud | WAF logs |

---

## Ferramentas Recomendadas
WAF, Burp Suite (validação autorizada), navegador com DevTools para análise de payload

---

## Caso Real
Stored XSS em campos de comentário/perfil de usuário sem sanitização adequada é uma classe de vulnerabilidade recorrente em plataformas com conteúdo gerado por usuário — quando explorado em massa, pode ser usado como worm (auto-propagação via payload que se replica em perfis visitados), padrão historicamente observado em redes sociais.

---

## Referências
- MITRE ATT&CK: [T1189](https://attack.mitre.org/techniques/T1189/), [T1190](https://attack.mitre.org/techniques/T1190/)
- OWASP Top 10 — Cross-Site Scripting

> 📌 Para expandir para Full Playbook, use `Templates/Full-Playbook-Template.md`.
