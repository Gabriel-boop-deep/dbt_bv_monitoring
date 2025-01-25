{{ config(materialized='table') }}

with stg_agencias as (
    select * from {{ ref('stg_agencias') }}
)

select
    {{ dbt_utils.generate_surrogate_key(['agencia_id', 'agencia_nome', 'agencia_endereco']) }} as agencia_sk,
    agencia_id,
    agencia_nome,
    agencia_endereco,
    agencia_cidade,
    agencia_estado,
    data_abertura,
    tipo_agencia
from stg_agencias
