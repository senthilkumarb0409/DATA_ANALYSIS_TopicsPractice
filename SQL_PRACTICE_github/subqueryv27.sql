-- Subqueries 

--RESULT TYPES : SCALAR SUBQUERY - returns single value

select avg(sales) average from sales.Orders

--RESULT TYPES : ROW SUBQUERY - returns multiple rows & single column

select CustomerID From Sales.Orders

--RESULT TYPES : TABLE SUBQUERY - returns multiple rowa & multiple column

select  OrderID, OrderDate from sales.orders

-- subquery in FROM clause

-- find the products that have price higher than the average price of all the products

-- Main Query
select 
ProductID, Price
FROM
--subquery
(select 
ProductID, 
Price,
avg(price) over() as averprice
from sales.Products)t
where Price > averprice

-- Rank the cutomers based on total amount pf sales


select 
*,
RANK() over(Order by TotalSales desc) CustRank
From
(select 
CustomerID,
sum(Sales) TotalSales
From
sales.Orders group by CustomerID)t

-- subquery in SELECT clause

--show the productID, price, name and total orders

Select ProductID,
Product, 
Price,
(Select Count(*) From Sales.Orders) as TotalOrders
From Sales.Products

-- subquery in Join Clause
-- show all customer details  and find the total orders of each customers

Select 
c.*,
o.TotalOrders
From Sales.Customers c
Left join
(Select CustomerID, count(*) TotalOrders From Sales.Orders group by CustomerID) o
on c.CustomerID = o.CustomerID

--subquery in where clause -> comparison and logical operators

-- find the products that have price higher than the average price of all the products

Select 
ProductID, Price
From Sales.Products where Price > (select Avg(Price) from Sales.Products)

-- show the details of orders made by customers in germany

Select * From Sales.Orders 
where CustomerID IN 
(Select CustomerID From Sales.Customers Where Country = 'Germany')

-- Find the female employees whose salary is greater than salaries any of the male employees

select 
EmployeeID,
FirstName,
Gender, Salary
From Sales.Employees
Where Gender = 'F' AND Salary > ANY (select  Salary From Sales.Employees Where Gender = 'M')

-- correlated sub queries

-- show all customer details  and find the total orders of each customers

Select *,
(Select count(*) From Sales.Orders O Where O.CustomerID = C.CustomerID) TotalOrders
From Sales.Customers C where Score is not null


-- show the details of orders made by customers in germany

Select * From Sales.Orders O
Where Exists (Select * From Sales.Customers C where Country = 'Germany' AND O.CustomerID = C.CustomerID)




