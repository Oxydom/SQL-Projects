CREATE TABLE order_date_status (order_id int PRIMARY KEY, order_date DATE, order_status text
							   FOREIGN KEY )
COPY order_date_status FROM 'C:\Users\HP\Desktop\order_date_status.CSV' WITH CSV HEADER;

SELECT* FROM orders

CREATE TABLE product_cost_price (product_id int PRIMARY KEY, unit_price int, unit_cost decimal(20,1))
COPY product_cost_price FROM 'C:\Users\HP\Desktop\product_cost_price.CSV' WITH CSV HEADER

