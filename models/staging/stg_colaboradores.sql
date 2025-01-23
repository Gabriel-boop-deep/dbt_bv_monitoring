{{ config(materialized='table') }}

with raw_colaboradores as (
    select
        cod_colaborador,
        primeiro_nome,
        ultimo_nome,
        email,
        cpf,
        data_nascimento,
        endereco,
        cep
    from {{ source('banvic', 'colaboradores') }}
)

select
    cod_colaborador as colaborador_id, -- Código único do colaborador
    primeiro_nome as colaborador_nome, -- Nome do colaborador
    ultimo_nome as colaborador_sobrenome, -- Sobrenome do colaborador
    email as colaborador_email, -- Email do colaborador
    cpf as colaborador_cpf, -- CPF do colaborador
    cast(data_nascimento as date) as data_nascimento, -- Data de nascimento do colaborador
    endereco as colaborador_endereco, -- Endereço do colaborador
    cep as colaborador_cep -- CEP do colaborador
from raw_colaboradores
