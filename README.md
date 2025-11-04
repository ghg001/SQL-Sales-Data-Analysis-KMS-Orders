# SQL-Sales-Data-Analysis-KMS-Orders
Tool:SQL(POSTGRE SQL/ MY SQL)

### PROJECT OVERVIEW
1. Company Overview
Kultra Mega Stores (KMS), headquartered in Lagos, specialises in office supplies and furniture. Its customer base includes individual consumers, small businesses (retail), and large corporate clients (wholesale) across Lagos, Nigeria.
y responsibility as a Business Intelligence Analyst to support the Abuja division of KMS. The Business Manager has shared an Excel file containing order data from 2009 to 2012 and has requested thati analyze the data and present key insights and findings.

### Techniques used
- Aggregate :sum(),Max(),MIN() Functions to summaries as sales
- grouping; GROUP BY used for category,region and subcategory analysis
- Filtering & Ranking:ORDER BY and LIMIT used to find top/button perfomer
- alias uasage: created meaningful column names for readablity


## Project stucture

1 database setup
- **Database Creation**: The project starts by creating a database named `kml order`.
- table creation CREATE TABLE kms_ordersThe table structure includes columns for
    row_id INTEGER,order_id INTEGER,order_date DATE,order_priority TEXT, order_quantity INTEGER, sales NUMERIC(12,2),discount ,ship_mode ,profit ,unit_price , shipping_cost , customer_name , province , region,customer_segment ,product_category ,product_sub_category ,product_name ,product_container,product_base_margin and ship_date DATE

  ```SQL
  CREATE TABLE kms_orders (
    row_id INTEGER,
    order_id INTEGER,
    order_date DATE,
    order_priority TEXT,
    order_quantity INTEGER,
    sales NUMERIC(12,2),
    discount NUMERIC(5,2),
    ship_mode TEXT,
    profit NUMERIC(12,2),
    unit_price NUMERIC(12,2),
    shipping_cost NUMERIC(12,2),
    customer_name TEXT,
    province TEXT,
    region TEXT,
    customer_segment TEXT,
    product_category TEXT,
    product_sub_category TEXT,
    product_name TEXT,
    product_container TEXT,
    product_base_margin NUMERIC(5,2),
    ship_date DATE
);

### Business Objectives
- Identify the most profitable product categories.
 ```sql
SELECT product_category,max (sales)
FROM kms_orders
group by product_category
order by product_category desc
```
- Evaluate regions with the highest and lowest revenue.
 ```sql
--low regions
SELECT region, sum(SALES)
FROM kms_orders 
GROUP BY region,sales
ORDER BY sales desc
LIMIT 3

--high region
SELECT region,sum(SALES) AS MIN_SALES
FROM kms_orders
GROUP BY region
ORDER BY MIN_SALES Asc
LIMIT 3
```

--What were the total sales of appliances in Ontario?
```sql
SELECT product_sub_category,sum (sales)
FROM kms_orders
where  region = 'Ontario' and  product_sub_category = 'Appliances'
group by product_sub_category
```
---KMS incurred the most shipping cost using which shipping method?
```sql
SELECT ship_mode,sum (shipping_cost) as SHIP_COST
FROM kms_orders
GROUP BY ship_mode
ORDER BY SHIP_COST ASC
LIMIT 1 OFFSET 1
```

--break down of profit made by month,accumulating to profit made by year
```sql
with Tp (total_profit,month,year) as
(SELECT sum(profit) as total_profit,extract (month from order_date) as month,extract (year from order_date) as year
FROM kms_orders
group by 2,3
order by 3,2)
select month,year,total_profit,sum(total_profit) over(partition by year order by month asc )
from Tp
```
--top performing product_categoty in each year
```sql
with Pr (profit,product_category,year,rank) as 
(SELECT sum(profit) as profit, product_category,extract (year from order_date) as year,
rank() over (partition by extract (year from order_date)order by sum(profit)desc ) as rank
FROM kms_orders
group by product_category,extract (year from order_date)
order by 3,1 desc)
select profit,product_category,year,rank
from Pr
where rank = 1
```



### SQL Queries & Insights



### Key Insights
- technology leads in product categoty by  significant margin
- Ontario is the top revenue generating regions
- Furniture struggles in most regions  opportunity for review.
### Conclusion
the analysis demonstrates my ability to transform raw transactional data into meaningful insights.
