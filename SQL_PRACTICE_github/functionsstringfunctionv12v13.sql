--function

/*
   1.Single Row Function          |     2.Multi Row Function
                                  |
   *String Function               |     *Aggregate Function
   *Numeric Function              |     *Window Function
   *Date&Time Function            |
   *Null Function                 |


   STRING FUNCTION

   MANIPULATION: CONCAT,UPPER,LOWER,TRIM,REPLACE
   CALCULATION : LEN
   EXTRACTION  : LEFT,RIGHT,SUBSTRING

*/

--CONCAT - combines multiple strings into one

--Show list of customers first name together with thier country in one column

select first_name,country from customers

select concat(first_name,' ',country) as name_country from customers

--UPPER - convert all characters to uppercase
--LOWER - convert all characters to lowercase

select lower(first_name) as low_name from customers

select upper(first_name) as up_name  from customers

--TRIM - remove leading and trailing spaces 

select trim(upper(first_name)) as tm_name from customers

select first_name from customers 
where first_name != trim(first_name)

--REPLACE -> change character with new character

select '123-456-7890' as phone,
replace('123-456-7890','-','') as clean_phone

--LEN -> counts how many characters

select first_name, len(first_name) as name_len from customers

--LEFT   -> extracts specific number of characters from start
--RIGHT  -> extracts specific number of characters from end

select * from customers

select first_name,
left(trim(first_name), 2) first_2_char,
right(trim(first_name), len(trim(first_name))-len(left(trim(first_name), 2))) remain_char
from customers

--SUBSTRING

select first_name,
substring(trim(first_name),3,len(trim(first_name))) as sub_string
from customers





