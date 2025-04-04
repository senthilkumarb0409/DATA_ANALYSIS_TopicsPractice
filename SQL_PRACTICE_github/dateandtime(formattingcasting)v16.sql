--date and time function : format & casting
/* 1. FORMAT 2.CONVERT 3.CAST*/

--format(value,format [,culture])

select OrderID, CreationTime , 
format(CreationTime,'dd-MM-yyyy') eus,
format(CreationTime,'MM-dd-yyyy') uss,
format(CreationTime,'yyyy-MM-dd') ins,
format(CreationTime, 'dd') dd,
format(CreationTime, 'ddd') ddd,
format(CreationTime, 'dddd') dddd,
format(CreationTime, 'MM') MM,
format(CreationTime, 'MMM') MMM,
format(CreationTime, 'MMMM') MMMM
from Sales.Orders

/*
show creation time in particular format
Day wed jan Q1 2025 12:34:56 PM
*/

select OrderID, CreationTime,
'DAY '+format(CreationTime,'ddd MMM') + 
' Q'+DATENAME(QUARTER,CreationTime) +
format(CreationTime, ' yyyy hh:mm:ss tt') Customformat
from Sales.Orders

--usecase:
--aggregation
select format(OrderDate, 'MMM yy') OrderDate,
Count(*) SalesCount
from Sales.Orders GROUP BY format(OrderDate, 'MMM yy')

--standardization

/*
convert(data_type, value [,style])
*/

select 
--convert(int, '123') as stringtoint,
--convert(date, '2025-08-20') as stringtodate,
convert(date, CreationTime ) as datetimetodate,
convert(varchar, CreationTime, 32) as usastdwithsty32,
convert(varchar, CreationTime, 34) as eurostdwithsty34
from Sales.Orders

/*
cast(value As data_type)
*/

select 
cast ('123' as int) stringtoint,
cast (CreationTime as date) datetimetodate
from Sales.Orders


/*
                casting          |     formating
				 
cast    : any type to any type   |  not used for formating
                                 |
convert : any type to any type   |  formating only date&time
                                 |
format  : any type to only str   |  formats both date&time & 
                                 |         numbers



*/








