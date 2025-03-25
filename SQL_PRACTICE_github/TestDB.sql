create table customer (custid int primary key, customer_name varchar(35), cust_age int, itembought varchar(30));

insert into customer values (1001, 'salim', 23, 'notebook', 5);
insert into customer values (1002, 'kathir', 13, 'pen', 6);
insert into customer values (1003, 'guru', 8, 'pencil', 10);
insert into customer values (1004, 'thiru', 15, 'cello tape', 25);
insert into customer values (1005, 'sundhar', 22, 'fountainpen', 35);

select * from customer;

alter table customer add (pieces int);

delete from customer where pieces is null;

update customer set pieces = 15 where pieces = 5;

select * from customer;

update customer set pieces = 16 where custid = 1002;

alter table customer rename column pieces to no_of_items;

select * from customer;

commit;

select custid , customer_name, no_of_items from customer where no_of_items >= 15;

insert into customer values(1006,'john doe', 30, 'notebook', 3);
insert into customer values(1007,'jane smith', 25, 'pen', 5);
insert into customer values(1008,'mike', 45, 'paper clips', 10);
insert into customer values(1009,'sam',  22, 'stapler', 3);
insert into customer values(1010,'tony', 40, 'paper clips ', 50);

select * from customer;



create table customer_details (custid int not null, customer_name varchar(35), phone_number int unique, emailid varchar(50), address varchar(50), foreign key (custid) references customer(custid));

insert into customer_details values(1001,'salim', 9876543210, 'salim34@gmail.com', '12, MG Road,Bangalore' );
insert into customer_details values(1002,'kathir', 9876543211, 'kathir312@gmail.com', '42, Main St,Delhi' );
insert into customer_details values(1003,'guru', 9876543212, 'guru38@gmail.com', '56, Shivaji Nagar,Pune' );
insert into customer_details values(1004,'thiru', 9876543213, 'thiru12@gmail.com', '78, Indira Nagar,Chennai' );
insert into customer_details values(1005,'sundhar', 9876543214, 'sundhar0303@gmail.com', '23, New Colony, Mumbai' );
insert into customer_details values(1006,'john doe', 9876543216, 'john.doe@gmail.com', '43, MG Road,Bangalore' );
insert into customer_details values(1007,'jane smith', 9876543217, 'smith.jane@gmail.com', '15, GR Road,Hyderabad' );
insert into customer_details values(1008,'mike', 9876653210, 'mike67@gmail.com', '67,Sarita Vihar, Lucknow' );
insert into customer_details values(1009,'sam', 9876893210, 'sam04@gmail.com', '89,Sector 15,Noida' );
insert into customer_details values(1010,'tony', 9876598210, 'tony.stark05@gmail.com', '101,Patel Nagar,Jaipur' );

select * from customer;
select * from customer_details;

drop table customer;
drop table customer_details;

commit;

select count(*) from customer;
select count(*) from customer_details;

select sum(no_of_items) as total_items_bought from customer;

select min(no_of_items) as min_items_bought from customer;

select max(no_of_items) as max_items_bought from customer;

select avg(no_of_items) as avg_items_bought from customer;

select customer_name,sum(no_of_items),itembought from customer group by customer_name,itembought;

select itembought, sum(no_of_items)as totalsalesbyproduct from customer group by itembought;

select itembought, sum(no_of_items)as totalsalesbyproduct from customer group by itembought having sum(no_of_items) > 0 order by totalsalesbyproduct ASC;

select * from customer;
select * from customer_details;

create table product_details (pid int primary key, itembought varchar(35) unique);

insert into product_details values (1, 'notebook');
insert into product_details values (2, 'pen');
insert into product_details values (3, 'pencil');
insert into product_details values (4, 'fountainpen');
insert into product_details values (5, 'cello tape');
insert into product_details values (6, 'paper clips');
insert into product_details values (7, 'stapler');

select * from product_details;
select * from customer;

select customer.customer_name, customer.itembought, product_details.pid from customer inner join product_details on customer.itembought = product_details.itembought; 
select customer.customer_name, customer.itembought, product_details.pid from customer LEFT join product_details on customer.itembought = product_details.itembought;
select customer.customer_name, customer.itembought, product_details.pid from customer RIGHT join product_details on customer.itembought = product_details.itembought;
select customer.customer_name, customer.itembought, product_details.pid from customer full join product_details on customer.itembought = product_details.itembought;





