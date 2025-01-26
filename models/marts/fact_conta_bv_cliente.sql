{{ config(materialized='table') }}

with 
    dim_dates as (
        select * from {{ ref('dim_dates') }}
    ),

    fact_table as (
        select * from {{ ref('int_bv_conta') }}
    ),

    dim_colaboradores as (
        select * from {{ ref('dim_colaboradores')}}
    ),

    joined_table as (
        select
            {{ dbt_utils.generate_surrogate_key(['fact_table.cliente_id', 'dim_dates.metric_date']) }} as financeiro_sk,
            fact_table.cliente_id as cliente_id,
            fact_table.conta_id as conta_id,
            dim_dates.metric_date as data_fk,
            dim_colaboradores.colaborador_sk as colaborador_fk,
            fact_table.saldo_total,
            fact_table.saldo_disponivel,
            fact_table.data_abertura,
            fact_table.data_ultimo_lancamento
        from fact_table
        left join dim_colaboradores
            on fact_table.colaborador_id = dim_colaboradores.colaborador_id
            and fact_table.agencia_id = dim_colaboradores.agencia_id
        left join dim_dates
            on fact_table.data_abertura = dim_dates.metric_date
            
    )

select
    financeiro_sk,
    colaborador_fk,
    data_fk,
    conta_id,
    cliente_id,
    data_abertura,
    data_ultimo_lancamento,
    saldo_total,
    saldo_disponivel
from joined_table
