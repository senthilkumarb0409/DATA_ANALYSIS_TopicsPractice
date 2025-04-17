--sql window functions basics: 
--partition by, order by , frame

--windows function : perform calculation(eg.calculation) on a 
--specific subset of data, without losing the level of detaails of rows

-- why we need window functions?

-- find the total sales across all orders

select sum(Sales) totalsales from Sales.Orders

-- find the total sales across all orders for each product

select ProductID, sum(Sales) totalsales from Sales.Orders
group by ProductID

--advanced: find the total sales for each product
--           provide orderid, orderdate

select 
OrderID,OrderDate,ProductID,
sum(Sales) over(Partition by productID) TotalSalesbyProd
from Sales.Orders

--syntax: windowfunction + over clause(partition+ order+ frame)

--find total sales for all orders and total sales for each product,
--also provide orderid ,order date

select 
OrderID,OrderDate,ProductID,OrderStatus,
sum(Sales) over() TotalSales,
sum(Sales) over(Partition by productID) TotalSalesbyProd,
sum(sales) over (partition by productID, OrderStatus) totalsalesbypando
from Sales.Orders

-- rank each order based on their sales from highest to lowest,
--additionally provide details such orderid & orderdate

select
OrderID,
OrderDate,
Sales,
rank() over(order by Sales desc) ranksales
from Sales.Orders

--using frames

select
OrderID,
OrderDate,
OrderStatus,
Sales,
sum(Sales) over (partition by OrderStatus Order by OrderDate
rows between current row and 1 following) totalsales
from Sales.Orders

--rank customers based on their total sales

select
CustomerID,
Sum(Sales) totalsales,
Rank() over(Order by Sum(Sales) desc ) rankofcusonsales
from Sales.Orders
group by CustomerID