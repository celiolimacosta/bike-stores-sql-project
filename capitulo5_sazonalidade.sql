/* ============================================================
   Capítulo 5 – Existem padrões ou tendências nas vendas?
   ------------------------------------------------------------
   O foco é identificar se existe sazonalidade ao longo do tempo:
   - Evolução mensal por categoria.
   - Meses de pico em vendas.
   - Comparação entre os anos 2016, 2017 e 2018.
   ============================================================ */

 /* ============================================================
    1. Como as vendas evoluíram mês a mês por categoria?
    ------------------------------------------------------------
    - Mostra a evolução das vendas em cada mês, segmentada por categoria.
    - Considera apenas pedidos concluídos (order_status = 4).
    - Útil para identificar sazonalidade específica em categorias.
    ============================================================ */
select 
    year(o.order_date) as ano,
    month(o.order_date) as mes,
    c.category_name,
    sum(oi.quantity * oi.list_price * (1 - oi.discount)) as valor_vendas
from sales.orders o
join sales.order_items oi on o.order_id = oi.order_id
join production.products p on oi.product_id = p.product_id
join production.categories c on p.category_id = c.category_id
where o.order_status = 4
group by year(o.order_date), month(o.order_date), c.category_name
order by ano, mes, valor_vendas desc;

 /* ============================================================
    2. Quais foram os meses com maiores picos de venda?
    ------------------------------------------------------------
    - Lista os 5 meses com maior volume de vendas no período.
    - Considera pedidos concluídos.
    - Ordena do maior para o menor valor vendido.
    ============================================================ */
select top 5
    year(o.order_date) as ano,
    month(o.order_date) as mes,
    sum(oi.quantity * oi.list_price * (1 - oi.discount)) as valor_vendas
from sales.orders o
join sales.order_items oi on o.order_id = oi.order_id
where o.order_status = 4
group by year(o.order_date), month(o.order_date)
order by valor_vendas desc;

 /* ============================================================
    3. Existe diferença entre anos consecutivos (2016 → 2017 → 2018)?
    ------------------------------------------------------------
    - Soma o valor total de vendas por ano.
    - Permite comparação direta entre os anos disponíveis na base.
    - Mostra a tendência de crescimento ou retração no período.
    ============================================================ */
select 
    year(o.order_date) as ano,
    sum(oi.quantity * oi.list_price * (1 - oi.discount)) as valor_vendas
from sales.orders o
join sales.order_items oi on o.order_id = oi.order_id
where o.order_status = 4
group by year(o.order_date)
order by ano;
