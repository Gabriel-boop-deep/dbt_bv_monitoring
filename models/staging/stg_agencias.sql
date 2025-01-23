{{ config(materialized='table') }}

with raw_agencias as (
    select
        cod_agencia,
        nome,
        endereco,
        cidade,
        uf,
        data_abertura,
        tipo_agencia
    from {{ source('banvic', 'agencias') }}
)

select
    cod_agencia as agencia_id, -- Código único da agência
    nome as agencia_nome, -- Nome da agência
    endereco as agencia_endereco, -- Endereço completo da agência
    cidade as agencia_cidade, -- Cidade onde a agência está localizada
    uf as agencia_estado, -- Unidade federativa da agência
    cast(data_abertura as date) as data_abertura, -- Data de abertura da agência (convertida para formato date)
    tipo_agencia -- Tipo da agência (ex.: física ou digital)
from raw_agencias
