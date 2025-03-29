--SET OPERATORS

--UNION UNION ALL EXCEPT INTERSECT

--union  -> return all distinct rows from both queries 


SELECT FirstName,LastName FROM Sales.Customers
SELECT FirstName,LastName FROM Sales.Employees

--combine the data from employess and customers into one table

SELECT FirstName,LastName FROM Sales.Customers
UNION
SELECT FirstName,LastName FROM Sales.Employees

--union all - return all rows from both queries with duplicates

--combine the data from employess and customers into one table INCLUDING DUPLICATES

SELECT FirstName,LastName FROM Sales.Customers
UNION ALL
SELECT FirstName,LastName FROM Sales.Employees

--except -> return all distinct rows from first query that are not found in second query

--find employess who are not customers at the same time

SELECT FirstName,LastName FROM Sales.Employees
EXCEPT
SELECT FirstName,LastName FROM Sales.Customers

--intersect ->return common rows from both queries(i.e duplicates alone)



SELECT FirstName,LastName FROM Sales.Employees
INTERSECT
SELECT FirstName,LastName FROM Sales.Customers

--Orders data stored in separate tables(orders and OrdersArchive),
--Combine all orders data into one report with out duplicates

SELECT * FROM Sales.Orders
SELECT * FROM Sales.OrdersArchive

SELECT 
'Orders' AS SourceTable,
[OrderID],
[ProductID],
[CustomerID],
[SalesPersonID],
[OrderDate],
[ShipDate],
[OrderStatus],
[ShipAddress],
[BillAddress],
[Quantity],
[Sales],
[CreationTime]
FROM Sales.Orders
UNION
SELECT 
'OrdersArchive' AS SourceTable,
[OrderID],
[ProductID],
[CustomerID],
[SalesPersonID],
[OrderDate],
[ShipDate],
[OrderStatus],
[ShipAddress],
[BillAddress],
[Quantity],
[Sales],
[CreationTime]
FROM Sales.OrdersArchive
ORDER BY OrderID