# Containers

> 🟡 Quick-Reference

## Descrição Técnica

**Definição:** Investigação de comprometimento em ambientes de container (Docker e equivalentes) fora do contexto de orquestração Kubernetes — inclui exploração de runtime, escape de container e abuso de imagem.

**Objetivo do atacante:** Execução de código dentro do container, escape para o host subjacente, persistência via imagem maliciosa, abuso de recursos.

**Impacto esperado:** Confidencialidade/Integridade do workload afetado; se houver escape, comprometimento completo do host.

**Vetores de entrada:**
- Imagem de container com vulnerabilidade conhecida não corrigida
- Container rodando como root com socket Docker montado (`/var/run/docker.sock`) — vetor clássico de escape
- Aplicação vulnerável dentro do container (RCE via web app, por exemplo)
- Registry de imagem comprometido/imagem trojanizada (ver `Supply-Chain/`)

**IOCs típicos:**
- Processo dentro do container tentando acessar `docker.sock`
- Container criado com `--privileged` fora do padrão
- Imagem puxada de registry público não usual para a organização

**TTPs (MITRE ATT&CK):**
| Tática | Técnica | ID |
|---|---|---|
| Execution | Deploy Container | T1610 |
| Privilege Escalation | Escape to Host | T1611 |
| Persistence | Implant Internal Image | T1525 |

---

## Fluxo de Investigação (resumido)

| Fase | Ação-chave |
|---|---|
| Identificação | Runtime security (Falco, Sysdig), comportamento anômalo dentro do container |
| Coleta | Logs do container (`docker logs`), imagem usada, configuração de execução (`docker inspect`) |
| Análise | Vulnerabilidade explorada, se houve escape para o host |
| Contenção | Parar/isolar o container, revogar acesso de rede |
| Erradicação | Remover imagem vulnerável/maliciosa, corrigir configuração de execução |
| Recuperação | Validar host subjacente se escape for confirmado/suspeito |
| Pós-Incidente | Scan de imagem (Trivy/Clair) no CI/CD, runtime security contínuo |

---

## Checklist Operacional

- [ ] Configuração de execução do container (`docker inspect`) analisada
- [ ] Verificado se socket Docker estava montado dentro do container
- [ ] Imagem original verificada quanto a vulnerabilidades conhecidas
- [ ] Confirmado se houve escape para o host
- [ ] Container/imagem maliciosa removidos
- [ ] Host subjacente validado se escape suspeito (ver `DFIR/`)

---

## Evidências Relevantes

| Fonte | O que procurar |
|---|---|
| `docker logs` / runtime logs | Comandos executados dentro do container |
| `docker inspect` | Configuração (privileged, mounts, capabilities) |
| Runtime security (Falco) | Syscalls anômalas, tentativa de acesso a recursos do host |
| Host (se escape suspeito) | Ver evidências padrão em `DFIR/README.md` |

---

## Ferramentas Recomendadas
Falco, Trivy, Docker Bench for Security, Sysdig

---

## Caso Real
Montagem do socket Docker (`/var/run/docker.sock`) dentro de um container é uma má configuração recorrente (geralmente para permitir "Docker-in-Docker" em pipelines de CI/CD) que, se o container for comprometido via aplicação vulnerável, concede ao atacante controle total sobre o Docker daemon do host — efetivamente um escape trivial. **Aplicação:** a investigação de qualquer container comprometido deve verificar imediatamente se esse mount estava presente antes de assumir que o impacto está contido ao container.

---

## Referências
- MITRE ATT&CK: [T1610](https://attack.mitre.org/techniques/T1610/), [T1611](https://attack.mitre.org/techniques/T1611/)
- Docker/CIS Benchmark para hardening de containers

> 📌 Esta categoria está marcada como Quick-Reference. Para expandir para Full Playbook, use `Templates/Full-Playbook-Template.md`.
