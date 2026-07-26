USE master;
GO

DROP DATABASE MessengerSystem;
GO

CREATE DATABASE MessengerSystem;
GO

USE MessengerSystem;


-- CREATE

CREATE TABLE Users(

ID INT IDENTITY(1,1) PRIMARY KEY,
Name NVARCHAR(30) NOT NULL,
Username VARCHAR(30) NOT NULL,
Password VARCHAR(30) NOT NULL,
Email VARCHAR(30) NOT NULL,
PhoneNumber VARCHAR(15) NULL,
IsActive BIT NOT NULL
);

CREATE TABLE Messages(
ID INT IDENTITY(1,1) PRIMARY KEY,
SenderID INT NULL REFERENCES Users(ID) ON DELETE SET NULL,
RecieverID INT NULL REFERENCES Users(ID),
SentDate DATETIME2 NOT NULL,
IsSeen BIT NOT NULL,
Content NVARCHAR(MAX) NOT NULL
);

CREATE TABLE Services(

ID INT IDENTITY(1,1) PRIMARY KEY,
Name NVARCHAR(30) NOT NULL,
Price DECIMAL(10,2) NOT NULL,
IsActive BIT NOT NULL
);

CREATE TABLE UsersServices(

UserID INT REFERENCES Users(ID),
ServiceID INT REFERENCES Services(ID),
RequestAt DATETIME2 NOT NULL,
EndAt DATETIME2 NULL,
PaymentMethod VARCHAR(50),
AmountPaid DECIMAL(18, 2),
PaidAt DATETIME2 NULL
PRIMARY KEY(UserID,ServiceID)
);
GO

-- INSERT

INSERT INTO Users (Name, Username, Password, Email, PhoneNumber, IsActive)
VALUES 
(N'Ahmad Al-Mansi',   'ahmad_m',   'Pass123!', 'ahmad.mansi@example.jo',   '+962791234567', 1),
(N'Rania Tarawneh',   'rania_t',   'Pass123!', 'rania.tarawneh@example.jo','+962788765432', 1),
(N'Omar Al-Khasawneh','omar_k',    'Pass123!', 'omar.khasawneh@example.jo','+962777112233', 1),
(N'Layla Qasem',      'layla_q',   'Pass123!', 'layla.qasem@example.jo',   '+962795544332', 1),
(N'Tariq Majali',     'tariq_m',   'Pass123!', 'tariq.majali@example.jo',  '+962780099887', 0),
(N'Yara Haddad',      'yara_h',    'Pass123!', 'yara.haddad@example.jo',   '+962776655443', 1);

INSERT INTO Messages (SenderID, RecieverID, SentDate, IsSeen, Content)
VALUES 
(1, 2, '2026-07-01 09:30:00', 1, N'Marhaba Rania, did you check the project proposal?'),
(2, 1, '2026-07-01 09:35:00', 1, N'Ahalan Ahmad! Yes, looks great. Sent payment via CliQ.'),
(3, 4, '2026-07-02 11:15:00', 1, N'Salam Layla, can we schedule a meeting for tomorrow?'),
(4, 3, '2026-07-02 12:00:00', 0, N'Sure Omar, 2 PM works for me. Let me know!'),
(5, 1, '2026-07-03 14:22:00', 0, N'Ahmad, please check the database logs when you are free.'),
(6, 2, '2026-07-04 16:45:00', 1, N'Thanks for the support today Rania, really appreciated!');

INSERT INTO Services (Name, Price, IsActive)
VALUES 
(N'Amman Web Hosting',      25.00,  1),
(N'Cloud Storage - Jo',     10.00,  1),
(N'SEO Audit & Marketing',  120.00, 1),
(N'UI/UX Mobile Design',    250.00, 1),
(N'Database Maintenance',   50.00,  1),
(N'Domain (.jo) Renewal',   35.00,  0);

INSERT INTO UsersServices (UserID, ServiceID, RequestAt, EndAt, PaymentMethod, AmountPaid, PaidAt)
VALUES 
(1, 1, '2026-01-10 08:00:00', '2027-01-10 08:00:00', 'CliQ',          25.00,  '2026-01-10 08:05:00'),
(1, 2, '2026-02-15 10:30:00', '2027-02-15 10:30:00', 'Visa Card',     10.00,  '2026-02-15 10:31:00'),
(2, 3, '2026-03-01 14:00:00', NULL,                  'CliQ',          120.00, '2026-03-01 14:02:00'),
(3, 4, '2026-04-12 09:00:00', '2026-05-12 09:00:00', 'Bank Transfer', 250.00, '2026-04-12 09:15:00'),
(4, 2, '2026-05-20 16:45:00', NULL,                  'Zain Cash',     50.00,  '2026-05-20 16:46:00'),
(6, 1, '2026-06-01 11:10:00', '2027-06-01 11:10:00', 'CliQ',          25.00,  '2026-06-01 11:12:00');

-- UPDATE

UPDATE Users
SET Password = 'tariq123!'  WHERE Username LIKE 'tariq%';

UPDATE Services
SET Price = 30  WHERE Name LIKE '%Hosting';

UPDATE UsersServices
SET AmountPaid = 50.50  WHERE UserID = 4;

-- DELETE

DELETE FROM Users WHERE IsActive = 0;
DELETE FROM Services WHERE IsActive = 0;
DELETE FROM UsersServices WHERE EndAt IS NULL;

-- RENAME

EXEC sp_rename 'Users','MyUsers';
EXEC sp_rename 'Services','Service';

GO

-- Columns modify



EXEC sp_rename 'MyUsers.Username', 'UserName', 'COLUMN';

GO

ALTER TABLE MyUsers
ALTER COLUMN UserName VARCHAR(10) NOT NULL;


EXEC sp_rename 'Service.Price', 'Cost', 'COLUMN';
GO

ALTER TABLE Service
ALTER COLUMN Cost DECIMAL(8,2) NOT NULL;
