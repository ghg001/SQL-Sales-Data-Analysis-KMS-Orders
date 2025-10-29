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



SELECT * FROM kms_orders
;

-- categories with highestsales
SELECT product_category,max (sales)
FROM kms_orders
group by product_category
order by product_category desc;

--What are the Top 3 and Bottom 3 regions in terms of sales?
SELECT region, sum(SALES) as sales
FROM kms_orders 
GROUP BY region
ORDER BY sales desc
LIMIT 3
;




SELECT region,sum(SALES) AS sales
FROM kms_orders
GROUP BY region
ORDER BY  sales asc
limit 3;



--What were the total sales of appliances in Ontario?

SELECT product_sub_category,sum (sales)
FROM kms_orders
where  region = 'Ontario' and  product_sub_category = 'Appliances'
group by product_sub_category
;


--Advise the management of KMS on what to do to increase the revenue from the bottom 10 customers
SELECT  customer_name,profit FROM kms_orders
group by  customer_name,profit
order by profit asc
limit 10


---KMS incurred the most shipping cost using which shipping method?
SELECT ship_mode,sum (shipping_cost) as SHIP_COST
FROM kms_orders
GROUP BY ship_mode
ORDER BY SHIP_COST ASC
LIMIT 1 OFFSET 1


---Who are the most valuable customers, and what products or services do they typically purchase?
SELECT customer_name,product_category, sum(sales) as sales
from kms_orders
GROUP BY customer_name,product_category
ORDER BY sales DESC
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






