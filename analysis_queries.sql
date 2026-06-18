CREATE DATABASE olist_ecommerce;
USE olist_ecommerce;

show tables;

select count(*) from customers  ;
select count(*) from order_items  ;
select count(*) from orders  ;
select count(*) from payments  ;
select count(*) from products  ;
alter table  payment rename payments; 
select * from customers limit 10  ;
select * from order_items limit 10  ;
select * from orders limit 10  ;
select * from payments limit 10  ;
select * from products limit 10  ;

-- Q1: What is the total number of orders?
SELECT COUNT( DISTINCT order_id) AS total_orders
FROM orders;

-- Q2 what is the total revenue generated?

SELECT ROUND(SUM(payment_value),2 )AS total_revenue
FROM payments;

-- Q3 Which payment type generates the hightest revenue?

SELECT payment_type,ROUND(SUM(payment_value),2 )AS total_revenue
FROM payments
GROUP BY payment_type
ORDER BY total_revenue DESC;

-- Q4 Which cities have the hightest number of orders?

SELECT c.customer_city,COUNT(o.order_id) AS total_orders
FROM customers c 
JOIN orders o 
ON c.customer_id=o.customer_id
GROUP BY c.customer_city
ORDER BY total_orders DESC
LIMIT 10;

-- Q5 How much reveue was generated each month?
SELECT DATE_FORMAT(o.order_purchase_timestamp, '%Y-%m') AS order_month,
ROUND(SUM(p.payment_value), 2) AS total_revenue
FROM orders o
JOIN payments p
ON o.order_id = p.order_id
GROUP BY order_month 
ORDER BY order_month LIMIT 10;

-- Q6 Which product categories have the highest number of orders?
SELECT p.product_category_name,
COUNT(DISTINCT oi.order_id) AS total_orders
FROM order_items oi
JOIN products p
ON oi.product_id = p.product_id
GROUP BY p.product_category_name
ORDER BY total_orders DESC
LIMIT 10;

-- Q7 How many orders are there for each order status?
SELECT order_status,COUNT(order_id) AS total_orders
FROM orders
GROUP BY order_status
ORDER BY total_orders DESC;

-- Q8 What is the average amount spent per order?
SELECT ROUND(SUM(payment_value) / COUNT(DISTINCT order_id), 2) AS average_order_value
FROM payments;

-- Q9 Which products generated the hightest revenue?
SELECT oi.product_id,p.product_category_name,
ROUND(SUM(oi.price), 2) AS total_revenue
FROM order_items oi
JOIN products p
ON oi.product_id = p.product_id
GROUP BY oi.product_id, p.product_category_name
ORDER BY total_revenue DESC
LIMIT 10;

-- Q10 Which customers spent the most money?
SELECT c.customer_id,c.customer_city,
ROUND(SUM(p.payment_value), 2) AS total_spent
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
JOIN payments p
ON o.order_id = p.order_id
GROUP BY c.customer_id, c.customer_city
ORDER BY total_spent DESC
LIMIT 10;
