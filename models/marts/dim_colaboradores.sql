{{ config(materialized='table') }}

with stg_colaboradores as (
    select * from {{ ref('stg_colaboradores') }}
)

select
    {{ dbt_utils.generate_surrogate_key(['colaborador_id', 'colaborador_email', 'data_nascimento']) }} as colaborador_sk,
    colaborador_id,
    colaborador_nome,
    colaborador_sobrenome,
    colaborador_email,
    colaborador_cpf,
    data_nascimento,
    colaborador_endereco,
    colaborador_cep
from stg_colaboradores
