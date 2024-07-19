--::----Basic Questions----::---
--Retrieve the total number of orders placed

SELECT count( distinct order_id) as Total_numbers from orders

--Calculate the total revenue generated from pizza sales.

SELECT cast(SUM(p.price*od.quantity) as decimal(10,2)) as Total_rev from order_details as od INNER JOIN pizzas as p ON p.pizza_id = od.pizza_id

--Identify the highest-priced pizza.

SELECT top 1 pizza_type_id,MAX(price) as high_price from pizzas
GROUP BY pizza_type_id
ORDER BY high_price DESC

--Alternative Solution is 

WITH CTE AS (
    SELECT pt.name as 'Pizza_Name', CAST(p.price as decimal(10,2)) as price
    ,RANK() OVER(Order By p.price desc) as rnk from pizzas p INNER JOIN pizza_types pt ON
    p.pizza_type_id = pt.pizza_type_id
)
SELECT Pizza_Name, price from CTE WHERE rnk=1

--Identify the most common pizza size ordered.

SELECT * from order_details
SELECT * from pizzas

SELECT p.[size] , COUNT(distinct od.order_id) as 'No of Orders',SUM(quantity) as 'Total Quantity Ordered' 
from order_details od 
    INNER JOIN pizzas p 
    ON
    od.pizza_id = p.pizza_id
GROUP By p.[size]
ORDER BY [No of Orders] DESC


--List the top 5 most ordered pizza types along with their quantities.
SELECT * from order_details
SELECT * from pizzas

SELECT top 5 pt.name as 'Pizza Name' , SUM(od.quantity) as 'Total Quantity' from order_details od INNER JOIN pizzas p ON od.pizza_id = p.pizza_id 
INNER JOIN pizza_types pt ON pt.pizza_type_id = p.pizza_type_id
GROUP BY pt.name
ORDER BY [Total Quantity] DESC

--::----Intermediate Questions----::---

--Find the total quantity of each pizza category ordered (this will help us to understand the category which customers prefer the most).

SELECT * from pizza_types
SELECT * from pizzas
SELECT * FROM order_details

SELECT 
    pt.category as 'Pizza Catgorey',
    SUM(od.quantity) as 'Total Quantity'
from order_details od 
    INNER JOIN pizzas p 
    ON od.pizza_id = p.pizza_id
    INNER JOIN pizza_types pt 
    ON p.pizza_type_id = pt.pizza_type_id
    GROUP BY pt.category
    ORDER BY [Total Quantity] DESC

--Determine the distribution of orders by hour of the day (at which time the orders are maximum (for inventory management and resource allocation).

SELECT DATEPART(HOUR,[time]) as 'Hour of the Day', COUNT(distinct(order_id)) as 'No of Orders' from orders
GROUP BY DATEPART(HOUR,[time])
ORDER BY [No of Orders] DESC

--Find the category-wise distribution of pizzas (to understand customer behaviour).

SELECT category , COUNT(distinct pizza_type_id) as 'No of Pizzas' from pizza_types
GROUP BY category
ORDER BY [No of Pizzas] DESC

--Group the orders by date and calculate the average number of pizzas ordered per day.

SELECT * from orders
SELECT * from pizzas
SELECT * from pizza_types
SELECT * from order_details