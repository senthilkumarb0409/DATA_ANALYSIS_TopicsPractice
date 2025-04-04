--dateandtimefunction : calulation & validation
/*
calculation: 1.dateadd(part, interval, date),   - ( 1.add days,mons,years to date
                                                  2.subtract days,mons,years to date)
             2.datediff(part,startdate,enddate) - find difference between two dates
validation : isdate(value)                      -  checks values is a date
*/

select OrderID, OrderDate ,
dateadd(day, 5, OrderDate) dadaya,
dateadd(month, 5, OrderDate) damona,
dateadd(year, 5, OrderDate) dayeara,
dateadd(day, -5, OrderDate) dadays,
dateadd(month, -5, OrderDate) damons,
dateadd(year, -5, OrderDate) dayears
from Sales.Orders
---------------------------------------------------------
select * from Sales.Orders
---------------------------------------------------------

select OrderID, OrderDate, ShipDate ,
datediff(year, OrderDate, ShipDate) shippedinyears,
datediff(month, OrderDate, ShipDate) shippedinmonths,
datediff(day, OrderDate, ShipDate) shippedindays
from Sales.Orders

--calculate age of employees

select * from Sales.Employees

select EmployeeID, BirthDate , concat(FirstName, LastName) FullName,
datediff(year, BirthDate, getdate()) Age
from Sales.Employees

--find average shipping duration in days for each month

select 
month(OrderDate) as OrderMonth, 
avg(datediff(day, OrderDate, ShipDate)) avgshippingduration
from Sales.Orders
group by month(OrderDate)

--timegap analysis
--numberof days between each order and previous order

select
orderId,
OrderDate as CurrentOrderDate,
lag(OrderDate) over (Order by OrderDate) PreviousOrderDate,
datediff(day,lag(OrderDate) over (Order by OrderDate),OrderDate) noofdays
from Sales.Orders

---------------------------------------------------------------------

select 
isdate('123') datecheck0,
isdate('2025-04-04') datecheck1,
isdate('20-04-2025') datecheck2,
isdate('2025') datecheck3


select 
OrderDate,
isdate(OrderDate),
case when isdate(OrderDate) = 1 then cast(OrderDate as date)
 else '9999-12-31'
end neworderdate 
from
(
 select '2025-08-20' as OrderDate union
 select '2025-08-21' union
 select '2025-08-24' union
 select '2025-08'
)t
