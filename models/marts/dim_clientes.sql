{{ config(materialized='table') }}

with stg_clientes as (
    select * from {{ ref('stg_clientes') }}
)

select
    {{ dbt_utils.generate_surrogate_key(['cliente_id', 'cliente_email', 'cliente_data_nascimento']) }} as cliente_sk,
    cliente_id,
    cliente_primeiro_nome,
    cliente_ultimo_nome,
    cliente_email,
    tipo_cliente,
    data_inclusao,
    cliente_cpf_cnpj,
    cliente_data_nascimento,
    cliente_endereco,
    cliente_cep
from stg_clientes
