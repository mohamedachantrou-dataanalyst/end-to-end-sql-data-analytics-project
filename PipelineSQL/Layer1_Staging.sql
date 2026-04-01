USE ecom_pipeline;
-- Vue de la table 'raw.customers' nettoyée
CREATE VIEW stg_customers AS
SELECT
	customer_id,
    TRIM(full_name) AS full_name,
    LOWER(TRIM(NULLIF(email,''))) AS email,
    TRIM(COALESCE(NULLIF(country,''),'Unknown')) AS country,
    CASE LOWER(TRIM(COALESCE(loyalty_tier,'')))
		WHEN 'vip' THEN 'VIP'
        WHEN 'premium' THEN 'VIP'
		WHEN 'bronze' THEN 'Bronze'
		WHEN 'silver' THEN 'Silver'
		WHEN 'gold' THEN 'Gold'
		WHEN '' THEN 'No loyalty tier'
	END AS loyalty_tier,
    STR_TO_DATE(signup_date,'%Y-%m-%d') AS signup_date
FROM db_ecommerce.raw_customers;

-- Vue de la table 'raw.orders' nettoyée
CREATE VIEW stg_orders AS
SELECT
	order_id,
    customer_id,
    STR_TO_DATE(order_date,'%Y-%m-%d') AS order_date,
    UPPER(TRIM(status)) AS status,
    CAST(
		 REPLACE(
			REPLACE(
            TRIM(total_amount),
            ',', '.'
			),
        '$',''
		) AS DECIMAL(10,2)
	) AS total_amount,
    COALESCE(NULLIF(currency,''),'EUR') AS currency
FROM db_ecommerce.raw_orders;

-- Vue de la table 'raw.products' nettoyée
CREATE VIEW stg_products AS
SELECT
	product_id,
    TRIM(product_name) AS product_name,
    p.category_id,
    c.category_name,
    NULLIF(brand,'') AS brand,
    cost_price,
    retail_price,
    (retail_price - cost_price) AS gross_margin,
    CAST(((retail_price - cost_price) / NULLIF(retail_price, 0)) AS DECIMAL(10,2)) AS margin_pct,
    CASE LOWER(TRIM(is_active))
		WHEN '1' THEN TRUE
        WHEN 'yes' THEN TRUE
        WHEN 'true' THEN TRUE
        WHEN '0' THEN FALSE
        WHEN 'no' THEN FALSE
        WHEN 'false' THEN FALSE
	END AS is_active
FROM db_catalogue.raw_products p
JOIN db_catalogue.raw_categories c
ON p.category_id = c.category_id;

-- Vue de la table 'raw.sessions' nettoyée
CREATE VIEW stg_sessions AS
SELECT
	session_id,
    customer_id,
    STR_TO_DATE(session_start, '%Y-%m-%d %H:%i:%s') AS session_start,
    STR_TO_DATE(session_end, '%Y-%m-%d %H:%i:%s') AS session_end,
    TIMESTAMPDIFF(MINUTE,STR_TO_DATE(session_start, '%Y-%m-%d %H:%i:%s'),STR_TO_DATE(session_end, '%Y-%m-%d %H:%i:%s')) AS session_duration,
    LOWER(TRIM(source_channel)) AS source_channel,
    IFNULL(page_views,0) AS page_views,
    CASE LOWER(TRIM(converted))
		WHEN '1' THEN TRUE
        WHEN 'yes' THEN TRUE
        WHEN 'true' THEN TRUE
        WHEN '0' THEN FALSE
        WHEN 'no' THEN FALSE
        WHEN 'false' THEN FALSE
	END AS converted
FROM db_analytics.raw_sessions;
