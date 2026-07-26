
USE master;
GO

DROP DATABASE Tasks3;
GO


CREATE DATABASE Tasks3;
GO

USE Tasks3;

CREATE TABLE Employees (
    EmployeeID INT IDENTITY(1,1) PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    Department VARCHAR(50),
    Salary DECIMAL(10, 2),
    Age INT,
    City VARCHAR(50)
);


INSERT INTO Employees (Name, Department, Salary, Age, City) VALUES
('Ahmad Rami', 'Engineering', 8000, 29, 'Amman'),
('Sami Rami', 'Science', 7500, 55, 'Amman'),
('Khaled Sami', 'Marketing', 500, 34, 'Irbid'),
('Mohammad Salah', 'IT', 700, 41, 'Amman'),
('Ali Kamel', 'Science', 9000, 60, 'Amman'),
('Cristiano Ronaldo', 'Engineering', 7000, 27, 'Aqaba'),
('Lionel Messi', 'IT', 800, 38, 'Zarqa'),
('Othman Dembele', 'Engineering', 8500, 26, 'Amman'),
('Lameen Yamal', 'IT', 1200, 38, 'Zarqa'),
('Wael Yousef', 'Science', 10000, 60, 'Amman'),
('Arda Guler', 'Engineering', 9000, 23, 'Amman');


------------------------------------

---- GROUP BY

-- Task 1
SELECT Department,COUNT(EmployeeID) 'Employees count' FROM Employees
GROUP BY Department;

-- Task 2
SELECT Department, AVG(Salary) 'Average salaries' FROM Employees
GROUP BY Department;

-- Task 3
SELECT Department, MAX(Salary) 'Average salaries' FROM Employees
GROUP BY Department;

-- Task 4
SELECT City, SUM(Salary) 'Total salaries' FROM Employees
GROUP BY City;

------------------------------------

---- HAVING

-- Task 1
SELECT Department, COUNT(EmployeeID) 'Employees count' FROM Employees
GROUP BY Department
HAVING COUNT(EmployeeID) > 3

-- Task 2
SELECT City, AVG(Salary) 'Average salaries' FROM Employees
GROUP BY City
HAVING AVG(Salary) > 5000;

-- Task 3
SELECT Department, SUM(Salary) 'Total salaries' FROM Employees
GROUP BY Department
HAVING SUM(Salary) > 15000;

-- Task 4
SELECT Department, MIN(Salary) 'Minimum salaries' FROM Employees
GROUP BY Department
HAVING MIN(Salary) > 3000;

------------------------------------

---- ORDER BY

-- Task 1
SELECT * 
FROM Employees
ORDER BY Salary desc;

-- Task 2
SELECT * 
FROM Employees
ORDER BY Name;

-- Task 3
SELECT * 
FROM Employees
ORDER BY Age;

-- Task 4
SELECT * 
FROM Employees
ORDER BY Department asc, Salary desc;

------------------------------------

---- GROUP BY + HAVING + ORDER BY

-- Task 1

SELECT Department, COUNT(*) 'Employees count'
FROM Employees
GROUP BY Department
HAVING COUNT(*) > 2
ORDER BY COUNT(*) DESC

-- Task 2

SELECT Department, AVG(Salary) 'Average salaries'
FROM Employees
GROUP BY Department
HAVING AVG(Salary) > 4000
ORDER BY AVG(Salary) DESC

-- Task 3

SELECT City, SUM(Salary) 'Total salaries'
FROM Employees
GROUP BY City
HAVING SUM(Salary) > 10000
ORDER BY AVG(Salary);

------------------------------------

---- Challenge

SELECT Department, COUNT(*) 'Employees count', AVG(Salary) 'Average salaries', MAX(Salary) 'Maximum salaries'
FROM Employees
GROUP BY Department;

SELECT Department, AVG(Salary) 'Average salaries' , MAX(Salary) 'Maximum salaries'
FROM Employees
GROUP BY Department
HAVING AVG(Salary) > 5000
ORDER BY MAX(Salary) DESC


