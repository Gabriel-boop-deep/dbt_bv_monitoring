{{ config(materialized='table') }}

with raw_propostas_credito as (
    select
        cod_proposta,
        cod_cliente,
        cod_colaborador,
        data_entrada_proposta,
        taxa_juros_mensal,
        valor_proposta,
        valor_financiamento,
        valor_entrada,
        valor_prestacao,
        quantidade_parcelas,
        carencia,
        status_proposta
    from {{ source('banvic', 'propostas_credito') }}
)

select
    cod_proposta as proposta_id, -- Código único da proposta
    cod_cliente as cliente_id, -- Código do cliente associado à proposta
    cod_colaborador as colaborador_id, -- Código do colaborador associado
    date(data_entrada_proposta) as data_entrada, -- Data de entrada da proposta
    taxa_juros_mensal, -- Taxa de juros mensal
    valor_proposta, -- Valor total da proposta
    valor_financiamento, -- Valor do financiamento
    valor_entrada, -- Valor de entrada
    valor_prestacao, -- Valor da prestação
    quantidade_parcelas, -- Número de parcelas
    carencia, -- Período de carência (em meses)
    status_proposta -- Status atual da proposta
from raw_propostas_credito
