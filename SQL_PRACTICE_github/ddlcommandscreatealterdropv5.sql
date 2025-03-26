create table persons (
id int not null, persons_name varchar(50) not null,
birth_date date, phone varchar(15) not null, 
constraint pk_persons primary key(id)
);

select * from persons;

alter table persons add email varchar(50) not null;

alter table persons drop column phone;

drop table persons;