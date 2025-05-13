--Window Analytical Functions

-- Lead -  Returns the value from a next row
-- Lag  -  Returns the value from previous row
-- First_Value - Returns the First value in window
-- Last_Value  - Returns the Last Value in a window


-- with min and max functions

--time series analysis :->
-- the process of analyzing the data to undersstand patterns, trends,
-- and behaviours

-- Analyse the month over month performance by finding the percentage change
-- in sales betweeen the current and previous months



Select
*,
CurrentMonthSales - PreviousMonthSales As MoM_Change,
Round(Cast((CurrentMonthSales - PreviousMonthSales) As Float)/PreviousMonthSales * 100, 1) As MoM_perc
From(
Select 
   Month(OrderDate) OrderMonth,
   Sum(Sales) CurrentMonthSales,
   Lag(Sum(Sales)) Over (Order By Month(OrderDate)) PreviousMonthSales
From Sales.Orders
Group By
     Month(OrderDate)
)t

--Inorder to analyse customer loyalty,
-- rank customers based on the average days between their orders

Select
CustomerID,
AVG(DaysUntilnxtorder) AvgDays,
Rank() Over (Order By Coalesce(Avg(DaysUntilnxtorder),99999)) RankAvg
From
(	Select 
		OrderID,
		CustomerID,
		OrderDate CurrentOrder,
		Lead(OrderDate) Over (Partition by CustomerID Order by OrderDate) NextOrder,
		DATEDIFF(day, OrderDate, Lead(OrderDate) Over (Partition by CustomerID Order by OrderDate)) DaysUntilnxtorder
	From Sales.Orders
)t
Group by CustomerID