CREATE DATABASE TaskOne;
GO

use TaskOne;

CREATE TABLE Customers(
	ID INT IDENTITY(1,1) PRIMARY KEY,
	Name VARCHAR(50) NOT NULL,
	Email VARCHAR(50) NOT NULL,
	Phone VARCHAR(15) NULL,
	Address VARCHAR(50) NULL
);

CREATE TABLE Products(
	ID INT IDENTITY(1,1) PRIMARY KEY,
	Name VARCHAR(30) NOT NULL,
	Price DECIMAL(10,2) NOT NULL,
	IsActive BIT NULL
);


CREATE TABLE Employees(
	ID INT IDENTITY(1,1) PRIMARY KEY,
	Name VARCHAR(50) NOT NULL,
	Email VARCHAR(50) NOT NULL,
	Phone VARCHAR(15) NULL,
	JobTitle VARCHAR(30) NULL,
);


CREATE TABLE Orders(
	ID INT IDENTITY(1,1) PRIMARY KEY,
	CustomerID INT NOT NULL REFERENCES Customers(ID),
	EmployeeID INT NOT NULL REFERENCES Employees(ID),
	ProductID INT NOT NULL REFERENCES Products(ID),
	OrderDate DATETIME2 NOT NULL,
	TotalAmount DECIMAL(10,2) NOT NULL
);

-- INSERT

INSERT INTO Customers (Name, Email, Phone, Address) VALUES
('Mohammad Salah', 'm.salah@liverpool.com', '079567', 'Cairo, Egypt'),
('Lionel Messi', 'messi@barcelona.com', '077123', 'Argentina'),
('Cristiano Ronaldo', 'cr7@madrid.com', '078777', 'Portugal');


INSERT INTO Products (Name, Price, IsActive) VALUES
('Mouse', 29.99, 1),
('Keyboard', 89.50, 1),
('Monitor', 249.99, 1),
('Football', 119.00, 1),
('Webcam', 45.00, 0);


INSERT INTO Employees (Name, Email, Phone, JobTitle) VALUES
('Peter Parker', 'spidey@marvel.com', '0781916', 'Photographer'),
('Bruce Lee', 'm.scott@company.com', '0778425', 'Movie star'),
('John Cena', 'p.beesly@company.com', '079113', 'Wrestler');


INSERT INTO Orders (CustomerID, EmployeeID, ProductID, OrderDate, TotalAmount) VALUES
(1, 2, 1, '2026-06-01 10:30:00', 29.99),
(2, 1, 3, '2026-06-02 14:15:00', 249.99),
(1, 2, 3, '2026-06-05 09:00:00', 89.50),
(3, 3, 1, '2026-06-10 16:45:00', 119.00);
