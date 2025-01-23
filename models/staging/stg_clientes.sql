{{ config(materialized='table') }}

with raw_clientes as (
    select
        cod_cliente,
        primeiro_nome,
        ultimo_nome,
        email,
        tipo_cliente,
        data_inclusao,
        cpfcnpj,
        data_nascimento,
        endereco,
        cep
    from {{ source('banvic', 'clientes') }}
)

select
    cod_cliente as cliente_id, -- Código único do cliente
    primeiro_nome as cliente_primeiro_nome, -- Primeiro nome do cliente
    ultimo_nome as cliente_ultimo_nome, -- Último nome do cliente
    email as cliente_email, -- E-mail do cliente
    tipo_cliente, -- Tipo de cliente (ex.: individual ou empresa)
    date(data_inclusao) as data_inclusao, -- Data de inclusão do cliente DATE(data_abertura) AS data_abertura
    cpfcnpj as cliente_cpf_cnpj, -- CPF ou CNPJ do cliente
    date(data_nascimento)  as cliente_data_nascimento, -- Data de nascimento do cliente
    endereco as cliente_endereco, -- Endereço completo do cliente
    cep as cliente_cep -- CEP do cliente
from raw_clientes
