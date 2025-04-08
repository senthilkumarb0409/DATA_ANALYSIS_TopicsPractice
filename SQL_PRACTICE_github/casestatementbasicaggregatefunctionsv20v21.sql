--how to build a conditional logic using case statement
--use case:
--data transformation
-- *categorizing data


--Generate a report showing the total sales for each category

select 
Category,
sum(Sales) as Total_Sales
from (
Select
OrderID,
Sales,
case when Sales > 50 then 'High'
     when Sales >20  then 'Medium'
	 else 'Low' 
end Category
From Sales.Orders
)t
group by Category Order by Total_Sales desc

-- Retrive employee details with gender displayed as full text

select 
EmployeeID,
FirstName,
LastName,
case 
   when Gender = 'F' then 'Female'
   when Gender = 'M' then 'Male'
end Gender
From Sales.Employees

--retrive customers details with abbreviated country code

Select 
CustomerID,
FirstName,
LastName,
case 
  when Country = 'Germany' then 'GER'
  when Country = 'USA' then 'US'
end Country
from Sales.Customers

--find average scores of customers and treat nulls as 0
--additionally provide details such as custid and lastname

--usual way

select 
CustomerID,
LastName,
Score,
coalesce(Score, 0) scrnonull,
avg(Score) over() withnull,
avg(coalesce(Score, 0)) over() avgnonull
from Sales.Customers

--using case statement

select 
CustomerID,
LastName,
Score,
case
   when Score is null then 0
   else Score
end Scorenonull,
avg(Score) over() withnullavg,
avg(case when Score is null then 0 else Score
end) over() withnonullavg
from Sales.Customers

--count how manny times each customer has made an order with sales greater then 30

select CustomerID, 
sum(case 
   when Sales > 30 then 1
   else 0
end) totalOrdersg30,
count(*) totalorders
from Sales.Orders 
group by CustomerID

--Aggregate functions : input multiple rows and gives a single output
-- count(),avg(),min(),max(),sum()

select count(*) as totalorders,
sum(Sales) as totalsales,
avg(Sales) as avgsales
from Sales.Orders




