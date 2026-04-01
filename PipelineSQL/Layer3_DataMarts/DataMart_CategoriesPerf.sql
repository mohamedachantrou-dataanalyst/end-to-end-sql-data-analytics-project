CREATE OR REPLACE VIEW mart_category_perf AS
SELECT 

category_id,
category_name,
COUNT(DISTINCT product_id) AS products_ordered,
COUNT(DISTINCT order_id) AS total_orders,
SUM(quantity) AS quantity_sold,
SUM(total_line) AS sales_eur,
DENSE_RANK() OVER(ORDER BY SUM(total_line) DESC) AS category_rank_sales,
ROUND(SUM(total_line) / COUNT(DISTINCT order_id), 2) AS avg_basket_eur,
DENSE_RANK() OVER(ORDER BY SUM(total_line) / COUNT(DISTINCT order_id) DESC) AS rank_avg_basket,
SUM(cost_price * quantity) AS total_cost,
SUM(gross_margin * quantity) AS theoric_margin_made,
SUM(total_line)-SUM(cost_price * quantity) AS real_margin_made,
ROUND(
    (SUM(total_line)-SUM(cost_price * quantity)) * 100 
    / SUM(total_line)
, 2) AS real_margin_pct,
DENSE_RANK() OVER(ORDER BY SUM(total_line)-SUM(cost_price * quantity) DESC) AS category_rank_margin,
DENSE_RANK() OVER(ORDER BY ROUND((SUM(total_line)-SUM(cost_price * quantity)) * 100 / SUM(total_line), 2) DESC) AS category_rank_margin_pct



FROM int_orders_enriched
GROUP BY category_id, category_name
ORDER BY category_id
