--date and time functions
/*
yyyy-mm-dd
year-month(12)-day(30 or 31) --|
                               |--| (Time   or (Date
hh(24):mm(60):ss(60) ----------|--|  Stamp)     Time2) 
18:45:55                       |


*/

select  OrderID,OrderDate,ShipDate,CreationTime
from Sales.Orders;

select  OrderID,CreationTime
from Sales.Orders;

select  OrderID,CreationTime,
'2025-03-31' Todays_date
from Sales.Orders;

--getdate() - return the current date and time 
--at the moment when the query is executed 

select  OrderID,CreationTime,
getdate() as Todays_date
from Sales.Orders;

/*part extraction |   format   | calculation | validation
                  |            |             |
    1.DAY         |   FORMAT   |   DATEADD   |  ISDATE
	2.MONTH		  |  CONVERT   |   DATEDIFF  |
	3.YEAR		  |    CAST    |             | 
	4.DATEPART	  |            |             |
	5.DATENAME    |            |             |
	6.DATETRUNC   |            |             |
	7.EOMONTH	  |            |             |
				

*/


--PART EXTRACTION

select '2025-03-31' as todays_date,
day( '2025-03-31' ) as todays_day,
month( '2025-03-31' ) as todays_month,
year( '2025-03-31' ) as todays_year

select orderID, OrderDate,
day(OrderDate) as todays_day,
month(OrderDate) as todays_month,
year(OrderDate) as todays_year from Sales.Orders

--datepart - returns specific part of date as number


select orderID, OrderDate,
datepart(DAYOFYEAR, OrderDate) as dayofyearofdate from Sales.Orders

select orderID, OrderDate,
datepart(QUARTER, OrderDate) as quarterofdate from Sales.Orders

select orderID, OrderDate,
datepart(WEEKDAY, OrderDate) as weekdayofdate from Sales.Orders


--datename

select orderID, OrderDate,
datename(DAYOFYEAR, OrderDate) as dayofyearofdate from Sales.Orders

select orderID, OrderDate,
datename(QUARTER, OrderDate) as quarterofdate from Sales.Orders

select orderID, OrderDate,
datename(MONTH, OrderDate) as monthofdate,
datename(WEEKDAY, OrderDate) as weekdayofdate from Sales.Orders

--datetrunc - truncates date to a specific part

select OrderID, OrderDate, CreationTime, 
datetrunc(MINUTE, CreationTime) as  minute_trunc,
datetrunc(month, CreationTime) as  month_trunc
from Sales.Orders

--simple example

select CreationTime,
COUNT(*) from sales.Orders 
group by CreationTime

select datetrunc(MONTH,CreationTime) as Creation_Month,
COUNT(*) from sales.Orders 
group by datetrunc(MONTH,CreationTime)

--eomonth - returns last day of month

select '2025-03-23', EOMONTH('2025-03-23')

select OrderID, OrderDate,
EOMONTH(OrderDate) as Last_dayofdate from 
Sales.Orders

--how many orders were placed each year?

select YEAR(OrderDate) as year,
count(*) Nooforders
from Sales.Orders
group by YEAR(OrderDate)

--how many orders were placed each month

select datename(Month,OrderDate) as MONTH,
count(*) No_of_orders  
from Sales.Orders
group by datename(Month,OrderDate)

--show all orders placed during the month of february

select * from Sales.orders
where Month(OrderDate) = 2



