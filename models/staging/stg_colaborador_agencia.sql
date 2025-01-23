{{ config(materialized='table') }}

with raw_colaborador_agencia as (
    select
        cod_colaborador,
        cod_agencia
    from {{ source('banvic', 'colaborador_agencia') }}
)

select
    cod_colaborador as colaborador_id, -- Código do colaborador
    cod_agencia as agencia_id -- Código da agência associada ao colaborador
from raw_colaborador_agencia
