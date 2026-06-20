# Supply-Chain

> 🟡 Quick-Reference

## Descrição Técnica

**Definição:** Comprometimento de um fornecedor, dependência de software, ou processo de build/atualização confiável, usado como vetor para atingir os clientes/usuários finais desse fornecedor — explora a confiança transitiva inerente a cadeias de suprimento de software.

**Objetivo do atacante:** Acesso em massa a múltiplas organizações através de um único ponto de comprometimento (alta eficiência de escala para o atacante).

**Impacto esperado:** Potencialmente catastrófico e amplo — um único comprometimento de fornecedor pode afetar milhares de organizações simultaneamente.

**Vetores de entrada:**
- Atualização de software legítimo trojanizada (build system comprometido)
- Dependência de código aberto comprometida (typosquatting de pacote, conta de mantenedor comprometida)
- Comprometimento de provedor de serviço gerenciado (MSP) com acesso a múltiplos clientes

**IOCs típicos:**
- Hash de atualização/binário não correspondente ao publicado oficialmente pelo fornecedor
- Comportamento anômalo de processo de software historicamente confiável (callback de rede não esperado)
- Pacote de dependência com nome similar a pacote legítimo popular

**TTPs (MITRE ATT&CK):**
| Tática | Técnica | ID |
|---|---|---|
| Initial Access | Supply Chain Compromise | T1195 |
| Initial Access | Supply Chain Compromise: Software Supply Chain | T1195.002 |

---

## Fluxo de Investigação (resumido)

| Fase | Ação-chave |
|---|---|
| Identificação | Alerta de fornecedor, TI feed, comportamento anômalo de software confiável |
| Coleta | Versão exata do componente afetado em uso, hash, data de instalação |
| Análise | Confirmar exploração local vs. apenas exposição (componente instalado mas não ativado/usado) |
| Contenção | Isolar/desabilitar o componente comprometido |
| Erradicação | Atualizar para versão corrigida, remover qualquer artefato malicioso instalado pela versão trojanizada |
| Recuperação | Validar integridade dos sistemas que usavam o componente |
| Pós-Incidente | Revisão de SBOM (Software Bill of Materials), processo de validação de dependências |

---

## Checklist Operacional

- [ ] Confirmado se a versão comprometida está/esteve em uso no ambiente
- [ ] Hash do componente em uso verificado contra a versão oficial conhecida
- [ ] Comportamento pós-instalação investigado (callback, execução de payload secundário)
- [ ] Componente atualizado/removido em todos os hosts afetados
- [ ] SBOM revisado para identificar outras dependências de risco similar

---

## Evidências Relevantes

| Ambiente | Fontes principais |
|---|---|
| Windows | Hash de binário/instalador, Sysmon Event ID 1 (execução pós-instalação) |
| Linux | Hash de pacote, gerenciador de pacotes (apt/yum/pip/npm) logs de instalação |
| Cloud | CI/CD pipeline logs (se comprometimento ocorreu no build interno) |

---

## Ferramentas Recomendadas
Ferramentas de SBOM (Syft, CycloneDX), VirusTotal para hash, EDR

---

## Caso Real
**SolarWinds Orion (2020):** atualização de software de monitoramento de TI amplamente usado foi trojanizada através de comprometimento do processo de build do fornecedor, distribuindo backdoor (SUNBURST) para milhares de organizações que aplicaram a atualização legítima assinada digitalmente. **Aplicação da metodologia:** o caso ilustra por que verificação de hash/assinatura sozinha é insuficiente quando o comprometimento ocorre no próprio processo de build do fornecedor — a investigação exige análise comportamental do software após instalação, não apenas confiança na cadeia de assinatura digital.

---

## Referências
- MITRE ATT&CK: [T1195](https://attack.mitre.org/techniques/T1195/), [T1195.002](https://attack.mitre.org/techniques/T1195/002/)
- CISA/relatórios públicos sobre o incidente SolarWinds

> 📌 Esta categoria está marcada como Quick-Reference. Para expandir para Full Playbook, use `Templates/Full-Playbook-Template.md`.
