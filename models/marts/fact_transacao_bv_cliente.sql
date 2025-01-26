{{ config(materialized="table") }}

with

    dim_dates as (select * from {{ ref("dim_dates") }}),
    dim_transacoes as (select * from {{ ref("dim_transacoes") }}),

    joined_table as (
        select
            {{
                dbt_utils.generate_surrogate_key(
                    [
                        "dim_transacoes.transacao_sk",
                        "dim_transacoes.conta_id",
                    ]
                )
            }} as financeiro_sk,
            dim_transacoes.conta_id as conta_id,
            dim_dates.metric_date as data_fk,
            dim_transacoes.transacao_sk as transacao_fk,
            dim_transacoes.data_transacao,
            dim_transacoes.valor_transacao
        from dim_transacoes

        left join dim_dates on dim_transacoes.data_transacao = dim_dates.metric_date

    )

select
    financeiro_sk,
    transacao_fk,
    data_fk,
    conta_id as cliente_id,
    data_transacao,
    valor_transacao
from joined_table
