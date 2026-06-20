# Command Injection

> 🟡 Quick-Reference | Subcategoria de [Web-Attacks](../README.md)

## Descrição Técnica

**Definição:** Vulnerabilidade que permite ao atacante injetar e executar comandos arbitrários do sistema operacional através de input não sanitizado passado a uma chamada de sistema (`system()`, `exec()`, `subprocess`, etc.) pela aplicação.

**Objetivo do atacante:** Execução de comando no SO subjacente — equivalente em impacto a RCE.

**Impacto esperado:** Máximo — Confidencialidade, Integridade e Disponibilidade do host comprometidas.

**Vetores de entrada:** Funcionalidades que invocam comandos de sistema com parâmetro de usuário (ex.: ferramenta de ping/traceroute embutida em painel admin, processamento de arquivo via chamada a binário externo).

**IOCs típicos:**
- Operadores de encadeamento de comando no input (`;`, `|`, `&&`, `` ` ``, `$()`)
- Processo filho do servidor web executando shell/binário do sistema (`sh`, `bash`, `cmd.exe`)
- Comandos de reconhecimento (`whoami`, `id`, `uname -a`) nos primeiros segundos pós-exploração

**TTPs (MITRE ATT&CK):**
| Tática | Técnica | ID |
|---|---|---|
| Initial Access | Exploit Public-Facing Application | T1190 |
| Execution | Command and Scripting Interpreter | T1059 |

---

## Fluxo de Investigação (resumido)

| Fase | Ação-chave |
|---|---|
| Identificação | EDR (processo filho do servidor web), WAF, log de aplicação |
| Coleta | Payload completo, comando(s) executado(s), processo filho gerado |
| Análise | Comandos executados, escopo de acesso obtido, persistência estabelecida |
| Contenção | Isolar servidor, bloquear origem |
| Erradicação | Corrigir código (evitar chamada direta a shell; usar APIs nativas em vez de invocar binário externo) |
| Recuperação | Validar integridade do servidor; considerar rebuild |
| Pós-Incidente | Princípio de least privilege para o processo da aplicação, WAF tuning |

---

## Checklist Operacional

- [ ] Payload de injeção capturado
- [ ] Comandos executados pelo atacante reconstruídos via processo filho
- [ ] Persistência estabelecida pós-exploração identificada
- [ ] Código corrigido (eliminar concatenação de comando shell)
- [ ] Servidor validado limpo antes de retorno à operação

---

## Evidências Relevantes

| Ambiente | Fontes principais |
|---|---|
| Windows | Sysmon Event ID 1 (processo filho do `w3wp.exe`/`httpd`), IIS logs |
| Linux | auditd (`execve`), access log, processo filho do servidor web |

---

## Ferramentas Recomendadas
EDR, Sysmon + Sigma (detecção de processo filho anômalo do servidor web), WAF

---

## Caso Real
Command Injection é frequentemente encontrada em painéis administrativos de dispositivos de rede/IoT e em funcionalidades legadas que invocam ferramentas de diagnóstico de sistema (ping, traceroute, nslookup) sem sanitização — um padrão recorrente em CVEs públicos de appliances de rede e dispositivos embarcados, onde a investigação deve sempre verificar se o dispositivo comprometido foi usado como ponto de pivô para a rede interna.

---

## Referências
- MITRE ATT&CK: [T1190](https://attack.mitre.org/techniques/T1190/), [T1059](https://attack.mitre.org/techniques/T1059/)
- OWASP — Command Injection

> 📌 Para expandir para Full Playbook, use `Templates/Full-Playbook-Template.md`.
