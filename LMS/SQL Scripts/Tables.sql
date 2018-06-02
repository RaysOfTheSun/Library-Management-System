IF NOT EXISTS ( 
		SELECT * FROM INFORMATION_SCHEMA.TABLES
		WHERE TABLE_SCHEMA = 'dbo'
		AND TABLE_NAME = 'Countries')
	BEGIN
		CREATE TABLE Countries (
		countryID INT IDENTITY(1, 1) CONSTRAINT PK_COUNTRYID PRIMARY KEY NOT NULL,
		countryName NVARCHAR(55) NOT NULL)
	END

IF NOT EXISTS ( 
		SELECT * FROM INFORMATION_SCHEMA.TABLES
		WHERE TABLE_SCHEMA = 'dbo'
		AND TABLE_NAME = 'Cities')
	BEGIN
		CREATE TABLE Cities (
		cityID INT IDENTITY(1, 1) CONSTRAINT PK_CITYID PRIMARY KEY NOT NULL,
		cityName NVARCHAR(60) NOT NULL)
	END

IF NOT EXISTS ( 
		SELECT * FROM INFORMATION_SCHEMA.TABLES
		WHERE TABLE_SCHEMA = 'dbo'
		AND TABLE_NAME = 'BookAuthors')
	BEGIN
		CREATE TABLE BookAuthors (
		authorID INT IDENTITY(1, 1) CONSTRAINT PK_AUTHORID PRIMARY KEY NOT NULL,
		firstName NVARCHAR(50) NOT NULL,
		lastName NVARCHAR(50) NOT NULL)
	END

IF NOT EXISTS ( 
		SELECT * FROM INFORMATION_SCHEMA.TABLES
		WHERE TABLE_SCHEMA = 'dbo'
		AND TABLE_NAME = 'BookPublishers')
	BEGIN
		CREATE TABLE BookPublishers (
		publisherID INT IDENTITY(1, 1) CONSTRAINT PK_PUBLISHERID PRIMARY KEY NOT NULL,
		publisherName NVARCHAR(50) NOT NULL,
		countryID INT FOREIGN KEY REFERENCES Countries(countryID) NOT NULL)
	END

IF NOT EXISTS ( 
		SELECT * FROM INFORMATION_SCHEMA.TABLES
		WHERE TABLE_SCHEMA = 'dbo'
		AND TABLE_NAME = 'BorrowerAddresses')
	BEGIN
		CREATE TABLE BorrowerAddresses (
		addressID INT IDENTITY(1, 1) CONSTRAINT PK_ADDRESSID PRIMARY KEY NOT NULL,
		countryID INT FOREIGN KEY REFERENCES Countries(countryID) NOT NULL,
		cityID INT FOREIGN KEY REFERENCES Cities(cityID) NOT NULL,
		street NVARCHAR(100) NOT NULL,
		zipCode SMALLINT NOT NULL)
	END

IF NOT EXISTS ( 
		SELECT * FROM INFORMATION_SCHEMA.TABLES
		WHERE TABLE_SCHEMA = 'dbo'
		AND TABLE_NAME = 'BorrowerNumbers')
	BEGIN
		CREATE TABLE BorrowerNumbers (
			numberID INT IDENTITY(1, 1) CONSTRAINT PK_NUMBERID PRIMARY KEY NOT NULL,
			phoneNumber NVARCHAR(255) NULL)
	END

IF NOT EXISTS ( 
		SELECT * FROM INFORMATION_SCHEMA.TABLES
		WHERE TABLE_SCHEMA = 'dbo'
		AND TABLE_NAME = 'Books')
	BEGIN
		CREATE TABLE Books (
		bookID INT IDENTITY(1, 1) CONSTRAINT PK_BOOKID PRIMARY KEY NOT NULL,
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
		indexID INT IDENTITY(1, 1) CONSTRAINT PK_INDEXID PRIMARY KEY NOT NULL,
		bookID INT FOREIGN KEY REFERENCES Books(bookID) NOT NULL,
		callNumber NVARCHAR(20) NULL)
	END

IF NOT EXISTS ( 
		SELECT * FROM INFORMATION_SCHEMA.TABLES
		WHERE TABLE_SCHEMA = 'dbo'
		AND TABLE_NAME = 'BookBorrowers')
	BEGIN
		CREATE TABLE BookBorrowers (
		borrowerID INT IDENTITY(1, 1) CONSTRAINT PK_BORROWERID PRIMARY KEY NOT NULL,
		firstName NVARCHAR(50) NOT NULL,
		middleName NVARCHAR(50) NOT NULL,
		lastName NVARCHAR(50) NOT NULL,
		mail NVARCHAR(255) NOT NULL,
		addressID INT FOREIGN KEY REFERENCES BorrowerAddresses(addressID) NOT NULL,
		numberID INT FOREIGN KEY REFERENCES BorrowerNumbers(numberID) NOT NULL)
	END

IF NOT EXISTS ( 
		SELECT * FROM INFORMATION_SCHEMA.TABLES
		WHERE TABLE_SCHEMA = 'dbo'
		AND TABLE_NAME = 'UserAccounts')
	BEGIN
		CREATE TABLE UserAccounts (
		accountID INT IDENTITY(1, 1) CONSTRAINT PK_ACCOUNTID PRIMARY KEY NOT NULL,
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
		rentalID INT IDENTITY(1, 1) CONSTRAINT PK_RENALID PRIMARY KEY NOT NULL,
		bookID INT FOREIGN KEY REFERENCES Books(bookID) NOT NULL,
		borrowerID INT FOREIGN KEY REFERENCES BookBorrowers(borrowerID) NOT NULL,
		rentalDate DATE NOT NULL,
		returnDate DATE NOT NULL)
	END

IF NOT EXISTS ( 
		SELECT * FROM INFORMATION_SCHEMA.TABLES
		WHERE TABLE_SCHEMA = 'dbo'
		AND TABLE_NAME = 'RentalRequests')
	BEGIN
		CREATE TABLE RentalRequests (
		rentalID INT IDENTITY(1, 1) CONSTRAINT PK_REQUESTID PRIMARY KEY NOT NULL,
		bookID INT FOREIGN KEY REFERENCES Books(bookID) NOT NULL,
		borrowerID INT FOREIGN KEY REFERENCES BookBorrowers(borrowerID) NOT NULL,
		rentalDate DATE NOT NULL,
		returnDate DATE NOT NULL)
	END

IF NOT EXISTS ( 
		SELECT * FROM INFORMATION_SCHEMA.TABLES
		WHERE TABLE_SCHEMA = 'dbo'
		AND TABLE_NAME = 'BookStatuses')
	BEGIN
		CREATE TABLE BookStatuses (
		statusID INT IDENTITY(1, 1) CONSTRAINT PK_STATUSID PRIMARY KEY NOT NULL,
		bookID INT FOREIGN KEY REFERENCES Books(bookID) NOT NULL,
		bookCount SMALLINT NOT NULL)
	END

IF NOT EXISTS ( 
		SELECT * FROM INFORMATION_SCHEMA.TABLES
		WHERE TABLE_SCHEMA = 'dbo'
		AND TABLE_NAME = 'Locations')
	BEGIN
		CREATE TABLE Locations (
		locationID INT IDENTITY(1, 1) CONSTRAINT PK_LOCATIONID PRIMARY KEY NOT NULL,
		countryID INT FOREIGN KEY REFERENCES Countries(countryID),
		cityID INT FOREIGN KEY REFERENCES cities(cityID))
	END
GO

CREATE OR ALTER VIEW BorrowerAccounts AS
	SELECT BookBorrowers.borrowerID, (BookBorrowers.firstName + ' ' 
		+ BookBorrowers.middleName + ' ' + BookBorrowers.lastName) AS accountOwner,
		BookBorrowers.mail AS userName, UserAccounts.[password] AS accountPassword
		FROM BookBorrowers	INNER JOIN UserAccounts ON UserAccounts.owner = BookBorrowers.borrowerID
GO

CREATE OR ALTER VIEW AuthorNames AS
	SELECT (authors.firstName + ' ' + authors.lastName) AS fullName, 
		authorID from BookAuthors authors
GO

CREATE OR ALTER VIEW PublisherWithCountryName AS
	SELECT BookPublishers.publisherID, BookPublishers.publisherName, Countries.countryName
		FROM BookPublishers INNER JOIN Countries ON BookPublishers.countryID = Countries.countryID
GO

CREATE OR ALTER VIEW BookDisplay WITH SCHEMABINDING AS 
	SELECT book.bookID, book.title, (authors.firstName + ' ' + authors.lastName) AS author, 
	publishers.publisherName, book.publishYear, book.ISBN, book.edition, book.genre, statuses.bookCount
	FROM dbo.Books book INNER JOIN dbo.BookAuthors authors ON book.authorID = authors.authorID
				INNER JOIN dbo.BookPublishers publishers ON publishers.publisherID = book.publisherID
				INNER JOIN dbo.BookStatuses statuses ON book.bookID = statuses.bookID
	GO
	CREATE UNIQUE CLUSTERED INDEX IDX_bookID ON BookDisplay(bookID)
	CREATE NONCLUSTERED INDEX IDX_displayIndex ON BookDisplay(bookID)
GO

CREATE OR ALTER VIEW completeBorrowerData AS
	SELECT BookBorrowers.borrowerID, BookBorrowers.firstName, BookBorrowers.middleName, BookBorrowers.lastName,
		BookBorrowers.mail, Countries.countryName, Cities.cityName, BorrowerAddresses.street, BorrowerAddresses.zipCode, 
		BookBorrowers.addressID
		FROM BookBorrowers
			INNER JOIN BorrowerAddresses ON BorrowerAddresses.addressID = BookBorrowers.addressID
			INNER JOIN Countries ON Countries.countryID = BorrowerAddresses.countryID
			INNER JOIN Cities ON Cities.cityID = BorrowerAddresses.cityID
GO

CREATE OR ALTER VIEW completeBorrowerDataB AS
	SELECT BookBorrowers.borrowerID, BookBorrowers.firstName, BookBorrowers.middleName, BookBorrowers.lastName,
		BookBorrowers.mail, Countries.countryID, Cities.cityID, BorrowerAddresses.street, BorrowerAddresses.zipCode, 
		BookBorrowers.addressID
		FROM BookBorrowers
			INNER JOIN BorrowerAddresses ON BorrowerAddresses.addressID = BookBorrowers.addressID
			INNER JOIN Countries ON Countries.countryID = BorrowerAddresses.countryID
			INNER JOIN Cities ON Cities.cityID = BorrowerAddresses.cityID
GO

CREATE OR ALTER VIEW RentalRequestDetails AS
	SELECT RentalRequests.rentalID, BorrowerAccounts.accountOwner, Books.title, AuthorNames.fullName, 
		Books.edition, Books.ISBN, rentalDate, returnDate FROM RentalRequests
		INNER JOIN Books ON RentalRequests.bookID = Books.bookID
		INNER JOIN AuthorNames ON AuthorNames.authorID = Books.authorID
		INNER JOIN BorrowerAccounts ON BorrowerAccounts.borrowerID = RentalRequests.borrowerID
GO

CREATE OR ALTER VIEW RentalDetails AS
	SELECT BookRentals.rentalID, BookRentals.borrowerID, BorrowerAccounts.accountOwner, 
		Books.title, AuthorNames.fullName, Books.edition, Books.ISBN, rentalDate, returnDate FROM BookRentals
		INNER JOIN Books ON BookRentals.bookID = Books.bookID
		INNER JOIN AuthorNames ON AuthorNames.authorID = Books.authorID
		INNER JOIN BorrowerAccounts ON BorrowerAccounts.borrowerID = BookRentals.borrowerID
GO

CREATE OR ALTER VIEW EditBookView AS
	SELECT Books.bookID, Books.title, Books.authorID, Books.publisherID, Books.publishYear, Books.ISBN,
		Books.edition, Books.genre, BookStatuses.bookCount FROM Books
		INNER JOIN BookStatuses ON Books.bookID = BookStatuses.bookID
GO

CREATE OR ALTER VIEW RentedBooksWithAuthorID AS 
	SELECT BookRentals.bookID, BookAuthors.authorID, BookPublishers.publisherID FROM BookRentals
	INNER JOIN Books ON BookRentals.bookID = Books.bookID
	INNER JOIN BookAuthors ON Books.authorID = BookAuthors.authorID
	INNER JOIN BookPublishers ON Books.publisherID = BookPublishers.publisherID
GO

CREATE OR ALTER VIEW LibraryIndexNamed WITH SCHEMABINDING AS 
	SELECT libIndex.indexID, book.bookID, book.title, (authors.firstName + ' ' + authors.lastName) AS fullName, 
		book.genre, libIndex.callNumber
		FROM dbo.LibraryIndex libIndex
		INNER JOIN dbo.Books book ON book.bookID = libIndex.bookID
		INNER JOIN dbo.BookAuthors authors ON book.authorID = authors.authorID
	GO
	CREATE UNIQUE CLUSTERED INDEX IDX_indexID ON LibraryIndexNamed(indexID)
	CREATE NONCLUSTERED INDEX IDX_displayIndex ON LibraryIndexNamed(indexID)
GO

--SEARCHING

-- BOOKS
IF NOT OBJECTPROPERTY ( object_id('BookDisplay'), 'TableHasActiveFulltextIndex') = 1 
BEGIN
	CREATE FULLTEXT CATALOG BookCatalog
	CREATE FULLTEXT INDEX ON BookDisplay (
		title LANGUAGE 1033,
		author LANGUAGE 1033,
		publisherName LANGUAGE 1033,
		genre LANGUAGE 1033,
		ISBN LANGUAGE 1033
	)
	KEY INDEX IDX_bookID ON BookCatalog
		WITH CHANGE_TRACKING AUTO,
		STOPLIST = OFF
END

-- CALL NUMBERS
IF NOT OBJECTPROPERTY ( object_id('LibraryIndexNamed'), 'TableHasActiveFulltextIndex') = 1 
BEGIN
	CREATE FULLTEXT CATALOG CallNumberCatalog
	CREATE FULLTEXT INDEX ON LibraryIndexNamed (
		callNumber LANGUAGE 1033
	)
	KEY INDEX IDX_indexID ON CallNumberCatalog
		WITH CHANGE_TRACKING AUTO,
		STOPLIST = OFF
END

--DROPS
--DROP TABLE BookImages
--DROP TABLE RentalRequests
--DROP TABLE BookRentals
--DROP TABLE UserAccounts
--DROP TABLE BookBorrowers
--DROP TABLE BorrowerAddresses
--DROP VIEW LibraryIndexNamed, BookDisplay, AuthorNames
--DROP TABLE LibraryIndex, BookStatuses
--DROP TABLE Books, BookAuthors, BookPublishers
--DROP TABLE Locations, Cities, Countries
--DROP VIEW PublisherWithCityName
GO
