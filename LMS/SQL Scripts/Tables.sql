IF NOT EXISTS ( 
		SELECT * FROM INFORMATION_SCHEMA.TABLES
		WHERE TABLE_SCHEMA = 'dbo'
		AND TABLE_NAME = 'BookAuthors')
	BEGIN
		CREATE TABLE BookAuthors (
		authorID INT IDENTITY(1, 1) PRIMARY KEY NOT NULL,
		firstName NVARCHAR(MAX) NULL,
		middleName NVARCHAR(MAX) NULL,
		lastName NVARCHAR(MAX) NULL)
	END

IF NOT EXISTS ( 
		SELECT * FROM INFORMATION_SCHEMA.TABLES
		WHERE TABLE_SCHEMA = 'dbo'
		AND TABLE_NAME = 'BookPublishers')
	BEGIN
		CREATE TABLE BookPublishers (
		publisherID INT IDENTITY(1, 1) PRIMARY KEY NOT NULL,
		publisherName NVARCHAR(MAX) NULL,
		city NVARCHAR(MAX) NULL)
	END

IF NOT EXISTS ( 
		SELECT * FROM INFORMATION_SCHEMA.TABLES
		WHERE TABLE_SCHEMA = 'dbo'
		AND TABLE_NAME = 'Books')
	BEGIN
		CREATE TABLE Books (
		bookID INT IDENTITY(1, 1) PRIMARY KEY NOT NULL,
		title NVARCHAR(MAX) NULL,
		authorID INT FOREIGN KEY REFERENCES BookAuthors(authorID) NULL, 
		publisherID INT FOREIGN KEY REFERENCES BookPublishers(publisherID) NULL,
		publishYear SMALLINT NULL, 
		genre NVARCHAR(MAX) NULL)
	END

IF NOT EXISTS ( 
		SELECT * FROM INFORMATION_SCHEMA.TABLES
		WHERE TABLE_SCHEMA = 'dbo'
		AND TABLE_NAME = 'BorrowerAddresses')
	BEGIN
		CREATE TABLE BorrowerAddresses (
		addressID INT IDENTITY(1, 1) PRIMARY KEY NOT NULL,
		country INT FOREIGN KEY REFERENCES Countries(countryID),
		city NVARCHAR(MAX)  NULL,
		street NVARCHAR(MAX) NULL,
		zipCode INT NULL)

	END


IF NOT EXISTS ( 
		SELECT * FROM INFORMATION_SCHEMA.TABLES
		WHERE TABLE_SCHEMA = 'dbo'
		AND TABLE_NAME = 'BookBorrowers')
	BEGIN
		CREATE TABLE BookBorrowers (
		borrowerID INT IDENTITY(1, 1) PRIMARY KEY NOT NULL,
		firstName NVARCHAR(MAX) NULL,
		middleName NVARCHAR(MAX) NULL,
		lastName NVARCHAR(MAX) NULL,
		mail NVARCHAR(MAX) NULL,
		addressID INT FOREIGN KEY REFERENCES BorrowerAddresses(addressID))
	END

IF NOT EXISTS ( 
		SELECT * FROM INFORMATION_SCHEMA.TABLES
		WHERE TABLE_SCHEMA = 'dbo'
		AND TABLE_NAME = 'UserAccounts')
	BEGIN
		CREATE TABLE UserAccounts (
		accountID INT IDENTITY(1, 1) PRIMARY KEY NOT NULL,
		[owner] INT FOREIGN KEY REFERENCES BookBorrowers(borrowerID) NOT NULL,
		username NVARCHAR(MAX) NOT NULL,
		[password] NVARCHAR(MAX) NOT NULL)
	END

IF NOT EXISTS ( 
		SELECT * FROM INFORMATION_SCHEMA.TABLES
		WHERE TABLE_SCHEMA = 'dbo'
		AND TABLE_NAME = 'BookRentals')
	BEGIN
		CREATE TABLE BookRentals (
		rentalID INT IDENTITY(1, 1) PRIMARY KEY NOT NULL,
		bookID NVARCHAR(MAX) NOT NULL,
		borrowerID NVARCHAR(MAX) NOT NULL)
	END

IF NOT EXISTS ( 
		SELECT * FROM INFORMATION_SCHEMA.TABLES
		WHERE TABLE_SCHEMA = 'dbo'
		AND TABLE_NAME = 'BookStatuses')
	BEGIN
		CREATE TABLE BookStatuses (
		rentalID INT IDENTITY(1, 1) PRIMARY KEY NOT NULL,
		bookID NVARCHAR(MAX) NOT NULL,
		borrowerID NVARCHAR(MAX) NOT NULL)
	END

IF NOT EXISTS ( 
		SELECT * FROM INFORMATION_SCHEMA.TABLES
		WHERE TABLE_SCHEMA = 'dbo'
		AND TABLE_NAME = 'Countries')
	BEGIN
		CREATE TABLE Countries (
		countryID INT IDENTITY(1, 1) PRIMARY KEY NOT NULL,
		countryName NVARCHAR(MAX) NOT NULL)
	END


--DROP TABLE UserAccounts, BookBorrowers
--DROP TABLE BorrowerAddresses
GO
CREATE OR ALTER VIEW BorrowerAccounts AS
SELECT b.firstName, b.middleName, b.lastName, a.city, a.street, a.zipCode, 
	u.username, u.[password] FROM BookBorrowers b, UserAccounts u, BorrowerAddresses a

GO
CREATE OR ALTER PROCEDURE CreateUser(@first NVARCHAR(MAX), @middle NVARCHAR(MAX), @last NVARCHAR(MAX), 
	@mail NVARCHAR(MAX), @pass NVARCHAR(MAX), @login NVARCHAR(MAX), @country INT, @city NVARCHAR(MAX), @street NVARCHAR(MAX), @zip INT) AS
	INSERT INTO BorrowerAddresses VALUES (@country, @city, @street, @zip)
	INSERT INTO BookBorrowers(firstName,middleName,lastName,mail,addressID) VALUES (@first, @middle, @last, @mail, IDENT_CURRENT('BorrowerAdresses'))
	INSERT INTO UserAccounts VALUES (IDENT_CURRENT('BookBorrowers'), @login, @pass)

--EXEC CreateUser 'first', 'middle', 'last', 'mail@example.com', 'pass123', 'mail', 'new york', '42nd', '1037'
--select * from BookBorrowers
--select * from UserAccounts

--drop view BorrowerAccounts
--select * from BorrowerAccounts

select * from Countries