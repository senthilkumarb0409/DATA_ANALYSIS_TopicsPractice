--null vs empty string vs blankspace

with Orders As(
select 1 Id, 'A' Category union
select 2, null union
select 3, '' union
select 4, ' '
)
select *,DATALENGTH(Category) lengthofCategory from Orders


-- data policy: 
-- set of rules that defines how data should be handled.

/*
-> only use nulls and empty strings, avoid blank spaces (use trim() function)

->only use nulls and avoid other two

-> use a default value like 'unknown' or 'n/a' .avoid the above three


--> replacing empty strings and blanks with null during data preparation
    before inserting into the database to optimize storage and performance

--> replacing empty strings and null and blanks with default value during data preparation
    before using it in reporting to improve readability and reduce confusion.



*/