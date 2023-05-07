SELECT * FROM product

drop table orders

drop table customers
--CASCADE
CREATE TABLE customers ( 
id serial primary key,
name VARCHAR (25),
email varchar (25) unique not null
);
CREATE TABLE orders ( 
id serial primary key,
customer_id INT references customers(id) on delete cascade,
order_date date not Null);

Insert into customers (name, email) values ('John okechukwu', 'john@gmail.com')
Insert into orders (customer_id, order_date) values (1, current_date)


SELECT * FROM customers 
SELECT * FROM orders 

DELETE FROM orders where id = 1

SELECT * FROM product


Mathematical operators 
--Addition: +
select unit_price + unit_cost sum_of_two_columns from product

--Subtraction: -
select unit_price - unit_cost profit from product
ALTER TABLE product add column profit 
UPDATE product set profit = unit_price-unit_cost

ALTER TABLE product drop column profit

--Multiplication: *
select 5*5
select unit_price * unit_cost profit from product

--Division: /
select unit_price / unit_cost profit from product

--Modulus (remainder): %
SELECT 6%3

--Exponentiation: ^ 
SELECT 3 ^ 2

SELECT POWER(3,2)
select POWER (unit_price, 2) from product

--FLOOR 
SELECT FLOOR(8.64) --8.64 = X
SELECT FLOOR(-8.64)

--CEILING 
SELECT CEILING(9.00) --8.64 = X
SELECT CEILING(-8.64)

--ROUND
SELECT ROUND((8.448654), 4)

comparison operators 
-- =
-- !=
SELECT * FROM product where product_id != 5

--Greater than: >
SELECT * FROM product where product_id > 3


--Less than: <
SELECT * FROM product where product_id < 3

-- >=
SELECT * FROM product where product_id >= 3


-- <=
SELECT * FROM product where product_id <= 3


SELECT * FROM product
-- LIKE
SELECT * FROM product where product_name like '%Book%'

-- NOT LIKE
SELECT * FROM product where product_name NOT like '%i%'

-- IN
SELECT * FROM product WHERE product_name in ('iPhone 13', 'Pixel 6') 
OR product_category in ('Laptop') 

-- NOT IN
SELECT * FROM product WHERE product_name NOT in ('iPhone 13', 'Pixel 6') 

SELECT * FROM order_table

-- IS NULL
SELECT * FROM order_table where delivery_status is null

-- IS NOT NULL
SELECT * FROM order_table where delivery_status is not null

-- BETWEEN
SELECT * FROM order_table where order_id between 5 and 10

-- NOT BETWEEN
SELECT * FROM order_table where order_id not between 5 and 10


Logical operators 
--AND
--OR

SELECT * FROM product

SELECT * FROM product where product_name = 'iPhone 13' OR product_category='Laptop'

SELECT * FROM product where product_name = 'iPhone 13' AND product_category='Laptop'

--NOT

JOIN

SELECT * FROM customer
SELECT * FROM order_table
SELECT * FROM creditcard
SELECT * FROM product


SELECT * FROM customer 
INNER JOIN order_table ON customer.customer_id = order_table.customer_id
--
SELECT * FROM customer c
INNER JOIN order_table o ON c.customer_id = o.customer_id
INNER JOIN creditcard cr on c.customer_id = cr.customer_id
--
SELECT * FROM customer 
INNER JOIN order_table using (customer_id)
INNER JOIN creditcard using (customer_id)




SELECT customer_id, customer_name, order_date, product_name, delivery_status from customer
JOIN creditcard ON customer.customer_id = creditcard.customer_id
JOIN order_table ON customer.customer_id = order_table.customer_id
JOIN product on order_table.product_id = product.product_id



SELECT customer_name, order_date, product_name, delivery_status, quantity, unit_price from customer c
JOIN creditcard cr ON c.customer_id = cr.customer_id
JOIN order_table o ON c.customer_id = o.customer_id
JOIN product p on o.product_id = p.product_id

SELECT c.customer_name, SUM(quantity * unit_price) revenue from customer c
JOIN creditcard cr ON c.customer_id = cr.customer_id
JOIN order_table o ON c.customer_id = o.customer_id
JOIN product p on o.product_id = p.product_id
where customer_name = 'John Doe' 
GROUP BY c.customer_name







































