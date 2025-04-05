--Null Function

--COALESCE,ISNULL, NULLIF, IS(NOT)NULL

--ISNULL(VALUE, REPLACEMENT_VALUE)
--COALESCE(VALUE1, VALUE2, ....)

Select * From Sales.Customers

--find the average scores of the customers.

select CustomerID, Score ,
Avg(Score) Over() AvgScore,
avg(coalesce(Score,'0')) over() AvgScoreNullclear
From Sales.Customers

--display the full name of customers in a single field
--by merging their first and last names,
--and add 10 bonus points to each customer's score.

Select CustomerID,
FirstName,LastName,
Score
from Sales.Customers

--ans:

Select CustomerID,
Concat(FirstName,' ',LastName) as FullName,
COALESCE(Score,0) + 10 as Score
from Sales.Customers

--use handling nulls before joins
--use bulls before sorting the data


--sort the customrs low to high with nulls appear atlast


select CustomerID, 
Concat(FirstName,' ',LastName) as FullName,
Score
from Sales.Customers 
order by case when Score is null then 1 else 0 end,
Score

--nullif(value1,value2) - compares two expression 
--returns null if are  equal
-- and first value if not equal

--find sales price for each order by dividing sales by quantity

select OrderID,
Sales,
Quantity,
Sales/ nullif(Quantity,0) as priceperorder
from Sales.Orders

--is null, is not null

--find the customers who have no scores

select * from Sales.Customers where Score is null

--find the customers who have  scores

select * from Sales.Customers where Score is not null

-- is null with left and right joins to make it 
--left anti join and right anti join

--list all customers who have not places any orders

select * from Sales.Customers
select * from Sales.Orders

select c.CustomerID,c.FirstName,c.LastName,c.Country,c.Score
from Sales.Customers as c left join
Sales.Orders as o on c.CustomerID = o.CustomerID 
where o.CustomerID is null



















