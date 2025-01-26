{{ config(materialized='table') }}

with stg_transacoes as (
    select * from {{ ref('stg_transacoes') }}
),

stg_clientes as (
    select * from {{ ref('stg_clientes') }}
),

joined_table as (
    select
    {{ dbt_utils.generate_surrogate_key(['stg_transacoes.transacao_id', 'stg_transacoes.data_transacao', 'stg_transacoes.valor_transacao']) }} as transacao_sk,
    stg_transacoes.transacao_id,
    stg_transacoes.conta_id,
    stg_transacoes.data_transacao,
    stg_transacoes.nome_transacao,
    stg_transacoes.valor_transacao,
    stg_clientes.cliente_primeiro_nome,
    stg_clientes.tipo_cliente,
    stg_clientes.cliente_endereco
    from stg_transacoes
    left join stg_clientes
        on stg_transacoes.conta_id=stg_clientes.cliente_id
)

select * from joined_table
