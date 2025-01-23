{{ config(materialized='table') }}

with raw_contas as (
    select
        num_conta,
        cod_cliente,
        cod_agencia,
        cod_colaborador,
        tipo_conta,
        data_abertura,
        saldo_total,
        saldo_disponivel,
        data_ultimo_lancamento
    from {{ source('banvic', 'contas') }}
)

select
    num_conta as conta_id, -- Número único da conta
    cod_cliente as cliente_id, -- Código do cliente associado à conta
    cod_agencia as agencia_id, -- Código da agência da conta
    cod_colaborador as colaborador_id, -- Código do colaborador associado à conta
    tipo_conta, -- Tipo da conta (ex.: corrente ou poupança)
    date(data_abertura) as data_abertura, -- Data de abertura da conta
    saldo_total, -- Saldo total da conta
    saldo_disponivel, -- Saldo disponível da conta
    date(data_ultimo_lancamento) as data_ultimo_lancamento -- Data do último lançamento
from raw_contas
