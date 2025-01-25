{{ config(materialized='table') }}

with stg_colaboradores as (
    select * from {{ ref('stg_colaboradores') }}
),
stg_colaboradores_agencia as (
    select * from {{ ref('stg_colaborador_agencia')}}
),

joined_table as (
    select
        {{ dbt_utils.generate_surrogate_key(['stg_colaboradores.colaborador_id', 'stg_colaboradores.colaborador_email', 'stg_colaboradores_agencia.agencia_id']) }} as colaborador_sk,
        stg_colaboradores.colaborador_id as colaborador_id,
        stg_colaboradores_agencia.agencia_id as agencia_id,
        stg_colaboradores.colaborador_nome as colaborador_nome,
        stg_colaboradores.colaborador_sobrenome as colaborador_sobrenome,
        stg_colaboradores.colaborador_email as colaborador_email
    from stg_colaboradores_agencia
    left join stg_colaboradores
        on stg_colaboradores_agencia.colaborador_id = stg_colaboradores.colaborador_id    

)

select
    colaborador_sk,
    colaborador_id,
    agencia_id,
    colaborador_nome,
    colaborador_sobrenome,
    colaborador_email
from joined_table
order by colaborador_id
