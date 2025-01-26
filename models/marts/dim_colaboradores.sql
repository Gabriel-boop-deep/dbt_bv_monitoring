{{ config(materialized="table") }}

with
    stg_colaboradores as (select * from {{ ref("stg_colaboradores") }}),
    stg_colaboradores_agencia as (select * from {{ ref("stg_colaborador_agencia") }}),

    stg_agencias as (select * from {{ ref("stg_agencias") }}),

    joined_table as (
        select
            {{
                dbt_utils.generate_surrogate_key(
                    [
                        "stg_colaboradores.colaborador_id",
                        "stg_colaboradores.colaborador_email",
                        "stg_colaboradores_agencia.agencia_id",
                    ]
                )
            }} as colaborador_sk,
            stg_colaboradores.colaborador_id as colaborador_id,
            stg_colaboradores_agencia.agencia_id as agencia_id,
            stg_agencias.agencia_nome,
            stg_agencias.agencia_endereco,
            stg_agencias.agencia_cidade,
            stg_agencias.agencia_estado,
            stg_agencias.data_abertura,
            stg_agencias.tipo_agencia,
            stg_colaboradores.colaborador_nome as colaborador_nome,
            stg_colaboradores.colaborador_sobrenome as colaborador_sobrenome,
            stg_colaboradores.colaborador_email as colaborador_email
        from stg_colaboradores_agencia
        left join
            stg_colaboradores
            on stg_colaboradores_agencia.colaborador_id
            = stg_colaboradores.colaborador_id
        left join
            stg_agencias
            on stg_colaboradores_agencia.agencia_id = stg_agencias.agencia_id

    )

select *
from joined_table
