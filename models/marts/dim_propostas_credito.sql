{{ config(materialized='table') }}

with stg_propostas_credito as (
    select * from {{ ref('stg_propostas_credito') }}
),

stg_clientes as (
    select * from {{ ref('stg_clientes') }}
),

joined_table as (
    select
        {{ dbt_utils.generate_surrogate_key(['stg_propostas_credito.proposta_id', 'stg_propostas_credito.cliente_id', 'stg_propostas_credito.data_entrada']) }} as proposta_sk,
        stg_propostas_credito.proposta_id,
        stg_propostas_credito.cliente_id,
        stg_propostas_credito.colaborador_id,
        stg_clientes.cliente_primeiro_nome,
        stg_clientes.tipo_cliente,
        stg_clientes.cliente_endereco,
        stg_propostas_credito.data_entrada,
        stg_propostas_credito.taxa_juros_mensal,
        stg_propostas_credito.valor_proposta,
        stg_propostas_credito.valor_financiamento,
        stg_propostas_credito.valor_entrada,
        stg_propostas_credito.valor_prestacao,
        stg_propostas_credito.quantidade_parcelas,
        stg_propostas_credito.carencia,
        stg_propostas_credito.status_proposta
    from stg_propostas_credito
    left join stg_clientes
        on stg_propostas_credito.cliente_id=stg_clientes.cliente_id
)

select
    *
from joined_table
    
    