--Aggregate window Functions:
--count,sum,min,max,avg

--syntax: AVG(_____) OVER(PARTITION BY __________  ORDERBY ________ FRAME_______)

--count

--return the number of rows in each window

-- find the total number of orders

Select count(*) TotalOrders From Sales.Orders

-- find the total number of orders
--additionally provide details of Orderid and order date

Select OrderID,OrderDate, Count(*) Over() TotalOrders From Sales.Orders

-- find the total number of orders
--find total number of orders for each customers
--additionally provide details of Orderid and order date

Select 
OrderID,
OrderDate, 
CustomerID,
Count(*) Over() TotalOrders,
Count(*) Over(Partition By CustomerID ) OrdersByCustomers
From Sales.Orders

--Find the total number of Customers
--Also Provide all customer details

Select  
*,
Count(*) over () TotalCustomers
From Sales.Customers

--Find the total number of Customers,scores
--Also Provide all customer details



Select  
*,
Count(*) over () TotalCustomers,
Count(Score) over() TotalScores
From Sales.Customers

--check whether the table 'orders' contains any duplicates rows

Select 
OrderId,
Count(*) over(partition by OrderId) Checkpk
From Sales.Orders

----------------------------------------------------------------
Select * 
From (
	Select 
	OrderId,
	Count(*) over(partition by OrderId) Checkpk
	From Sales.OrdersArchive
)t where Checkpk > 1

--use case aggregate window func: count 
--overall analysis,category analysis, qualitycheck:identify NULLS, qualitycheck: identify Duplicates

-----------------------------------------------------------------------------------------------------------------

--sum

--return the sum of all values with in the a window

/* 
1.find total sales across all orders
  and total sales for each product
  also detials such as order id , order date
*/


select 
OrderID,
OrderDate,
ProductID,
Sales,
sum(Sales) over() Totalsales,
sum(Sales) over(partition by ProductId) TotalsalesbyProd
From Sales.Orders

-- 2. find the percentage contribution of each product sales to total sales

select 
OrderID,
ProductID,
Sales,
sum(Sales) over() Totalsales,
round(cast (Sales as float) / sum(sales) over() * 100,2) Perct_Contri
From Sales.Orders

--average: avg

-- returns average value within a window

--find the average sales across all orders
--find the average sales for each product
--additionally provide details such as orderid, orderdate

Select
OrderID,
OrderDate,
ProductID,
Sales,
Avg(Sales) over () AvgSales,
Avg(Sales) over (Partition by ProductId) Avgbyprod
From Sales.Orders

--Find the average scores of customers
--Additionally provide details such as CustomerID, LastName

Select 
CustomerID,
FirstName,
LastName,
Score,
Avg(coalesce(Score,0)) over () avgScore
From Sales.Customers

-- find all orders where sales are higher than the average sales across all orders
Select *
From(
Select 
OrderID,
CustomerID,
ProductID,
Sales,
Avg(Sales) over () AvgSales
From Sales.Orders
)t Where Sales > AvgSales

--min & max

--min: return the lowest value within a window
--max: returns the highest value within a window

-- 1. find the highest and lowest sales of all orders
--    find the highest and lowest sales for each product
-- additionally provide details orderid, orderdate

Select 
OrderID,
ProductID,
OrderDate,
Sales,
min(Sales) over() minsales,
max(Sales) over() maxsales,
min(Sales) over(Partition by ProductID) minsalesbyprod,
max(Sales) over(Partition by ProductID) maxsalesbyprod
From Sales.Orders

-- select the employees who have the highest salries

Select
*
From(
Select 
*,
Max(Salary) over () highestSal
From Sales.Employees
)t where Salary = highestSal

--running total 
-- Aggregate all values from the begginnig up to the current point
-- without dropping off older data.

--rolling total 
-- Aggreggate all valueswithin a fixed time window(e.g 30 days).
-- as new data is added , the oldest data point will be dropped.

--calculate moving average of sales for each product over time

Select
OrderID,
ProductID,
OrderDate,
Sales,
avg(Sales) over(partition by ProductID) AvgbyProd,
avg(Sales) over(partition by ProductID Order by OrderDate) movAvgbyProd
From Sales.Orders

--calculate moving average of sales for each product over time,including only the next order


Select
OrderID,
ProductID,
OrderDate,
Sales,
avg(Sales) over(partition by ProductID) AvgbyProd,
avg(Sales) over(partition by ProductID Order by OrderDate Rows between current row and 1 following) movAvgcandnProd
From Sales.Orders
