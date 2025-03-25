CREATE TABLE Employees_new (
    EmployeeID INT PRIMARY KEY,               
    EmployeeName VARCHAR(100),                 
    DepartmentID INT,                         
    HireDate DATE,                            
    ManagerID INT,                            
    Salary DECIMAL(10, 2)                      
);

INSERT ALL
  INTO Employees_new (EmployeeID, EmployeeName, DepartmentID, HireDate, ManagerID, Salary)
  VALUES (1, 'John Doe', 1, TO_DATE('2020-01-15', 'YYYY-MM-DD'), 3, 75000)
  INTO Employees_new (EmployeeID, EmployeeName, DepartmentID, HireDate, ManagerID, Salary)
  VALUES (2, 'Jane Smith', 2, TO_DATE('2021-03-25', 'YYYY-MM-DD'), 3, 65000)
  INTO Employees_new (EmployeeID, EmployeeName, DepartmentID, HireDate, ManagerID, Salary)
  VALUES (3, 'Samuel Green', 1, TO_DATE('2022-07-01', 'YYYY-MM-DD'), NULL, 85000)
  INTO Employees_new (EmployeeID, EmployeeName, DepartmentID, HireDate, ManagerID, Salary)
  VALUES (4, 'Emma Brown', 2, TO_DATE('2020-08-10', 'YYYY-MM-DD'), 2, 95000)
  INTO Employees_new (EmployeeID, EmployeeName, DepartmentID, HireDate, ManagerID, Salary)
  VALUES (5, 'Oliver White', 1, TO_DATE('2022-02-14', 'YYYY-MM-DD'), 1, 72000)
  INTO Employees_new (EmployeeID, EmployeeName, DepartmentID, HireDate, ManagerID, Salary)
  VALUES (6, 'Ava Black', 3, TO_DATE('2021-11-01', 'YYYY-MM-DD'), 3, 67000)
  INTO Employees_new (EmployeeID, EmployeeName, DepartmentID, HireDate, ManagerID, Salary)
  VALUES (7, 'Michael Blue', 1, TO_DATE('2020-12-12', 'YYYY-MM-DD'), 3, 80000)
  INTO Employees_new (EmployeeID, EmployeeName, DepartmentID, HireDate, ManagerID, Salary)
  VALUES (8, 'Sophia Pink', 2, TO_DATE('2019-06-20', 'YYYY-MM-DD'), 2, 92000)
  INTO Employees_new (EmployeeID, EmployeeName, DepartmentID, HireDate, ManagerID, Salary)
  VALUES (9, 'Liam Gray', 1, TO_DATE('2022-01-05', 'YYYY-MM-DD'), 3, 78000)
  INTO Employees_new (EmployeeID, EmployeeName, DepartmentID, HireDate, ManagerID, Salary)
  VALUES (10, 'Charlotte Red', 3, TO_DATE('2019-06-13', 'YYYY-MM-DD'), 3, 69000)
  INTO Employees_new (EmployeeID, EmployeeName, DepartmentID, HireDate, ManagerID, Salary)
  VALUES (11, 'Jack White', 1, TO_DATE('2021-04-10', 'YYYY-MM-DD'), 1, 77000)
  INTO Employees_new (EmployeeID, EmployeeName, DepartmentID, HireDate, ManagerID, Salary)
  VALUES (12, 'Olivia Brown', 2, TO_DATE('2020-05-22', 'YYYY-MM-DD'), 2, 66000)
  INTO Employees_new (EmployeeID, EmployeeName, DepartmentID, HireDate, ManagerID, Salary)
  VALUES (13, 'Lucas Black', 3, TO_DATE('2021-01-11', 'YYYY-MM-DD'), 3, 71000)
  INTO Employees_new (EmployeeID, EmployeeName, DepartmentID, HireDate, ManagerID, Salary)
  VALUES (14, 'Mia Green', 1, TO_DATE('2020-09-18', 'YYYY-MM-DD'), 3, 78000)
  INTO Employees_new (EmployeeID, EmployeeName, DepartmentID, HireDate, ManagerID, Salary)
  VALUES (15, 'Noah Blue', 2, TO_DATE('2021-07-15', 'YYYY-MM-DD'), 2, 85000)
  INTO Employees_new (EmployeeID, EmployeeName, DepartmentID, HireDate, ManagerID, Salary)
  VALUES (16, 'Ethan Gray', 1, TO_DATE('2022-02-05', 'YYYY-MM-DD'), 3, 83000)
  INTO Employees_new (EmployeeID, EmployeeName, DepartmentID, HireDate, ManagerID, Salary)
  VALUES (17, 'Isabella Pink', 3, TO_DATE('2021-10-01', 'YYYY-MM-DD'), 3, 72000)
  INTO Employees_new (EmployeeID, EmployeeName, DepartmentID, HireDate, ManagerID, Salary)
  VALUES (18, 'Logan Red', 2, TO_DATE('2019-04-01', 'YYYY-MM-DD'), 2, 68000)
  INTO Employees_new (EmployeeID, EmployeeName, DepartmentID, HireDate, ManagerID, Salary)
  VALUES (19, 'James White', 3, TO_DATE('2022-06-12', 'YYYY-MM-DD'), 3, 71000)
  INTO Employees_new (EmployeeID, EmployeeName, DepartmentID, HireDate, ManagerID, Salary)
  VALUES (20, 'Mason Brown', 1, TO_DATE('2021-02-20', 'YYYY-MM-DD'), 3, 76000)
SELECT * FROM dual;

select * from employees_new;

CREATE TABLE Departments_new (
    DepartmentID INT PRIMARY KEY,              -- Unique department ID
    DepartmentName VARCHAR(100)                -- Name of the department
);

INSERT ALL
  INTO Departments_new (DepartmentID, DepartmentName)
  VALUES (1, 'Sales')
  INTO Departments_new (DepartmentID, DepartmentName)
  VALUES (2, 'HR')
  INTO Departments_new (DepartmentID, DepartmentName)
  VALUES (3, 'IT')
  INTO Departments_new (DepartmentID, DepartmentName)
  VALUES (4, 'Marketing')
  INTO Departments_new (DepartmentID, DepartmentName)
  VALUES (5, 'Finance')
SELECT * FROM dual;

CREATE TABLE Projects_new (
    ProjectID INT PRIMARY KEY,                 -- Unique project ID
    ProjectName VARCHAR(100),                   -- Project name
    StartDate DATE,                             -- Project start date
    EndDate DATE,                               -- Project end date
    DepartmentID INT,                           -- Foreign key referencing the Departments_new table
    CONSTRAINT fk_department FOREIGN KEY (DepartmentID) REFERENCES Departments_new(DepartmentID)
);

INSERT ALL
  INTO Projects_new (ProjectID, ProjectName, StartDate, EndDate, DepartmentID)
  VALUES (1, 'Project Alpha', TO_DATE('2020-01-01', 'YYYY-MM-DD'), TO_DATE('2020-12-31', 'YYYY-MM-DD'), 1)
  INTO Projects_new (ProjectID, ProjectName, StartDate, EndDate, DepartmentID)
  VALUES (2, 'Project Beta', TO_DATE('2021-05-15', 'YYYY-MM-DD'), TO_DATE('2022-05-15', 'YYYY-MM-DD'), 2)
  INTO Projects_new (ProjectID, ProjectName, StartDate, EndDate, DepartmentID)
  VALUES (3, 'Project Gamma', TO_DATE('2021-07-01', 'YYYY-MM-DD'), TO_DATE('2021-12-31', 'YYYY-MM-DD'), 3)
  INTO Projects_new (ProjectID, ProjectName, StartDate, EndDate, DepartmentID)
  VALUES (4, 'Project Delta', TO_DATE('2022-02-01', 'YYYY-MM-DD'), TO_DATE('2022-12-01', 'YYYY-MM-DD'), 1)
  INTO Projects_new (ProjectID, ProjectName, StartDate, EndDate, DepartmentID)
  VALUES (5, 'Project Epsilon', TO_DATE('2022-03-10', 'YYYY-MM-DD'), TO_DATE('2023-03-10', 'YYYY-MM-DD'), 2)
  INTO Projects_new (ProjectID, ProjectName, StartDate, EndDate, DepartmentID)
  VALUES (6, 'Project Zeta', TO_DATE('2023-01-01', 'YYYY-MM-DD'), TO_DATE('2023-12-31', 'YYYY-MM-DD'), 3)
  INTO Projects_new (ProjectID, ProjectName, StartDate, EndDate, DepartmentID)
  VALUES (7, 'Project Theta', TO_DATE('2024-01-01', 'YYYY-MM-DD'), TO_DATE('2024-12-31', 'YYYY-MM-DD'), 1)
  INTO Projects_new (ProjectID, ProjectName, StartDate, EndDate, DepartmentID)
  VALUES (8, 'Project Iota', TO_DATE('2025-01-01', 'YYYY-MM-DD'), TO_DATE('2025-12-31', 'YYYY-MM-DD'), 2)
SELECT * FROM dual;

CREATE TABLE Salaries_new (
    EmployeeID INT PRIMARY KEY,                 -- Employee ID referencing Employees table
    Salary DECIMAL(10, 2),                      -- Salary amount
    Bonus DECIMAL(10, 2),                       -- Bonus amount
    CONSTRAINT fk_employee FOREIGN KEY (EmployeeID) REFERENCES Employees_new(EmployeeID)
);

INSERT ALL
  INTO Salaries_new (EmployeeID, Salary, Bonus)
  VALUES (1, 75000, 5000)
  INTO Salaries_new (EmployeeID, Salary, Bonus)
  VALUES (2, 65000, 4500)
  INTO Salaries_new (EmployeeID, Salary, Bonus)
  VALUES (3, 85000, 7000)
  INTO Salaries_new (EmployeeID, Salary, Bonus)
  VALUES (4, 95000, 8000)
  INTO Salaries_new (EmployeeID, Salary, Bonus)
  VALUES (5, 72000, 4000)
  INTO Salaries_new (EmployeeID, Salary, Bonus)
  VALUES (6, 67000, 3000)
  INTO Salaries_new (EmployeeID, Salary, Bonus)
  VALUES (7, 80000, 6000)
  INTO Salaries_new (EmployeeID, Salary, Bonus)
  VALUES (8, 92000, 10000)
  INTO Salaries_new (EmployeeID, Salary, Bonus)
  VALUES (9, 78000, 5500)
  INTO Salaries_new (EmployeeID, Salary, Bonus)
  VALUES (10, 69000, 3500)
  INTO Salaries_new (EmployeeID, Salary, Bonus)
  VALUES (11, 77000, 4000)
  INTO Salaries_new (EmployeeID, Salary, Bonus)
  VALUES (12, 66000, 3200)
  INTO Salaries_new (EmployeeID, Salary, Bonus)
  VALUES (13, 71000, 2500)
  INTO Salaries_new (EmployeeID, Salary, Bonus)
  VALUES (14, 78000, 3500)
  INTO Salaries_new (EmployeeID, Salary, Bonus)
  VALUES (15, 85000, 7000)
  INTO Salaries_new (EmployeeID, Salary, Bonus)
  VALUES (16, 83000, 6500)
  INTO Salaries_new (EmployeeID, Salary, Bonus)
  VALUES (17, 72000, 4200)
  INTO Salaries_new (EmployeeID, Salary, Bonus)
  VALUES (18, 68000, 2800)
  INTO Salaries_new (EmployeeID, Salary, Bonus)
  VALUES (19, 71000, 3100)
  INTO Salaries_new (EmployeeID, Salary, Bonus)
  VALUES (20, 76000, 4200)
SELECT * FROM dual;

CREATE TABLE Roles_new (
    RoleID INT PRIMARY KEY,                    -- Unique Role ID
    RoleName VARCHAR(100)                       -- Role Name (e.g., 'Manager', 'Developer', etc.)
);

INSERT ALL
  INTO Roles_new (RoleID, RoleName)
  VALUES (1, 'Manager')
  INTO Roles_new (RoleID, RoleName)
  VALUES (2, 'Developer')
  INTO Roles_new (RoleID, RoleName)
  VALUES (3, 'HR Specialist')
  INTO Roles_new (RoleID, RoleName)
  VALUES (4, 'Sales Representative')
  INTO Roles_new (RoleID, RoleName)
  VALUES (5, 'Project Lead')
  INTO Roles_new (RoleID, RoleName)
  VALUES (6, 'Software Engineer')
  INTO Roles_new (RoleID, RoleName)
  VALUES (7, 'Marketing Specialist')
  INTO Roles_new (RoleID, RoleName)
  VALUES (8, 'Team Lead')
SELECT * FROM dual;

CREATE TABLE Employee_Roles_new (
    EmployeeID INT,                            -- Employee ID (foreign key from Employees)
    RoleID INT,                                -- Role ID (foreign key from Roles)
    PRIMARY KEY (EmployeeID, RoleID),          -- Composite Primary Key (to handle multiple roles per employee)
    CONSTRAINT fk_employee_new FOREIGN KEY (EmployeeID) REFERENCES Employees_new(EmployeeID),  -- Unique constraint name
    CONSTRAINT fk_role_new FOREIGN KEY (RoleID) REFERENCES Roles_new(RoleID)                    -- Unique constraint name
);

INSERT ALL
  INTO Employee_Roles_new (EmployeeID, RoleID) VALUES (1, 4)   -- Sales Representative
  INTO Employee_Roles_new (EmployeeID, RoleID) VALUES (1, 1)   -- Manager
  INTO Employee_Roles_new (EmployeeID, RoleID) VALUES (2, 3)   -- HR Specialist
  INTO Employee_Roles_new (EmployeeID, RoleID) VALUES (2, 5)   -- Project Lead
  INTO Employee_Roles_new (EmployeeID, RoleID) VALUES (3, 2)   -- Developer
  INTO Employee_Roles_new (EmployeeID, RoleID) VALUES (4, 3)   -- HR Specialist
  INTO Employee_Roles_new (EmployeeID, RoleID) VALUES (4, 5)   -- Project Lead
  INTO Employee_Roles_new (EmployeeID, RoleID) VALUES (5, 4)   -- Sales Representative
  INTO Employee_Roles_new (EmployeeID, RoleID) VALUES (6, 2)   -- Developer
  INTO Employee_Roles_new (EmployeeID, RoleID) VALUES (7, 4)   -- Sales Representative
  INTO Employee_Roles_new (EmployeeID, RoleID) VALUES (7, 6)   -- Software Engineer
  INTO Employee_Roles_new (EmployeeID, RoleID) VALUES (8, 3)   -- HR Specialist
  INTO Employee_Roles_new (EmployeeID, RoleID) VALUES (9, 4)   -- Sales Representative
  INTO Employee_Roles_new (EmployeeID, RoleID) VALUES (10, 2)  -- Developer
  INTO Employee_Roles_new (EmployeeID, RoleID) VALUES (11, 4)  -- Sales Representative
  INTO Employee_Roles_new (EmployeeID, RoleID) VALUES (12, 3)  -- HR Specialist
  INTO Employee_Roles_new (EmployeeID, RoleID) VALUES (13, 6)  -- Software Engineer
  INTO Employee_Roles_new (EmployeeID, RoleID) VALUES (14, 2)  -- Developer
  INTO Employee_Roles_new (EmployeeID, RoleID) VALUES (15, 4)  -- Sales Representative
  INTO Employee_Roles_new (EmployeeID, RoleID) VALUES (16, 2)  -- Developer
  INTO Employee_Roles_new (EmployeeID, RoleID) VALUES (17, 6)  -- Software Engineer
  INTO Employee_Roles_new (EmployeeID, RoleID) VALUES (18, 3)  -- HR Specialist
  INTO Employee_Roles_new (EmployeeID, RoleID) VALUES (19, 4)  -- Sales Representative
  INTO Employee_Roles_new (EmployeeID, RoleID) VALUES (20, 6)  -- Software Engineer
SELECT * FROM dual;

 -- selecting all 
 
SELECT * FROM Employees_new;
SELECT * FROM Departments_new;
SELECT * FROM Projects_new;
SELECT * FROM Salaries_new;
SELECT * FROM Roles_new;
SELECT * FROM Employee_Roles_new;

SELECT SUM(Salary) FROM Employees_new;

SELECT * FROM Employees_new
WHERE DepartmentID = (SELECT DepartmentID FROM Departments_new WHERE DepartmentName = 'Sales');

SELECT DepartmentID, SUM(Salary)
FROM employees_new
GROUP BY DepartmentID;

SELECT DepartmentID, SUM(Salary) AS TotalSalary
FROM Employees_new
GROUP BY DepartmentID;

SELECT EmployeeName, hiredate
FROM Employees_new
WHERE EXTRACT(YEAR FROM HireDate) = 2020;

SELECT EmployeeName, Salary
FROM Employees_new
ORDER BY Salary DESC;

SELECT MAX(Salary) AS HighestSalary
FROM Employees_new;

SELECT Employees_new.EmployeeName, Departments_new.DepartmentName
FROM Employees_new
INNER JOIN Departments_new ON Employees_new.DepartmentID = Departments_new.DepartmentID;

SELECT * FROM Employees_new
WHERE ROWNUM <= 10;  

SELECT EmployeeName
FROM Employees_new
WHERE EmployeeID NOT IN (SELECT EmployeeID FROM Projects_new);

SELECT * FROM Employees_new
ORDER BY HireDate
FETCH FIRST 5 ROWS ONLY;  

SELECT DepartmentID, COUNT(*) AS EmployeeCount
FROM Employees_new
GROUP BY DepartmentID;

SELECT * FROM Employees_new
WHERE ManagerID IS NULL;






























