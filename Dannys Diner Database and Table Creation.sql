USE Dannys_Diner -- using the Dannys_Diner database/
CREATE TABLE Sales -- creating tables with their respective columns in the Dannys_Diner database
(customer_id VARCHAR(1),
order_date DATE,
product_id INT,
FOREIGN KEY(customer_id) REFERENCES Members(customer_id));

CREATE TABLE Members 
(customer_id VARCHAR(1),
join_date TIMESTAMP,
PRIMARY KEY(customer_id));

CREATE TABLE Menu
(product_id INT,
product_name VARCHAR(5),
price INT,
PRIMARY KEY(product_id));