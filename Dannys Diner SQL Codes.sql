USE Dannys_Diner --/Making refernce to the Dannys_Diner database when fetching the below information./

--1 /Calculating the Total Amount spent by each customer/
Select Sale.customer_id, SUM (Menus.price) as TotalAmountSpent, COUNT(Sale.product_id) as NumberofPurch, Menus.product_name, menus.price
from Sale join Menus on Sale.product_id = Menus.product_id
GROUP BY Sale.customer_id, menus.product_name, Menus.price;

--2 /Calculating the number of days each customer has visited the Diner/
select Sale.customer_id, COUNT(DISTINCT Sale.order_date) as DaysVisited
from Sale
GROUP BY Sale.customer_id; 

--3 /Calculating the day a customer first purcahsed each food item/
select Sale.customer_id, Menus.product_name, MIN(Sale.order_date) as FirstPurchase
from Sale join Menus on Sale.product_id = Menus.product_id
GROUP BY Sale.customer_id,Menus.product_name
ORDER BY Sale.customer_id;

--4 /Calculating how many times a food item has been purchased/
select Menus.product_name, COUNT(Sale.product_id) as NumberofPurchase
from Sale join Menus on Sale.product_id = Menus.product_id
GROUP BY Menus.product_name;

--5 /Calculating how many times a food item has been purchased by each customer/
select Sale.customer_id, Menus.product_name, COUNT(Sale.product_id) as NumberofPurchase
from Sale join Menus on Sale.product_id = Menus.product_id
GROUP BY Sale.customer_id, Menus.product_name;

--6 /Calculating the item purchased when the customer became a Member/
select Sale.customer_id, Menus.product_name, Customers.join_date, Sale.order_date
from Customers, Sale join Menus on Sale.product_id = Menus.product_id
where Sale.order_date = Customers.join_date
GROUP BY Sale.customer_id, Menus.product_name, Sale.order_date, Customers.join_date;

--7 /Calculating food items purchased by each customer before becoming a member/
select Sale.customer_id, Menus.product_name
from Customers, Sale join Menus on Sale.product_id = Menus.product_id 
where Sale.order_date !> Customers.registered_date
GROUP BY Menus.product_name, Sale.customer_id;

--8 /Calculating Total amount spent by each customer before becoming a member/
select Sale.customer_id, Menus.product_name, COUNT(Sale.product_id) as TotalPurchase, SUM(Menus.price) as AmountSpent
from Customers, Sale join Menus on Sale.product_id = Menus.product_id 
where Sale.order_date !> Customers.registered_date
GROUP BY Menus.product_name, Sale.customer_id;

--9 /Calculating to give 10 points to Customers who bought any food item other than Sushi and 20 points to Customers who did/
select Sale.customer_id, Menus.product_name, Menus.price, COUNT(Sale.product_id) as TotalNoPurchase, SUM(Menus.price)as TotalAmountSpent,
Total_Point = SUM(Menus.price * CASE WHEN Menus.product_name = 'Sushi' THEN 20 ELSE 10 END)
from Sale join Menus on Sale.product_id = Menus.product_id
GROUP BY Sale.customer_id, Menus.product_name, Menus.price
ORDER BY Sale.customer_id; 

--10 /A query to show item purchased by customer, when it was purchased, the cost and if the Customer was already a member when the item was purchased/
select Customers.customer_id, Sale.order_date, Menus.product_name, Menus.price, CASE WHEN Sale.order_date >= Customers.registered_date THEN 'Y' ELSE 'N' END AS Members
from Customers, Sale join Menus on Sale.product_id = Menus.product_id
ORDER BY customer_id


