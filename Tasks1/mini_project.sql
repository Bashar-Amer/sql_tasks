USE master;
DROP DATABASE TrainingCenter;
GO


CREATE DATABASE TrainingCenter;
GO

USE TrainingCenter;



-- CREATE

CREATE TABLE CompletionStatuses(
	ID INT IDENTITY(1,1) PRIMARY KEY,
	Name VARCHAR(50) NOT NULL
);

CREATE TABLE Cities(
	ID INT IDENTITY(1,1) PRIMARY KEY,
	Name VARCHAR(50) NOT NULL
);

CREATE TABLE Instructors(
	ID INT IDENTITY(1,1) PRIMARY KEY,
	Name VARCHAR(50) NOT NULL,
	Email VARCHAR(30) NULL,
	Phone VARCHAR(15) NULL
);

CREATE TABLE Courses(
	ID INT IDENTITY(1,1) PRIMARY KEY,
	Name VARCHAR(50) NOT NULL,
	InstructorID INT NOT NULL REFERENCES Instructors(ID)
);


CREATE TABLE Students(
	ID INT IDENTITY(1,1) PRIMARY KEY,
	Name VARCHAR(50) NOT NULL,
	Email VARCHAR(30) NULL,
	Phone VARCHAR(15) NULL,
	CityID INT NOT NULL REFERENCES Cities(ID)
);



CREATE TABLE StudentsCourses(  -- Junction Table
	StudentID INT NOT NULL,
	CourseID INT NOT NULL,
	EnrollmentDate DATETIME2 NOT NULL,
	FinalGrade DECIMAL(5,2) NOT NULL,
	CompletionStatus INT NOT NULL REFERENCES CompletionStatuses(ID),
	PRIMARY KEY(StudentID,CourseID)
);


-- INSERT


INSERT INTO CompletionStatuses (Name) VALUES
('Completed'),
('In Progress'),
('Dropped');


INSERT INTO Cities (Name) VALUES
('Amman'),
('Irbid'),
('Zarqa'),
('Aqaba'),
('Cairo'),
('Baghdad'),
('Riyadh'),
('Dubai');


INSERT INTO Instructors (Name, Email, Phone) VALUES
('Dr. Yousef Al-Fayez', 'yousef@univ.edu', '0791917'),
('Prof. Ellie Sattler', 'esattler@univ.edu', '0791912'),
('Dr. Ian Malcolm', 'imalcolm@univ.edu', '0791911'),
('Sarah Harding', 'sharding@univ.edu', '0791999'),
('Henry Wu', 'hwu@univ.edu', '0791917'),
('Ray Arnold', 'rarnold@univ.edu', '0791917'),
('Robert Muldoon', 'rmuldoon@univ.edu', '0791299'),
('Lina Inverse', 'linai@univ.edu', '0793899');


INSERT INTO Courses (Name, InstructorID) VALUES
('Database Systems', 1),
('Web Development', 2),
('Data Structures', 3),
('Machine Learning', 4),
('Software Architecture', 5),
('Cybersecurity Basics', 6),
('Cloud Computing', 7),
('Mobile App Development', 8);


INSERT INTO Students (Name, Email, Phone, CityID) VALUES
('John Smith', 'jsmith@mail.com', '555-0201', 1),
('Emily Davis', 'edavis@mail.com', '555-0202', 2),
('Michael Brown', 'mbrown@mail.com', '555-0203', 3),
('Sophia Wilson', 'swilson@mail.com', '555-0204', 4),
('James Taylor', 'jtaylor@mail.com', '555-0205', 5),
('Olivia Martin', 'omartin@mail.com', '555-0206', 6),
('Daniel Anderson', 'danders@mail.com', '555-0207', 7),
('Emma Thomas', 'ethomas@mail.com', '555-0208', 8);


INSERT INTO StudentsCourses (StudentID, CourseID, EnrollmentDate, FinalGrade, CompletionStatus) VALUES
(1, 2, '2024-01-15 09:00:00', 92.50, 3),
(2, 2, '2024-01-16 10:30:00', 88.00, 3),
(3, 8, '2024-02-01 11:00:00', 75.25, 1),
(4, 4, '2024-02-10 14:15:00', 95.00, 3),
(5, 8, '2024-03-01 08:30:00', 62.00, 1),
(6, 6, '2024-03-05 13:00:00', 81.50, 2),
(7, 7, '2024-03-12 15:45:00', 0.00, 2),
(8, 8, '2024-04-01 10:00:00', 89.75, 1);


-- 


SELECT * FROM Students;

SELECT * FROM Instructors;


SELECT * FROM Courses;


SELECT DISTINCT(c.Name) FROM Courses c JOIN StudentsCourses sc
ON c.ID = sc.CourseID where sc.CompletionStatus = 1;


SELECT s.Name,sc.FinalGrade FROM Students s JOIN StudentsCourses sc
ON s.ID = sc.StudentID where sc.FinalGrade > 80;

SELECT s.Name, c.Name FROM Students s JOIN Cities c
ON s.CityID = c.ID WHERE c.Name = 'Amman';

SELECT i.Name, c.Name FROM Instructors i JOIN Courses c
ON c.InstructorID = i.ID WHERE i.Name LIKE 'Henry%'

SELECT s.Name,sc.FinalGrade FROM Students s JOIN StudentsCourses sc
ON s.ID = sc.StudentID where sc.EnrollmentDate > '2024-03-01 08:30:00';

SELECT * FROM Students WHERE Name LIKE 'J%';


SELECT s.Name,sc.FinalGrade FROM Students s JOIN StudentsCourses sc
ON s.ID = sc.StudentID where sc.FinalGrade BETWEEN 70 AND 90;

-- UPDATE

UPDATE StudentsCourses
SET FinalGrade = 90 WHERE StudentID = 1;

UPDATE Students
SET CityID = 3 WHERE ID = 1;

UPDATE Courses
SET Name = 'ASP .NET Core' WHERE ID = 6;

UPDATE Instructors
SET Name = 'Ahmad Rami',Email='a.rami@gmail.com' WHERE ID = 7;

UPDATE StudentsCourses
SET CompletionStatus = 1 WHERE StudentID = 2;

-- DELETE

DELETE FROM Students WHERE ID = 8;
DELETE FROM Courses WHERE ID = 8;
DELETE FROM StudentsCourses WHERE StudentID = 7;
DELETE Students FROM Students s JOIN StudentsCourses sc
ON s.ID = sc.StudentID where CompletionStatus = 3;

-- JOIN

SELECT s.Name,c.Name FROM Students s 
FULL OUTER JOIN StudentsCourses sc ON s.ID = sc.StudentID 
FULL OUTER JOIN Courses c on c.ID = sc.CourseID;

SELECT s.Name,i.Name FROM Students s 
JOIN StudentsCourses sc ON s.ID = sc.StudentID 
Left JOIN Courses c on c.ID = sc.CourseID
Left JOIN Instructors i on c.ID = i.ID;

-- ALTER


EXEC sp_rename 'Cities','City';

EXEC sp_rename 'StudentsCourses.EnrollmentDate', 'EnrDate', 'COLUMN';

ALTER TABLE Students 
ADD Address VARCHAR(50) NULL;

ALTER TABLE Students 
DROP COLUMN Address;

ALTER TABLE Students 
ALTER COLUMN Name NVARCHAR(50) NULL;


-- BONUS


SELECT c.ID , c.Name,COUNT(sc.StudentID) 'students count' FROM Courses c
LEFT JOIN StudentsCourses sc ON c.ID = sc.CourseID 
group by c.ID,c.Name;

SELECT c.ID , c.Name, AVG(sc.FinalGrade) 'Average' FROM Courses c
LEFT JOIN StudentsCourses sc ON c.ID = sc.CourseID 
group by c.ID,c.Name;

SELECT s.Name , MAX(sc.FinalGrade) 'Highest grade' FROM StudentsCourses sc
JOIN Students s on sc.StudentID = s.ID
group by s.ID,s.Name;

SELECT s.Name , MIN(sc.FinalGrade) 'Highest grade' FROM StudentsCourses sc
JOIN Students s on sc.StudentID = s.ID
group by s.ID,s.Name;

SELECT s.Name , MIN(sc.FinalGrade) 'Highest grade' FROM StudentsCourses sc
JOIN Students s on sc.StudentID = s.ID
group by s.ID,s.Name;

SELECT s.ID,s.Name,c.Name, SC.FinalGrade FROM Students s 
RIGHT JOIN StudentsCourses sc ON s.ID = sc.StudentID 
LEFT JOIN Courses c on c.ID = sc.CourseID
ORDER BY sc.FinalGrade desc;

SELECT c.Name FROM Courses c order by c.Name;

SELECT c.Name,COUNT(s.ID) 'students count' FROM City c
LEFT JOIN Students s ON s.CityID = c.ID
GROUP BY c.Name;


