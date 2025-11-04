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


SELECT *
FROM kms_orders


SELECT sum(profit) as total_profit,extract (month from order_date) as month,extract (year from order_date) as year,
FROM kms_orders
group by 2,3
order by 3,2
;
  

-- categories with highestsales
SELECT product_category,max (sales)
FROM kms_orders
group by product_category
order by product_category desc;

--What are the Top 3 and Bottom 3 regions in terms of sales?
SELECT region, sum(SALES)
FROM kms_orders 
GROUP BY region,sales
ORDER BY sales desc
LIMIT 3
;




SELECT region,sum(SALES) AS MIN_SALES
FROM kms_orders
GROUP BY region
ORDER BY MIN_SALES A
LIMIT 3;



--What were the total sales of appliances in Ontario?

SELECT product_sub_category,sum (sales)
FROM kms_orders
where  region = 'Ontario' and  product_sub_category = 'Appliances'
group by product_sub_category
;


--Advise the management of KMS on what to do to increase the revenue from the bottom 10 customers
SELECT customer_name,MIN (sales) as min_sales
from kms_orders
GROUP BY customer_name
ORDER BY  min_sales asc
LIMIT 10;

---KMS incurred the most shipping cost using which shipping method?
SELECT ship_mode,sum (shipping_cost) as SHIP_COST
FROM kms_orders
GROUP BY ship_mode
ORDER BY SHIP_COST ASC
LIMIT 1 OFFSET 1


---Who are the most valuable customers, and what products or services do they typically purchase?
SELECT customer_name,product_category, MAX(sales) as MAX_sales
from kms_orders
GROUP BY customer_name,product_category
ORDER BY MAX_sales DESC
LIMIT 10



---Which small business customer had the highest sales?
SELECT customer_name,customer_segment,sum(sales) as max_sales
from kms_orders
GROUP BY customer_name,customer_segment
order by max_sales desc
LIMIT 1

-----
CREATE TABLE ORDER_(
Order_ID INTEGER,
Status TEXT
)

SELECT * 
FROM ORDER_




SELECT *
FROM kms_orders
JOIN ORDER_
	ON kms_orders.order_id=ORDER_.order_id


--Which Corporate Customer placed the most number of orders in 2009 – 2012?


SELECT order_date,order_id,customer_name,customer_segment
FROM kms_orders
where order_date BETWEEN '2009-01-01' AND '2012-12-31'
GROUP BY order_date,order_id,customer_name,customer_segment



--Which consumer customer was the most profitable one?

SELECT customer_name,SUM(profit) AS revenue
FROM kms_orders
GROUP BY customer_name
ORDER BY revenue DESC;



--Which customer returned items, and what segment do they belong to?
SELECT kms_orders.customer_name,kms_orders.customer_segment,ORDER_.status
FROM kms_orders
JOIN ORDER_
	ON kms_orders.order_id=ORDER_.order_id
group by  kms_orders.customer_name,kms_orders.customer_segment,ORDER_.status

--profit made by year
with profit_by_month as
(SELECT extract (month from order_date) as month,extract (year from order_date) as year,sum(profit) as total_profit
FROM kms_orders
group by 1,2
order by 2,1)
select sum(total_profit)
from profit_by_month
where year = 2009

--break down of profit made by month,accumulating to profit made by year
with Tp (total_profit,month,year) as
(SELECT sum(profit) as total_profit,extract (month from order_date) as month,extract (year from order_date) as year
FROM kms_orders
group by 2,3
order by 3,2)
select month,year,total_profit,sum(total_profit) over(partition by year order by month asc )
from Tp






