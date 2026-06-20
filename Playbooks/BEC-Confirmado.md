# Runbook: BEC Confirmado (Business Email Compromise)

## Quando usar
Conta de e-mail corporativo confirmada como comprometida (login anômalo, regra de encaminhamento maliciosa, ou fraude financeira já reportada por um destinatário).

## Primeiros 15 minutos
1. **Resete a senha** da conta comprometida e **revogue todas as sessões/tokens ativos** (Azure AD/Google Workspace: revoke sign-in sessions).
2. Force re-autenticação com MFA em todos os dispositivos.
3. Verifique e **remova regras de encaminhamento/redirecionamento** criadas na caixa (Inbox Rules, Forwarding).
4. Verifique se houve **transferência financeira** solicitada/em andamento — se sim, contate o setor financeiro/banco imediatamente para tentar reverter (janela é curta, minutos importam).
5. Classifique severidade: **SEV1** se houver fraude financeira em andamento; **SEV2** caso contrário.

## Contenção (próximas 1-2h)
1. Audite o log de login da conta (IPs, geolocalização, user-agent, MFA challenges) para determinar quando o acesso começou.
2. Revise **todas** as regras de caixa de entrada criadas/modificadas no período suspeito (inbox rules são a persistência mais comum em BEC).
3. Verifique se a conta foi usada para enviar e-mails a terceiros (clientes/fornecedores) — eles também podem precisar de alerta.
4. Verifique acesso a OneDrive/SharePoint/Drive vinculado à conta — BEC frequentemente inclui exfiltração de dados antes da fraude.
5. Identifique o vetor de acesso inicial (phishing AiTM, credential stuffing, reuso de senha vazada).

## Escalonamento
- Acionar **jurídico** e **financeiro** imediatamente se houve solicitação de transferência.
- Acionar **liderança** se a conta comprometida for de executivo (C-level BEC tem maior exposição reputacional/financeira).
- Notificar clientes/fornecedores que possam ter recebido e-mail fraudulento da conta comprometida.

## Não fazer
- ❌ Apenas resetar a senha sem revogar sessões ativas (token roubado continua válido).
- ❌ Ignorar regras de encaminhamento ocultas (muitas vezes configuradas para não aparecer na UI padrão — auditar via PowerShell/API).
- ❌ Assumir que é um caso isolado sem verificar se outras contas no domínio foram visadas pela mesma campanha.
- ❌ Demorar para contatar o financeiro quando há fraude em andamento — a janela de reversão bancária é de minutos a poucas horas.

## Referência completa
→ Ver [`Attack-Categories/BEC/README.md`](../Attack-Categories/BEC/README.md) para as 7 fases completas, evidências (incluindo auditoria de Inbox Rules e OAuth grants), ferramentas e casos reais.
