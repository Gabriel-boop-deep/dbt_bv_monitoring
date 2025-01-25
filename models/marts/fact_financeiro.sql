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
    dim_dates as (
        select * from {{ ref('dim_dates') }}
    ),
    fact_table as (
        select * from {{ ref('int_bv_conta') }}
    ),

    dim_transacoes_ranked as (
        select
            *,
            row_number() over (
                partition by conta_id 
                order by data_transacao desc
            ) as row_num
        from {{ ref('dim_transacoes') }}
    ),

    joined_table as (
        select
            {{ dbt_utils.generate_surrogate_key(['fact_table.cliente_id', 'dim_agencias.agencia_sk', 'dim_clientes.cliente_sk']) }} as financeiro_sk,
            fact_table.cliente_id as cliente_id,
            fact_table.conta_id as conta_id,
            dim_dates.metric_date as data_fk,
            dim_agencias.agencia_sk as agencia_fk,
            dim_clientes.cliente_sk as cliente_fk,
            dim_colaboradores.colaborador_sk as colaborador_fk,
            dim_propostas_credito.proposta_sk as proposta_fk,
            dim_transacoes.transacao_sk as transacao_fk,
            dim_transacoes.data_transacao,
            fact_table.saldo_total,
            fact_table.saldo_disponivel,
            fact_table.data_abertura,
            fact_table.data_ultimo_lancamento,
            dim_transacoes.valor_transacao
        from fact_table
        left join dim_agencias
            on fact_table.agencia_id = dim_agencias.agencia_id
        left join dim_clientes
            on fact_table.cliente_id = dim_clientes.cliente_id
            and fact_table.conta_id = dim_clientes.cliente_id
        left join dim_colaboradores
            on fact_table.colaborador_id = dim_colaboradores.colaborador_id
            and fact_table.agencia_id = dim_colaboradores.agencia_id
        left join dim_dates
            on fact_table.data_abertura = dim_dates.metric_date
        left join dim_transacoes_ranked dim_transacoes
            on fact_table.conta_id = dim_transacoes.conta_id
            and dim_transacoes.data_transacao between fact_table.data_abertura and fact_table.data_ultimo_lancamento
            and dim_transacoes.row_num = 1
        left join dim_propostas_credito
            on fact_table.colaborador_id = dim_propostas_credito.colaborador_id
            and fact_table.cliente_id = dim_propostas_credito.cliente_id
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
    data_fk,
    data_transacao,
    data_abertura,
    data_ultimo_lancamento,
    saldo_total,
    saldo_disponivel,
    valor_transacao
from joined_table
