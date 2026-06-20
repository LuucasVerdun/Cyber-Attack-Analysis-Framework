# Master Mapping Table — MITRE ATT&CK x Attack Categories

> Tabela mestre de referência cruzada entre as 51 categorias do repositório e as táticas/técnicas MITRE ATT&CK (Enterprise Matrix) mais associadas a cada uma. Não é exaustiva — cada playbook individual em `Attack-Categories/<categoria>/README.md` detalha as sub-técnicas específicas com IDs completos.
>
> ⚠️ IDs e nomes de técnicas evoluem com as revisões da MITRE. Validar contra o [ATT&CK Navigator](https://attack.mitre.org) antes de uso em relatórios formais ou integrações de SIEM.

## Legenda de Táticas (Enterprise Matrix)

| Sigla | Tática |
|---|---|
| RC | Reconnaissance |
| RD | Resource Development |
| IA | Initial Access |
| EX | Execution |
| PS | Persistence |
| PE | Privilege Escalation |
| DE | Defense Evasion |
| CA | Credential Access |
| DI | Discovery |
| LM | Lateral Movement |
| CO | Collection |
| C2 | Command and Control |
| EXF | Exfiltration |
| IM | Impact |

---

## Tabela de Mapeamento

| Categoria | Táticas principais | Técnicas-chave (exemplos) |
|---|---|---|
| Malware | EX, PS, DE | T1204 (User Execution), T1059 (Command and Scripting Interpreter), T1027 (Obfuscated Files) |
| Ransomware | IM, EXF, CA | T1486 (Data Encrypted for Impact), T1490 (Inhibit System Recovery), T1567 (Exfiltration Over Web Service) |
| Phishing | IA | T1566 (Phishing), T1566.001/002/003 |
| Spear-Phishing | IA | T1566.001 (Spearphishing Attachment), T1566.002 (Spearphishing Link) |
| BEC | IA, CO, IM | T1586 (Compromise Accounts), T1114 (Email Collection), T1565 (Data Manipulation) |
| Credential-Access | CA | T1110 (Brute Force), T1003 (OS Credential Dumping), T1555 (Credentials from Password Stores) |
| Brute-Force | CA | T1110.001/003/004 |
| Password-Spraying | CA | T1110.003 (Password Spraying) |
| Kerberoasting | CA | T1558.003 (Steal or Forge Kerberos Tickets: Kerberoasting) |
| Pass-the-Hash | LM, DE | T1550.002 (Use Alternate Authentication Material: Pass the Hash) |
| Lateral-Movement | LM | T1021 (Remote Services), T1570 (Lateral Tool Transfer) |
| Privilege-Escalation | PE | T1068 (Exploitation for Privilege Escalation), T1078 (Valid Accounts) |
| Persistence | PS | T1547 (Boot or Logon Autostart), T1053 (Scheduled Task/Job), T1098 (Account Manipulation) |
| C2 | C2 | T1071 (Application Layer Protocol), T1573 (Encrypted Channel), T1090 (Proxy) |
| Data-Exfiltration | EXF | T1041 (Exfiltration Over C2 Channel), T1567 (Exfiltration Over Web Service) |
| Insider-Threat | CO, EXF | T1530 (Data from Cloud Storage), T1052 (Exfiltration Over Physical Medium) |
| Supply-Chain | IA | T1195 (Supply Chain Compromise) |
| Web-Attacks (SQLi/XSS/SSRF/XXE/RCE/Path-Traversal/File-Upload/Command-Injection) | IA, EX | T1190 (Exploit Public-Facing Application) |
| Active-Directory | CA, LM, PE | T1558 (Steal/Forge Kerberos Tickets), T1484 (Domain/Group Policy Modification) |
| Cloud-Intrusion | IA, PS | T1078.004 (Valid Accounts: Cloud Accounts), T1098.001 (Additional Cloud Credentials) |
| AWS | IA, PS, CA | T1078.004, T1552.005 (Cloud Instance Metadata API) |
| Azure | IA, PS, CA | T1078.004, T1556.006 (Multi-Factor Authentication) |
| GCP | IA, PS, CA | T1078.004, T1098.001 |
| Kubernetes | EX, PE | T1610 (Deploy Container), T1611 (Escape to Host) |
| Containers | EX, PE | T1610, T1611, T1612 (Build Image on Host) |
| API-Attacks | IA, CA | T1190, T1556 (Modify Authentication Process) |
| DDoS | IM | T1498 (Network Denial of Service), T1499 (Endpoint Denial of Service) |
| Botnets | C2 | T1583.005 (Acquire Infrastructure: Botnet), T1071 |
| Cryptojacking | IM, EX | T1496 (Resource Hijacking) |
| Malware-Triage | — (metodologia) | (aplica-se a todas as técnicas de Execution/Defense Evasion) |
| Memory-Forensics | — (metodologia) | (suporta investigação de DE, PS, CA em memória) |
| Threat-Hunting | DI | (hunting hipótese-driven, cobre múltiplas táticas) |
| IOC-Hunting | DI | (busca retroativa por indicadores conhecidos) |
| Threat-Intel | — (metodologia) | (suporta atribuição e contexto de campanha) |
| Email-Investigation | IA, CO | T1566, T1114 |
| Endpoint-Investigation | — (metodologia) | (suporta investigação host-based em geral) |
| Network-Investigation | — (metodologia) | (suporta investigação de C2, LM, EXF) |
| DNS-Abuse | C2, EXF | T1071.004 (DNS), T1568 (Dynamic Resolution) |
| VPN-Abuse | IA | T1133 (External Remote Services) |
| USB-Forensics | IA, EXF | T1091 (Replication Through Removable Media), T1052.001 |
| Mobile-Forensics | — (Mobile ATT&CK) | T1426 (System Information Discovery - Mobile), etc. |
| Insider-Activity | CO, EXF | T1078 (Valid Accounts), T1530 |
| APT-Investigation | Multi-tática | Campanha completa — ver playbook individual |

---

## Como Usar Esta Tabela

1. **Para Threat Hunting hipótese-driven:** escolha uma técnica (ex.: T1558.003) e cruze com a categoria correspondente (Kerberoasting) para acessar o playbook completo de investigação.
2. **Para mapear cobertura de detecção:** cruze esta tabela com `Detection-Rules/` para identificar lacunas (técnicas sem regra Sigma/YARA/Suricata associada).
3. **Para relatórios de incidente:** use os IDs aqui como ponto de partida, mas sempre confirme a sub-técnica exata no playbook da categoria antes de finalizar o relatório.

## Referências
- [MITRE ATT&CK Enterprise Matrix](https://attack.mitre.org/matrices/enterprise/)
- [MITRE D3FEND](https://d3fend.mitre.org/) — contramedidas defensivas mapeadas por técnica ofensiva
- [MITRE ATT&CK Navigator](https://mitre-attack.github.io/attack-navigator/)
