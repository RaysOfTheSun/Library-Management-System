﻿IF NOT EXISTS ( 
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
		ISBN NVARCHAR(MAX) NULL,
		callNumber NVARCHAR(MAX) NULL,
		edition NVARCHAR(MAX) NULL,
		genre NVARCHAR(MAX) NULL)
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

IF NOT EXISTS ( 
		SELECT * FROM INFORMATION_SCHEMA.TABLES
		WHERE TABLE_SCHEMA = 'dbo'
		AND TABLE_NAME = 'Cities')
	BEGIN
		CREATE TABLE Cities (
		cityID INT IDENTITY(1, 1) PRIMARY KEY NOT NULL,
		cityName NVARCHAR(MAX) NOT NULL)
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
		AND TABLE_NAME = 'Locations')
	BEGIN
		CREATE TABLE Locations (
		locationID INT IDENTITY(1, 1) PRIMARY KEY NOT NULL,
		countryID INT FOREIGN KEY REFERENCES Countries(countryID),
		cityID INT FOREIGN KEY REFERENCES cities(cityID))
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
	INSERT INTO BookBorrowers(firstName,middleName,lastName,mail,addressID) VALUES (@first, @middle, @last, @mail, IDENT_CURRENT('BorrowerAddresses'))
	INSERT INTO UserAccounts VALUES (IDENT_CURRENT('BookBorrowers'), @login, @pass)

GO
--CREATE OR ALTER PROCEDURE AddBook (@authorFirstName NVARCHAR(MAX), @authorMiddleName NVARCHAR(MAX), @authorLastName NVARCHAR(MAX),
--	@publisherName NVARCHAR(MAX), @publisherCity NVARCHAR(MAX), @bookTitle NVARCHAR, 

CREATE OR ALTER PROCEDURE AddAuthor (@authorFirstName NVARCHAR(MAX), @authorMiddleName NVARCHAR(MAX), 
	@authorLastName NVARCHAR(MAX)) AS
	INSERT INTO BookAuthors VALUES (@authorFirstName, @authorMiddleName, @authorLastName)
GO

CREATE OR ALTER PROCEDURE AddPublisher(@publisherName NVARCHAR(MAX), @cityID INT) AS
	INSERT INTO BookPublishers VALUES (@publisherName, @cityID)
GO

CREATE OR ALTER PROCEDURE AddBook(@authorFirstName NVARCHAR(MAX), @authorMiddleName NVARCHAR(MAX), 
	@authorLastName NVARCHAR(MAX), @publisherName NVARCHAR(MAX), @cityID INT, @bookTitle NVARCHAR(MAX),
	@publishYear SMALLINT, @genre NVARCHAR(MAX), @ISBN NVARCHAR(MAX), @callNumber NVARCHAR(MAX), 
	@edition NVARCHAR(MAX)) AS 
	EXEC AddAuthor @authorFirstName, @authorMiddleName, @authorLastName
	EXEC AddPublisher @publisherName, @cityID
	INSERT INTO Books VALUES (@bookTitle, IDENT_CURRENT('BookAuthors'), IDENT_CURRENT('BookPublishers'), @publishYear,
		@ISBN, @callNumber, @edition, @genre)

--EXEC CreateUser 'first', 'middle', 'last', 'mail@example.com', 'pass123', 'mail', 'new york', '42nd', '1037'
select * from BookBorrowers
--select * from UserAccounts
----select * from BorrowerAddresses
--select IDENT_CURRENT('BorrowerAddresses')


--drop table BookBorrowers
--drop view BorrowerAccounts
--select * from BorrowerAccounts



EXEC CreateUser 'Arvin', 'Collado', 'Alvarez', 'arvin@mail.com', '1111', 'rvn', 2, 1, 'Elm st.', 1008
EXEC CreateUser 'John', 'Smith', 'Heather', 'john@mail.com', '21241', 'jsh', 2, 1, 'flem st.', 1010
EXEC CreateUser 'Skratta', 'Purora', 'Mommin', 'scaty@mail.com', 'password', 'spm', 2, 1, 'lost st.', 1042
GO

SELECT * FROM BookBorrowers
GO


select * from Countries

INSERT INTO Countries VALUES('Bhutan')
INSERT INTO Countries VALUES('Philippines')
INSERT INTO Countries VALUES('Brazil')
INSERT INTO Countries VALUES('France')
INSERT INTO Countries VALUES('Libia')
INSERT INTO Countries VALUES('Philippines')
INSERT INTO Countries VALUES('Germany')