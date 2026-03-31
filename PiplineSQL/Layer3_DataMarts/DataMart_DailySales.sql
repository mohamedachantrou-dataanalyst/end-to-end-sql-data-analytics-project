CREATE OR REPLACE VIEW mart_sales_daily AS
SELECT 

order_date,
DAYNAME(order_date) AS day_of_week,
COUNT(DISTINCT order_id) AS total_orders,
ROUND(
        COUNT(DISTINCT CASE WHEN status = 'COMPLETED' THEN order_id ELSE NULL END) * 100.0 
        / COUNT(DISTINCT order_id),
        2
    ) AS completed_orders_pct,
ROUND(
        COUNT(DISTINCT CASE WHEN status = 'CANCELLED' THEN order_id ELSE NULL END) * 100.0 
        / COUNT(DISTINCT order_id),
        2
    ) AS cancelled_orders_pct,
COUNT(DISTINCT customer_id) AS total_customers,
COUNT(DISTINCT product_id) AS unique_products_sold,
SUM(quantity) AS total_quantity,
SUM(total_line) AS sales_eur,
ROUND(SUM(total_line) / COUNT(DISTINCT order_id), 2) AS avg_basket_eur

FROM int_orders_enriched
GROUP BY order_date
ORDER BY order_date