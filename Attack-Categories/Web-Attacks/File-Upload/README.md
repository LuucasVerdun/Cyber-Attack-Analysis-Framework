# File-Upload (Vulnerabilidades de Upload de Arquivo)

> 🟡 Quick-Reference | Subcategoria de [Web-Attacks](../README.md)

## Descrição Técnica

**Definição:** Vulnerabilidade na validação de funcionalidades de upload de arquivo, permitindo ao atacante enviar um arquivo malicioso (tipicamente um **webshell**) que é então executável pelo servidor, concedendo execução remota de código persistente.

**Objetivo do atacante:** Estabelecer webshell para execução de comando persistente e de fácil reacesso no servidor comprometido.

**Impacto esperado:** Máximo — equivalente a RCE persistente, frequentemente usado como mecanismo de persistência de longo prazo.

**Vetores de entrada:** Funcionalidades de upload (avatar, anexo, documento) sem validação de tipo de conteúdo real (apenas extensão), sem isolamento de diretório de execução, sem renomeação do arquivo enviado.

**IOCs típicos:**
- Arquivo com extensão executável pelo servidor (`.php`, `.asp`, `.aspx`, `.jsp`) em diretório de upload que deveria conter apenas mídia/documentos
- Padrões de código de webshell conhecidos (China Chopper, ASPXSpy, etc.)
- Acesso HTTP subsequente ao arquivo recém-enviado com parâmetros incomuns

**TTPs (MITRE ATT&CK):**
| Tática | Técnica | ID |
|---|---|---|
| Initial Access | Exploit Public-Facing Application | T1190 |
| Persistence | Server Software Component: Web Shell | T1505.003 |

---

## Fluxo de Investigação (resumido)

| Fase | Ação-chave |
|---|---|
| Identificação | EDR/AV sinalizando webshell, WAF, varredura de integridade de arquivo |
| Coleta | Arquivo enviado (preservado com hash), logs de upload e de acesso subsequente |
| Análise | Capacidade do webshell (comandos suportados), o que foi executado através dele |
| Contenção | Remover/isolar o arquivo, bloquear origem |
| Erradicação | Corrigir validação de upload (verificar conteúdo real, não extensão; renomear; isolar diretório sem permissão de execução) |
| Recuperação | Validar ausência de outros webshells (varredura completa do diretório de upload e do servidor) |
| Pós-Incidente | WAF rule para padrões de webshell, monitoramento de integridade de arquivo (FIM) no diretório de upload |

---

## Checklist Operacional

- [ ] Webshell identificado e preservado (hash) antes de remoção
- [ ] Capacidades do webshell analisadas (estático/dinâmico)
- [ ] Logs de acesso ao webshell revisados (comandos executados, duração do acesso)
- [ ] Validação de upload corrigida (content-type real, não extensão)
- [ ] Diretório de upload configurado sem permissão de execução
- [ ] Varredura completa por outros webshells no servidor

---

## Evidências Relevantes

| Ambiente | Fontes principais |
|---|---|
| Windows | IIS logs, Sysmon Event ID 11 (criação de arquivo), Event ID 1 (processo filho do `w3wp.exe`) |
| Linux | Access log (Apache/Nginx), auditd, processo filho do servidor web |

---

## Ferramentas Recomendadas
File Integrity Monitoring (FIM), EDR, WAF, ferramentas de detecção de webshell (NeoPI, webshell signatures em YARA)

---

## Caso Real
Webshells (como China Chopper) são consistentemente observados como mecanismo de persistência em campanhas de exploração em massa de vulnerabilidades de servidores web/CMS expostos (incluindo explorações documentadas contra Microsoft Exchange Server — ver também o contexto de RCE) — sua simplicidade (poucas linhas de código) e a dificuldade de detecção por assinatura (webshells customizados variam amplamente) tornam a detecção comportamental (processo filho anômalo do servidor web) mais eficaz que detecção por assinatura de arquivo.

---

## Referências
- MITRE ATT&CK: [T1505.003](https://attack.mitre.org/techniques/T1505/003/), [T1190](https://attack.mitre.org/techniques/T1190/)
- OWASP — Unrestricted File Upload

> 📌 Para expandir para Full Playbook, use `Templates/Full-Playbook-Template.md`.
