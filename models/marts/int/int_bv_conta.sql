with
    stg_contas as (
        select *
        from {{ ref('stg_contas') }}
    )
 
    , 
    fact_table as (
        select
        conta_id, -- Número único da conta
        cliente_id, -- Código do cliente associado à conta
        agencia_id, -- Código da agência da conta
        colaborador_id,
        data_abertura,
        tipo_conta, -- Tipo da conta (ex.: corrente ou poupança)
        saldo_total, -- Saldo total da conta
        saldo_disponivel, -- Saldo disponível da conta
        data_ultimo_lancamento
        from stg_contas
    )

select *
from fact_table