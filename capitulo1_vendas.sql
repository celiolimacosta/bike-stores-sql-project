/* ============================================================
   Capítulo 1 – Por onde começar?
   ============================================================ */

 /* ============================================================
    1. Qual foi o total de vendas mês a mês?
    ------------------------------------------------------------
    - Calcula a receita líquida mensal, considerando os descontos aplicados.
    - Agrupa por mês e ano no formato 'Jan - 2016', facilitando a leitura.
    - A receita é formatada como moeda americana para uma apresentação mais clara.
    ============================================================ */
select
  concat(left(datename(month, o.order_date), 3), ' - ', year(o.order_date)) as mes_ano,
  format(sum(oi.quantity * oi.list_price * (1 - oi.discount)), 'C', 'en-US') as receita_total
from sales.orders o
join sales.order_items oi on o.order_id = oi.order_id
group by year(o.order_date), month(o.order_date), datename(month, o.order_date)
order by year(o.order_date), month(o.order_date);

 /* ============================================================
    2. Quanto os clientes gastam, em média, em cada loja?
    ------------------------------------------------------------
    - Calcula o ticket médio por loja:
      * Soma o valor total de vendas por loja (quantidade * preço * desconto).
      * Divide esse valor pelo número de pedidos distintos (order_id).
      * Formata o resultado como moeda americana (ex: $215,146.42).
    - Ordena as lojas da maior para a menor média.
    ============================================================ */
select
  s.store_name,
  format(
    sum(oi.quantity * oi.list_price * (1 - oi.discount)) / count(distinct o.order_id),
    'C','en-US'
  ) as ticket_medio
from sales.orders o
join sales.order_items oi on o.order_id = oi.order_id
join sales.stores s on o.store_id = s.store_id
group by s.store_name 
order by ticket_medio desc;

 /* ============================================================
    3. O que cada estado prefere comprar?
    ------------------------------------------------------------
    - Ranqueia as categorias mais vendidas em cada estado:
      * Agrupa os dados por estado e categoria.
      * Soma o total de unidades vendidas (quantity).
      * Usa a função RANK() para ordenar as categorias por volume de vendas.
      * O ranking é reiniciado para cada estado (partition by state).
    - Útil para entender o comportamento regional de consumo por tipo de produto.
    ============================================================ */
select
  s.state,
  c.category_name,
  sum(oi.quantity) as total_vendido,
  rank() over (partition by s.state order by sum(oi.quantity) desc) as ranking_categoria
from sales.order_items oi
join sales.orders o on oi.order_id = o.order_id
join production.products p on oi.product_id = p.product_id
join production.categories c on p.category_id = c.category_id
join sales.stores s on o.store_id = s.store_id
group by s.state, c.category_name
order by s.state, ranking_categoria;
