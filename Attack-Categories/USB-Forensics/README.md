# USB-Forensics

> 🟡 Quick-Reference

## Descrição Técnica

**Definição:** Investigação relacionada ao uso de dispositivos de mídia removível (USB) — tanto como vetor de entrada de malware (autorun, payload em dispositivo "perdido" propositalmente — BadUSB) quanto como canal de exfiltração de dados (especialmente relevante em investigações de insider threat).

**Objetivo do atacante:** Introdução de malware via mídia física (contornando controles de rede), ou exfiltração de dados para mídia física não monitorada pela rede.

**Impacto esperado:** Confidencialidade (exfiltração física), Integridade (introdução de malware via dispositivo).

**Vetores de entrada:**
- Dispositivo USB malicioso "perdido" propositalmente em local público da organização (USB drop attack)
- BadUSB (dispositivo que se apresenta como teclado/HID e injeta comandos automaticamente)
- Cópia não autorizada de dados para dispositivo USB pessoal (insider)

**IOCs típicos:**
- Conexão de dispositivo USB de armazenamento não corporativo/não registrado
- Volume alto de cópia de arquivo para unidade removível em curto período
- Dispositivo USB se apresentando como HID (teclado) e injetando comandos rapidamente (padrão BadUSB)

**TTPs (MITRE ATT&CK):**
| Tática | Técnica | ID |
|---|---|---|
| Initial Access | Replication Through Removable Media | T1091 |
| Exfiltration | Exfiltration Over Physical Medium | T1052.001 |

---

## Fluxo de Investigação (resumido)

| Fase | Ação-chave |
|---|---|
| Identificação | Alerta de DLP/EDR de dispositivo USB, política de bloqueio de dispositivo |
| Coleta | Registry (histórico de dispositivos USB conectados), logs de DLP |
| Análise | Volume/tipo de arquivo copiado, identificação do dispositivo (Serial Number) |
| Contenção | Bloquear porta USB/dispositivo, revogar acesso se insider confirmado |
| Erradicação | Remover malware se introduzido via USB |
| Recuperação | Validar integridade do host após conexão de dispositivo suspeito |
| Pós-Incidente | Política de controle de dispositivo (whitelist), DLP para mídia removível |

---

## Checklist Operacional

- [ ] Histórico de dispositivos USB do host (Registry) coletado
- [ ] Volume e tipo de arquivo transferido determinado
- [ ] Serial Number do dispositivo identificado (para correlação com outros hosts)
- [ ] Se insider suspeito: RH/Jurídico acionados (ver `Insider-Threat/`)
- [ ] Se malware suspeito: host investigado conforme `Malware/`

---

## Evidências Relevantes

### Windows
| Fonte | Localização | O que procurar |
|---|---|---|
| Registry | `HKLM\SYSTEM\CurrentControlSet\Enum\USBSTOR` | Histórico de dispositivos USB conectados, com timestamp |
| Registry | `HKLM\SOFTWARE\Microsoft\Windows Portable Devices\Devices` | Nome amigável do dispositivo |
| Setupapi logs | `C:\Windows\inf\setupapi.dev.log` | Timestamp de primeira/última conexão |
| Event Viewer | Microsoft-Windows-DriverFrameworks-UserMode | Conexão/desconexão de dispositivo |

### Linux
| Fonte | Caminho | O que procurar |
|---|---|---|
| `dmesg` / `journalctl` | — | Conexão de dispositivo USB, identificação |
| udev logs | `/var/log/syslog` | Eventos de hotplug |

---

## Ferramentas Recomendadas
USB Detective, Registry Explorer, DLP corporativo

---

## Caso Real
Ataques de "USB drop" (deixar dispositivos USB maliciosos em estacionamentos ou áreas comuns de uma organização-alvo, na expectativa de que um funcionário curioso o conecte) continuam sendo uma técnica de engenharia social documentada em exercícios de red team e em incidentes reais — a investigação de qualquer dispositivo USB desconhecido conectado deve assumir potencial comprometimento até prova em contrário, especialmente se o dispositivo se apresentar como HID.

---

## Referências
- MITRE ATT&CK: [T1091](https://attack.mitre.org/techniques/T1091/), [T1052.001](https://attack.mitre.org/techniques/T1052/001/)

> 📌 Esta categoria está marcada como Quick-Reference. Para expandir para Full Playbook, use `Templates/Full-Playbook-Template.md`.
