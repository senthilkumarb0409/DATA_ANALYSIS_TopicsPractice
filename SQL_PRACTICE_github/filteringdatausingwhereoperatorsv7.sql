--filtering data v7
--comparison operator

select * from customers;

-- = operator

select * from customers where country = 'Germany';

-- <> or != operator

select * from customers where country <> 'Germany';

-- > operator

select * from customers where score > 500;

-- >= operator

select * from customers where score >= 500;

-- < operator

select * from customers where score < 500;

-- <= operator

select * from customers where score <= 500;

--logical operator

-- and operator - all conditions must be true

select * from customers where country = 'USA' AND score > 500;

--or operator - any one of condition must be true

select * from customers where country = 'USA' OR score > 500;

--not operator - (reverse) exclude matching values

select * from customers where NOT country = 'USA';

select * from customers where NOT score < 500;

-- range operators

--between operator

select * from customers where score between 100 and 500;

--membership operators

--in operator

select * from customers where country in ('Germany', 'USA');


--search operators

--like operator - specific pattern '%' anything '_' exact 1

select * from customers;

select * from customers where first_name like 'M%';

select * from customers where first_name like '%N';

select * from customers where first_name like '%R%';

select * from customers where first_name like '__R%';


