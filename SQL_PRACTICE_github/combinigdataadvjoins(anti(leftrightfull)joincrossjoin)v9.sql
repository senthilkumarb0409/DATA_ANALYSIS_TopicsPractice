--combining data 
-- advanced joins - Anti joins(left,right,full), cross joins

-- Left Anti joins

--get all customers who havent placed any orders

select  c.id , c.first_name, c.score,c.country 
from customers as c left join orders as o 
on c.id = o.customer_id 
where o.customer_id IS NULL 

--Right Anti Join

select * from orders
select * from customers

insert into orders values (1005,7,'2021-09-04',99),
(1006,8,'2021-10-17',88)

--get all orders without matching customers

select  * /*o.order_id , o.customer_id, o.order_date,o.sales */ 
from customers as c Right join orders as o 
on c.id = o.customer_id 
--where c.id IS NULL

select  * /*o.order_id , o.customer_id, o.order_date,o.sales */ 
from customers as c Right join orders as o 
on c.id = o.customer_id 
where c.id IS NULL

--using right join for right anti join

select  o.order_id , o.customer_id, o.order_date,o.sales 
from customers as c Right join orders as o 
on c.id = o.customer_id 
where c.id IS NULL

--using left join for right anti join

select  o.order_id , o.customer_id, o.order_date,o.sales 
from  orders as o left join  customers as c 
on c.id = o.customer_id 
where c.id  IS NULL

-- full anti join -> opposite of inner join

select  *
from customers as c full join orders as o  
on c.id = o.customer_id 
where c.id  IS NULL or  o.customer_id IS NULL


--get all customers along with their orders, but only for the customers 
-- who have palce their orders without using inner join

select  *
from customers as c left join orders as o  
on c.id = o.customer_id 
where o.customer_id IS NOT NULL

--using inner join

select * from customers as c inner join orders as o
on c.id = o.customer_id

-- cross join -

-- generate all possible combination of customers and order

select * from customers

select * from orders

select * from customers cross join orders

select * from orders cross join customers