# Mobile-Forensics

> 🟡 Quick-Reference

## Descrição Técnica

**Definição:** Investigação forense de dispositivos móveis (iOS/Android) — abrangendo desde malware móvel comercial (spyware/stalkerware) até comprometimento via aplicativo malicioso ou exploração de vulnerabilidade zero-click, com referência à matriz **MITRE ATT&CK for Mobile** (distinta da Enterprise Matrix usada no restante do repositório).

**Objetivo do atacante:** Vigilância (spyware comercial visando jornalistas/ativistas/executivos), roubo de dados/credenciais armazenados no dispositivo, ou uso do dispositivo móvel como ponto de pivô para acesso a contas corporativas (MFA, e-mail).

**Impacto esperado:** Confidencialidade — dispositivos móveis frequentemente contêm o conjunto mais sensível e pessoal de dados de um indivíduo (localização, comunicação, autenticação).

**Vetores de entrada:**
- Aplicativo malicioso (sideload ou, raramente, presente em loja oficial)
- Exploração zero-click via vulnerabilidade de processamento de mensagem/mídia (sem interação do usuário)
- Phishing móvel (smishing) levando a instalação de perfil de configuração malicioso (iOS) ou APK (Android)
- Acesso físico não autorizado ao dispositivo desbloqueado

**IOCs típicos:**
- Consumo de bateria/dados anômalo
- Aplicativo desconhecido com permissões excessivas (acessibilidade, administrador de dispositivo)
- Perfil de configuração (iOS) ou certificado MDM não reconhecido instalado
- Processos/conexões de rede associadas a spyware comercial conhecido (Pegasus e variantes — quando há recursos forenses específicos disponíveis)

**TTPs (MITRE ATT&CK for Mobile — referência, matriz distinta):**
| Tática | Técnica (exemplo) |
|---|---|
| Initial Access | Drive-by Compromise (Mobile), Phishing (Mobile) |
| Persistence | Event Triggered Execution |
| Collection | Access Calendar/Contact List/Call Log |
| Credential Access | Access Stored Application Data |

---

## Fluxo de Investigação (resumido)

| Fase | Ação-chave |
|---|---|
| Identificação | Comportamento anômalo relatado, MDM alertando sobre perfil/app não autorizado |
| Coleta | Imagem forense do dispositivo (se possível, via MDM/ferramenta forense móvel) |
| Análise | Aplicativos instalados, perfis de configuração, permissões concedidas |
| Contenção | Remover app/perfil malicioso, revogar acesso de conta vinculada (se MFA/e-mail comprometido) |
| Erradicação | Reset de fábrica do dispositivo em casos de comprometimento profundo confirmado |
| Recuperação | Reconfigurar dispositivo a partir de backup limpo conhecido |
| Pós-Incidente | Política de MDM mais restritiva, treinamento sobre smishing |

> ⚠️ Investigação forense completa de dispositivo móvel (especialmente iOS) frequentemente exige ferramentas e expertise especializada além do escopo de SOC tradicional — avaliar engajamento de especialista forense móvel para casos de suspeita de spyware comercial sofisticado.

---

## Checklist Operacional

- [ ] Dispositivo isolado de rede (modo avião) se comprometimento ativo suspeito, preservando estado para coleta
- [ ] Lista de aplicativos e perfis de configuração instalados revisada
- [ ] Permissões concedidas a apps de terceiros auditadas
- [ ] Contas vinculadas ao dispositivo (e-mail, MFA) avaliadas quanto a comprometimento
- [ ] Decisão de reset de fábrica vs. remediação pontual tomada
- [ ] Engajamento de especialista forense móvel avaliado para casos de alta sofisticação

---

## Evidências Relevantes

| Plataforma | Fonte | O que procurar |
|---|---|---|
| iOS | MDM (Mobile Device Management) | Perfis de configuração, apps instalados via MDM |
| iOS | Sysdiagnose / backup | Histórico de processos, configuração |
| Android | MDM / Google Workspace Admin | Apps instalados, permissões concedidas |
| Android | ADB (se acesso autorizado) | Lista de pacotes, logs do sistema |

---

## Ferramentas Recomendadas
MVT (Mobile Verification Toolkit — útil para indicadores de spyware comercial conhecido), Cellebrite/Magnet AXIOM (forense profissional), MDM nativo (Intune, Jamf, Google Workspace)

---

## Caso Real
Spyware comercial sofisticado (categoria amplamente documentada por organizações de pesquisa como Citizen Lab e Amnesty International Security Lab) tem sido repetidamente associado a comprometimento de dispositivos de jornalistas, ativistas e figuras públicas via explorações zero-click, sem necessidade de qualquer interação da vítima. **Aplicação:** perfis de alto risco (executivos C-level, equipe jurídica, comunicação institucional) devem ser tratados com política de monitoramento de dispositivo móvel mais rigorosa, dado que o vetor zero-click torna treinamento de usuário ineficaz como controle primário para este cenário específico.

---

## Referências
- MITRE ATT&CK for Mobile: https://attack.mitre.org/matrices/mobile/
- Mobile Verification Toolkit (MVT) — Amnesty International Security Lab

> 📌 Esta categoria está marcada como Quick-Reference. Para expandir para Full Playbook, use `Templates/Full-Playbook-Template.md`.
