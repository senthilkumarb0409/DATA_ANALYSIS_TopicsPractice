-- view:

--create,update, drop view:

--1. find the running total  of sales for each month
/*
with CTE_Monthly_Summary as
(
	select 
	DATETRUNC(month, OrderDate) OrderMonth,
	Sum (Sales) TotalSales,
	count(OrderID) TotalOrders,
	sum(Quantity) TotalQuantity
	From Sales.Orders 
	group by DATETRUNC(month, OrderDate)
)
select 
OrderMonth,
sum(TotalSales) over (order by OrderMonth) RunningTotal
from CTE_Monthly_Summary
*/


Create View Sales.V_Monthly_Summary as 
(
   select 
	DATETRUNC(month, OrderDate) OrderMonth,
	Sum (Sales) TotalSales,
	count(OrderID) TotalOrders,
	sum(Quantity) TotalQuantity
	From Sales.Orders 
	group by DATETRUNC(month, OrderDate)
)

-- select * from V_Monthly_Summary
-- drop view V_Monthly_Summary

select 
*,
sum(TotalSales) over (order by OrderMonth) RunningTotal
from Sales.V_Monthly_Summary

if object_id ('Sales.V_Monthly_Summary' , 'V') is not null
    Drop View Sales.V_Monthly_Summary
Go
Create View Sales.V_Monthly_Summary as 
(
   select 
	DATETRUNC(month, OrderDate) OrderMonth,
	Sum (Sales) TotalSales,
	count(OrderID) TotalOrders
	From Sales.Orders 
	group by DATETRUNC(month, OrderDate)
)

-- 2. provide the view that combines detailsfrom orders , products, customers and employees

create view Sales.V_Order_Details As
(
select 
o.OrderID,
o.OrderDate,
CONCAT(c.FirstName, ' ' ,c.LastName) CustomerName,
p.Product,
p.Category,
o.Quantity,
o.Sales,
c.Country,
c.Score,
e.EmployeeID,
concat(e.FirstName , ' ' , e.LastName) Salesperson_name,
e.Department
From Sales.Orders o
left join Sales.Products p
on o.ProductID = p.ProductID
left join Sales.Customers c
on o.CustomerID = c.CustomerID
left join Sales.Employees e
on o.SalesPersonID = e.EmployeeID
)

select * From Sales.V_Order_Details


-- provide a view for eu sales team
-- that combines all the tables
-- exclude data related to usa

create view Sales.V_EUOrder_Details As
(
select 
o.OrderID,
o.OrderDate,
CONCAT(c.FirstName, ' ' ,c.LastName) CustomerName,
p.Product,
p.Category,
o.Quantity,
o.Sales,
c.Country,
c.Score,
e.EmployeeID,
concat(e.FirstName , ' ' , e.LastName) Salesperson_name,
e.Department
From Sales.Orders o
left join Sales.Products p
on o.ProductID = p.ProductID
left join Sales.Customers c
on o.CustomerID = c.CustomerID
left join Sales.Employees e
on o.SalesPersonID = e.EmployeeID
where c.Country != 'USA'
)

select * from Sales.V_EUOrder_Details