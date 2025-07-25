-- Partitioning concept:

-- step 1:create a partition function:

Create Partition Function Partitionbyyear (DATE)
as range left for values ('2023-12-31', '2024-12-31', '2025-12-31')

-- query to list all partitions created in the database

select name,function_id,type,type_desc,boundary_value_on_right from sys.partition_functions

-- step 2:create file groups

Alter Database SalesDB Add Filegroup FG_2023;
Alter Database SalesDB Add Filegroup FG_2024;
Alter Database SalesDB Add Filegroup FG_2025;
Alter Database SalesDB Add Filegroup FG_2026;

-- query to list all file gruops created

select * from sys.filegroups
where type = 'FG'

-- step 3: create data files

Alter Database SalesDB Add File
(
   NAME = P_2023, -- logical name
   FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\P_2023.ndf'
) To filegroup FG_2023;

Alter Database SalesDB Add File
(
   NAME = P_2024, -- logical name
   FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\P_2024.ndf'
) To filegroup FG_2024;

Alter Database SalesDB Add File
(
   NAME = P_2025, -- logical name
   FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\P_2025.ndf'
) To filegroup FG_2025;

Alter Database SalesDB Add File
(
   NAME = P_2026, -- logical name
   FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\P_2026.ndf'
) To filegroup FG_2026;

--query all data files create:

SELECT
	fg.name AS FilegroupName,
	mf.name AS LogicalFileName,
	mf.physical_name AS PhysicalFilePath,
	mf.size/128 AS SizeInMB
FROM
	sys.filegroups fg
JOIN
	sys.master_files mf ON fg.data_space_id = mf.data_space_id
WHERE
	mf.database_id = DB_ID('SaleDB');

-- create partition scheme

create partition scheme SchemePartitionByYear
As Partition Partitionbyyear
To (FG_2023, FG_2024, FG_2025, FG_2026)

--query lists all partition Scheme

Select
ps.name as Partitionschemename,
pf.name as PartitionFunctionname,
ds.destination_id as Partitionnumber,
fg.name as filegroupname
From sys.partition_schemes ps
join sys.partition_functions pf on ps.function_id = pf.function_id
join sys.destination_data_spaces ds on ps.data_space_id = ds.data_space_id
join sys.filegroups fg on ds.data_space_id = fg.data_space_id

--step 5:

--create partitioned table



create table Sales.Orders_Partitoned
(
   OrderID INT,
   OrderDate DATE,
   Sales INT
) on SchemePartitionByYear (OrderDate)

-- insert data into partitioned table

insert into Sales.Orders_Partitoned values(1,'2023-05-15', 100);
INSERT INTO Sales.Orders_Partitoned VALUES (2, '2023-03-15', 200);
INSERT INTO Sales.Orders_Partitoned VALUES (3, '2023-06-20', 150);
INSERT INTO Sales.Orders_Partitoned VALUES (4, '2023-09-05', 180);
INSERT INTO Sales.Orders_Partitoned VALUES (5, '2023-12-25', 220);
INSERT INTO Sales.Orders_Partitoned VALUES (6, '2024-02-14', 120);
INSERT INTO Sales.Orders_Partitoned VALUES (7, '2024-04-18', 210);
INSERT INTO Sales.Orders_Partitoned VALUES (8, '2024-07-01', 160);
INSERT INTO Sales.Orders_Partitoned VALUES (9, '2024-10-12', 190);
INSERT INTO Sales.Orders_Partitoned VALUES (10, '2024-11-30', 230);
INSERT INTO Sales.Orders_Partitoned VALUES (11, '2025-01-05', 130);
INSERT INTO Sales.Orders_Partitoned VALUES (12, '2025-03-22', 220);
INSERT INTO Sales.Orders_Partitoned VALUES (13, '2025-06-10', 170);
INSERT INTO Sales.Orders_Partitoned VALUES (14, '2025-08-19', 200);
INSERT INTO Sales.Orders_Partitoned VALUES (15, '2025-12-10', 240);
INSERT INTO Sales.Orders_Partitoned VALUES (16, '2026-02-02', 140);
INSERT INTO Sales.Orders_Partitoned VALUES (17, '2026-05-14', 230);
INSERT INTO Sales.Orders_Partitoned VALUES (18, '2026-07-25', 180);
INSERT INTO Sales.Orders_Partitoned VALUES (19, '2026-10-08', 210);
INSERT INTO Sales.Orders_Partitoned VALUES (20, '2026-12-31', 250);

SELECT 
    p.partition_number AS PartitionNumber,
    f.name AS PartitionFilegroup,
    p.rows AS NumberOfRows
FROM sys.partitions p
JOIN sys.destination_data_spaces dds 
    ON p.partition_number = dds.destination_id
JOIN sys.filegroups f 
    ON dds.data_space_id = f.data_space_id
WHERE OBJECT_NAME(p.object_id) = 'Orders_Partitoned';

--create a duplicate table with partioneded table values to cross check the performance
select *
into  Sales.OrdersNoPartioned
From Sales.Orders_Partitoned


----------------------------------------------------------------------------------------------------------------------------------------------------
--partitioned tables:

Select * From Sales.Orders_Partitoned where OrderDate = '2025-03-22';





---------------------------------------------------------------------------------------------------------------------------------------------------
--Not Partitioned Table:

Select * From Sales.OrdersNoPartioned where OrderDate = '2025-03-22';


----------------------------------------------------------------------------------------------------------------------------------------------------

-- Stored Procedures:

--step1: write query

--*for usa customers find the total number of customers and the average score

Select 
	COUNT(*) TotalCustomers,
	AVG(Score) AvgScore
From Sales.Customers
where Country = 'USA';

--step 2 : Turning the query into a stored procedure

create procedure GetCustomerSummary As
begin
	Select 
		COUNT(*) TotalCustomers,
		AVG(Score) AvgScore
	From Sales.Customers
	where Country = 'USA';
end

--step3 execute stored procedure:

exec GetCustomerSummary

----------------------------------------------------------------

--parameters in stored procedure

-- for german customers find the total number of customers and the average score


ALTER PROCEDURE GetCustomerSummary2 @Country NVARCHAR(50) = 'USA'
AS
BEGIN

Declare @TotalCustomers INT , @AvgScore Float;
-- Prepare & Cleanup Data
IF EXISTS (SELECT 1 FROM Sales.Customers WHERE Score IS NULL AND Country = @Country)
BEGIN
    PRINT('Updating NULL Scores to 0')
    UPDATE Sales.Customers
	SET Score = 0
	WHERE Score IS NULL AND Country = @Country
END
ELSE
BEGIN
	PRINT 'No NULL Scores found'
END;


--Generating Reports
	Select 
		@TotalCustomers = COUNT(*),
		@AvgScore = AVG(Score) 
	From Sales.Customers
	where Country = @Country 

PRINT 'Total Customers From '+ @Country+':' + CAST(@TotalCustomers AS NVARCHAR);
PRINT 'Average Score From ' + @Country +':' + CAST(@AvgScore AS NVARCHAR);

--find the total no of orders and total sales
		SELECT 
			COUNT(OrderID) TotalOrders,
			SUM(Sales) TotalSales
		FROM Sales.Orders o
		join Sales.Customers c
		on o.CustomerID = c.CustomerID
		where c.Country = @Country
END

exec GetCustomerSummary2 @Country = 'Germany'
exec GetCustomerSummary2 --default 'USA'

/*
--find the total no of orders and total sales

SELECT 
COUNT(OrderID) TotalOrders,
SUM(Sales) TotalSales
FROM Sales.Orders o
join Sales.Customers c
on o.CustomerID = c.CustomerID
where c.Country = 'USA'
*/
--------------------------------------------------------------------------------------
--triggers

-- 1. create log table

Create Table Sales.EmployeesLogs (
	LogID INT IDENTITY(1,1) PRIMARY KEY,
	EmployeeID INT,
	LogMessage VARCHAR(255),
	LogDate DATE
)

--2 . create trigger

Create Trigger trg_AfterInsertEmployee ON Sales.Employees
After Insert
As
Begin
	Insert into Sales.EmployeesLogs (EmployeeID, LogMessage, LogDate)
	Select
		EmployeeID,
		'New Employee Added =' + CAST(EmployeeID AS VARCHAR),
		GETDATE()
	From INSERTED
End

--3. insert the values to the employees table

Select * From Sales.EmployeesLogs
Select * From Sales.Employees

insert into Sales.Employees 
values
(6, 'Senthil', 'Kumar', 'DataAnalyst', '2002-09-04','M',80000,4)