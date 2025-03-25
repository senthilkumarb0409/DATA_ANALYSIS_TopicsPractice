select * from customers;


select * from orders;

select first_name, country from customers;

select customer_id , sales from orders;

--where

select * from customers where score >= 500;

select * from customers where score != 0;

select * from customers where country = 'Germany';

-- order by

select * from customers order by score desc;

select * from customers where score > 500 order by score desc;

-- group by

select country, sum(score)  as scores, count(id) as total_customers 
from customers 
group by country 
order by scores desc; 

--having clause

select country, sum(score)  as scores, count(id) as total_customers 
from customers 
group by country 
having sum(score) >750
order by scores desc; 

-- find the average score for each country considering 
-- only customers with a score not equal to 0
-- and return only those countries with
-- average score greater than 430


select country, AVG(score) as Average_Score 
from customers where score != 0  group by country
having AVG(score) > 430 order by Average_Score desc;