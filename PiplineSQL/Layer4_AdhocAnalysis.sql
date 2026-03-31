-- Question 1 — Tendance du CA  "Est ce que le chiffre d'affaires progresse d'une semaine à l'autre — et de combien en pourcentage ?"
SELECT

YEARWEEK(order_date) AS week_ref,
SUM(sales_eur) AS total_sales,
LAG(SUM(sales_eur),1,SUM(sales_eur)) OVER( ORDER BY YEARWEEK(order_date) ) AS total_sales_lw,
SUM(sales_eur) - LAG(SUM(sales_eur),1,SUM(sales_eur)) OVER( ORDER BY YEARWEEK(order_date) ) AS diff_sales_lw,
ROUND(((SUM(sales_eur) / LAG(SUM(sales_eur),1,SUM(sales_eur)) OVER( ORDER BY YEARWEEK(order_date) ))-1)*100,2) AS sales_evolution_lw_pct

FROM mart_sales_daily
GROUP BY YEARWEEK(order_date)
ORDER BY YEARWEEK(order_date);

-- Question 2 — Fidélité client "Quels clients ont dépensé plus que la moyenne globale ET ont passé plus de 2 commandes ?"
WITH stats AS (
    SELECT *,
    ROUND(AVG(sales_eur) OVER(), 2) AS avg_sales_eur
    FROM mart_customer_kpis
)
SELECT

customer_id,
full_name,
country,
loyalty_tier,
total_orders,
sales_eur,
avg_sales_eur

FROM stats
WHERE sales_eur > avg_sales_eur AND total_orders >= 2
ORDER BY customer_id;

-- Question 3 — Produits sous-performants par catégorie "Quels sont les produits dont la marge réelle est inférieure à la moyenne des marges de leur catégorie ?"
WITH stats AS (
    SELECT *,
    ROUND(AVG(real_margin_made) OVER(PARTITION BY category_id),2) AS avg_margin_category
    FROM mart_product_perf
)
SELECT

    product_id,
    product_name,
    category_id,
    category_name,
    brand,
    sales_eur,
    total_cost,
    real_margin_made,
    avg_margin_category
    
FROM stats
WHERE real_margin_made < avg_margin_category
ORDER BY category_id;

-- Question 4 — Canal vs qualité client "Quel canal d'acquisition ramène le plus de clients VIP ?"
SELECT

source_channel,
total_customers,
vip_customers_pct,
DENSE_RANK() OVER(ORDER BY vip_customers_pct DESC) AS vip_conversion_rank

FROM mart_sessions
ORDER BY vip_customers_pct DESC;

-- Question 5 — Évolution cumulative "Quel est le CA cumulé mois par mois sur toute la période ?"
WITH stats AS (
	SELECT 

	DATE_FORMAT(order_date, '%Y-%m') AS yyyy_mm,
	SUM(sales_eur) AS total_sales_eur
	

	FROM mart_sales_daily
	GROUP BY DATE_FORMAT(order_date, '%Y-%m')
	ORDER BY DATE_FORMAT(order_date, '%Y-%m')
)
SELECT 

*,
SUM(total_sales_eur) OVER(ORDER BY yyyy_mm) AS running_total_sales_eur

FROM stats