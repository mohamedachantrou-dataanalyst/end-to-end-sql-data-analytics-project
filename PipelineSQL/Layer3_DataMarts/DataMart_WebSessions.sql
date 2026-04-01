CREATE OR REPLACE VIEW mart_sessions AS
SELECT

source_channel,
COUNT(session_id) AS number_of_sessions,
ROUND(AVG(session_duration), 2) AS avg_session_duration_min,
SUM(page_views) AS total_page_views,
ROUND(AVG(page_views), 2) AS avg_page_views,
DENSE_RANK() OVER(ORDER BY AVG(page_views) DESC) AS avg_page_views_rank,
SUM(CASE WHEN converted = TRUE THEN 1 ELSE 0 END) AS visits_converted,
ROUND(SUM(converted)*100 / COUNT(session_id),2) AS conversion_rate,
DENSE_RANK() OVER(ORDER BY SUM(converted)*100 / COUNT(session_id) DESC) AS cr_rank,
COUNT(DISTINCT customer_id) AS total_customers,
COUNT(DISTINCT CASE WHEN country <> 'Unknown' THEN country ELSE NULL END) AS countries,
COUNT(CASE WHEN country = 'Unknown' THEN country ELSE NULL END) AS Unknown_countries,
ROUND(
        COUNT(DISTINCT CASE WHEN loyalty_tier = 'VIP' THEN customer_id ELSE NULL END) * 100.0 
        / COUNT(DISTINCT customer_id),
        2
    ) AS vip_customers_pct,
ROUND(
        COUNT(DISTINCT CASE WHEN loyalty_tier = 'Gold' THEN customer_id ELSE NULL END) * 100.0 
        / COUNT(DISTINCT customer_id),
        2
    ) AS gold_customers_pct,
ROUND(
        COUNT(DISTINCT CASE WHEN loyalty_tier = 'Silver' THEN customer_id ELSE NULL END) * 100.0 
        / COUNT(DISTINCT customer_id),
        2
    ) AS silver_customers_pct,
ROUND(
        COUNT(DISTINCT CASE WHEN loyalty_tier = 'Bronze' THEN customer_id ELSE NULL END) * 100.0 
        / COUNT(DISTINCT customer_id),
        2
    ) AS bronze_customers_pct,
ROUND(
        COUNT(DISTINCT CASE WHEN loyalty_tier = 'No loyalty tier' THEN customer_id ELSE NULL END) * 100.0 
        / COUNT(DISTINCT customer_id),
        2
    ) AS others_customers_pct
    
FROM int_sessions_enriched
GROUP BY source_channel
ORDER BY SUM(converted)*100 / COUNT(session_id) DESC
