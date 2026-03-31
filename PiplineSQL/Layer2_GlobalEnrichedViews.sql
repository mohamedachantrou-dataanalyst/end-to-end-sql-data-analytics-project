-- Vison globale sur les commandes
CREATE OR REPLACE VIEW int_orders_enriched AS
    -- étapes de jointure via des tables temporaires
    WITH
    -- items achetés dans chaque commande
    items_per_order AS (
    SELECT
    
	o.order_id,
    o.order_date,
    o.customer_id,
    o.status,
    o.total_amount,
    o.currency,
    oi.quantity,
    oi.unit_price,
    oi.discount_pct,
    ROUND(oi.quantity*oi.unit_price*(1-(oi.discount_pct/100)),2) AS total_line,
    oi.product_id
    
	FROM stg_orders o
	JOIN db_ecommerce.raw_order_items oi
	ON o.order_id = oi.order_id
    ),
    -- détails sur les produits
    products_details_per_order AS (
    SELECT
    
    ipo.*,
    p.product_name,
    p.category_id,
    p.category_name,
    p.brand,
    p.cost_price,
    p.retail_price,
    p.gross_margin,
    p.is_active
    
	FROM items_per_order ipo
	JOIN stg_products p
	ON ipo.product_id = p.product_id
    ),
     -- détails sur les clients
    ensemble AS (
    SELECT
    
    pdo.*,
    c.full_name,
    c.email,
    c.country,
    c.loyalty_tier,
    c.signup_date
    
	FROM products_details_per_order pdo
	JOIN stg_customers c
	ON pdo.customer_id = c.customer_id
    )
    SELECT * FROM ensemble;

-- Vison globale sur les sessions
CREATE OR REPLACE VIEW int_sessions_enriched AS
SELECT

s.session_id,
s.session_start,
s.session_end,
s.session_duration,
s.source_channel,
s.page_views,
s.converted,

c.customer_id,
c.full_name,
c.email,
c.country,
c.loyalty_tier,
c.signup_date

FROM stg_sessions s
LEFT JOIN stg_customers c
ON s.customer_id = c.customer_id;
