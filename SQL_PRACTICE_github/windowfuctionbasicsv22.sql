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

