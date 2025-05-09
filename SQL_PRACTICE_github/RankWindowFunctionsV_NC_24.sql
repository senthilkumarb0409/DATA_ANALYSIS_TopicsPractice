--Ranking Window Functions
/*
          -------------|  
1.Row_number           |-- Top/Bottom N analysis
2.Rank                 |
3.Dense_rank           |-- uses Discrete values
4.Ntile                |
          -------------|
		  -------------|
5.cume_dist            |-- Distribution Analysis
6.percent_rank         |-- uses Continous values
          -------------|
*/


-- 1. Row_Number - assigns a unique number to each row in a window
--               - it doesnt handle ties

Select
OrderID,
ProductID,
Sales,
ROW_NUMBER() OVER(ORDER BY Sales DESC) SalesRank_Rownumber
From Sales.Orders

	Select *
	From (Select
		OrderID,
		ProductID,
		Sales,
		ROW_NUMBER() OVER(PARTITION BY ProductID ORDER BY Sales DESC) RankByProduct
		From Sales.Orders)t where RankByProduct = 1

Select * From (Select 
CustomerID,Sum(Sales) TotalSales,
ROW_NUMBER() over (order by Sum(Sales)) RankCustomers
From Sales.Orders
Group by CustomerID)t where RankCustomers <=2

Select * From
(Select 
Row_Number() Over (Partition by OrderID Order by CreationTime DESC) rn,
* FROM Sales.OrdersArchive)t where rn=1

-- 2. Rank - assigns a rank to each row in a window , with gaps
--         - it handles ties

Select
OrderID,
ProductID,
Sales,
RANK() OVER(ORDER BY Sales DESC) SalesRank_Rank
From Sales.Orders

-- 3. Dense_Rank - assigns a rank to each row in a window, without gaps
--               - it handles ties

Select
OrderID,
ProductID,
Sales,
DENSE_RANK() OVER(ORDER BY Sales DESC) SalesRank_DenseRank
From Sales.Orders

-- 4. Cume_Dist - calculates the cumulative distribution of a value within a set of values
-- 5. Percent_Rank - returns the percentile ranking number of a row.
-- 6. Ntile(n) - Dividesthe rows into a specified number of approximately equal gaps

Select OrderID,
Sales,
Ntile(2) Over (Order By Sales DESC) TwoBucket
From Sales.Orders



