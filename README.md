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
## Data Pipeline Architecture

```mermaid
flowchart TD

subgraph Raw_Data["Raw Data Sources"]
A1["db_ecommerce.raw_customers"]
A2["db_ecommerce.raw_orders"]
A3["db_ecommerce.raw_order_items"]
A4["db_catalogue.db_products"]
A5["db_catalogue.db_categories"]
A6["db_analytics.raw_sessions"]
end


subgraph Layer1["Layer 1 - Staging (Cleaning & Standardization)"]
B1["stg_customers"]
B2["stg_orders"]
B3["stg_products"]
B4["stg_sessions"]
end


subgraph Layer2["Layer 2 - Enriched Views"]
C1["int_enriched_orders"]
C2["int_enriched_sessions"]
end


subgraph Layer3["Layer 3 - Data Marts"]
D1["DataMart_ProductsPerf"]
D2["DataMart_CategoriesPerf"]
D3["DataMart_CustomerKpis"]
D4["DataMart_DailySales"]
D5["DataMart_WebSessions"]
end


subgraph Layer4["Layer 4 - Ad Hoc Analysis"]
E1["Business Analysis Queries"]
end


A1 --> B1
A2 --> B2
A4 --> B3
A6 --> B4

B1 --> C1
B2 --> C1
B3 --> C1
A3 --> C1

B4 --> C2
B1 --> C2

C1 --> D1
C1 --> D2
C1 --> D3
C1 --> D4

C2 --> D5

D1 --> E1
D2 --> E1
D3 --> E1
D4 --> E1
D5 --> E1


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

```
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
```


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
