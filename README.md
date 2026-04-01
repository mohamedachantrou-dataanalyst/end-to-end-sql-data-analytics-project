# End-to-End SQL Data Analytics Project

## Contexte du projet

Ce projet a pour objectif de démontrer la construction d’une **pipeline analytique complète en SQL**, permettant de transformer des données brutes issues de plusieurs sources en **data marts analytiques** utilisables par des data analysts pour répondre à des questions business.

L’idée est de reproduire une architecture classique utilisée dans les projets data :

**nettoyage des données → enrichissement → data marts → analyses métier**

Les données utilisées dans ce projet sont **générées fictivement** afin de simuler un Business e-commerce.

---

## Objectifs

Ce projet montre comment :

- nettoyer et standardiser des données brutes
- combiner plusieurs sources de données
- créer des vues analytiques enrichies
- construire des **data marts orientés business**
- répondre à des **questions métier avec SQL**

---

## compéténces démontrées

- **SQL**
- **Modélisation de données**
- **Exploratory Data Analysis (EDA)**
- **Data Cleaning**
- **Ad Hoc Analysis**
- **Reporting**

---

## Concepts SQL utilisés

Le projet met en pratique plusieurs concepts importants en SQL :

- **Jointures (INNER JOIN, LEFT JOIN)**
- **CTE (Common Table Expressions)**
- **Window Functions**
- **Agrégations**
- **Sous-requêtes**
- **Nettoyage et transformation de données**
- **Date functions**

---

## Données brutes et modèle de données

![Description de l'image](Data/data_model.png)

---

## Architecture du projet

La pipeline suit une architecture en **4 couches** :

![Description de l'image](PipelineSQL/pipeline_architecture.png)


---

### Layer 1 — Staging (nettoyage des données)

Cette étape consiste à **préparer et nettoyer les données brutes**.

Tables créées :

- `stg_customers`
- `stg_orders`
- `stg_sessions`
- `stg_products`

Transformations appliquées :

- correction des incohérences
- suppression des espaces inutiles
- gestion des valeurs manquantes
- suppression des doublons
- gestion des outliers
- Calcul d'autres attributs

L’objectif est d’obtenir des **données propres et cohérentes** pour les étapes suivantes.

---

### Layer 2 — Global Enriched Views

Cette couche crée des **vues enrichies** en combinant les tables nettoyées.

Vues créées :

- `int_enriched_orders`
- `int_enriched_sessions`

Exemple :

`int_enriched_orders` combine :

- `stg_orders`
- `stg_customers`
- `stg_products`
- `raw_order_items`

Cette vue permet d’avoir **une vision détaillée de chaque commande**.

---

### Layer 3 — Data Marts

Les **data marts** permettent d’analyser les données sous différents angles.

Data marts créés :

**Performance des catégories**

`DataMart_CategoriesPerf`

**KPIs clients**

`DataMart_CustomerKpis`

**Performance produits**

`DataMart_ProductsPerf`

**Ventes journalières**

`DataMart_DailySales`

**Sessions web**

`DataMart_WebSessions`

Ces data marts sont construits principalement à partir de :

- `int_enriched_orders`
- `int_enriched_sessions`

---

### Layer 4 — Ad Hoc Analysis

La dernière étape consiste à utiliser les **data marts pour répondre à des questions métier**.

Exemples :

- Quels produits génèrent le plus de chiffre d’affaires ?
- Quelles catégories performent le mieux ?
- Quels sont les clients les plus rentables ?

---

## Structure du repo

├── README.md
├── Data/
│  └── rawdata.sql
│  └── datamodel.png
├──PipelineSQL/
  └── Db_pipeline.sql
  └── Layer1_staging.sql
  └── Layer2_enriched.sql
  └── Layer3_data_marts/
  │  └── DataMart_CategoriesPerf.sql
  │  └── DataMart_CustomerKpis.sql
  │  └── DataMart_ProductsPerf.sql
  │  └── DataMart_DailySales.sql
  │  └── DataMart_WebSessions.sql
  └── Layer4_adhoc_analysis.sql



---

## Comment reproduire le projet

1️⃣ Créer les données bruts ---> [Raw Data](Data/raw_data.sql)

2️⃣ Créer la base de données de la pipeline (la base qui stockera la pipeline des données) ---> [Pipeline Creation](PipelineSQL/Db_pipeline.sql)

3️⃣ Exécuter la couche 1 staging ---> [Layer 1](Layer1_Satging.sql)

4️⃣ Exécuter la couche 2 Enriched Views ---> [Layer 2](Layer2_GlobalEnrichedViews.sql)

5️⃣ Exécuter la couche 3 Data Marts dans l'ordre souhaité ---> [Layer 3](Layer3_DataMarts)

6️⃣ Exécuter la couche 4 Ad Hoc Analysis ou creer des requêtes Ad Hoc personnalisées ---> [Layer 4](Layer4_AdhocAnalysis)


---

# Résultat

Ce projet illustre une **pipeline analytique complète en SQL**, allant de données brutes à des analyses business structurées.
