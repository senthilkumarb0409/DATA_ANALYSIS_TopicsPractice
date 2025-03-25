CREATE TABLE Customers ( CustomerID NUMBER PRIMARY KEY,FirstName VARCHAR2(50),LastName VARCHAR2(50),Email VARCHAR2(100));

INSERT INTO Customers (CustomerID, FirstName, LastName, Email) VALUES (1, 'John', 'Doe', 'john.doe@example.com');
INSERT INTO Customers (CustomerID, FirstName, LastName, Email) VALUES (2, 'Jane', 'Smith', 'jane.smith@example.com');
INSERT INTO Customers (CustomerID, FirstName, LastName, Email) VALUES (3, 'Alice', 'Johnson', 'alice.johnson@example.com');
INSERT INTO Customers (CustomerID, FirstName, LastName, Email) VALUES (4, 'Bob', 'Brown', 'bob.brown@example.com');
INSERT INTO Customers (CustomerID, FirstName, LastName, Email) VALUES (5, 'Charlie', 'Davis', 'charlie.davis@example.com');
INSERT INTO Customers (CustomerID, FirstName, LastName, Email) VALUES (6, 'David', 'Miller', 'david.miller@example.com');
INSERT INTO Customers (CustomerID, FirstName, LastName, Email) VALUES (7, 'Eva', 'Wilson', 'eva.wilson@example.com');
INSERT INTO Customers (CustomerID, FirstName, LastName, Email) VALUES (8, 'Frank', 'Moore', 'frank.moore@example.com');
INSERT INTO Customers (CustomerID, FirstName, LastName, Email) VALUES (9, 'Grace', 'Taylor', 'grace.taylor@example.com');
INSERT INTO Customers (CustomerID, FirstName, LastName, Email) VALUES (10, 'Hannah', 'Anderson', 'hannah.anderson@example.com');

CREATE TABLE Orders (
    OrderID NUMBER PRIMARY KEY,
    CustomerID NUMBER,
    OrderDate DATE,
    TotalAmount NUMBER(10, 2),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

INSERT INTO Orders (OrderID, CustomerID, OrderDate, TotalAmount) VALUES (101, 1, TO_DATE('2025-01-15', 'YYYY-MM-DD'), 250.50);
INSERT INTO Orders (OrderID, CustomerID, OrderDate, TotalAmount) VALUES (102, 2, TO_DATE('2025-02-01', 'YYYY-MM-DD'), 125.00);
INSERT INTO Orders (OrderID, CustomerID, OrderDate, TotalAmount) VALUES (103, 3, TO_DATE('2025-02-10', 'YYYY-MM-DD'), 300.75);
INSERT INTO Orders (OrderID, CustomerID, OrderDate, TotalAmount) VALUES (104, 4, TO_DATE('2025-02-05', 'YYYY-MM-DD'), 175.30);
INSERT INTO Orders (OrderID, CustomerID, OrderDate, TotalAmount) VALUES (105, 5, TO_DATE('2025-02-12', 'YYYY-MM-DD'), 500.40);
INSERT INTO Orders (OrderID, CustomerID, OrderDate, TotalAmount) VALUES (106, 6, TO_DATE('2025-01-22', 'YYYY-MM-DD'), 320.60);
INSERT INTO Orders (OrderID, CustomerID, OrderDate, TotalAmount) VALUES (107, 7, TO_DATE('2025-01-29', 'YYYY-MM-DD'), 150.00);
INSERT INTO Orders (OrderID, CustomerID, OrderDate, TotalAmount) VALUES (108, 8, TO_DATE('2025-02-03', 'YYYY-MM-DD'), 450.90);
INSERT INTO Orders (OrderID, CustomerID, OrderDate, TotalAmount) VALUES (109, 9, TO_DATE('2025-02-08', 'YYYY-MM-DD'), 700.00);
INSERT INTO Orders (OrderID, CustomerID, OrderDate, TotalAmount) VALUES (110, 10, TO_DATE('2025-02-11', 'YYYY-MM-DD'), 220.75);


CREATE TABLE Products (
    ProductID NUMBER PRIMARY KEY,
    ProductName VARCHAR2(100),
    Price NUMBER(10, 2)
);

INSERT INTO Products (ProductID, ProductName, Price) VALUES (1, 'Laptop', 1000.00);
INSERT INTO Products (ProductID, ProductName, Price) VALUES (2, 'Smartphone', 500.00);
INSERT INTO Products (ProductID, ProductName, Price) VALUES (3, 'Headphones', 100.00);
INSERT INTO Products (ProductID, ProductName, Price) VALUES (4, 'Keyboard', 50.00);
INSERT INTO Products (ProductID, ProductName, Price) VALUES (5, 'Mouse', 25.00);
INSERT INTO Products (ProductID, ProductName, Price) VALUES (6, 'Monitor', 200.00);
INSERT INTO Products (ProductID, ProductName, Price) VALUES (7, 'Speaker', 75.00);
INSERT INTO Products (ProductID, ProductName, Price) VALUES (8, 'Webcam', 40.00);
INSERT INTO Products (ProductID, ProductName, Price) VALUES (9, 'Microphone', 60.00);
INSERT INTO Products (ProductID, ProductName, Price) VALUES (10, 'Charger', 15.00);


CREATE TABLE OrderDetails (
    OrderDetailID NUMBER PRIMARY KEY,
    OrderID NUMBER,
    ProductID NUMBER,
    Quantity NUMBER,
    Subtotal NUMBER(10, 2),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

INSERT INTO OrderDetails (OrderDetailID, OrderID, ProductID, Quantity, Subtotal) VALUES (1, 101, 1, 1, 1000.00);
INSERT INTO OrderDetails (OrderDetailID, OrderID, ProductID, Quantity, Subtotal) VALUES (2, 101, 3, 2, 200.00);
INSERT INTO OrderDetails (OrderDetailID, OrderID, ProductID, Quantity, Subtotal) VALUES (3, 102, 2, 1, 500.00);
INSERT INTO OrderDetails (OrderDetailID, OrderID, ProductID, Quantity, Subtotal) VALUES (4, 103, 4, 3, 150.00);
INSERT INTO OrderDetails (OrderDetailID, OrderID, ProductID, Quantity, Subtotal) VALUES (5, 104, 1, 1, 1000.00);
INSERT INTO OrderDetails (OrderDetailID, OrderID, ProductID, Quantity, Subtotal) VALUES (6, 105, 6, 2, 400.00);
INSERT INTO OrderDetails (OrderDetailID, OrderID, ProductID, Quantity, Subtotal) VALUES (7, 106, 7, 1, 75.00);
INSERT INTO OrderDetails (OrderDetailID, OrderID, ProductID, Quantity, Subtotal) VALUES (8, 107, 8, 1, 40.00);
INSERT INTO OrderDetails (OrderDetailID, OrderID, ProductID, Quantity, Subtotal) VALUES (9, 108, 9, 3, 180.00);
INSERT INTO OrderDetails (OrderDetailID, OrderID, ProductID, Quantity, Subtotal) VALUES (10, 109, 10, 2, 30.00);

SELECT * FROM Customers;
SELECT * FROM Orders;
SELECT * FROM Products;
SELECT * FROM OrderDetails;

-- inner join

-- An INNER JOIN returns only the rows that have matching values in both tables.
 
-- Example: Retrieve customer details along with their orders.

SELECT 
    Customers.FirstName, 
    Customers.LastName, 
    Orders.OrderID, 
    Orders.OrderDate, 
    Orders.TotalAmount
FROM Customers
INNER JOIN Orders ON Customers.CustomerID = Orders.CustomerID;

--leftjoin

--A LEFT JOIN returns all rows from the left table (the first one) and the matched rows from the right table. If no match is found, NULL values are returned for columns of the right table.

--Example: Retrieve all customers along with any orders they may have placed (even if they have no orders).

SELECT 
    Customers.FirstName, 
    Customers.LastName, 
    Orders.OrderID, 
    Orders.OrderDate
FROM Customers
LEFT JOIN Orders ON Customers.CustomerID = Orders.CustomerID;

--right join

-- A RIGHT JOIN returns all rows from the right table (the second one) and the matched rows from the left table. If no match is found, NULL values are returned for columns of the left table.

-- Example: Retrieve all orders along with the customer details, even if an order has no associated customer (e.g., orphaned records).

SELECT 
    Orders.OrderID, 
    Orders.OrderDate, 
    Orders.TotalAmount, 
    Customers.FirstName, 
    Customers.LastName
FROM Orders
RIGHT JOIN Customers ON Orders.CustomerID = Customers.CustomerID;

--full join

-- A FULL OUTER JOIN returns all rows when there is a match in one of the tables. It returns NULL for non-matching rows from both tables.

-- Example: Retrieve all customers and all orders, including those without a matching record in the other table.

SELECT 
    Customers.FirstName, 
    Customers.LastName, 
    Orders.OrderID, 
    Orders.OrderDate
FROM Customers
FULL OUTER JOIN Orders ON Customers.CustomerID = Orders.CustomerID;

-- inner join practice 
--1. What is the total amount spent by each customer on orders they have placed?

SELECT 
    Customers.FirstName || ' ' || Customers.LastName AS CustomerName, 
    SUM(Orders.TotalAmount) AS TotalAmountSpent
FROM Customers
INNER JOIN Orders ON Customers.CustomerID = Orders.CustomerID
GROUP BY Customers.FirstName, Customers.LastName;

-- 2.Which products were ordered by each customer?

SELECT 
    Customers.FirstName || ' ' || Customers.LastName AS CustomerName, 
    Products.ProductName
FROM Customers
INNER JOIN Orders ON Customers.CustomerID = Orders.CustomerID
INNER JOIN OrderDetails ON Orders.OrderID = OrderDetails.OrderID
INNER JOIN Products ON OrderDetails.ProductID = Products.ProductID;

-- 3. Which orders were placed on February 5th, 2025?

SELECT 
    Orders.OrderID, 
    customers.firstname || ' ' || customers.lastname as CustomerName,
    Orders.CustomerID, 
    Orders.OrderDate, 
    Orders.TotalAmount
FROM Orders
INNER JOIN Customers ON Orders.CustomerID = Customers.CustomerID
WHERE Orders.OrderDate = TO_DATE('2025-02-05', 'YYYY-MM-DD');

-- 4. What is the quantity and subtotal for each product in an order?

SELECT 
    Orders.OrderID, 
    Products.ProductName, 
    OrderDetails.Quantity, 
    OrderDetails.Subtotal
FROM OrderDetails
INNER JOIN Orders ON OrderDetails.OrderID = Orders.OrderID
INNER JOIN Products ON OrderDetails.ProductID = Products.ProductID;

--left join:
--1.Which customers have placed orders, and which customers have not?

SELECT 
    Customers.FirstName || ' ' || Customers.LastName AS CustomerName, 
    Orders.OrderID
FROM Customers
LEFT JOIN Orders ON Customers.CustomerID = Orders.CustomerID;

--2.Which orders were placed by customers, and what are the details of those orders, including any customers who might not have ordered?


SELECT 
    Orders.OrderID, 
    Orders.OrderDate, 
    Orders.TotalAmount, 
    Customers.FirstName || ' ' || Customers.LastName AS CustomerName
FROM Orders
LEFT JOIN Customers ON Orders.CustomerID = Customers.CustomerID;

--3.List all customers and the products they have ordered (even if they haven't ordered anything).

SELECT 
    Customers.FirstName || ' ' || Customers.LastName AS CustomerName, 
    Products.ProductName,
    orderdetails.quantity
FROM Customers
LEFT JOIN Orders ON Customers.CustomerID = Orders.CustomerID
LEFT JOIN OrderDetails ON Orders.OrderID = OrderDetails.OrderID
LEFT JOIN Products ON OrderDetails.ProductID = Products.ProductID;

--4.Which products have been ordered by customers, including products that have not been ordered?

SELECT 
    Products.ProductName, 
    OrderDetails.Quantity, 
    OrderDetails.Subtotal
FROM Products
LEFT JOIN OrderDetails ON Products.ProductID = OrderDetails.ProductID;

--5. List customers and the total amount they have spent, including customers who have not spent anything.

SELECT 
    Customers.FirstName || ' ' || Customers.LastName AS CustomerName, 
    COALESCE(SUM(Orders.TotalAmount), 0) AS TotalAmountSpent
FROM Customers
LEFT JOIN Orders ON Customers.CustomerID = Orders.CustomerID
GROUP BY Customers.FirstName, Customers.LastName;

--right join
--1.List all orders and the customer who placed them (including orders with no customer).

SELECT 
    Orders.OrderID, 
    Orders.OrderDate, 
    Orders.TotalAmount, 
    Customers.FirstName || ' ' || Customers.LastName AS CustomerName
FROM Orders
RIGHT JOIN Customers ON Orders.CustomerID = Customers.CustomerID;

--2.Which orders are missing customer information (e.g., orphan orders)?

SELECT 
    Orders.OrderID, 
    Orders.OrderDate, 
    Orders.TotalAmount
FROM Orders
RIGHT JOIN Customers ON Orders.CustomerID = Customers.CustomerID
WHERE Orders.CustomerID IS NULL;

--3.Which products have been ordered, and for each product, list the customer who ordered it (if available)?

SELECT 
    Products.ProductName, 
    Customers.FirstName || ' ' || Customers.LastName AS CustomerName
FROM Products
RIGHT JOIN OrderDetails ON Products.ProductID = OrderDetails.ProductID
RIGHT JOIN Orders ON OrderDetails.OrderID = Orders.OrderID
RIGHT JOIN Customers ON Orders.CustomerID = Customers.CustomerID;

--4.List orders that include products and their respective customers, even if a product has not been ordered.

SELECT 
    Orders.OrderID, 
    Products.ProductName, 
    Customers.FirstName || ' ' || Customers.LastName AS CustomerName
FROM Orders
RIGHT JOIN OrderDetails ON Orders.OrderID = OrderDetails.OrderID
RIGHT JOIN Products ON OrderDetails.ProductID = Products.ProductID
RIGHT JOIN Customers ON Orders.CustomerID = Customers.CustomerID;












