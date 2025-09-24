/* ============================================================
   Capítulo 3 – Há gargalos no estoque?
   ------------------------------------------------------------
   O objetivo é identificar possíveis riscos de ruptura e 
   analisar o equilíbrio entre vendas e disponibilidade.
   ============================================================ */

 /* ============================================================
    1. Quais produtos têm estoque abaixo da média na maioria das lojas?
    ------------------------------------------------------------
    - Calcula o estoque médio por produto em todas as lojas.
    - Compara esse valor com a média geral da base.
    - Retorna apenas os produtos cujo estoque está abaixo da média.
    ============================================================ */
select 
    p.product_name,
    avg(stk.quantity) as estoque_medio_por_loja
from production.stocks stk
join production.products p on stk.product_id = p.product_id
group by p.product_name
having avg(stk.quantity) < (
    select avg(quantity) from production.stocks
)
order by estoque_medio_por_loja asc;

 /* ============================================================
    2. Quais produtos onde as vendas superam ou chegam perto do estoque?
    ------------------------------------------------------------
    - Soma total vendido e total em estoque por produto.
    - Calcula a razão vendas/estoque:
        * valores > 1 → vendas maiores que estoque (gargalo imediato).
        * valores próximos de 1 → estoque quase esgotado.
        * valores baixos → estoque folgado em relação à demanda.
    - Filtra apenas produtos que tiveram vendas.
    ============================================================ */
select 
    p.product_name,
    sum(oi.quantity) as total_vendido,
    sum(stk.quantity) as total_estoque,
    cast(sum(oi.quantity) as float) / nullif(sum(stk.quantity),0) as razao_venda_estoque
from sales.order_items oi
join production.products p on oi.product_id = p.product_id
join sales.orders o on oi.order_id = o.order_id
join production.stocks stk on p.product_id = stk.product_id
where o.order_status = 4
group by p.product_name
having sum(oi.quantity) > 0
order by razao_venda_estoque desc;

 /* ============================================================
    3. Qual a relação entre vendas e estoque por categoria?
    ------------------------------------------------------------
    - Consolida as informações de vendas e estoque por categoria.
    - Mostra quais categorias têm maior saída em comparação ao estoque.
    - Útil para identificar desequilíbrios em nível agregado.
    ============================================================ */
select 
    c.category_name,
    sum(oi.quantity) as total_vendido,
    sum(stk.quantity) as total_estoque
from production.categories c
join production.products p on c.category_id = p.category_id
join sales.order_items oi on p.product_id = oi.product_id
join sales.orders o on oi.order_id = o.order_id
join production.stocks stk on p.product_id = stk.product_id
where o.order_status = 4
group by c.category_name
order by total_vendido desc;
