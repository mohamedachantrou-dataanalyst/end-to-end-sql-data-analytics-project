CREATE OR REPLACE VIEW mart_customer_kpis AS
SELECT 

customer_id,
full_name,
email,
country,
signup_date,
DENSE_RANK() OVER(ORDER BY signup_date) AS customer_tenure_rank,
COUNT(DISTINCT order_id) AS total_orders,
COUNT(DISTINCT CASE WHEN status = 'COMPLETED' THEN order_id ELSE NULL END) AS completed_orders,
COUNT(DISTINCT CASE WHEN status = 'CANCELLED' THEN order_id ELSE NULL END) AS cancelled_orders,
COUNT(DISTINCT product_id) AS unique_products_purchased,
SUM(quantity) AS total_quantity,
MIN(order_date) AS first_order_date,
MAX(order_date) AS last_order_date,
DATEDIFF(MAX(order_date), MIN(order_date)) AS customer_lifespan_days,
loyalty_tier,
SUM(total_line) AS sales_eur,
ROUND(SUM(total_line) / COUNT(DISTINCT order_id), 2) AS avg_basket_eur,
DENSE_RANK() OVER(ORDER BY SUM(total_line) DESC) AS customer_rank_sales


FROM int_orders_enriched
GROUP BY customer_id, full_name, email, country, signup_date, loyalty_tier
ORDER BY customer_id
