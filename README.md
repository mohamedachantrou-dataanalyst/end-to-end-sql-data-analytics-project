End-to-End SQL Data Analytics Project
Contexte du projet

Ce projet a pour objectif de démontrer la construction d’une pipeline analytique complète en SQL, permettant de transformer des données brutes issues de plusieurs sources en data marts analytiques utilisables par des data analysts pour répondre à des questions business.

L’idée est de reproduire une architecture classique utilisée dans les projets data :
nettoyage des données → enrichissement → data marts → analyses métier.

Les données utilisées dans ce projet sont générées fictivement afin de simuler un environnement e-commerce et web analytics.

Objectifs

Ce projet montre comment :

nettoyer et standardiser des données brutes
combiner plusieurs sources de données
créer des vues analytiques enrichies
construire des data marts orientés business
répondre à des questions métier avec SQL
Outils utilisés
MySQL
SQL
Git / GitHub
Modélisation de données
Concepts SQL utilisés

Le projet met en pratique plusieurs concepts importants en SQL :

Jointures (INNER JOIN, LEFT JOIN)
CTE (Common Table Expressions)
Window Functions
Agrégations
Nettoyage et transformation de données
Architecture du projet

La pipeline suit une architecture en 4 couches :

Raw Data
   ↓
Layer 1 : Staging (nettoyage et standardisation)
   ↓
Layer 2 : Enriched Views
   ↓
Layer 3 : Data Marts
   ↓
Layer 4 : Ad Hoc Analysis

Chaque couche a un rôle spécifique dans la transformation des données.

Sources de données

Les données simulées proviennent de trois domaines :

Base E-commerce

Tables :

raw_customers
raw_orders
raw_order_items
Catalogue produits

Tables :

db_products
db_categories
Web analytics

Table :

raw_sessions

Les données brutes sont définies dans :

data/rawdata.sql

Le modèle de données est disponible dans :

data/datamodel.png
Structure du projet
data/
 ├ rawdata.sql
 └ datamodel.png

sql_pipeline/
 ├ db_pipeline.sql
 ├ layer1_staging.sql
 ├ layer2_enriched.sql
 ├ layer3_data_marts/
 │   ├ DataMart_CategoriesPerf.sql
 │   ├ DataMart_CustomerKpis.sql
 │   ├ DataMart_ProductsPerf.sql
 │   ├ DataMart_DailySales.sql
 │   └ DataMart_WebSessions.sql
 └ layer4_adhoc_analysis.sql
Layer 1 — Staging (nettoyage des données)

Cette étape consiste à préparer et nettoyer les données brutes.

Tables créées :

stg_customers
stg_orders
stg_sessions
stg_products

Transformations appliquées :

correction des incohérences (ex : france vs France)
suppression des espaces inutiles
gestion des valeurs manquantes
suppression des doublons
gestion des outliers

L’objectif est d’obtenir des données propres et cohérentes pour les étapes suivantes.

Layer 2 — Enriched Views

Cette couche crée des vues enrichies en combinant les tables nettoyées.

Vues créées :

int_enriched_orders
int_enriched_sessions

Exemple :

int_enriched_orders combine :

stg_orders
stg_customers
stg_products
raw_order_items

Cette vue permet d’avoir une vision détaillée de chaque commande.

Layer 3 — Data Marts

Les data marts permettent d’analyser les données sous différents angles.

Data marts créés :

Performance des catégories

DataMart_CategoriesPerf

KPIs clients

DataMart_CustomerKpis

Performance produits

DataMart_ProductsPerf

Ventes journalières

DataMart_DailySales

Sessions web

DataMart_WebSessions

Ces data marts sont construits principalement à partir de :

int_enriched_orders
int_enriched_sessions
Layer 4 — Ad Hoc Analysis

La dernière étape consiste à utiliser les data marts pour répondre à des questions métier.

Exemples :

Quels produits génèrent le plus de chiffre d’affaires ?
Quelles catégories performent le mieux ?
Quels sont les clients les plus rentables ?
Comment évoluent les ventes dans le temps ?
Quel est le lien entre sessions web et achats ?

Les requêtes analytiques sont disponibles dans :

layer4_adhoc_analysis.sql
Comment reproduire le projet
Créer la base de données de la pipeline
sql_pipeline/db_pipeline.sql
Charger les données brutes
data/rawdata.sql
Exécuter la couche staging
layer1_staging.sql
Créer les vues enrichies
layer2_enriched.sql
Construire les data marts

exécuter les scripts dans :

layer3_data_marts/
Lancer les analyses
layer4_adhoc_analysis.sql
Résultat

Ce projet illustre une pipeline analytique complète en SQL, allant de données brutes à des analyses business structurées.
