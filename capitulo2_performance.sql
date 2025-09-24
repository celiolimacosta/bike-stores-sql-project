/* ============================================================
   Capítulo 2 – Quem está fazendo a diferença?
   ------------------------------------------------------------
   Neste capítulo, o foco foi descobrir quem impulsiona os resultados:
   - Quais funcionários geraram mais receita recentemente.
   - Quais produtos sustentam a margem com preço alto e pouco desconto.
   ============================================================ */

 /* ============================================================
    1. Qual funcionário gerou mais receita no último semestre?
    ------------------------------------------------------------
    - Soma o valor total de vendas atribuídas a cada funcionário.
    - Considera apenas pedidos finalizados (order_status = 4).
    - Limita o período aos últimos 6 meses a partir da data atual.
    - Agrupa por funcionário e retorna o ranking decrescente.
    ============================================================ */
select 
    st.first_name + ' ' + st.last_name as funcionario,
    s.store_name as loja,
    sum(oi.quantity * oi.list_price * (1 - oi.discount)) as receita
from sales.orders o
join sales.order_items oi on o.order_id = oi.order_id
join sales.staffs st on o.staff_id = st.staff_id
join sales.stores s on s.store_id = st.store_id
where o.order_status = 4
  and o.order_date >= dateadd(month, -6, getdate())
group by st.first_name, st.last_name, s.store_name
order by receita desc;

 /* ============================================================
    2. Quais produtos possuem maior valor médio de venda e menor desconto aplicado?
    ------------------------------------------------------------
    - Calcula o preço médio de venda (list_price - desconto).
    - Calcula o desconto médio aplicado em cada produto.
    - Agrupa por produto e ordena:
      * primeiro pelo maior preço médio de venda,
      * depois pelo menor desconto médio.
    ============================================================ */
select 
    p.product_name as produto,
    avg(oi.list_price * (1 - oi.discount)) as preco_medio_venda,
    avg(oi.discount) as desconto_medio
from sales.order_items oi
join production.products p on oi.product_id = p.product_id
join sales.orders o on o.order_id = oi.order_id
where o.order_status = 4
group by p.product_name
order by preco_medio_venda desc, desconto_medio asc;
