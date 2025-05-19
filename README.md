# 📦 EcommerceDB

Sistema de banco de dados para simulação de um e-commerce, desenvolvido com Microsoft SQL Server. Este projeto visa praticar modelagem de dados, criação de views analíticas, procedures, inserção de dados e consultas SQL realistas baseadas em cenários de negócio.

---

## 🧠 Objetivo do Projeto

- Criar um banco relacional para representar um cenário de e-commerce.
- Popular as tabelas com dados simulados.
- Construir views e procedures que auxiliam na geração de insights analíticos.
- Praticar SQL com foco em performance, organização e clareza de consultas.

---

## 🗂 Estrutura do Projeto
```
EcommerceDB/
├── README.md
├── database/
│ ├── ddl_tabels.sql # Criação das tabelas e relacionamentos
│ ├── views.sql/ # Scripts das views analíticas
│ ├── procedures.sql/ # Procedures para relatórios e transformação de dados
│ └── inserts.sql/
│ └── queries.sql
├── images/ # Prints e diagramas do projeto
│ ├── views/
│ └── procedures/
└── LICENSE
```


---

## 🧱 Modelagem do Banco

O modelo simula as principais operações de um e-commerce:

- `Customers`: Cadastro de clientes.
- `Products`: Catálogo de produtos.
- `Orders`: Pedidos realizados pelos clientes.
- `OrderItems`: Produtos em cada pedido.

---

## 📊 Views Criadas

| View | Descrição |
|------|-----------|
| `VW_BEST_SELLING_PROD` | Produtos mais vendidos por quantidade |
| `VW_CUSTOMER_ORDERS_SUMMARY` | Total de pedidos e gastos por cliente |
| `VW_DW_CUSTOMER_LTV` | Lifetime Value de cada cliente |
| `VW_DW_REVENUE_BY_DATE` | Receita diária |
| `VW_DW_TOP_PRODUCTS` | Top produtos por volume e receita |
| `VW_MONTHLY_REVENUE` | Receita mensal consolidada |
| `VW_SALES_BY_CATEGORY` | Faturamento por categoria |
| `VW_SALES_BY_CUSTOMER` | Total de vendas por cliente |

---

## ⚙️ Stored Procedures

| Procedure | Finalidade |
|----------|-------------|
| `SP_GENERATE_DAILY_REVENUE` | Gera receita diária na DW |
| `SP_POPULATE_DW_CUSTOMER_LTV` | Calcula e grava o LTV por cliente |
| `SP_POPULATE_DW_REVENUE_BY_DATE` | Popula DW de receita por data |
| `SP_POPULATE_DW_TOP_PRODUCTS` | Gera ranking de produtos mais vendidos |

---

## 📈 Consultas SQL de Análise

Você encontrará consultas no diretório `queries/`, com exemplos como:

- Total de pedidos por cliente
- Produto mais vendido (por quantidade)
- Top 5 clientes que mais gastaram no e-commerce
- Total de vendas por mês
- Clientes que fizeram apenas um pedido
- Categorias mais vendidas por volume e faturamento
- Produtos mais vendidos

---

## 🖼 Prints e Evidências

Veja as capturas de tela na pasta `images/` com evidências da execução das queries, views e procedures.

- `images/views/` → prints das views criadas
- `images/procedures/` → prints da execução das procedures

---

## 🚀 Como Executar o Projeto

1. Clone este repositório:

```bash
git clone https://github.com/seuusuario/EcommerceDB.git
cd EcommerceDB
```
## No SQL Server Management Studio (SSMS):

- Execute database/schema.sql para criar as tabelas.

- Execute data/seed_data.sql para inserir os dados simulados.

- Execute os scripts da pasta views/ para criar as views analíticas.

- Execute os scripts da pasta procedures/ para criar as stored procedures.

## Para gerar insights:

- Use as queries do diretório queries/

- Execute as procedures para alimentar a camada DW

## 💡 Requisitos
- SQL Server 2022 ou compatível

- SQL Server Management Studio (SSMS)

- Acesso local ao banco (pode ser via Docker, VM ou instalação direta)







