/* ============================================================
   Capítulo 4 – E os clientes? Como se comportam?
   ------------------------------------------------------------
   O objetivo é analisar o perfil e o comportamento de compra 
   dos clientes: concentração de vendas e prazos de envio.
   ============================================================ */

 /* ============================================================
    1. Existe concentração de vendas por estado ou cidade?
    ------------------------------------------------------------
    - Calcula o valor total vendido em cada estado e cidade.
    - Considera apenas pedidos concluídos (order_status = 4).
    - Ordena pelo valor total decrescente para destacar os polos.
    ============================================================ */
select 
    c.state,
    c.city,
    sum(oi.quantity * oi.list_price * (1 - oi.discount)) as valor_total
from sales.customers c
join sales.orders o on c.customer_id = o.customer_id
join sales.order_items oi on o.order_id = oi.order_id
where o.order_status = 4
group by c.state, c.city
order by valor_total desc;

 /* ============================================================
    2. Qual o ciclo médio entre pedido e envio por região?
    ------------------------------------------------------------
    - Mede o tempo médio (em dias) entre a data do pedido 
      (order_date) e a data de envio (shipped_date).
    - Agrupa por estado para entender variações regionais.
    - Filtra apenas pedidos concluídos e já enviados.
    ============================================================ */
select 
    c.state,
    avg(datediff(day, o.order_date, o.shipped_date)) as ciclo_medio_dias
from sales.customers c
join sales.orders o on c.customer_id = o.customer_id
where o.order_status = 4 
  and o.shipped_date is not null
group by c.state
order by ciclo_medio_dias asc;
