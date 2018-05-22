IF NOT EXISTS ( 
		SELECT * FROM INFORMATION_SCHEMA.TABLES
		WHERE TABLE_SCHEMA = 'dbo'
		AND TABLE_NAME = 'Countries')
	BEGIN
		CREATE TABLE Countries (
		countryID INT IDENTITY(1, 1) PRIMARY KEY NOT NULL,
		countryName NVARCHAR(55) NOT NULL)
	END

IF NOT EXISTS ( 
		SELECT * FROM INFORMATION_SCHEMA.TABLES
		WHERE TABLE_SCHEMA = 'dbo'
		AND TABLE_NAME = 'Cities')
	BEGIN
		CREATE TABLE Cities (
		cityID INT IDENTITY(1, 1) PRIMARY KEY NOT NULL,
		cityName NVARCHAR(60) NOT NULL)
	END

IF NOT EXISTS ( 
		SELECT * FROM INFORMATION_SCHEMA.TABLES
		WHERE TABLE_SCHEMA = 'dbo'
		AND TABLE_NAME = 'BookAuthors')
	BEGIN
		CREATE TABLE BookAuthors (
		authorID INT IDENTITY(1, 1) PRIMARY KEY NOT NULL,
		firstName NVARCHAR(50) NOT NULL,
		middleName NVARCHAR(50) NOT NULL,
		lastName NVARCHAR(50) NOT NULL)
	END

IF NOT EXISTS ( 
		SELECT * FROM INFORMATION_SCHEMA.TABLES
		WHERE TABLE_SCHEMA = 'dbo'
		AND TABLE_NAME = 'BookPublishers')
	BEGIN
		CREATE TABLE BookPublishers (
		publisherID INT IDENTITY(1, 1) PRIMARY KEY NOT NULL,
		publisherName NVARCHAR(50) NOT NULL,
		countryID INT FOREIGN KEY REFERENCES Countries(countryID) NOT NULL)
	END

IF NOT EXISTS ( 
		SELECT * FROM INFORMATION_SCHEMA.TABLES
		WHERE TABLE_SCHEMA = 'dbo'
		AND TABLE_NAME = 'BorrowerAddresses')
	BEGIN
		CREATE TABLE BorrowerAddresses (
		addressID INT IDENTITY(1, 1) PRIMARY KEY NOT NULL,
		countryID INT FOREIGN KEY REFERENCES Countries(countryID) NOT NULL,
		cityID INT FOREIGN KEY REFERENCES Cities(cityID) NOT NULL,
		street NVARCHAR(100) NOT NULL,
		zipCode SMALLINT NOT NULL)
	END

IF NOT EXISTS ( 
		SELECT * FROM INFORMATION_SCHEMA.TABLES
		WHERE TABLE_SCHEMA = 'dbo'
		AND TABLE_NAME = 'Books')
	BEGIN
		CREATE TABLE Books (
		bookID INT IDENTITY(1, 1) PRIMARY KEY NOT NULL,
		title NVARCHAR(100) NOT NULL,
		authorID INT FOREIGN KEY REFERENCES BookAuthors(authorID) NULL, 
		publisherID INT FOREIGN KEY REFERENCES BookPublishers(publisherID) NULL,
		publishYear SMALLINT NULL,
		ISBN NVARCHAR(20) NULL,
		edition TINYINT NULL,
		genre NVARCHAR(20) NULL)
	END

IF NOT EXISTS ( 
		SELECT * FROM INFORMATION_SCHEMA.TABLES
		WHERE TABLE_SCHEMA = 'dbo'
		AND TABLE_NAME = 'LibraryIndex')
	BEGIN
		CREATE TABLE LibraryIndex (
		indexID INT IDENTITY(1, 1) PRIMARY KEY NOT NULL,
		bookID INT FOREIGN KEY REFERENCES Books(bookID) NOT NULL,
		callNumber NVARCHAR(20) NULL)
	END

IF NOT EXISTS ( 
		SELECT * FROM INFORMATION_SCHEMA.TABLES
		WHERE TABLE_SCHEMA = 'dbo'
		AND TABLE_NAME = 'BookBorrowers')
	BEGIN
		CREATE TABLE BookBorrowers (
		borrowerID INT IDENTITY(1, 1) PRIMARY KEY NOT NULL,
		firstName NVARCHAR(50) NOT NULL,
		middleName NVARCHAR(50) NOT NULL,
		lastName NVARCHAR(50) NOT NULL,
		mail NVARCHAR(255) NOT NULL,
		addressID INT FOREIGN KEY REFERENCES BorrowerAddresses(addressID) NOT NULL)
	END

IF NOT EXISTS ( 
		SELECT * FROM INFORMATION_SCHEMA.TABLES
		WHERE TABLE_SCHEMA = 'dbo'
		AND TABLE_NAME = 'UserAccounts')
	BEGIN
		CREATE TABLE UserAccounts (
		accountID INT IDENTITY(1, 1) PRIMARY KEY NOT NULL,
		[owner] INT FOREIGN KEY REFERENCES BookBorrowers(borrowerID) NOT NULL,
		username NVARCHAR(70) NOT NULL,
		[password] NVARCHAR(128) NOT NULL)
	END

IF NOT EXISTS ( 
		SELECT * FROM INFORMATION_SCHEMA.TABLES
		WHERE TABLE_SCHEMA = 'dbo'
		AND TABLE_NAME = 'BookRentals')
	BEGIN
		CREATE TABLE BookRentals (
		rentalID INT IDENTITY(1, 1) PRIMARY KEY NOT NULL,
		bookID INT FOREIGN KEY REFERENCES Books(bookID) NOT NULL,
		borrowerID INT FOREIGN KEY REFERENCES BookBorrowers(borrowerID) NOT NULL)
	END

IF NOT EXISTS ( 
		SELECT * FROM INFORMATION_SCHEMA.TABLES
		WHERE TABLE_SCHEMA = 'dbo'
		AND TABLE_NAME = 'BookStatuses')
	BEGIN
		CREATE TABLE BookStatuses (
		statusID INT IDENTITY(1, 1) PRIMARY KEY NOT NULL,
		bookID INT FOREIGN KEY REFERENCES Books(bookID) NOT NULL,
		bookCount SMALLINT NOT NULL)
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
GO

CREATE OR ALTER VIEW BorrowerAccounts AS
SELECT b.firstName, b.middleName, b.lastName, a.cityID, a.countryID, a.street, a.zipCode, 
	u.username, u.[password] FROM BookBorrowers b, UserAccounts u, BorrowerAddresses a
GO

CREATE OR ALTER VIEW AuthorNames AS
	SELECT (firstName + ' ' + middleName + ' ' + lastName) AS fullName, 
		authorID from BookAuthors 
GO

CREATE OR ALTER VIEW PublisherWithCountryName AS
	SELECT BookPublishers.publisherID, BookPublishers.publisherName, Countries.countryName
		FROM BookPublishers INNER JOIN Countries ON BookPublishers.countryID = Countries.countryID
GO

CREATE OR ALTER VIEW BookDisplay AS 
	SELECT Books.bookID, books.title, AuthorNames.fullName AS author, BookPublishers.publisherName, 
	Books.publishYear, Books.ISBN, Books.edition, Books.genre
	FROM Books INNER JOIN AuthorNames ON Books.authorID = AuthorNames.authorID
				INNER JOIN BookPublishers ON BookPublishers.publisherID = Books.publisherID
GO

--DROPS
--DROP TABLE BookRentals,UserAccounts,BookBorrowers,BorrowerAddresses
--DROP TABLE LibraryIndex, BookStatuses
--DROP TABLE Books, BookAuthors, BookPublishers
--DROP TABLE Locations, Cities, Countries
--DROP VIEW PublisherWithCityName

