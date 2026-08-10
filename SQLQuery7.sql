create table employees (EmployeeID int primary key, departmentID int, EmployeeName varchar (100), managerID int)

create table Departments (deptID int primary key, deptName varchar(100))

create table Managers (ManagerId int primary key, managerName varchar(100))

create table salaries (employeeId int, salary int)

create table attendance (attendanceID int, employeeID int, attendanceDate int, status varchar(20))

create table performanceReviews (employeeID int, score int, reviewDate date)

select employeename, managername from employees
inner join managers on employees.managerID=Managers.ManagerId

select employees.EmployeeID,employees.EmployeeName,employees.departmentID, salaries.salary
from employees
inner join salaries on employees.EmployeeID=salaries.employeeId

WITH SalaryRank AS
(
    SELECT
        d.DepartmentName,
        e.FirstName,
        s.SalaryAmount,

        RANK() OVER
        (
            PARTITION BY d.DepartmentID
            ORDER BY s.SalaryAmount DESC
        ) AS SalaryRank
    FROM Employees e
    JOIN Departments d
        ON e.DepartmentID = d.DepartmentID
    JOIN Salaries s
        ON e.EmployeeID = s.EmployeeID
)
SELECT *
FROM SalaryRank
WHERE SalaryRank = 1;

select top 5  performanceReviews.score, employees.EmployeeID,employees.EmployeeName
from employees inner join performanceReviews on employees.EmployeeID = performanceReviews.employeeID


WITH SalaryHistory AS
(
    SELECT
        EmployeeID,
        Salary,
        EffectiveDate,

        LAG(SalaryAmount)
        OVER
        (
            PARTITION BY EmployeeID
            ORDER BY EffectiveDate
        ) AS PreviousSalary
    FROM Salaries
)
SELECT
    EmployeeID,
    PreviousSalary,
    SalaryAmount,
    SalaryAmount - PreviousSalary AS Increase
FROM SalaryHistory;

WITH EmployeeHierarchy AS
(
    -- Anchor
    SELECT
        EmployeeID,
        employeename,
        ManagerID,
        0 AS Level
    FROM Employees
    WHERE ManagerID IS NULL

    UNION ALL

    -- Recursive Part
    SELECT
        e.EmployeeID,
        e.EmployeeName,
        e.ManagerID,
        eh.Level + 1
    FROM Employees e
    JOIN EmployeeHierarchy eh
        ON e.ManagerID = eh.EmployeeID
)
SELECT *
FROM EmployeeHierarchy;

--recursive cte continuation

CREATE TABLE Parts
(
    ParentPart VARCHAR(50),
    partName VARCHAR(50),
    Quantity INT
);

INSERT INTO Parts VALUES
('Car','Engine',1),
('Car','Wheel',4),
('Engine','Piston',4),
('Engine','Spark Plug',4),
('Wheel','Tire',1);
insert into parts values (null,'car',1)
delete from parts where ParentPart=null
select * from parts

with recursiveCarParts as(
select Parts.partName, Parts.ParentPart, 0 as partlevel from parts where parts.ParentPart=NULL 

union all

select parts.partName,Parts.ParentPart, recursiveCarParts.partlevel + 1
from parts inner join recursiveCarParts on parts.ParentPart=recursiveCarParts.partname  
)
select * from  recursiveCarParts

WITH PartHierarchy AS
(
    -- Anchor: direct components of Car
    SELECT
        ParentPart,
        partname,
        Quantity
    FROM Parts
    WHERE ParentPart = 'Car'

    UNION ALL

    -- Recursive: find components of components
    SELECT
        p.ParentPart,
        p.partName,
        p.Quantity
    FROM Parts p
    JOIN PartHierarchy ph
        ON p.ParentPart = ph.partname
)
SELECT *
FROM PartHierarchy;

INSERT INTO Employees (employeeID, EmployeeName,managerID) VALUES
(1, 'Sarah', NULL),
(2, 'David', 1),
(3, 'John', 1),
(4, 'Emily', 2),
(5, 'Mike', 2),
(6, 'Lisa', 4),
(7, 'Tom', 3),
(8, 'Anna', 7);

WITH EmployeeHierarchy AS
(
    SELECT
        EmployeeID,
        EmployeeName,
        ManagerID,
        0 AS Level
    FROM Employees
    WHERE ManagerID IS NULL

    UNION ALL

    SELECT
        e.EmployeeID,
        e.EmployeeName,
        e.ManagerID,
        eh.Level + 1
    FROM Employees e
    JOIN EmployeeHierarchy eh
        ON e.ManagerID = eh.EmployeeID
)
SELECT
    *
FROM EmployeeHierarchy;