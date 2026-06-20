# VPN-Abuse

> 🟡 Quick-Reference

## Descrição Técnica

**Definição:** Uso não autorizado de credenciais VPN legítimas (comprometidas ou abusadas por insider) para obter acesso remoto ao ambiente interno — um vetor de acesso inicial particularmente perigoso por conceder posição de rede equivalente a estar fisicamente dentro do perímetro corporativo.

**Objetivo do atacante:** Acesso inicial à rede interna usando credencial legítima, frequentemente evitando completamente controles de perímetro voltados para tráfego externo não autenticado.

**Impacto esperado:** Confidencialidade/Integridade — acesso de rede interno equivalente a um funcionário legítimo, viabilizando reconhecimento e movimento lateral subsequentes.

**Vetores de entrada:**
- Credencial VPN vazada/reutilizada (sem MFA)
- Exploração de vulnerabilidade conhecida em appliance VPN (vetor recorrente em CVEs críticos de appliances corporativos)
- Sessão VPN de ex-funcionário não revogada (falha de processo de offboarding)

**IOCs típicos:**
- Login VPN de geolocalização/dispositivo inconsistente com o padrão do usuário
- Múltiplas sessões VPN simultâneas da mesma conta de localizações diferentes (impossível travel)
- Login VPN fora do horário/padrão habitual do usuário, seguido de atividade de reconhecimento de rede

**TTPs (MITRE ATT&CK):**
| Tática | Técnica | ID |
|---|---|---|
| Initial Access | External Remote Services | T1133 |
| Initial Access | Valid Accounts | T1078 |

---

## Fluxo de Investigação (resumido)

| Fase | Ação-chave |
|---|---|
| Identificação | Alerta de geolocalização anômala, sessões concorrentes, ou exploração de CVE de appliance |
| Coleta | Logs de autenticação VPN (origem, duração, dados transferidos) |
| Análise | Atividade realizada durante a sessão (o que foi acessado na rede interna) |
| Contenção | Encerrar sessão, desabilitar conta, revogar certificado se aplicável |
| Erradicação | Resetar credencial, aplicar patch se vetor foi vulnerabilidade de appliance |
| Recuperação | Validar atividade de rede interna pós-sessão suspeita |
| Pós-Incidente | MFA obrigatório para VPN, revisão de processo de offboarding, patch de appliance |

---

## Checklist Operacional

- [ ] Logs de sessão VPN (origem, duração, volume) coletados
- [ ] Atividade de rede interna durante a sessão correlacionada
- [ ] Sessão encerrada e credencial revogada
- [ ] Verificado se há indício de exploração de vulnerabilidade do appliance (não apenas credencial)
- [ ] MFA validado/forçado para acesso VPN
- [ ] Processo de offboarding revisado se a causa foi conta não desativada

---

## Evidências Relevantes

| Fonte | O que procurar |
|---|---|
| Logs do appliance/concentrador VPN | Origem, duração, volume de dados, certificado usado |
| Logs de autenticação (RADIUS/LDAP/AD) | Correlação com diretório de identidade |
| NetFlow interno | Atividade de rede gerada pela sessão VPN |

---

## Ferramentas Recomendadas
SIEM com correlação de geolocalização, logs do appliance VPN, KQL/Splunk

---

## Caso Real
Vulnerabilidades críticas em appliances VPN corporativos amplamente usados (incluindo CVEs documentados publicamente pela CISA ao longo dos últimos anos em produtos de fornecedores como Ivanti, Fortinet e Citrix) têm sido consistentemente exploradas em massa como vetor de acesso inicial direto à rede interna de organizações, frequentemente antecedendo intrusões de ransomware e espionagem. **Aplicação:** ao investigar qualquer atividade VPN suspeita, verificar primeiro se o appliance está em versão corrigida antes de assumir que o vetor foi exclusivamente credencial comprometida.

---

## Referências
- MITRE ATT&CK: [T1133](https://attack.mitre.org/techniques/T1133/), [T1078](https://attack.mitre.org/techniques/T1078/)
- CISA Advisories sobre vulnerabilidades de appliances VPN (público)

> 📌 Esta categoria está marcada como Quick-Reference. Para expandir para Full Playbook, use `Templates/Full-Playbook-Template.md`.
