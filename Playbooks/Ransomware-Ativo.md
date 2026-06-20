# Runbook: Ransomware Ativo

## Quando usar
Criptografia de arquivos confirmada ou fortemente suspeita em andamento (extensões anômalas aparecendo, notas de resgate sendo criadas, alertas EDR de "ransomware behavior" / mass file modification).

## Primeiros 15 minutos
1. **Não desligue as máquinas afetadas** — isso pode destruir a chave de criptografia em memória e evidências voláteis.
2. Isole a(s) máquina(s) afetada(s) da rede (desconectar rede/Wi-Fi via EDR ou fisicamente) — mantenha ligada.
3. Identifique o "paciente zero" — host onde a criptografia começou primeiro.
4. Acione o Incident Commander e classifique como **SEV1**.
5. Verifique escopo: a criptografia está se espalhando para shares de rede / outros hosts agora?
6. Se houver backups acessíveis pela rede, **isole-os imediatamente** (ransomware moderno mira backups primeiro).

## Contenção (próximas 1-2h)
1. Desabilite contas comprometidas usadas para se mover lateralmente (se identificadas).
2. Bloqueie IOCs conhecidos (hash do binário, IPs de C2) em EDR/firewall/proxy.
3. Segmente/isole subnets afetadas se a propagação for via SMB/RDP.
4. Capture memória de pelo menos 1-2 hosts representativos **antes** de qualquer remediação (pode conter a chave de criptografia).
5. Identifique a família de ransomware (nota de resgate, extensão, comportamento) — buscar em ID Ransomware ou TI interno.
6. Preserve uma cópia da nota de resgate e de um arquivo criptografado de amostra.

## Escalonamento
- Acionar **jurídico** imediatamente (possível obrigação de notificação regulatória).
- Acionar **liderança executiva** em SEV1.
- Avaliar acionamento de **DFIR externo / seguro cyber** conforme apólice.
- **Não negocie nem entre em contato com os atacantes** sem aprovação formal de jurídico + liderança.

## Não fazer
- ❌ Desligar máquinas afetadas sem captura de memória prévia.
- ❌ Restaurar backups antes de confirmar que a causa raiz foi erradicada (risco de reinfecção imediata).
- ❌ Pagar ou negociar resgate sem aprovação formal.
- ❌ Apagar a nota de resgate ou arquivos criptografados de amostra (necessários para identificação e possível decryptor).
- ❌ Assumir que isolar 1 host resolve — ransomware moderno frequentemente já tem persistência em múltiplos hosts antes da detonação.

## Referência completa
→ Ver [`Attack-Categories/Ransomware/README.md`](../Attack-Categories/Ransomware/README.md) para as 7 fases completas, evidências, ferramentas e casos reais (LockBit, BlackCat, etc.)
