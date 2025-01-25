{{ config(materialized='table') }}

with stg_transacoes as (
    select * from {{ ref('stg_transacoes') }}
)

select
    {{ dbt_utils.generate_surrogate_key(['transacao_id', 'data_transacao', 'valor_transacao']) }} as transacao_sk,
    transacao_id,
    conta_id,
    data_transacao,
    nome_transacao,
    valor_transacao
from stg_transacoes
