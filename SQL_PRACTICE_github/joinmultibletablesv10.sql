--multi join table

--from salesDB ,Retrieve a list of all orders, along with the relatedcustomer,
--product,and employee details, for each order display Order id,
--Customer name,Product name, Sales, Price,SalesPerson's name

select 
o.OrderID, 
c.FirstName as Customer_Firstname,
c.LastName as Customer_Lastname,
p.Product as Productname,
o.Sales ,
p.Price,
e.FirstName as SalesPerson_Firstname,
e.LastName as SalesPerson_Lastname

from Sales.Orders as o
left join Sales.Customers as c
on o.CustomerID = c.CustomerID
left join Sales.Products as p
on o.ProductID = p.ProductID
left join Sales.Employees as e
on o.SalesPersonID = e.EmployeeID