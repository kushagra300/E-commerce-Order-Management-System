-- QUESTIONS

-- 1 Retrieve the order ID, customer IDs and customer names and total amounts for orders that have a total amount greater than $1000.

SELECT o.order_id,o.customer_id,c.customer_name,SUM(qty * order_price) as total_amt
FROM 
orders o 
INNER JOIN customers c
ON o.customer_id = c.customer_id
RIGHT JOIN orders_details d
ON o.order_id = d.order_id
GROUP BY o.order_id
HAVING total_amt > 1000;

-- 2 Retrieve the total quantity of each product sold.

SELECT p.product_name , p.product_id , SUM(qty) as total_quantity_sold
FROM products p
INNER JOIN orders_details o
ON p.product_id = o.product_id
GROUP BY p.product_name , p.product_id ;

-- 3 Retrieve the order details (order ID, product name, quantity) for orders with a quantity greater than the average quantity of all orders.

SELECT o.order_id, p.product_name , o.qty  
FROM products p
INNER JOIN orders_details o
ON p.product_id = o.product_id
WHERE o.qty > (SELECT AVG(qty) FROM orders_details);

-- 4 Retrieve the order IDs and the number of unique products included in each order.

SELECT order_id , COUNT(DISTINCT product_id) as unq_products
FROM Orders_Details
GROUP BY order_id;

-- 5 Retrieve the total number of products sold for each month in the year 2023. Display the month along with the total number of products.

SELECT month(a.Order_date) as `year_month` , SUM(b.qty) as total_pro
FROM orders a
INNER JOIN orders_details b
ON a.order_id = b.order_id
WHERE year(a.order_date) = 2023
GROUP BY month(a.Order_date);

-- 6 Retrieve the total number of products sold for each month in the year 2023 where the total number of products sold were greater than 2. Display the month along with the total number of products.

SELECT month(a.Order_date) as `year_month` , SUM(b.qty) as total_pro
FROM orders a
INNER JOIN orders_details b
ON a.order_id = b.order_id
WHERE year(a.order_date) = 2023
GROUP BY month(a.Order_date)
HAVING SUM(b.qty) > 2;

-- 7 Retrieve the order IDs and the order amount based on the following criteria:
-- a. If the total_amount > 1000 then ‘High Value’
-- b. If it is less than or equal to 1000 then ‘Low Value’
-- c. Output should be — order IDs, order amount and Value

SELECT order_id, total_amount, 
CASE
    WHEN total_amount > 1000 THEN "High Value"
    WHEN total_amount <= 1000 THEN "Low Value"
END as `Value`
FROM orders;

-- 8 Retrieve the order IDs and the order amount based on the following criteria:
-- a. If the total_amount > 1000 then ‘High Value’
-- b. If it is less than 1000 then ‘Low Value’
-- c. If it is equal to 1000 then ‘Medium Value’
-- Also, please only print the ‘High Value’ products. 
-- Output should be — order IDs, order amount and Value

SELECT order_id, total_amount, order_value
FROM (
SELECT order_id,
total_amount,
CASE
 WHEN total_amount > 1000 THEN 'High Value'
 WHEN total_amount = 1000 THEN 'Medium Value'
 ELSE 'Low Value'
END AS order_value
FROM Orders) as sub
WHERE order_value = 'High Value';


