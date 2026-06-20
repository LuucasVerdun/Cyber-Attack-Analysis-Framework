# Runbook: Beacon de C2 Detectado

## Quando usar
EDR, proxy, IDS/IPS ou regra de threat intel identificou comunicação periódica (beaconing) de um host para infraestrutura de Command & Control conhecida ou suspeita.

## Primeiros 15 minutos
1. **Não isole o host imediatamente** se o objetivo for entender o escopo total primeiro (a menos que haja exfiltração ativa de dados sensíveis — nesse caso, isole já).
2. Capture as conexões de rede ativas do host (netstat, EDR network view) antes de qualquer ação.
3. Identifique o processo responsável pelo beacon (PID, caminho do binário, linha de comando, processo pai).
4. Verifique se o IOC (IP/domínio de C2) já apareceu em outros hosts — pode indicar propagação.
5. Classifique severidade: **SEV1** se Domain Controller ou servidor crítico envolvido; **SEV2** caso contrário.

## Contenção (próximas 1-2h)
1. Capture memória do host (o malware pode ser fileless / residir apenas em memória).
2. Bloqueie o IOC de C2 em firewall/proxy/EDR para todos os hosts, não apenas o afetado.
3. Isole o host da rede mantendo-o ligado, após coleta de evidência volátil.
4. Identifique persistência associada (registry run keys, scheduled task, serviço, WMI subscription).
5. Verifique se houve movimento lateral a partir deste host (logs de autenticação, RDP, PsExec, WMI).
6. Extraia o binário/payload para análise (sandbox isolado, nunca execute fora de ambiente controlado).

## Escalonamento
- Acionar **DFIR/Threat Hunting** para verificar se o C2 está associado a um ator/campanha conhecida (TI lookup).
- Escalar para **SEV1** se houver indícios de APT (persistência sofisticada, evasão de EDR, infraestrutura de C2 não-commodity).

## Não fazer
- ❌ Matar o processo antes de capturar memória e identificar persistência (o malware pode se re-executar automaticamente, mascarando a investigação).
- ❌ Bloquear o IOC de C2 sem antes confirmar se isso vai "queimar" uma investigação mais ampla de movimento lateral em andamento (avaliar com Lead Investigator).
- ❌ Assumir que é um host único sem verificar beaconing similar em toda a frota (hunting retroativo nos logs de proxy/DNS).

## Referência completa
→ Ver [`Attack-Categories/C2/README.md`](../Attack-Categories/C2/README.md) para as 7 fases completas, evidências, ferramentas (Zeek, Suricata, Wireshark) e casos reais.
