# 📊 BikeStores SQL Analysis

Este projeto utiliza a base de dados **BikeStores** (2016–2018) para responder perguntas de negócio através de SQL.  
A análise foi organizada em capítulos que contam uma história sobre vendas, performance, estoque e clientes.

---

## 📂 Estrutura do Projeto
```
bike-stores-sql-project/
│
├── capitulo1_vendas.sql # consultas sobre panorama das vendas
├── capitulo2_performance.sql # lojas, funcionários e produtos de destaque
├── capitulo3_estoque.sql # gargalos e riscos de ruptura
├── capitulo4_clientes.sql # comportamento dos clientes
├── capitulo5_sazonalidade.sql # análise de padrões e tendências
└── dataset/
└── bike_stores_create.sql # script para criação das tabelas
```

---

## 🗂️ Capítulos da Análise

1. **Por onde começar?**  
   - Total de vendas mês a mês  
   - Ticket médio por loja  
   - Preferências de compra por estado  

2. **Quem está fazendo a diferença?** 
   - Funcionários com maior receita  
   - Produtos mais valiosos para a margem  

3. **Há gargalos no estoque?**  
   - Produtos com estoque abaixo da média  
   - Produtos de alta saída com estoque insuficiente  
   - Relação entre vendas e estoque por categoria  

4. **E os clientes? Como se comportam?**  
   - Concentração de vendas por região  
   - Ciclo médio entre pedido e envio  

5. **Existem padrões ou tendências nas vendas?**  
   - Evolução mensal por categoria  
   - Meses de pico  
   - Comparação entre anos  

---

## ▶️ Como Executar

1. Execute o script `dataset/BikeStores Sample Database - create objects.sql` para criar as tabelas da base.  
2. Em seguida, Execute o script `dataset/BikeStores Sample Database - load data.sql` para inserir os dados de exemplo (2016–2018).  
3. Execute os arquivos `.sql` de cada capítulo para reproduzir as análises.  

---

## 📫 Contato

[![LinkedIn](https://img.shields.io/badge/LinkedIn-blue?style=for-the-badge&logo=linkedin)](https://www.linkedin.com/in/celiolimacosta/)  
