# Insider-Threat

> 🟡 Quick-Reference

## Descrição Técnica

**Definição:** Ameaça originada de pessoa com acesso legítimo ao ambiente (funcionário, ex-funcionário, contratado, parceiro) que abusa desse acesso para causar dano — intencionalmente (malicioso) ou não (negligente).

**Objetivo do atacante:** Varia: sabotagem, roubo de propriedade intelectual para benefício pessoal/concorrente, fraude financeira, ou vazamento de dados por vingança (ex.: após desligamento).

**Impacto esperado:** Confidencialidade (dados levados), Integridade (sabotagem de sistemas), potencialmente Disponibilidade.

**Vetores de entrada:**
- Acesso legítimo já existente (não há "vetor de entrada" no sentido tradicional)
- Contas não desativadas após desligamento (vetor de oportunidade)

**IOCs típicos:**
- Acesso a dados fora do escopo normal de função
- Download/cópia em massa pouco antes de pedido de demissão/desligamento
- Acesso fora de horário incomum para o perfil do usuário

**TTPs (MITRE ATT&CK):**
| Tática | Técnica | ID |
|---|---|---|
| Collection | Data from Cloud Storage | T1530 |
| Exfiltration | Exfiltration Over Physical Medium | T1052 |
| Initial Access | Valid Accounts | T1078 |

---

## Fluxo de Investigação (resumido)

| Fase | Ação-chave |
|---|---|
| Identificação | DLP, UEBA (User Entity Behavior Analytics), denúncia de RH/gestor |
| Coleta | Logs de acesso a arquivo, e-mail, USB, atividade de impressão |
| Análise | Padrão de acesso vs. baseline da função; janela temporal vs. evento de RH (demissão, etc.) |
| Contenção | Suspender acesso (coordenado com RH/Jurídico) |
| Erradicação | Revogar todo acesso remanescente |
| Recuperação | N/A operacional — foco em investigação/processo |
| Pós-Incidente | Revisão de processo de offboarding, princípio de menor privilégio |

> ⚠️ Investigações de insider exigem envolvimento obrigatório de **RH e Jurídico desde o início** — questões trabalhistas e de privacidade do funcionário têm peso legal direto.

---

## Checklist Operacional

- [ ] RH e Jurídico acionados antes de qualquer ação investigativa direta sobre o indivíduo
- [ ] Baseline de acesso normal da função estabelecido para comparação
- [ ] Evidência de acesso anômalo coletada com cadeia de custódia (pode virar caso trabalhista/judicial)
- [ ] Janela temporal correlacionada com eventos de RH (aviso prévio, avaliação negativa, etc.)
- [ ] Acesso suspenso de forma coordenada (evitar alertar prematuramente)

---

## Evidências Relevantes

| Ambiente | Fontes principais |
|---|---|
| Windows | Event ID 4663 (acesso a arquivo), USB device logs, histórico de impressão |
| Linux | auditd, histórico de acesso a arquivo |
| Cloud | Logs de DLP, Google Workspace/M365 Audit (download em massa, compartilhamento externo) |

---

## Ferramentas Recomendadas
DLP, UEBA, Velociraptor (para coleta forense formal se necessário)

---

## Caso Real
**Roubo de propriedade intelectual antes de mudança de emprego:** padrão recorrente em casos públicos de litígio: funcionário copia documentos/código para mídia pessoal ou cloud pessoal nos dias/semanas antes de pedir demissão para ir trabalhar em concorrente — DLP com regra de "download em massa + destino externo pessoal" é o controle mais eficaz para detecção precoce.

---

## Referências
- MITRE ATT&CK: [T1530](https://attack.mitre.org/techniques/T1530/), [T1078](https://attack.mitre.org/techniques/T1078/)

> 📌 Esta categoria está marcada como Quick-Reference. Para expandir para Full Playbook, use `Templates/Full-Playbook-Template.md`.
