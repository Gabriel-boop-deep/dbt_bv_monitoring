{{ config(materialized='table') }}

with raw_transacoes as (
    select
        cod_transacao,
        num_conta,
        data_transacao,
        nome_transacao,
        valor_transacao
    from {{ source('banvic', 'transacoes') }}
)

select
    cod_transacao as transacao_id, -- Código único da transação
    num_conta as conta_id, -- Conta associada à transação
    date(data_transacao) as data_transacao, -- Data da transação
    nome_transacao, -- Nome ou descrição da transação
    valor_transacao -- Valor associado à transação
from raw_transacoes
