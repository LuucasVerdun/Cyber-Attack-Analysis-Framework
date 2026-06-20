# API-Attacks

> 🟡 Quick-Reference

## Descrição Técnica

**Definição:** Ataques direcionados especificamente a APIs (REST, GraphQL, SOAP) — abrangendo desde falhas de autorização a nível de objeto (BOLA/IDOR) até abuso de rate limiting e exposição excessiva de dados, conforme catalogado no OWASP API Security Top 10.

**Objetivo do atacante:** Acesso não autorizado a dados de outros usuários/tenants (em aplicações multi-tenant), abuso de lógica de negócio, exfiltração em massa via enumeração de endpoint.

**Impacto esperado:** Confidencialidade (exposição de dados de múltiplos usuários via falha de autorização), Integridade (modificação de dado de outro usuário).

**Vetores de entrada:**
- Broken Object Level Authorization (BOLA/IDOR) — endpoint não valida se o objeto solicitado pertence ao usuário autenticado
- Excessive Data Exposure — API retorna mais campos do que o necessário, expostos por debug/inspeção do tráfego
- Falta de rate limiting permitindo enumeração/scraping em massa
- Mass Assignment — API aceita campos não pretendidos no payload (ex.: `"role": "admin"` em update de perfil)

**IOCs típicos:**
- Sequência de requisições com ID incremental (`/api/users/1`, `/api/users/2`, ...) — enumeração
- Volume de requisições muito acima do padrão de uso humano normal de um único token/usuário
- Resposta de API contendo campos sensíveis não exibidos na UI (indício de excessive data exposure sendo explorado)

**TTPs (MITRE ATT&CK):**
| Tática | Técnica | ID |
|---|---|---|
| Initial Access | Exploit Public-Facing Application | T1190 |
| Credential Access | Modify Authentication Process | T1556 |

---

## Fluxo de Investigação (resumido)

| Fase | Ação-chave |
|---|---|
| Identificação | API Gateway/WAF, volume anômalo de requisições, relato de exposição de dado |
| Coleta | Logs completos de requisição/resposta da API no período |
| Análise | Tipo de falha (BOLA, mass assignment, etc.), escopo de dados/usuários afetados |
| Contenção | Rate limiting de emergência, revogação de token/API key do atacante |
| Erradicação | Corrigir validação de autorização a nível de objeto |
| Recuperação | Notificar usuários cujos dados foram expostos, se aplicável |
| Pós-Incidente | API security testing (DAST específico para API), schema validation |

---

## Checklist Operacional

- [ ] Tipo de falha de API identificado (BOLA, mass assignment, rate limit, etc.)
- [ ] Escopo de objetos/usuários acessados indevidamente determinado
- [ ] Token/API key do atacante revogado
- [ ] Validação de autorização corrigida no endpoint
- [ ] Avaliação de notificação a usuários afetados realizada

---

## Evidências Relevantes

| Fonte | O que procurar |
|---|---|
| API Gateway logs | Toda requisição com parâmetros completos, token usado |
| WAF | Padrões de enumeração/scraping bloqueados ou permitidos |
| Application logs | Erros de autorização, exceções |

---

## Ferramentas Recomendadas
API Gateway com logging completo, Burp Suite (validação autorizada), OWASP ZAP

---

## Caso Real
Falhas de BOLA (Broken Object Level Authorization) são consistentemente classificadas pelo OWASP API Security Top 10 como a vulnerabilidade de API mais prevalente, frequentemente explorada simplesmente incrementando um ID numérico na URL de uma requisição autenticada legítima — sem necessidade de ferramentas sofisticadas, tornando essa classe de falha acessível mesmo a atacantes pouco sofisticados quando presente.

---

## Referências
- MITRE ATT&CK: [T1190](https://attack.mitre.org/techniques/T1190/)
- OWASP API Security Top 10

> 📌 Esta categoria está marcada como Quick-Reference. Para expandir para Full Playbook, use `Templates/Full-Playbook-Template.md`.
