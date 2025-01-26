### 📊 **Análise e Monitoramento de Dados - BanVic**

---

#### 🏦 **Introdução**

Este repositório documenta o desenvolvimento de um projeto de **Engenharia de Analytics e Análise de Dados** para o Banco Vitória S.A. (**BanVic**), uma instituição financeira nacional fictícia que busca evoluir em sua **cultura de dados** e implementar um ecossistema analítico robusto. O projeto se propõe a transformar os dados brutos em insights estratégicos, utilizando as melhores práticas do **Modern Data Stack (MDS)**.

A proposta é construir uma **estrutura de dados escalável e moderna**, criando um pipeline que abrange desde a **transformação dos dados** até a **visualização em dashboards interativos**, permitindo tomadas de decisão baseadas em dados.

---

#### 🎯 **Objetivo do Projeto**

- **Aprimorar a cultura de dados do BanVic**: Demonstrar como o uso de dados pode gerar valor estratégico, aprimorar a experiência do cliente e otimizar as operações.
- **Estruturar o Data Warehouse do BanVic**: Usar o modelo **Star Schema** para criar dimensões e fatos que suportem análises robustas.
- **Fornecer insights para os desafios estratégicos**: Responder às perguntas de negócio com análises baseadas em indicadores financeiros e operacionais.
- **Convencer stakeholders**: Mostrar à equipe de liderança os benefícios da análise de dados por meio de visualizações e recomendações acionáveis.

---

#### ⚙️ **Ferramentas Utilizadas**

1. **dbt (Data Build Tool)**:
   - Realiza a **transformação de dados** de forma eficiente e escalável.
   - Facilita a gestão de **pipelines de dados** e promove a documentação automatizada.

2. **Google BigQuery**:
   - Data Warehouse que armazena e processa os dados do BanVic.
   - Permite análises rápidas e dimensionáveis, suportando grandes volumes de dados.

3. **Python**:
   - Usado para **análises exploratórias** e manipulação dos dados brutos.
   - Integra bibliotecas como **Pandas**, **NumPy** e **Matplotlib** para análises estatísticas e visualizações preliminares.

4. **Looker**:
   - Ferramenta de BI para criação de **dashboards interativos** e dinâmicos.
   - Permite o detalhamento das análises por **data**, **agência** e **cliente**.

5. **GitHub**:
   - Controle de versão para o código e documentação.
   - Garante rastreabilidade das mudanças e facilita a colaboração.

---

#### 📁 **Estrutura do Repositório**

```plaintext
📂 banvic-data-analytics
├── 📂 dbt_project       # Modelos e transformações do dbt
│   ├── 📂 models
│   │   ├── 📂 staging   # Modelos de tabelas intermediárias
│   │   ├── 📂 marts     # Tabelas finais (dimensões e fatos)
│   └── 📂 snapshots     # Snapshots para controle de histórico
├── 📂 python_scripts    # Scripts para análise exploratória e enriquecimento
├── 📂 looker_dashboard  # Configuração e snapshots do dashboard no Looker
├── 📂 docs              # Documentação geral do projeto
│   ├── README.md        # Este arquivo!
│   ├── 📂 yaml_files    # Arquivos de documentação de tabelas dbt
│   ├── data_transformations.pdf # Relatório sobre tratamentos aplicados
│   └── business_analysis.pdf   # Relatório final para a CEO do BanVic
├── 📂 data              # Dados de entrada e intermediários
└── 📂 videos            # Link para vídeo explicativo
```

---

#### 🛠️ **Principais Implementações**

1. **Estruturação do Star Schema**:
   - Dimensões criadas: `dim_dates`, `dim_clientes`, `dim_agencias`.
   - Tabelas fato: `fato_transacoes`, `fato_financeiro`.
   - Uso de **surrogate keys** para as dimensões e **foreign keys** nas tabelas fato.

2. **Data Transformations**:
   - Criação de pipelines no dbt para limpeza, transformação e agregação de dados.
   - Tratamento de inconsistências e normalização dos dados provenientes do ERP.

3. **Análise de Dados no Python**:
   - Validação de hipóteses com base nos dados transacionais.
   - Geração de insights preliminares para modelagem de KPIs.

4. **Dashboards no Looker**:
   - Indicadores como **volume de transações**, **receita por agência**, e **segmentação de clientes**.
   - Visualizações com filtros dinâmicos por trimestre, mês e localização.

---

#### 📈 **Modern Data Stack no BanVic**

Este projeto adota os princípios do **Modern Data Stack (MDS)**:
- **Flexibilidade**: Componentes modulares que permitem a integração de ferramentas específicas.
- **Escalabilidade**: Utilização de um Data Warehouse cloud-native (BigQuery) que suporta grandes volumes de dados.
- **Automação**: Transformações e documentação no dbt, reduzindo esforço manual.
- **Acessibilidade**: Dashboards interativos que democratizam o acesso aos insights.

---

#### 📝 **Desafios e Respostas**

1. **Análises Exploratórias**:
   - Identificação de padrões sazonais em transações.
   - Validação de hipóteses com dados financeiros.

2. **Indicadores Criados**:
   - KPI: Volume médio por trimestre.
   - KPI: Receita mensal por cliente.
   - Análise: Comparativo de meses com e sem "R" no nome.

3. **Recomendações Estratégicas**:
   - Ampliação do uso de ferramentas de BI no BanVic.
   - Investimento em marketing com base em clusters de clientes.
   - Enriquecimento do DW com dados externos (ex.: IPCA e tendências econômicas).

---

#### 🎥 **Demonstração**

O vídeo explicativo com o passo a passo do projeto está disponível neste link: [📹 Link para o vídeo no Google Drive](#).  
⚠️ Certifique-se de ter acesso autorizado para visualização.

---

#### 💡 **Conclusão**

Este projeto demonstra como a implementação de uma estrutura moderna de dados pode transformar o processo de tomada de decisão no Banco Vitória. Ao unir **tecnologia**, **estratégia de negócios**, e **análise de dados**, foi possível gerar insights significativos para alavancar a eficiência operacional e a experiência do cliente.

Com uma cultura de dados amadurecida, o BanVic pode consolidar-se ainda mais como uma instituição financeira inovadora, utilizando **dados como ativo estratégico**.
