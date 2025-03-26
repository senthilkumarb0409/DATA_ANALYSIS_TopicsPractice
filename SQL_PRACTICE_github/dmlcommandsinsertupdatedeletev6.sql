select * from customers;

insert into customers values(6,'Bob', 'UK', 450 );

insert into customers values(7, 'Anna', 'Italy', 980),
                             (8,'kia','USA',250);
--insert using select

--target - persons , source - customers

create table persons (
     id int not null, person_name varchar(50) not null,
	 birth_date date, phone varchar(50) not null
);

select * from customers;

select * from persons;

insert into persons (id, person_name, birth_date, phone)
select id, first_name,null, 'unknown' from customers

--update

select * from customers;

update customers set score = 400 where id = 5;

update customers set country = 'UK' where id = 7;

select * from persons;

update persons set phone = 0000000000 where phone = 'unknown';

-- delete 

delete from customers where id > 6;

select * from customers;

