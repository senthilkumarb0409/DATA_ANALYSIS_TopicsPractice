-- Topics:
-- 1. Subquery
-- 2.CTE
-- 3.View
-- 4. TMP
-- 5. CTAS - create table as select

/*
Data Warehouse - A special Database that collects and integrates data
from different sources to enable analytics and support decision- making.

Database Engine - It is the brain of the database, executing multiple operations
such as storing, retrieving and managing data within the database.

Disk storage -  long term memory where data is stored permanently.
                - capacity: can hold large amount of data
				- speed: slow to read and to write.
| TEMP               | SYSTEM CATALOG      | USER                | 
|Temporary           |Databases internal   | it the main content |
|space used by       |storage foe its own  | of the database.This|
|the database        |information.Blueprint| is where the actual |
|for short-term      |that keeps track of  |data that users care |
|tasks, like         |everything about the | is stored           |
|processing que      |data itself, not the |                     |
|ies or sorting data | user data           |                     |
cache storage- Fast short term memory, where data is stored temporarily.
                - capacity: can hold small amount of data
				- speed: extremely fast to read and to write.

inforamtion schema : A system-defined schema with builtin views that
 provide info about the database, like tables and columns.

 eg for system catalog: metadata, information schema
*/