-- ============================================================
--  PROJET : ecom_pipeline
--  FICHIER : 01_raw_data.sql
--  DESC    : Création des 3 bases sources + données brutes
--  SGBD    : MySQL
--  USAGE   : Exécuter en entier dans MySQL Workbench (Ctrl+Shift+Enter)
-- ============================================================


-- ============================================================
--  BASE 1 : db_ecommerce
-- ============================================================
DROP DATABASE IF EXISTS db_ecommerce;
CREATE DATABASE db_ecommerce CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE db_ecommerce;

-- ----------------------------------------------------------
--  TABLE : raw_customers
-- ----------------------------------------------------------
CREATE TABLE raw_customers (
    customer_id   INT          PRIMARY KEY,
    full_name     VARCHAR(150),
    email         VARCHAR(200),
    country       VARCHAR(100),
    signup_date   VARCHAR(20),   -- volontairement VARCHAR (format sale)
    loyalty_tier  VARCHAR(50)
);

INSERT INTO raw_customers VALUES
-- données propres
(1,  'Alice Martin',       'alice.martin@email.com',      'France',        '2021-03-15', 'gold'),
(2,  'Bob Dupont',         'bob.dupont@email.com',        'France',        '2020-11-02', 'silver'),
(3,  'Clara Durand',       'clara.durand@email.com',      'Belgique',      '2022-01-20', 'bronze'),
(4,  'David Leroy',        'david.leroy@email.com',       'France',        '2019-07-08', 'VIP'),
(5,  'Emma Petit',         'emma.petit@email.com',        'Suisse',        '2023-02-14', 'gold'),
(6,  'François Moreau',    'f.moreau@email.com',          'France',        '2021-09-30', 'silver'),
(7,  'Grace Nguyen',       'grace.nguyen@email.com',      'France',        '2022-06-11', 'bronze'),
(8,  'Hugo Bernard',       'hugo.bernard@email.com',      'Luxembourg',    '2020-04-25', 'silver'),
(9,  'Inès Roux',          'ines.roux@email.com',         'France',        '2023-05-03', 'bronze'),
(10, 'Jules Simon',        'jules.simon@email.com',       'Belgique',      '2021-12-19', 'gold'),
-- données avec espaces parasites (TRIM nécessaire)
(11, '  Kevin Thomas  ',   '  k.thomas@email.com  ',     ' France ',      '2022-03-07', '  silver  '),
(12, 'Laura  Garcia',      'laura.garcia@email.com',      'France',        '2020-08-14', 'GOLD'),        -- casse inconsistante
(13, 'Marc Lambert',       'MARC.LAMBERT@EMAIL.COM',      'France',        '2019-11-28', 'Silver'),      -- email en majuscules
(14, '  Nadia Fontaine',   'nadia.fontaine@email.com',    '  Suisse  ',    '2023-01-09', 'bronze'),
(15, 'Olivier Chevalier',  'o.chevalier@email.com',       'France',        '2022-07-22', 'SILVER'),
-- données avec valeurs manquantes (COALESCE / NULLIF nécessaire)
(16, 'Paula Girard',       '',                            'France',        '2021-04-16', 'bronze'),      -- email vide
(17, 'Quentin Lefebvre',   'q.lefebvre@email.com',        '',              '2020-09-03', 'gold'),        -- pays vide
(18, 'Rachel Morel',       'rachel.morel@email.com',      'France',        '2023-06-30', NULL),          -- tier NULL
(19, 'Samuel Fournier',    NULL,                          'Belgique',      '2022-10-17', 'silver'),      -- email NULL
(20, 'Théa Rousseau',      'thea.rousseau@email.com',     'France',        '2021-08-05', ''),            -- tier vide
-- données avec tier non standard (CASE WHEN nécessaire)
(21, 'Ugo Blanc',          'ugo.blanc@email.com',         'France',        '2020-12-01', 'vip'),         -- minuscule
(22, 'Vera Henry',         'vera.henry@email.com',        'Luxembourg',    '2023-03-18', 'VIP'),
(23, 'William Gauthier',   'w.gauthier@email.com',        'France',        '2022-05-29', 'premium'),     -- valeur non standard
(24, 'Xena Perrin',        'xena.perrin@email.com',       'Suisse',        '2021-01-14', 'Gold'),
(25, 'Yann Clement',       'yann.clement@email.com',      'France',        '2019-06-20', 'BRONZE'),
(26, 'Zoé Mercier',        'zoe.mercier@email.com',       'France',        '2022-11-11', 'silver'),
(27, 'Antoine Barbier',    'a.barbier@email.com',         'France',        '2020-02-28', 'gold'),
(28, 'Béatrice Arnaud',    'b.arnaud@email.com',          'Belgique',      '2023-07-04', 'bronze'),
(29, 'Cédric Picard',      'c.picard@email.com',          'France',        '2021-06-15', 'silver'),
(30, 'Delphine Renard',    'd.renard@email.com',          'France',        '2022-09-08', 'gold'),
(31, 'Ethan Lemaire',      'e.lemaire@email.com',         'France',        '2020-05-19', 'bronze'),
(32, 'Fatima Olivier',     'f.olivier@email.com',         'Maroc',         '2023-04-22', 'silver'),
(33, 'Gaël Schmitt',       'g.schmitt@email.com',         'France',        '2021-10-30', 'gold'),
(34, 'Hélène Bertrand',    'h.bertrand@email.com',        'France',        '2019-09-12', 'VIP'),
(35, 'Ismaël Colin',       'i.colin@email.com',           'France',        '2022-08-03', 'silver'),
(36, 'Julie Charpentier',  'j.charpentier@email.com',     'Suisse',        '2020-07-17', 'gold'),
(37, 'Karim Gaillard',     'k.gaillard@email.com',        'France',        '2023-02-28', 'bronze'),
(38, 'Lucie Bonnet',       'l.bonnet@email.com',          'Belgique',      '2021-11-06', 'silver'),
(39, 'Mathieu Dupuis',     'm.dupuis@email.com',          'France',        '2022-04-14', 'gold'),
(40, 'Nina Garnier',       'n.garnier@email.com',         'France',        '2020-01-31', 'bronze'),
(41, 'Oscar Faure',        'o.faure@email.com',           'Luxembourg',    '2023-08-09', 'silver'),
(42, 'Pauline Gros',       'p.gros@email.com',            'France',        '2021-07-23', 'gold'),
(43, 'Rémi Bourgeois',     'r.bourgeois@email.com',       'France',        '2019-12-05', 'VIP'),
(44, 'Sophie Julien',      's.julien@email.com',          'France',        '2022-03-19', 'silver'),
(45, 'Thomas Muller',      't.muller@email.com',          'France',        '2020-10-27', 'bronze'),
(46, 'Ursula Perez',       'u.perez@email.com',           'Espagne',       '2023-01-15', 'silver'),
(47, 'Vincent Aubert',     'v.aubert@email.com',          'France',        '2021-05-08', 'gold'),
(48, 'Wendy Caron',        'w.caron@email.com',           'France',        '2022-12-01', 'bronze'),
(49, 'Xavier Lepage',      'x.lepage@email.com',          'Belgique',      '2020-06-14', 'silver'),
(50, 'Yasmine Noel',       'y.noel@email.com',            'France',        '2023-09-20', 'gold');


-- ----------------------------------------------------------
--  TABLE : raw_orders
-- ----------------------------------------------------------
CREATE TABLE raw_orders (
    order_id      INT          PRIMARY KEY,
    customer_id   INT,
    order_date    VARCHAR(20),   -- format sale : VARCHAR au lieu de DATE
    status        VARCHAR(50),
    total_amount  VARCHAR(20),   -- peut contenir symboles ou espaces
    currency      VARCHAR(10)
);

INSERT INTO raw_orders VALUES
-- commandes propres
(1001, 1,  '2024-01-05', 'completed',  '120.50',    'EUR'),
(1002, 2,  '2024-01-07', 'completed',  '89.99',     'EUR'),
(1003, 3,  '2024-01-10', 'pending',    '245.00',    'EUR'),
(1004, 4,  '2024-01-12', 'completed',  '520.75',    'EUR'),
(1005, 5,  '2024-01-15', 'completed',  '67.30',     'EUR'),
(1006, 6,  '2024-01-18', 'cancelled',  '34.00',     'EUR'),
(1007, 7,  '2024-01-20', 'completed',  '198.40',    'EUR'),
(1008, 8,  '2024-01-22', 'completed',  '310.00',    'EUR'),
(1009, 9,  '2024-01-25', 'pending',    '55.90',     'EUR'),
(1010, 10, '2024-01-28', 'completed',  '412.20',    'EUR'),
-- statuts avec casse inconsistante (UPPER + TRIM nécessaire)
(1011, 11, '2024-02-01', 'Completed',  '78.00',     'EUR'),
(1012, 12, '2024-02-03', 'COMPLETED',  '156.50',    'EUR'),
(1013, 13, '2024-02-05', '  pending ', '203.00',    'EUR'),   -- espaces dans statut
(1014, 14, '2024-02-08', 'Cancelled',  '91.75',     'EUR'),
(1015, 15, '2024-02-10', 'PENDING',    '340.00',    'EUR'),
-- montants sales (CAST + REPLACE nécessaire)
(1016, 16, '2024-02-12', 'completed',  '$145.00',   'EUR'),   -- symbole dollar
(1017, 17, '2024-02-14', 'completed',  ' 220.50 ',  'EUR'),   -- espaces
(1018, 18, '2024-02-16', 'completed',  '88,00',     'EUR'),   -- virgule au lieu de point
(1019, 19, '2024-02-19', 'completed',  '175.00',    NULL),    -- devise NULL
(1020, 20, '2024-02-21', 'completed',  '430.25',    ''),      -- devise vide
-- commandes de février suite
(1021, 21, '2024-02-23', 'completed',  '99.00',     'EUR'),
(1022, 22, '2024-02-25', 'completed',  '285.60',    'EUR'),
(1023, 23, '2024-02-27', 'cancelled',  '47.30',     'EUR'),
(1024, 24, '2024-03-01', 'completed',  '612.00',    'EUR'),
(1025, 25, '2024-03-03', 'completed',  '133.80',    'EUR'),
(1026, 26, '2024-03-05', 'pending',    '76.40',     'EUR'),
(1027, 27, '2024-03-07', 'completed',  '509.00',    'EUR'),
(1028, 28, '2024-03-10', 'completed',  '224.50',    'EUR'),
(1029, 29, '2024-03-12', 'completed',  '88.20',     'EUR'),
(1030, 30, '2024-03-14', 'completed',  '345.00',    'EUR'),
(1031, 31, '2024-03-16', 'cancelled',  '62.10',     'EUR'),
(1032, 32, '2024-03-18', 'completed',  '179.90',    'EUR'),
(1033, 33, '2024-03-20', 'completed',  '430.00',    'EUR'),
(1034, 34, '2024-03-22', 'completed',  '890.50',    'EUR'),
(1035, 35, '2024-03-24', 'pending',    '115.30',    'EUR'),
(1036, 36, '2024-03-26', 'completed',  '267.40',    'EUR'),
(1037, 37, '2024-03-28', 'completed',  '54.00',     'EUR'),
(1038, 38, '2024-03-30', 'completed',  '398.75',    'EUR'),
(1039, 39, '2024-04-01', 'completed',  '741.20',    'EUR'),
(1040, 40, '2024-04-03', 'cancelled',  '29.90',     'EUR'),
(1041, 41, '2024-04-05', 'completed',  '183.60',    'EUR'),
(1042, 42, '2024-04-07', 'completed',  '556.00',    'EUR'),
(1043, 43, '2024-04-09', 'completed',  '1024.00',   'EUR'),
(1044, 44, '2024-04-11', 'completed',  '212.30',    'EUR'),
(1045, 45, '2024-04-13', 'pending',    '97.50',     'EUR'),
(1046, 46, '2024-04-15', 'completed',  '143.80',    'EUR'),
(1047, 47, '2024-04-17', 'completed',  '488.00',    'EUR'),
(1048, 48, '2024-04-19', 'completed',  '66.40',     'EUR'),
(1049, 49, '2024-04-21', 'completed',  '319.90',    'EUR'),
(1050, 50, '2024-04-23', 'completed',  '755.00',    'EUR'),
-- deuxièmes commandes pour certains clients (multi-commandes)
(1051, 1,  '2024-04-25', 'completed',  '230.00',    'EUR'),
(1052, 4,  '2024-04-27', 'completed',  '678.50',    'EUR'),
(1053, 10, '2024-04-29', 'completed',  '145.20',    'EUR'),
(1054, 12, '2024-05-01', 'completed',  '88.00',     'EUR'),
(1055, 22, '2024-05-03', 'cancelled',  '310.00',    'EUR'),
(1056, 27, '2024-05-05', 'completed',  '492.30',    'EUR'),
(1057, 33, '2024-05-07', 'completed',  '167.40',    'EUR'),
(1058, 34, '2024-05-09', 'completed',  '945.00',    'EUR'),
(1059, 43, '2024-05-11', 'completed',  '1150.00',   'EUR'),
(1060, 47, '2024-05-13', 'completed',  '374.60',    'EUR');


-- ----------------------------------------------------------
--  TABLE : raw_order_items
-- ----------------------------------------------------------
CREATE TABLE raw_order_items (
    item_id      INT            PRIMARY KEY,
    order_id     INT,
    product_id   INT,
    quantity     INT,
    unit_price   DECIMAL(10,2),
    discount_pct DECIMAL(5,2)
);

INSERT INTO raw_order_items VALUES
(1,  1001, 101, 1, 120.50, 0.00),
(2,  1002, 105, 2,  35.00, 2.00),
(3,  1002, 110, 1,  19.99, 0.00),
(4,  1003, 102, 1, 199.00, 5.00),
(5,  1003, 108, 2,  23.00, 0.00),
(6,  1004, 103, 1, 450.00,10.00),
(7,  1004, 106, 1,  70.75, 0.00),
(8,  1005, 109, 3,  22.43, 0.00),
(9,  1006, 104, 2,  17.00, 0.00),
(10, 1007, 101, 1, 120.50, 0.00),
(11, 1007, 107, 1,  77.90, 0.00),
(12, 1008, 103, 1, 310.00, 0.00),
(13, 1009, 105, 1,  55.90, 0.00),
(14, 1010, 102, 2, 199.00, 3.00),
(15, 1010, 110, 1,  14.20, 0.00),
(16, 1011, 108, 3,  26.00, 0.00),
(17, 1012, 106, 2,  78.25, 0.00),
(18, 1013, 101, 1, 120.50, 5.00),
(19, 1013, 109, 2,  41.25, 0.00),
(20, 1014, 104, 3,  30.58, 0.00),
(21, 1015, 103, 1, 340.00, 0.00),
(22, 1016, 107, 1, 145.00, 0.00),
(23, 1017, 102, 1, 220.50, 0.00),
(24, 1018, 105, 2,  44.00, 0.00),
(25, 1019, 106, 2,  87.50, 0.00),
(26, 1020, 103, 1, 430.25, 0.00),
(27, 1021, 109, 4,  24.75, 0.00),
(28, 1022, 101, 2, 120.50, 5.00),
(29, 1022, 110, 1,  44.60, 0.00),
(30, 1023, 104, 2,  23.65, 0.00),
(31, 1024, 103, 1, 550.00,10.00),
(32, 1024, 107, 1,  62.00, 0.00),
(33, 1025, 105, 3,  44.60, 0.00),
(34, 1026, 108, 2,  38.20, 0.00),
(35, 1027, 102, 2, 199.00, 5.00),
(36, 1027, 106, 1, 111.00, 0.00),
(37, 1028, 101, 1, 224.50, 0.00),
(38, 1029, 109, 2,  44.10, 0.00),
(39, 1030, 103, 1, 345.00, 0.00),
(40, 1031, 110, 3,  20.70, 0.00),
(41, 1032, 107, 2,  89.95, 0.00),
(42, 1033, 102, 2, 199.00, 5.00),
(43, 1033, 105, 1,  32.00, 0.00),
(44, 1034, 103, 1, 890.50, 0.00),
(45, 1035, 106, 3,  38.43, 0.00),
(46, 1036, 101, 2, 120.50, 5.00),
(47, 1036, 108, 1,  26.40, 0.00),
(48, 1037, 104, 3,  18.00, 0.00),
(49, 1038, 102, 2, 199.37, 0.00),
(50, 1039, 103, 1, 741.20, 0.00),
(51, 1040, 110, 1,  29.90, 0.00),
(52, 1041, 107, 2,  91.80, 0.00),
(53, 1042, 101, 4, 120.50, 8.00),
(54, 1043, 103, 2, 450.00,10.00),
(55, 1043, 102, 1, 124.00, 0.00),
(56, 1044, 106, 2, 106.15, 0.00),
(57, 1045, 109, 4,  24.37, 0.00),
(58, 1046, 105, 3,  47.93, 0.00),
(59, 1047, 102, 2, 199.00, 5.00),
(60, 1047, 107, 1,  90.00, 0.00),
(61, 1048, 110, 2,  33.20, 0.00),
(62, 1049, 101, 2, 120.50, 5.00),
(63, 1049, 108, 2,  39.95, 0.00),
(64, 1050, 103, 1, 680.00,10.00),
(65, 1050, 106, 1,  75.00, 0.00),
(66, 1051, 101, 2, 120.50, 5.00),
(67, 1052, 103, 1, 678.50, 0.00),
(68, 1053, 105, 3,  48.40, 0.00),
(69, 1054, 108, 3,  29.33, 0.00),
(70, 1055, 103, 1, 310.00, 0.00),
(71, 1056, 102, 2, 199.00, 5.00),
(72, 1056, 107, 1,  94.30, 0.00),
(73, 1057, 106, 2,  83.70, 0.00),
(74, 1058, 103, 2, 450.00, 5.00),
(75, 1058, 101, 1,  45.00, 0.00),
(76, 1059, 103, 2, 500.00,10.00),
(77, 1059, 102, 1, 150.00, 0.00),
(78, 1060, 101, 3, 120.50, 5.00),
(79, 1060, 108, 1,  18.35, 0.00);


-- ============================================================
--  BASE 2 : db_catalogue
-- ============================================================
DROP DATABASE IF EXISTS db_catalogue;
CREATE DATABASE db_catalogue CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE db_catalogue;

-- ----------------------------------------------------------
--  TABLE : raw_categories
-- ----------------------------------------------------------
CREATE TABLE raw_categories (
    category_id   INT    PRIMARY KEY,
    category_name VARCHAR(100),
    parent_id     INT             -- NULL = catégorie racine
);

INSERT INTO raw_categories VALUES
(1, 'Électronique',       NULL),
(2, 'Mode',               NULL),
(3, 'Maison & Jardin',    NULL),
(4, 'Sport & Loisirs',    NULL),
(5, 'Informatique',       1),    -- sous-catégorie d'Électronique
(6, 'Audio & Vidéo',      1),
(7, 'Vêtements',          2),
(8, 'Chaussures',         2),
(9, 'Décoration',         3),
(10,'Outillage',          3);

-- ----------------------------------------------------------
--  TABLE : raw_products
-- ----------------------------------------------------------
CREATE TABLE raw_products (
    product_id    INT            PRIMARY KEY,
    product_name  VARCHAR(200),
    category_id   INT,
    brand         VARCHAR(100),
    cost_price    DECIMAL(10,2),
    retail_price  DECIMAL(10,2),
    is_active     VARCHAR(5)     -- valeurs sales : "yes","1","true","no","0"
);

INSERT INTO raw_products VALUES
-- produits propres et actifs
(101, 'Casque Bluetooth Pro',      6,  'SoundMax',   55.00,  120.50, 'yes'),
(102, 'Laptop UltraSlim 14"',      5,  'TechBook',  320.00,  499.00, '1'),      -- is_active = "1"
(103, 'Smartphone Galaxy X',       1,  'Galax',     280.00,  699.00, 'true'),   -- is_active = "true"
(104, 'T-shirt Col V Homme',       7,  'UrbanWear',   8.50,   24.99, 'yes'),
(105, 'Sneakers Running Femme',    8,  'RunFast',    42.00,   89.90, 'yes'),
(106, 'Lampe de Bureau LED',       9,  'LumiHome',   28.00,   69.90, '1'),
(107, 'Sac à Dos Voyage 40L',      4,  'TrailPro',   35.00,   99.90, 'yes'),
(108, 'Tapis de Yoga Premium',     4,  'ZenFit',     15.00,   39.90, 'yes'),
(109, 'Mug Isotherme 500ml',       9,  'KeepWarm',    6.50,   22.90, 'yes'),
(110, 'Câble USB-C 2m',            5,  'ConnectPro',  2.50,   12.90, '1'),
-- produits avec données sales
(111, '  Clavier Mécanique RGB  ', 5,  'TypeMaster',  40.00,  89.90, 'YES'),   -- espaces + casse
(112, 'Écouteurs Sans Fil',        6,  '',            25.00,   59.90, 'yes'),   -- brand vide
(113, 'Jean Slim Homme',           7,  'DenimCo',     18.00,   49.90, 'no'),    -- produit inactif
(114, 'Chaussures de Randonnée',   8,  'HikePro',     55.00,  129.90, '0'),     -- is_active = "0"
(115, 'Tondeuse à Gazon',          10, 'GardenPro',  120.00,  249.90, 'false'), -- is_active = "false"
(116, NULL,                        9,  'DecoHome',    12.00,   34.90, 'yes'),   -- nom NULL
(117, 'Montre Connectée Sport',    1,  'SmartTime',   80.00,  199.90, 'yes'),
(118, 'Enceinte Portable',         6,  'BassBox',     30.00,   79.90, '1'),
(119, 'Pantalon de Jogging',       7,  'ComfortFit',  14.00,   39.90, 'yes'),
(120, 'Perceuse Visseuse',         10, 'BuildPro',    45.00,   99.90, 'yes');


-- ============================================================
--  BASE 3 : db_analytics
-- ============================================================
DROP DATABASE IF EXISTS db_analytics;
CREATE DATABASE db_analytics CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE db_analytics;

-- ----------------------------------------------------------
--  TABLE : raw_sessions
-- ----------------------------------------------------------
CREATE TABLE raw_sessions (
    session_id     VARCHAR(50)  PRIMARY KEY,
    customer_id    INT,
    session_start  VARCHAR(30),
    session_end    VARCHAR(30),
    source_channel VARCHAR(100),
    page_views     INT,
    converted      VARCHAR(5)
);

INSERT INTO raw_sessions VALUES
-- sessions propres avec conversion
('SES-001', 1,  '2024-01-05 09:12:00', '2024-01-05 09:28:00', 'google / cpc',    8,  'TRUE'),
('SES-002', 2,  '2024-01-07 14:05:00', '2024-01-07 14:19:00', 'organic',         5,  'TRUE'),
('SES-003', 3,  '2024-01-10 11:30:00', '2024-01-10 11:48:00', 'facebook',        12, 'TRUE'),
('SES-004', 4,  '2024-01-12 16:22:00', '2024-01-12 16:55:00', 'direct',          20, 'TRUE'),
('SES-005', 5,  '2024-01-15 08:45:00', '2024-01-15 08:57:00', 'email',           6,  'TRUE'),
-- sessions sans conversion (navigation simple)
('SES-006', 6,  '2024-01-17 13:10:00', '2024-01-17 13:15:00', 'organic',         3,  'FALSE'),
('SES-007', 7,  '2024-01-19 10:00:00', '2024-01-19 10:22:00', 'instagram',       9,  'TRUE'),
('SES-008', 8,  '2024-01-21 15:30:00', '2024-01-21 15:52:00', 'direct',          14, 'TRUE'),
('SES-009', 9,  '2024-01-24 09:00:00', '2024-01-24 09:08:00', 'google / cpc',    4,  'FALSE'),
('SES-010', 10, '2024-01-28 11:15:00', '2024-01-28 11:45:00', 'email',           18, 'TRUE'),
-- canaux sales (TRIM + LOWER nécessaire)
('SES-011', 11, '2024-02-01 08:30:00', '2024-02-01 08:44:00', '  Google / CPC ', 7,  'TRUE'),  -- espaces + casse
('SES-012', 12, '2024-02-03 12:00:00', '2024-02-03 12:18:00', 'ORGANIC',         11, 'TRUE'),  -- majuscules
('SES-013', 13, '2024-02-05 17:20:00', '2024-02-05 17:35:00', 'Facebook ',       9,  'TRUE'),  -- espace en fin
('SES-014', 14, '2024-02-08 10:05:00', '2024-02-08 10:12:00', '  direct  ',      5,  'FALSE'), -- espaces
('SES-015', 15, '2024-02-10 14:30:00', '2024-02-10 15:00:00', 'EMAIL',           16, 'TRUE'),  -- majuscules
-- converted avec formats inconsistants (CASE WHEN nécessaire)
('SES-016', 16, '2024-02-12 09:45:00', '2024-02-12 10:02:00', 'google / cpc',    8,  '1'),     -- "1" au lieu de TRUE
('SES-017', 17, '2024-02-14 13:15:00', '2024-02-14 13:30:00', 'organic',         7,  '1'),
('SES-018', 18, '2024-02-16 11:00:00', '2024-02-16 11:20:00', 'instagram',       10, 'true'),  -- minuscule
('SES-019', 19, '2024-02-19 16:40:00', '2024-02-19 16:55:00', 'direct',          6,  'yes'),   -- "yes"
('SES-020', 20, '2024-02-21 08:00:00', '2024-02-21 08:25:00', 'email',           13, 'TRUE'),
-- page_views NULL (IFNULL nécessaire)
('SES-021', 21, '2024-02-23 10:30:00', '2024-02-23 10:48:00', 'organic',         NULL,'TRUE'), -- page_views NULL
('SES-022', 22, '2024-02-25 14:00:00', '2024-02-25 14:22:00', 'google / cpc',    NULL,'TRUE'), -- page_views NULL
('SES-023', 23, '2024-02-27 09:15:00', '2024-02-27 09:20:00', 'facebook',        2,  'FALSE'),
('SES-024', 24, '2024-03-01 11:00:00', '2024-03-01 11:40:00', 'direct',          22, 'TRUE'),
('SES-025', 25, '2024-03-03 15:30:00', '2024-03-03 15:45:00', 'email',           8,  'TRUE'),
('SES-026', 26, '2024-03-05 08:20:00', '2024-03-05 08:28:00', 'organic',         4,  'FALSE'),
('SES-027', 27, '2024-03-07 12:10:00', '2024-03-07 12:40:00', 'google / cpc',    17, 'TRUE'),
('SES-028', 28, '2024-03-10 09:50:00', '2024-03-10 10:10:00', 'instagram',       11, 'TRUE'),
('SES-029', 29, '2024-03-12 14:20:00', '2024-03-12 14:33:00', 'organic',         6,  'TRUE'),
('SES-030', 30, '2024-03-14 10:00:00', '2024-03-14 10:25:00', 'direct',          14, 'TRUE'),
('SES-031', 31, '2024-03-16 16:00:00', '2024-03-16 16:08:00', 'facebook',        3,  'FALSE'),
('SES-032', 32, '2024-03-18 11:30:00', '2024-03-18 11:48:00', 'email',           9,  'TRUE'),
('SES-033', 33, '2024-03-20 09:00:00', '2024-03-20 09:30:00', 'google / cpc',    16, 'TRUE'),
('SES-034', 34, '2024-03-22 14:45:00', '2024-03-22 15:20:00', 'direct',          25, 'TRUE'),
('SES-035', 35, '2024-03-24 10:15:00', '2024-03-24 10:28:00', 'organic',         7,  'FALSE'),
('SES-036', 36, '2024-03-26 13:00:00', '2024-03-26 13:22:00', 'instagram',       12, 'TRUE'),
('SES-037', 37, '2024-03-28 08:45:00', '2024-03-28 08:52:00', 'organic',         4,  'TRUE'),
('SES-038', 38, '2024-03-30 15:10:00', '2024-03-30 15:35:00', 'email',           14, 'TRUE'),
('SES-039', 39, '2024-04-01 10:30:00', '2024-04-01 11:10:00', 'google / cpc',    28, 'TRUE'),
('SES-040', 40, '2024-04-03 09:00:00', '2024-04-03 09:05:00', 'facebook',        2,  'FALSE'),
('SES-041', 41, '2024-04-05 12:00:00', '2024-04-05 12:18:00', 'direct',          10, 'TRUE'),
('SES-042', 42, '2024-04-07 14:30:00', '2024-04-07 15:00:00', 'google / cpc',    20, 'TRUE'),
('SES-043', 43, '2024-04-09 09:15:00', '2024-04-09 10:00:00', 'direct',          30, 'TRUE'),
('SES-044', 44, '2024-04-11 11:00:00', '2024-04-11 11:20:00', 'email',           11, 'TRUE'),
('SES-045', 45, '2024-04-13 15:45:00', '2024-04-13 15:55:00', 'organic',         5,  'FALSE'),
('SES-046', 46, '2024-04-15 10:00:00', '2024-04-15 10:15:00', 'instagram',       8,  'TRUE'),
('SES-047', 47, '2024-04-17 13:20:00', '2024-04-17 13:50:00', 'google / cpc',    18, 'TRUE'),
('SES-048', 48, '2024-04-19 09:30:00', '2024-04-19 09:42:00', 'organic',         6,  'TRUE'),
('SES-049', 49, '2024-04-21 14:00:00', '2024-04-21 14:25:00', 'direct',          13, 'TRUE'),
('SES-050', 50, '2024-04-23 10:45:00', '2024-04-23 11:20:00', 'email',           22, 'TRUE'),
-- sessions sans customer_id connu (visiteurs anonymes)
('SES-051', NULL,'2024-04-24 08:00:00','2024-04-24 08:03:00', 'google / cpc',    2,  'FALSE'),
('SES-052', NULL,'2024-04-24 10:00:00','2024-04-24 10:07:00', 'organic',         4,  'FALSE'),
('SES-053', NULL,'2024-04-25 11:00:00','2024-04-25 11:15:00', 'facebook',        7,  'FALSE'),
-- deuxièmes sessions pour certains clients
('SES-054', 1,  '2024-04-25 09:00:00', '2024-04-25 09:30:00', 'direct',          15, 'TRUE'),
('SES-055', 4,  '2024-04-27 14:10:00', '2024-04-27 14:45:00', 'google / cpc',    21, 'TRUE'),
('SES-056', 10, '2024-04-29 10:00:00', '2024-04-29 10:28:00', 'email',           16, 'TRUE'),
('SES-057', 22, '2024-05-03 09:30:00', '2024-05-03 09:40:00', 'instagram',       5,  'FALSE'),
('SES-058', 34, '2024-05-09 13:00:00', '2024-05-09 13:50:00', 'direct',          28, 'TRUE'),
('SES-059', 43, '2024-05-11 08:30:00', '2024-05-11 09:15:00', 'google / cpc',    32, 'TRUE'),
('SES-060', 47, '2024-05-13 11:00:00', '2024-05-13 11:35:00', 'organic',         19, 'TRUE');


-- ============================================================
--  VÉRIFICATION RAPIDE
-- ============================================================
SELECT 'db_ecommerce → raw_customers' AS table_name, COUNT(*) AS nb_lignes FROM db_ecommerce.raw_customers
UNION ALL
SELECT 'db_ecommerce → raw_orders',      COUNT(*) FROM db_ecommerce.raw_orders
UNION ALL
SELECT 'db_ecommerce → raw_order_items', COUNT(*) FROM db_ecommerce.raw_order_items
UNION ALL
SELECT 'db_catalogue → raw_products',    COUNT(*) FROM db_catalogue.raw_products
UNION ALL
SELECT 'db_catalogue → raw_categories',  COUNT(*) FROM db_catalogue.raw_categories
UNION ALL
SELECT 'db_analytics → raw_sessions',    COUNT(*) FROM db_analytics.raw_sessions;
