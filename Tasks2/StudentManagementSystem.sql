
USE master;
DROP DATABASE StudentManagementSystem;
GO

CREATE DATABASE StudentManagementSystem;
GO

USE StudentManagementSystem;


CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    Major VARCHAR(20) NOT NULL,
    Age INT NOT NULL,
    GPA DECIMAL(3, 2) NOT NULL
);
GO

INSERT INTO Students (StudentID, Name, Major, Age, GPA)
VALUES
    (1,'Ahmad','IT', 21, 3.5),
    (2,'Sara', 'CS', 20, 3.9),
    (3,'Ali',  'IT', 22, 2.8),
    (4,'Noor', 'SE', 19, 3.7),
    (5,'Omar', 'CS', 23, 3.2),
    (6,'Lina', 'IT', 20, 4.0),
    (7,'Ameer','SE', 21, 2.9),
    (8,'Rana', 'CS', 22, 3.6);
GO

SELECT MAX(GPA) 'MAX GPA' FROM Students;
SELECT MIN(GPA) 'MIN GPA' FROM Students;
SELECT COUNT(*) 'Students count' FROM Students;
SELECT SUM(GPA) 'SUM GPA' FROM Students;
SELECT AVG(GPA) 'AVG GPA' FROM Students;
SELECT Name 'Names start with A' FROM Students WHERE Name LIKE 'A%';
SELECT Name 'Names contain with ra' FROM Students WHERE Name LIKE '%ra%';
SELECT Name 'Names end with r' FROM Students WHERE Name LIKE '%r';
SELECT Name 'CS students',Major FROM Students WHERE Major = 'CS';

SELECT MAX(GPA) AS 'MAX',MIN(GPA) AS 'MIN' FROM Students;

-- BONUS

SELECT COUNT(*) 'Students count in IT' 
FROM Students WHERE Major = 'IT';

SELECT AVG(GPA) 'Average GPA in CS' 
FROM Students WHERE Major = 'CS';

-- Challenge

SELECT MAX(GPA) 'MAX',MIN(GPA) 'MIN',AVG(GPA) 'AVG',COUNT(*) 'COUNT'
FROM Students;

