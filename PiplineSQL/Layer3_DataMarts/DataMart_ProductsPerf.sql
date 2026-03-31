CREATE OR REPLACE VIEW mart_product_perf AS
SELECT 

product_id,
product_name,
category_id,
category_name,
brand,
cost_price,
retail_price,
gross_margin,
is_active,
MAX(order_date) AS last_purchase_date,
COUNT(*) AS times_sold,
SUM(quantity) AS quantity_sold,
SUM(total_line) AS sales_eur,
DENSE_RANK() OVER(ORDER BY SUM(total_line) DESC) AS product_rank_sales,
cost_price * SUM(quantity) AS total_cost,
gross_margin * SUM(quantity) AS theoric_margin_made,
SUM(total_line)-cost_price * SUM(quantity) AS real_margin_made,
ROUND(
    (SUM(total_line) - cost_price * SUM(quantity)) * 100 
    / SUM(total_line)
, 2) AS real_margin_pct,
DENSE_RANK() OVER(ORDER BY SUM(total_line)-cost_price * SUM(quantity) DESC) AS product_rank_margin,
DENSE_RANK() OVER(ORDER BY ROUND((SUM(total_line) - cost_price * SUM(quantity)) * 100 / SUM(total_line), 2) DESC) AS product_rank_margin_pct,
ROUND(AVG(discount_pct),2) AS avg_discount_pct


FROM int_orders_enriched
GROUP BY product_id, product_name, category_id, category_name, brand, cost_price, retail_price, gross_margin, is_active
ORDER BY product_id