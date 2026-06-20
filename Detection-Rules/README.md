# Detection Rules

Repositório de regras de detecção prontas, organizadas por formato e mapeadas às categorias de `Attack-Categories/` e técnicas MITRE ATT&CK.

## Estrutura

```
Detection-Rules/
├── Sigma/        ← regras agnósticas de SIEM (YAML)
├── YARA/         ← assinaturas de malware/arquivo/memória
└── Suricata/     ← assinaturas de rede (IDS/IPS)
```

## Convenção de Nomenclatura

```
<categoria>_<descricao-curta>_<TXXXX>.{yml|yar|rules}
```

Exemplos:
- `Sigma/kerberoasting_excessive_tgs_requests_T1558.003.yml`
- `YARA/ransomware_lockbit_payload_T1486.yar`
- `Suricata/c2_dns_tunneling_T1071.004.rules`

## Convenção de Metadados (Sigma)

Toda regra Sigma deve incluir, no mínimo:

```yaml
title: <título descritivo>
id: <UUID>
status: experimental | test | stable
description: <o que detecta e por quê>
references:
    - <link para o playbook da categoria, ex: ../../Attack-Categories/Kerberoasting/README.md>
tags:
    - attack.credential_access
    - attack.t1558.003
logsource:
    category: <...>
    product: <...>
detection:
    selection:
        ...
    condition: selection
falsepositives:
    - <cenários conhecidos de falso positivo>
level: low | medium | high | critical
```

## Convenção de Metadados (YARA)

```c
rule categoria_descricao_TXXXX
{
    meta:
        author = "..."
        date = "AAAA-MM-DD"
        description = "..."
        mitre_attack = "TXXXX"
        reference = "../../Attack-Categories/<categoria>/README.md"
        hash = "<sha256 de amostra, se aplicável>"

    strings:
        ...

    condition:
        ...
}
```

## Convenção de Metadados (Suricata)

```
# categoria: <categoria> | mitre: TXXXX | ref: ../../Attack-Categories/<categoria>/README.md
alert <proto> $HOME_NET any -> $EXTERNAL_NET any (msg:"<descrição>"; ...; sid:<SID único>; rev:1;)
```

> Faixa de SID reservada para regras internas deste repositório: **9000000–9099999** (evita colisão com SIDs públicos do Emerging Threats/Suricata).

## Severidade e Tuning

Toda regra deve passar por um ciclo de tuning antes de ir para `level: high/critical` em produção:

1. Deploy em modo `experimental` / log-only por no mínimo 7 dias.
2. Revisão de falsos positivos com o time gerador do log de origem.
3. Promoção para `test` → `stable` conforme taxa de falso positivo aceitável (<5% recomendado para alertas críticos).

## Índice de Regras

| Categoria | Sigma | YARA | Suricata |
|---|---|---|---|
| Kerberoasting | ✅ | — | — |
| Ransomware | ✅ | ✅ | — |
| C2 | — | — | ✅ |

> 📌 Roadmap: expandir cobertura para todas as 16 categorias Full Playbook, depois para Quick-Reference de maior frequência (Brute-Force, Password-Spraying, Web-Attacks).
