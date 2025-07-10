--Common Table Expressions (CTE)


/*
--Non Recursive CTE

--Step 1: Find the total  sales per customers(Standalone cte)

with CTE_Total_Sales AS
(
Select CustomerID,
Sum(Sales) Totalsales
From Sales.Orders 
group by CustomerID
)
--Step 2: Find last Order Date For Each Customer (Multiple CTE)
, CTE_Last_Order AS
(
    Select 
	CustomerID,
	max(OrderDate) Last_Order
	From
	Sales.Orders
	Group by CustomerID

)
-- Step 3: Rank the customers based on total sales per customers
,CTE_Cust_Rank As
(
  select CustomerID,
  Totalsales ,
  Rank() over(order by TotalSales desc) CustRank
  From CTE_Total_Sales
)
-- Step 4 : Segent the customers based total sales
,CTE_Seg_Cust AS
(
select 
CustomerID,
Case when Totalsales > 100 then 'High'
     when Totalsales > 80 then 'Medium'
	 Else 'Low'
End CustSeg
From CTE_Total_Sales
)

--Main Query
Select 
C.CustomerID,
C.FirstName,
C.LastName,
TS.Totalsales,
LS.Last_Order,
CR.CustRank,
CS.CustSeg
From Sales.Customers C
Left join CTE_Total_Sales TS
on TS.CustomerID = C.CustomerID 
left join CTE_Last_Order LS
on LS.CustomerID = C.CustomerID
left join CTE_Cust_Rank CR
on CR.CustomerID = C.CustomerID
left join CTE_Seg_Cust CS
on CS.CustomerID = C.CustomerID
where TS.Totalsales is not null
order by CustRank 


-- Recursive CTE

-- Generate a sequence of number from 1 to 20


with series as
(
  --anchor query
  select
  1 as mynumber 
  union all
  -- recursivequery
  select
  mynumber +1
  from series 
  where mynumber < 20
)

--mainquery

select 
*
From 
series

*/

-- Show the employee hierarchy by displaying each employee's level with in the organization

With CTE_Hierarchy As
(
--Anchorquery
select 
EmployeeID,
FirstName,
ManagerID,
1 as Level
from Sales.Employees where ManagerID is null

union all
-- recursive query
select 
 e.EmployeeID,
 e.FirstName,
 e.ManagerID,
 Level + 1
from Sales.Employees as e 
inner join CTE_Hierarchy as ceh
on e.ManagerID = ceh.EmployeeID

)

--mainquery

select * 
From CTE_Hierarchy