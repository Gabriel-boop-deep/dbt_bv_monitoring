{{ config(materialized="table") }}

with

    dim_colaboradores as (select * from {{ ref("dim_colaboradores") }}),
    dim_propostas_credito as (select * from {{ ref("dim_propostas_credito") }}),
    dim_dates as (select * from {{ ref("dim_dates") }}),

    joined_table as (
        select
            {{
                dbt_utils.generate_surrogate_key(
                    [
                        "dim_propostas_credito.cliente_id",
                        "dim_propostas_credito.proposta_sk",
                    ]
                )
            }} as financeiro_sk,
            dim_dates.metric_date as data_fk,
            dim_colaboradores.colaborador_sk as colaborador_fk,
            dim_propostas_credito.proposta_sk as proposta_fk,
            dim_propostas_credito.cliente_id,
            dim_propostas_credito.data_entrada,
            dim_propostas_credito.taxa_juros_mensal,
            dim_propostas_credito.valor_proposta,
            dim_propostas_credito.valor_financiamento,
            dim_propostas_credito.valor_entrada,
            dim_propostas_credito.valor_prestacao,
            dim_propostas_credito.quantidade_parcelas,
            dim_propostas_credito.carencia,
            dim_propostas_credito.status_proposta
        from dim_propostas_credito
        left join
            dim_colaboradores
            on dim_propostas_credito.colaborador_id = dim_colaboradores.colaborador_id
        left join
            dim_dates on dim_propostas_credito.data_entrada = dim_dates.metric_date

    )

select
    financeiro_sk,
    colaborador_fk,
    proposta_fk,
    data_fk,
    cliente_id,
    taxa_juros_mensal,
    valor_proposta,
    valor_financiamento,
    valor_entrada,
    valor_prestacao,
    quantidade_parcelas,
    carencia,
    status_proposta
from joined_table
