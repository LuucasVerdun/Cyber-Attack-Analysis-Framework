# Remote Code Execution (RCE)

> 🟡 Quick-Reference | Subcategoria de [Web-Attacks](../README.md)

## Descrição Técnica

**Definição:** Classe de vulnerabilidade que permite ao atacante executar código/comando arbitrário no servidor que hospeda a aplicação — geralmente a vulnerabilidade web de maior impacto possível, pois concede execução direta, não apenas acesso a dados.

**Objetivo do atacante:** Controle completo do servidor afetado, ponto de entrada para todas as táticas subsequentes (persistência, movimento lateral, C2).

**Impacto esperado:** Máximo — Confidencialidade, Integridade e Disponibilidade simultaneamente comprometidas no host afetado.

**Vetores de entrada:** Deserialização insegura, upload de arquivo malicioso processado como código (ver `File-Upload/`), exploração de vulnerabilidade conhecida em framework/CMS (Log4Shell, Spring4Shell, vulnerabilidades de plugin WordPress), template injection (SSTI).

**IOCs típicos:**
- Webshell criado no servidor pós-exploração (ver `File-Upload/`)
- Processo filho anômalo do processo do servidor web (ex.: `w3wp.exe → cmd.exe`, `httpd → /bin/sh`)
- Payload de exploração conhecido em logs (ex.: string JNDI para Log4Shell)

**TTPs (MITRE ATT&CK):**
| Tática | Técnica | ID |
|---|---|---|
| Initial Access | Exploit Public-Facing Application | T1190 |
| Execution | Command and Scripting Interpreter | T1059 |

---

## Fluxo de Investigação (resumido)

| Fase | Ação-chave |
|---|---|
| Identificação | EDR no servidor (processo filho anômalo), WAF, alerta de vulnerabilidade conhecida (CVE) |
| Coleta | Request completo, processo filho gerado, qualquer webshell/payload dropado |
| Análise | CVE/vulnerabilidade explorada, comando executado, escopo pós-exploração |
| Contenção | Isolar servidor, bloquear origem, aplicar WAF rule virtual-patch |
| Erradicação | Aplicar patch oficial, remover webshell/payload, remover persistência |
| Recuperação | Validar integridade do servidor antes de retorno; considerar rebuild se RCE confirmado |
| Pós-Incidente | Patch management acelerado para CVEs críticos em ativos expostos, WAF tuning |

> ⚠️ RCE confirmado deve ser tratado com o mesmo rigor de qualquer comprometimento de host (ver `DFIR/README.md`) — não é "apenas" uma vulnerabilidade web, é potencialmente um host totalmente comprometido.

---

## Checklist Operacional

- [ ] CVE/técnica de exploração identificada
- [ ] Comando(s) executado(s) pelo atacante reconstruído(s)
- [ ] Webshell/payload dropado identificado e removido
- [ ] Verificado se houve movimento lateral a partir do servidor
- [ ] Patch oficial aplicado
- [ ] Servidor validado limpo (ou reconstruído) antes de retorno à operação

---

## Evidências Relevantes

| Ambiente | Fontes principais |
|---|---|
| Windows | Sysmon Event ID 1 (processo filho do servidor web), logs IIS |
| Linux | auditd, access log (Apache/Nginx), processo filho do servidor |
| Cloud | WAF logs, logs de aplicação gerenciada (App Service, Cloud Run, etc.) |

---

## Ferramentas Recomendadas
EDR, WAF, Velociraptor, Sysmon + Sigma para detecção de processo filho anômalo

---

## Caso Real
**Log4Shell (CVE-2021-44228):** vulnerabilidade crítica de RCE na biblioteca Log4j amplamente usada, explorável via simples string de log contendo lookup JNDI malicioso, afetando incontáveis aplicações Java em produção globalmente. **Aplicação:** a investigação exigiu varredura ampla de toda a stack (qualquer aplicação Java usando Log4j vulnerável, não apenas a aplicação onde o alerta original surgiu), reforçando a prática de tratar CVEs críticos em bibliotecas amplamente usadas como evento de varredura organizacional completa, não apenas remediação pontual.

---

## Referências
- MITRE ATT&CK: [T1190](https://attack.mitre.org/techniques/T1190/), [T1059](https://attack.mitre.org/techniques/T1059/)
- OWASP Top 10 — Injection / Vulnerable Components

> 📌 Para expandir para Full Playbook, use `Templates/Full-Playbook-Template.md`.
