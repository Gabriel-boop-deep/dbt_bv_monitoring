{{ config(materialized='table') }}

with 
    dim_agencias as (
        select * from {{ ref('dim_agencias') }}
    ),
    dim_clientes as (
        select * from {{ ref('dim_clientes') }}
    ),
    dim_colaboradores as (
        select * from {{ ref('dim_colaboradores') }}
    ),
    dim_propostas_credito as (
        select * from {{ ref('dim_propostas_credito') }}
    ),
    dim_transacoes as (
        select * from {{ ref('dim_transacoes') }}
    ),
    dim_dates as (
        select *from {{ref('dim_dates')}}
    ),
    fact_table as (
        select * from {{ref('int_bv_conta')}}
    ),


    joined_table as (
        select
            {{ dbt_utils.generate_surrogate_key(['fact_table.cliente_id', 'dim_agencias.agencia_sk', 'dim_clientes.cliente_sk']) }} as financeiro_sk,
            fact_table.cliente_id as cliente_id,
            fact_table.conta_id as conta_id,
            dim_agencias.agencia_sk as agencia_fk,
            dim_clientes.cliente_sk as cliente_fk,
            dim_colaboradores.colaborador_sk as colaborador_fk,
            dim_propostas_credito.proposta_sk as proposta_fk,
            dim_transacoes.transacao_sk as transacao_fk,
            dim_transacoes.data_transacao,
            fact_table.saldo_total,
            fact_table.saldo_disponivel,
            dim_transacoes.valor_transacao
        from fact_table
        left join dim_agencias
            on fact_table.agencia_id = dim_agencias.agencia_id
        left join dim_clientes
            on fact_table.cliente_id = dim_clientes.cliente_id
        left join dim_colaboradores
            on fact_table.colaborador_id = dim_colaboradores.colaborador_id
        left join dim_dates
            on fact_table.data_abertura = dim_dates.metric_date
        left join dim_transacoes
            on fact_table.conta_id = dim_transacoes.conta_id
        left join dim_propostas_credito
            on fact_table.cliente_id = dim_propostas_credito.cliente_id
            and fact_table.colaborador_id = dim_propostas_credito.colaborador_id
    )

select
    financeiro_sk,
    conta_id,
    cliente_id,
    agencia_fk,
    cliente_fk,
    colaborador_fk,
    proposta_fk,
    transacao_fk,
    data_transacao,
    saldo_total,
    saldo_disponivel,
    valor_transacao
from joined_table
