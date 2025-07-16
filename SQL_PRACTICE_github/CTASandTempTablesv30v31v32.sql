-- tables  and temp tables

-- CTAS

Select 
	DATENAME(month, OrderDate) OrderMonth,
	count(OrderID) TotalOrders
into Sales.MonthlyOrders
From Sales.Orders
Group by DATENAME(month, OrderDate)

if OBJECT_ID ('Sales.MonthlyOrders' , 'U') is not null
     drop table Sales.MonthlyOrders
go
Select 
	DATENAME(month, OrderDate) OrderMonth,
	count(OrderID) TotalOrders
into Sales.MonthlyOrders
From Sales.Orders
Group by DATENAME(month, OrderDate)

select * from Sales.MonthlyOrders

--temp tables:

select 
*
into #orderscopy
From Sales.Orders

select * From #orderscopy


--v32: just comparsion of view,cte,temp,subquery,ctas