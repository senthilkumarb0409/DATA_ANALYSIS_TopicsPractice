-- indexes:

--structure indexes: 1. clustered 2. non clustered

--create a dummy table to practice clust index

select 
* 
into Sales.DBCustomers
From Sales.Customers	

select * from Sales.DBCustomers

create clustered index idx_DBCustomers_CustomerID on Sales.DBCustomers(CustomerID)

DROP INDEX idx_DBCustomers_CustomerID ON Sales.DBCustomers;
DROP INDEX idx_DBCustomers_FirstName ON Sales.DBCustomers;


create nonclustered index idx_DBCustomers_LastName on Sales.DBCustomers(LastName)

select * from Sales.DBCustomers where LastName = 'Brown'


create index idx_DBCustomers_FirstName on Sales.DBCustomers(FirstName)

select * from Sales.DBCustomers where FirstName = 'Anna'

-- storage indexes: columnstore index and rowstore index (basic clustered and non clustered indexex are example)

--column store index : clustered column store and Non clustered Column Store

DROP INDEX idx_DBCustomers_CustomerID ON Sales.DBCustomers;

create clustered columnstore index idx_DBCustomers_CluColStoCustomers on Sales.DBCustomers

select * from Sales.DBCustomers 

DROP INDEX idx_DBCustomers_CluColStoCustomers ON Sales.DBCustomers;

DROP INDEX idx_DBCustomers_FirstName ON Sales.DBCustomers;

create nonclustered columnstore index idx_DBCustomers_CluColStoFirstName on Sales.DBCustomers(FirstName)

--function indexes: unique indexes and Filtered indexes

-- unique indexes

select 
*
From Sales.Products

create unique nonclustered index idx_Products_UNCI on Sales.Products(ProductID)


--index maintenance:

--list all indexes on a specific table

sp_helpindex 'Sales.Customers'
sp_helpindex 'Sales.DBCustomers'

-- Monitor index usage

select 
tbl.name as TableName,
idx.object_id,
idx.name as IndexName,
idx.type_desc as IndexType,
idx.is_primary_key as IsPrimaryKey,
idx.is_unique as IsUnique,
idx.is_disabled as IsDisabled,
s.user_seeks as userseeks,
s.user_scans as userscan ,
s.user_lookups as userlookups,
s.last_user_update as userupdates,
coalesce(s.last_user_seek,s.last_user_scan) LastUpdate
from sys.indexes idx
join sys.tables tbl
on idx.object_id = tbl.object_id
left join sys.dm_db_index_usage_stats s
on s.object_id = idx.object_id
and
s.index_id = idx.index_id
Order by tbl.name, idx.name


select * From sys.dm_db_index_usage_stats