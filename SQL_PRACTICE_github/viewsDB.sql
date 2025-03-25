--table creation

CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR2(50),
    LastName VARCHAR2(50),
    BirthDate DATE,
    HireDate DATE,
    DepartmentID INT
);

CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR2(100),
    ManagerID INT
);

CREATE TABLE Salaries (
    EmployeeID INT,
    Salary DECIMAL(10, 2),
    EffectiveDate DATE,
    PRIMARY KEY (EmployeeID, EffectiveDate)
);

CREATE TABLE Projects (
    ProjectID INT PRIMARY KEY,
    ProjectName VARCHAR2(100),
    StartDate DATE,
    EndDate DATE
);

CREATE TABLE Employee_Project (
    EmployeeID INT,
    ProjectID INT,
    PRIMARY KEY (EmployeeID, ProjectID),
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID),
    FOREIGN KEY (ProjectID) REFERENCES Projects(ProjectID)
);

--value insertion

-- Insert into Employees table
INSERT INTO Employees (EmployeeID, FirstName, LastName, BirthDate, HireDate, DepartmentID) VALUES (1, 'John', 'Doe', TO_DATE('1980-03-01', 'YYYY-MM-DD'), TO_DATE('2015-06-15', 'YYYY-MM-DD'), 1);
INSERT INTO Employees (EmployeeID, FirstName, LastName, BirthDate, HireDate, DepartmentID) VALUES (2, 'Jane', 'Smith', TO_DATE('1990-07-22', 'YYYY-MM-DD'), TO_DATE('2020-01-05', 'YYYY-MM-DD'), 2);
INSERT INTO Employees (EmployeeID, FirstName, LastName, BirthDate, HireDate, DepartmentID) VALUES (3, 'Michael', 'Johnson', TO_DATE('1985-05-15', 'YYYY-MM-DD'), TO_DATE('2018-10-10', 'YYYY-MM-DD'), 1);
INSERT INTO Employees (EmployeeID, FirstName, LastName, BirthDate, HireDate, DepartmentID) VALUES (4, 'Emily', 'Davis', TO_DATE('1992-04-11', 'YYYY-MM-DD'), TO_DATE('2021-05-18', 'YYYY-MM-DD'), 3);
INSERT INTO Employees (EmployeeID, FirstName, LastName, BirthDate, HireDate, DepartmentID) VALUES (5, 'David', 'Williams', TO_DATE('1983-11-30', 'YYYY-MM-DD'), TO_DATE('2017-09-25', 'YYYY-MM-DD'), 2);
INSERT INTO Employees (EmployeeID, FirstName, LastName, BirthDate, HireDate, DepartmentID) VALUES (6, 'Sophia', 'Martinez', TO_DATE('1995-08-22', 'YYYY-MM-DD'), TO_DATE('2019-12-05', 'YYYY-MM-DD'), 1);
INSERT INTO Employees (EmployeeID, FirstName, LastName, BirthDate, HireDate, DepartmentID) VALUES (7, 'Liam', 'Brown', TO_DATE('1988-12-19', 'YYYY-MM-DD'), TO_DATE('2014-03-17', 'YYYY-MM-DD'), 3);
INSERT INTO Employees (EmployeeID, FirstName, LastName, BirthDate, HireDate, DepartmentID) VALUES (8, 'Olivia', 'Garcia', TO_DATE('1994-10-10', 'YYYY-MM-DD'), TO_DATE('2022-04-12', 'YYYY-MM-DD'), 2);
INSERT INTO Employees (EmployeeID, FirstName, LastName, BirthDate, HireDate, DepartmentID) VALUES (9, 'James', 'Miller', TO_DATE('1982-01-06', 'YYYY-MM-DD'), TO_DATE('2016-11-01', 'YYYY-MM-DD'), 1);
INSERT INTO Employees (EmployeeID, FirstName, LastName, BirthDate, HireDate, DepartmentID) VALUES (10, 'Isabella', 'Taylor', TO_DATE('1993-09-20', 'YYYY-MM-DD'), TO_DATE('2020-03-14', 'YYYY-MM-DD'), 3);
INSERT INTO Employees (EmployeeID, FirstName, LastName, BirthDate, HireDate, DepartmentID) VALUES (11, 'Alexander', 'Anderson', TO_DATE('1991-06-15', 'YYYY-MM-DD'), TO_DATE('2021-07-10', 'YYYY-MM-DD'), 2);
INSERT INTO Employees (EmployeeID, FirstName, LastName, BirthDate, HireDate, DepartmentID) VALUES (12, 'Charlotte', 'Thomas', TO_DATE('1994-03-12', 'YYYY-MM-DD'), TO_DATE('2023-02-01', 'YYYY-MM-DD'), 1);
INSERT INTO Employees (EmployeeID, FirstName, LastName, BirthDate, HireDate, DepartmentID) VALUES (13, 'Mason', 'Jackson', TO_DATE('1987-11-25', 'YYYY-MM-DD'), TO_DATE('2015-02-28', 'YYYY-MM-DD'), 2);
INSERT INTO Employees (EmployeeID, FirstName, LastName, BirthDate, HireDate, DepartmentID) VALUES (14, 'Ava', 'White', TO_DATE('1997-07-30', 'YYYY-MM-DD'), TO_DATE('2020-08-10', 'YYYY-MM-DD'), 3);
INSERT INTO Employees (EmployeeID, FirstName, LastName, BirthDate, HireDate, DepartmentID) VALUES (15, 'Ethan', 'Harris', TO_DATE('1990-10-25', 'YYYY-MM-DD'), TO_DATE('2021-01-20', 'YYYY-MM-DD'), 1);
INSERT INTO Employees (EmployeeID, FirstName, LastName, BirthDate, HireDate, DepartmentID) VALUES (16, 'Harper', 'Clark', TO_DATE('1992-09-11', 'YYYY-MM-DD'), TO_DATE('2020-05-15', 'YYYY-MM-DD'), 2);
INSERT INTO Employees (EmployeeID, FirstName, LastName, BirthDate, HireDate, DepartmentID) VALUES (17, 'Daniel', 'Lewis', TO_DATE('1989-02-17', 'YYYY-MM-DD'), TO_DATE('2017-04-25', 'YYYY-MM-DD'), 1);
INSERT INTO Employees (EmployeeID, FirstName, LastName, BirthDate, HireDate, DepartmentID) VALUES (18, 'Amelia', 'Roberts', TO_DATE('1993-12-02', 'YYYY-MM-DD'), TO_DATE('2021-08-22', 'YYYY-MM-DD'), 3);
INSERT INTO Employees (EmployeeID, FirstName, LastName, BirthDate, HireDate, DepartmentID) VALUES (19, 'Megan', 'Walker', TO_DATE('1986-05-08', 'YYYY-MM-DD'), TO_DATE('2015-11-05', 'YYYY-MM-DD'), 2);
INSERT INTO Employees (EmployeeID, FirstName, LastName, BirthDate, HireDate, DepartmentID) VALUES (20, 'Lucas', 'Young', TO_DATE('1984-04-15', 'YYYY-MM-DD'), TO_DATE('2013-06-30', 'YYYY-MM-DD'), 1);


-- Insert into Departments table
INSERT INTO Departments (DepartmentID, DepartmentName, ManagerID) VALUES (1, 'IT', 3);
INSERT INTO Departments (DepartmentID, DepartmentName, ManagerID) VALUES (2, 'HR', 2);
INSERT INTO Departments (DepartmentID, DepartmentName, ManagerID) VALUES (3, 'Sales', 7);

-- Insert into Salaries table
INSERT INTO Salaries (EmployeeID, Salary, EffectiveDate) VALUES (1, 60000, TO_DATE('2015-06-15', 'YYYY-MM-DD'));
INSERT INTO Salaries (EmployeeID, Salary, EffectiveDate) VALUES (2, 50000, TO_DATE('2020-01-05', 'YYYY-MM-DD'));
INSERT INTO Salaries (EmployeeID, Salary, EffectiveDate) VALUES (3, 70000, TO_DATE('2018-10-10', 'YYYY-MM-DD'));
INSERT INTO Salaries (EmployeeID, Salary, EffectiveDate) VALUES (4, 55000, TO_DATE('2021-05-18', 'YYYY-MM-DD'));
INSERT INTO Salaries (EmployeeID, Salary, EffectiveDate) VALUES (5, 62000, TO_DATE('2017-09-25', 'YYYY-MM-DD'));
INSERT INTO Salaries (EmployeeID, Salary, EffectiveDate) VALUES (6, 65000, TO_DATE('2019-12-05', 'YYYY-MM-DD'));
INSERT INTO Salaries (EmployeeID, Salary, EffectiveDate) VALUES (7, 56000, TO_DATE('2014-03-17', 'YYYY-MM-DD'));
INSERT INTO Salaries (EmployeeID, Salary, EffectiveDate) VALUES (8, 48000, TO_DATE('2022-04-12', 'YYYY-MM-DD'));
INSERT INTO Salaries (EmployeeID, Salary, EffectiveDate) VALUES (9, 59000, TO_DATE('2016-11-01', 'YYYY-MM-DD'));
INSERT INTO Salaries (EmployeeID, Salary, EffectiveDate) VALUES (10, 67000, TO_DATE('2020-03-14', 'YYYY-MM-DD'));
INSERT INTO Salaries (EmployeeID, Salary, EffectiveDate) VALUES (11, 54000, TO_DATE('2021-07-10', 'YYYY-MM-DD'));
INSERT INTO Salaries (EmployeeID, Salary, EffectiveDate) VALUES (12, 72000, TO_DATE('2023-02-01', 'YYYY-MM-DD'));
INSERT INTO Salaries (EmployeeID, Salary, EffectiveDate) VALUES (13, 62000, TO_DATE('2015-02-28', 'YYYY-MM-DD'));
INSERT INTO Salaries (EmployeeID, Salary, EffectiveDate) VALUES (14, 51000, TO_DATE('2020-08-10', 'YYYY-MM-DD'));
INSERT INTO Salaries (EmployeeID, Salary, EffectiveDate) VALUES (15, 65000, TO_DATE('2021-01-20', 'YYYY-MM-DD'));
INSERT INTO Salaries (EmployeeID, Salary, EffectiveDate) VALUES (16, 55000, TO_DATE('2020-05-15', 'YYYY-MM-DD'));
INSERT INTO Salaries (EmployeeID, Salary, EffectiveDate) VALUES (17, 69000, TO_DATE('2017-04-25', 'YYYY-MM-DD'));
INSERT INTO Salaries (EmployeeID, Salary, EffectiveDate) VALUES (18, 53000, TO_DATE('2021-08-22', 'YYYY-MM-DD'));
INSERT INTO Salaries (EmployeeID, Salary, EffectiveDate) VALUES (19, 60000, TO_DATE('2015-11-05', 'YYYY-MM-DD'));
INSERT INTO Salaries (EmployeeID, Salary, EffectiveDate) VALUES (20, 75000, TO_DATE('2013-06-30', 'YYYY-MM-DD'));

-- Insert into Projects table
INSERT INTO Projects (ProjectID, ProjectName, StartDate, EndDate) VALUES (101, 'Project A', TO_DATE('2023-01-01', 'YYYY-MM-DD'), TO_DATE('2023-12-31', 'YYYY-MM-DD'));
INSERT INTO Projects (ProjectID, ProjectName, StartDate, EndDate) VALUES (102, 'Project B', TO_DATE('2023-02-01', 'YYYY-MM-DD'), TO_DATE('2023-11-30', 'YYYY-MM-DD'));
INSERT INTO Projects (ProjectID, ProjectName, StartDate, EndDate) VALUES (103, 'Project C', TO_DATE('2023-03-01', 'YYYY-MM-DD'), TO_DATE('2023-10-30', 'YYYY-MM-DD'));
INSERT INTO Projects (ProjectID, ProjectName, StartDate, EndDate) VALUES (104, 'Project D', TO_DATE('2023-04-01', 'YYYY-MM-DD'), TO_DATE('2023-09-30', 'YYYY-MM-DD'));
INSERT INTO Projects (ProjectID, ProjectName, StartDate, EndDate) VALUES (105, 'Project E', TO_DATE('2023-05-01', 'YYYY-MM-DD'), TO_DATE('2023-08-31', 'YYYY-MM-DD'));
INSERT INTO Projects (ProjectID, ProjectName, StartDate, EndDate) VALUES (106, 'Project F', TO_DATE('2023-06-01', 'YYYY-MM-DD'), TO_DATE('2023-07-31', 'YYYY-MM-DD'));
INSERT INTO Projects (ProjectID, ProjectName, StartDate, EndDate) VALUES (107, 'Project G', TO_DATE('2023-07-01', 'YYYY-MM-DD'), TO_DATE('2023-12-15', 'YYYY-MM-DD'));
INSERT INTO Projects (ProjectID, ProjectName, StartDate, EndDate) VALUES (108, 'Project H', TO_DATE('2023-08-01', 'YYYY-MM-DD'), TO_DATE('2023-12-01', 'YYYY-MM-DD'));
INSERT INTO Projects (ProjectID, ProjectName, StartDate, EndDate) VALUES (109, 'Project I', TO_DATE('2023-09-01', 'YYYY-MM-DD'), TO_DATE('2023-11-30', 'YYYY-MM-DD'));
INSERT INTO Projects (ProjectID, ProjectName, StartDate, EndDate) VALUES (110, 'Project J', TO_DATE('2023-10-01', 'YYYY-MM-DD'), TO_DATE('2023-12-30', 'YYYY-MM-DD'));

-- Insert into Employee_Project table
INSERT INTO Employee_Project (EmployeeID, ProjectID) VALUES (1, 101);
INSERT INTO Employee_Project (EmployeeID, ProjectID) VALUES (2, 102);
INSERT INTO Employee_Project (EmployeeID, ProjectID) VALUES (3, 103);
INSERT INTO Employee_Project (EmployeeID, ProjectID) VALUES (4, 104);
INSERT INTO Employee_Project (EmployeeID, ProjectID) VALUES (5, 105);
INSERT INTO Employee_Project (EmployeeID, ProjectID) VALUES (6, 106);
INSERT INTO Employee_Project (EmployeeID, ProjectID) VALUES (7, 107);
INSERT INTO Employee_Project (EmployeeID, ProjectID) VALUES (8, 108);
INSERT INTO Employee_Project (EmployeeID, ProjectID) VALUES (9, 109);
INSERT INTO Employee_Project (EmployeeID, ProjectID) VALUES (10, 110);
INSERT INTO Employee_Project (EmployeeID, ProjectID) VALUES (11, 101);
INSERT INTO Employee_Project (EmployeeID, ProjectID) VALUES (12, 102);
INSERT INTO Employee_Project (EmployeeID, ProjectID) VALUES (13, 103);
INSERT INTO Employee_Project (EmployeeID, ProjectID) VALUES (14, 104);
INSERT INTO Employee_Project (EmployeeID, ProjectID) VALUES (15, 105);
INSERT INTO Employee_Project (EmployeeID, ProjectID) VALUES (16, 106);
INSERT INTO Employee_Project (EmployeeID, ProjectID) VALUES (17, 107);
INSERT INTO Employee_Project (EmployeeID, ProjectID) VALUES (18, 108);
INSERT INTO Employee_Project (EmployeeID, ProjectID) VALUES (19, 109);
INSERT INTO Employee_Project (EmployeeID, ProjectID) VALUES (20, 110);

SELECT * FROM Employees;
SELECT * FROM Departments;
SELECT * FROM Salaries;
SELECT * FROM Projects;
SELECT * FROM Employee_Project;


--1.Create a view named View_Employees_Above_50k to show employees whose salary is greater than 50,000.

CREATE VIEW View_Employees_Above_50k AS
SELECT e.FirstName, e.LastName, s.Salary
FROM Employees e, Salaries s
WHERE e.EmployeeID = s.EmployeeID
AND s.Salary > 50000;

--2.Create a view named View_HR_Employees to show employees who are working in the "HR" department.

CREATE VIEW View_HR_Employees AS
SELECT FirstName, LastName, DepartmentID
FROM Employees
WHERE DepartmentID = (SELECT DepartmentID FROM Departments WHERE DepartmentName = 'HR');

--3.Create a view View_Large_Departments to show the department name and the number of employees in that department, but only for departments that have more than 5 employees.

CREATE VIEW View_Large_Departments AS
SELECT d.DepartmentName, COUNT(e.EmployeeID) AS NumEmployees
FROM Employees e, Departments d
WHERE e.DepartmentID = d.DepartmentID
GROUP BY d.DepartmentName
HAVING COUNT(e.EmployeeID) > 5;

--4.Create a view View_Employees_No_Project to show employees who are not assigned to any project

CREATE VIEW View_Employees_No_Project AS
SELECT FirstName, LastName
FROM Employees e
WHERE e.EmployeeID NOT IN (SELECT EmployeeID FROM Employee_Project);

--5.Create a view View_Average_Salary_By_Department to show the average salary for each department.

--CREATE VIEW View_Average_Salary_By_Department AS
--SELECT d.DepartmentName, AVG(s.Salary) AS AvgSalary
--FROM Salaries s, Employees e, Departments d
--WHERE e.EmployeeID = s.EmployeeID
--AND e.DepartmentID = d.DepartmentID
--GROUP BY d.DepartmentName;

--DROP VIEW View_Average_Salary_By_Department;

CREATE VIEW View_Average_Salary_By_Department AS
SELECT d.DepartmentName, ROUND(AVG(s.Salary), 2) AS AvgSalary
FROM Salaries s
JOIN Employees e ON e.EmployeeID = s.EmployeeID
JOIN Departments d ON e.DepartmentID = d.DepartmentID
GROUP BY d.DepartmentName;

-- extra view for practice

CREATE VIEW View_Employees_Born_1980 AS
SELECT FirstName, LastName, BirthDate
FROM Employees
WHERE EXTRACT(YEAR FROM BirthDate) = 1980;

CREATE VIEW View_Projects_Started_2023 AS
SELECT ProjectName, StartDate, EndDate
FROM Projects
WHERE EXTRACT(YEAR FROM StartDate) = 2023;







select * from View_Employees_Above_50k;
select * from View_HR_Employees;
select * from View_Large_Departments;
select * from  View_Employees_No_Project;
select * from View_Average_Salary_By_Department;
select * from View_Employees_Born_1980;
select * from View_Projects_Started_2023;


-- sub queries:

--1. Subquery in the WHERE Clause (Single-Row Subquery)
--Find employees whose salary is greater than the average salary in the company

SELECT e.FirstName, e.LastName, s.Salary
FROM Employees e
JOIN Salaries s ON e.EmployeeID = s.EmployeeID
WHERE s.Salary > (SELECT AVG(Salary) FROM Salaries);

--2. Find Employees Who Belong to the "HR" Department

SELECT e.FirstName, e.LastName
FROM Employees e
WHERE e.DepartmentID = (SELECT DepartmentID FROM Departments WHERE DepartmentName = 'HR');

--3. Find Employees with the Highest Salary in the Company

SELECT e.FirstName, e.LastName, s.Salary
FROM Employees e
JOIN Salaries s ON e.EmployeeID = s.EmployeeID
WHERE s.Salary = (SELECT MAX(Salary) FROM Salaries);









