# Modelo Padrão de Análise de Incidente

> **O que é este arquivo:** o documento único de trabalho que você abre no primeiro sinal de um alerta e mantém atualizado até o encerramento do caso. Reúne, em um só lugar, o cabeçalho do caso, a linha do tempo, as evidências, os IOCs, o mapeamento MITRE ATT&CK, as ações das 7 fases e as lições aprendidas — para você não precisar alternar entre os 6 templates separados durante uma investigação real.
>
> **Como usar:** copie este arquivo para o seu caso (ex.: `IR-2026-0042-Analise.md`), preencha as seções **na ordem em que a informação fica disponível** (não precisa ser sequencial — volte e complete conforme a investigação avança), e mantenha-o como fonte única de verdade do caso.
>
> **Quando usar os templates separados em vez deste:**
> | Se você precisa de... | Use em vez disso |
> |---|---|
> | Relatório final formal para liderança/diretoria | [`IR-Report-Template.md`](IR-Report-Template.md) (pode ser gerado a partir deste documento ao final) |
> | Timeline forense muito extensa (dezenas de eventos) | [`Timeline-Template.md`](Timeline-Template.md), referenciado na Seção 3 |
> | Registro formal de cadeia de custódia para múltiplas evidências físicas/digitais | [`Evidence-Collection-Template.md`](Evidence-Collection-Template.md), referenciado na Seção 4 |
> | Exportação de IOCs para SIEM/TIP/MISP | [`IOC-Tracking-Template.md`](IOC-Tracking-Template.md), referenciado na Seção 5 |
>
> Para a metodologia técnica específica do tipo de ataque, sempre consulte `Attack-Categories/<categoria>/README.md` antes e durante o preenchimento.

---

## 0. Identificação do Caso

| Campo | Valor |
|---|---|
| ID do caso | IR-[AAAA]-[NNNN] |
| Data/hora de abertura (UTC) | |
| Analista responsável | |
| Categoria de ataque (link) | `Attack-Categories/.../README.md` |
| Severidade | ☐ Crítica (SEV1) ☐ Alta (SEV2) ☐ Média (SEV3) ☐ Baixa (SEV4) |
| Status atual | ☐ Triagem ☐ Em Investigação ☐ Contido ☐ Erradicado ☐ Encerrado |
| Incident Commander (se SEV1/SEV2) | |

---

## 1. Resumo do Alerta / Gatilho Inicial

**Como o caso chegou até você:**
- [ ] Alerta automatizado (SIEM/EDR/WAF) — nome da regra: ___
- [ ] Report de usuário
- [ ] Threat Intel (IOC match / relatório externo)
- [ ] Threat Hunting proativo
- [ ] Outro: ___

**Descrição em 2-3 frases do que disparou a investigação:**

[...]

**Hipótese inicial (antes de investigar a fundo):**

[...]

---

## 2. Escopo

| Pergunta | Resposta (atualize conforme descobre) |
|---|---|
| Quantos hosts estão envolvidos? | |
| Quantas contas estão envolvidas? | |
| Há dados sensíveis/pessoais em risco? | |
| Há sistema Tier 0 envolvido (DC, PKI, backup)? | |
| O atacante ainda tem acesso ativo? | |

---

## 3. Linha do Tempo

> Para casos com muitos eventos, mova esta seção para um [`Timeline-Template.md`](Timeline-Template.md) dedicado e deixe aqui apenas o resumo de marcos.

| # | Data/Hora (UTC) | Evento | Fonte | Confiança |
|---|---|---|---|---|
| 1 | | | | |
| 2 | | | | |

**Marcos-chave:**

| Marco | Data/Hora (UTC) |
|---|---|
| Acesso inicial (compromise time) | |
| Detecção | |
| Início da contenção | |
| Contenção completa | |
| Erradicação completa | |

**Dwell time (detecção − acesso inicial):** ___

---

## 4. Evidências Coletadas

> Para múltiplas evidências formais com cadeia de custódia completa, use [`Evidence-Collection-Template.md`](Evidence-Collection-Template.md) por item e referencie aqui.

| ID | Descrição | Tipo | Coletado por | Data/hora (UTC) | Hash (SHA256) | Local de armazenamento |
|---|---|---|---|---|---|---|
| EVD-001 | | Disco/Memória/Log/Rede/Documento | | | | |

**Checklist de integridade:**
- [ ] Hash calculado imediatamente após coleta
- [ ] Evidência original preservada (write blocker / read-only)
- [ ] Análise feita apenas em cópia, nunca no original

---

## 5. Indicadores de Comprometimento (IOCs)

> Para exportação em escala (CSV/STIX) para bloqueio em SIEM/TIP/EDR, use [`IOC-Tracking-Template.md`](IOC-Tracking-Template.md) e referencie aqui o arquivo gerado.

| Tipo | Valor | Contexto | Confiança | Bloqueado? |
|---|---|---|---|---|
| Hash SHA256 | | | | ☐ |
| Domínio/IP | | | | ☐ |
| Outro | | | | ☐ |

---

## 6. Mapeamento MITRE ATT&CK

| Tática | Técnica | ID | Evidência que confirma |
|---|---|---|---|
| | | | |

> Cruze com [`MITRE-Mappings/Master-Mapping-Table.md`](../MITRE-Mappings/Master-Mapping-Table.md) para identificar a categoria de ataque e o playbook correspondente.

---

## 7. Ações por Fase

> Esqueleto das 7 fases do framework (ver `README.md` raiz). Marque conforme avança; detalhe ações específicas do playbook da categoria em cada subseção.

### 7.1 Identificação
- [ ] Alerta validado (não é falso positivo)
- [ ] Severidade classificada
- [ ] Logs/ferramentas relevantes identificados (ver playbook da categoria)

### 7.2 Coleta
- [ ] Artefatos voláteis priorizados antes de qualquer remediação
- [ ] Evidências registradas na Seção 4

### 7.3 Análise
- [ ] Hipóteses formuladas e testadas (ver abaixo)
- [ ] Escopo (Seção 2) atualizado com achados
- [ ] Causa raiz em investigação

### 7.4 Contenção
- [ ] Ações imediatas executadas: ___
- [ ] IOCs bloqueados (Seção 5)
- [ ] Host(s)/conta(s) isolados: ___

### 7.5 Erradicação
- [ ] Ameaça removida: ___
- [ ] Persistência verificada e removida (checklist completo em `Attack-Categories/Persistence/README.md`)
- [ ] Correção/patch aplicado: ___

### 7.6 Recuperação
- [ ] Critério de validação definido: ___
- [ ] Sistemas restaurados e validados
- [ ] Monitoramento elevado pós-recuperação ativo até: ___

### 7.7 Pós-Incidente
- [ ] Lições aprendidas documentadas (Seção 9)
- [ ] Regra de detecção nova/atualizada criada em `Detection-Rules/`
- [ ] Ações de hardening atribuídas (Seção 9)

---

## 8. Hipóteses Investigadas

| Hipótese | Status | Evidência de suporte/descarte |
|---|---|---|
| | ☐ Confirmada ☐ Descartada ☐ Em aberto | |

---

## 9. Causa Raiz e Lições Aprendidas

**Causa raiz (por que o ataque foi possível):**

[...]

**Por que a detecção demorou (ou não demorou):**

[...]

| O que funcionou bem | O que não funcionou | Ação corretiva | Responsável | Prazo |
|---|---|---|---|---|
| | | | | |

---

## 10. Classificação Final e Encerramento

| Campo | Valor |
|---|---|
| Classificação final | ☐ Incidente Confirmado ☐ Falso Positivo ☐ Atividade Benigna Explicada |
| Dados pessoais/sensíveis expostos? | ☐ Sim ☐ Não — se sim, jurídico acionado em: ___ |
| Relatório formal necessário? | ☐ Sim → gerar via `IR-Report-Template.md` ☐ Não |
| Aprovado para encerramento por | |
| Data de encerramento (UTC) | |

**Critérios de encerramento (todos marcados antes de fechar):**
- [ ] Causa raiz identificada e documentada
- [ ] Persistência/backdoors removidos e validados
- [ ] Nenhuma atividade maliciosa observada no período de monitoramento pós-recuperação
- [ ] Ações de hardening/detecção atribuídas com responsável e prazo

---

## Referência Rápida

- Playbook técnico da categoria: `Attack-Categories/<categoria>/README.md`
- Processo macro de IR: [`Incident-Response/README.md`](../Incident-Response/README.md)
- Runbook de execução rápida (se aplicável): `Playbooks/`
- Metodologia DFIR/Malware/Rede/Cloud: [`DFIR/`](../DFIR/), [`Malware-Analysis/`](../Malware-Analysis/), [`Network-Forensics/`](../Network-Forensics/), [`Cloud-Investigations/`](../Cloud-Investigations/)
