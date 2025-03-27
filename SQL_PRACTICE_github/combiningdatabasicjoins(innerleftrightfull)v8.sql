--v8 joins - inner ,left, right, full join

-- No Join


select * from customers

select * from orders 

-- Inner Join

SELECT 
   id, first_name,order_id,sales
FROM customers INNER JOIN orders 
on id = customer_id

--best practice - mention the specific table name and for table also give a simle alias name

SELECT c.id,c.first_name AS Name, o.order_id,o.sales FROM customers AS c INNER JOIN orders AS o
ON c.id = o.customer_id


--left join

select c.id,c.first_name AS Name, o.order_id,o.sales from customers as c LEFT JOIN orders as o 
ON c.id = o.customer_id

select c.id,c.first_name AS Name, o.order_id,o.sales from orders as o LEFT JOIN customers as c
ON c.id = o.customer_id

--Right Join

select c.id,c.first_name AS Name, o.order_id,o.sales from customers as c RIGHT JOIN orders as o 
ON c.id = o.customer_id

--full join

select c.id,c.first_name AS Name, o.order_id,o.sales from customers as c FULL JOIN orders as o 
ON c.id = o.customer_id