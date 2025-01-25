{{ config(materialized='table') }}

with stg_propostas_credito as (
    select * from {{ ref('stg_propostas_credito') }}
)

select
    {{ dbt_utils.generate_surrogate_key(['proposta_id', 'cliente_id', 'data_entrada']) }} as proposta_sk,
    proposta_id,
    cliente_id,
    colaborador_id,
    data_entrada,
    taxa_juros_mensal,
    valor_proposta,
    valor_financiamento,
    valor_entrada,
    valor_prestacao,
    quantidade_parcelas,
    carencia,
    status_proposta
from stg_propostas_credito
