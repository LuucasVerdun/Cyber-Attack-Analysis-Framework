# Registro de Coleta de Evidências — IR-[AAAA]-[NNNN]

> Preencher um registro por item coletado. Cadeia de custódia é obrigatória para qualquer evidência que possa ser usada em processo disciplinar, judicial ou regulatório.

---

## Item de Evidência #[N]

| Campo | Valor |
|---|---|
| ID da evidência | EVD-[AAAA]-[NNNN]-[NN] |
| Descrição | [ex.: Imagem de disco do host WKS-001] |
| Tipo | [Disco / Memória / Log / Rede / Documento / Outro] |
| Origem (host/sistema) | |
| Coletado por | |
| Data/hora da coleta (UTC) | |
| Método de coleta | [ex.: KAPE, dd, Velociraptor, export nativo] |
| Ferramenta + versão | |
| Hash (SHA256) no momento da coleta | |
| Local de armazenamento | [ex.: storage forense, write-protected] |
| Hash de verificação (pós-transferência) | |

### Cadeia de Custódia

| Data/Hora | De | Para | Motivo | Hash verificado? |
|---|---|---|---|---|
| | | | | |

### Notas
[Condições da coleta, anomalias observadas, integridade confirmada/comprometida.]

---

## Ordem de Volatilidade (referência rápida)

Ao coletar evidência viva (live response), seguir do mais volátil ao menos volátil:

1. Registradores de CPU, cache
2. Tabela de roteamento, cache ARP, tabela de processos, estatísticas de kernel, memória RAM
3. Estado de sistema de arquivos temporário
4. Disco
5. Logs remotos e dados de monitoramento relevantes ao sistema em questão
6. Configuração física / topologia de rede
7. Mídia de arquivo/backup

---

## Checklist de Integridade

- [ ] Hash calculado imediatamente após a coleta
- [ ] Hash verificado após qualquer transferência
- [ ] Evidência original preservada (write blocker / read-only)
- [ ] Análise realizada apenas em cópia forense, nunca no original
- [ ] Acesso à evidência restrito e registrado
- [ ] Cadeia de custódia sem lacunas de tempo não justificadas
