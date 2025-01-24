{{ config(materialized='table') }}

with 
    agencias as (
        select *
        from {{ ref('stg_agencias') }}
    )

    , dim_agencias as (
        select
            agencias.agencia_id,
            agencias.agencia_nome,
            agencias.agencia_endereco,
            agencias.agencia_cidade,
            agencias.agencia_estado,
            agencias.data_abertura,
            agencias.tipo_agencia
        from agencias
    )

    , dim_agencias_sk as (
        select
            {{ dbt_utils.generate_surrogate_key(['agencia_id']) }} as agencia_sk,
            *
        from dim_agencias
    )

select *
from dim_agencias_sk
