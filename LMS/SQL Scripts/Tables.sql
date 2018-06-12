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

CREATE OR ALTER VIEW BorrowerAccounts WITH SCHEMABINDING AS
	SELECT borrower.borrowerID, (borrower.firstName + ' ' 
		+ borrower.middleName + ' ' + borrower.lastName) AS accountOwner,
		borrower.mail AS userName, account.[password] AS accountPassword
		FROM dbo.BookBorrowers borrower	INNER JOIN dbo.UserAccounts account ON account.owner = borrower.borrowerID
GO

CREATE OR ALTER VIEW AuthorNames WITH SCHEMABINDING AS
	SELECT (authors.firstName + ' ' + authors.lastName) AS fullName, 
		authorID from dbo.BookAuthors authors
GO

CREATE OR ALTER VIEW PublisherWithCountryName WITH SCHEMABINDING AS
	SELECT publisher.publisherID, publisher.publisherName, country.countryName
		FROM dbo.BookPublishers publisher INNER JOIN dbo.Countries country ON publisher.countryID = country.countryID
	GO

	CREATE UNIQUE CLUSTERED INDEX IDX_pubID ON PublisherWithCountryName(publisherID)
	CREATE NONCLUSTERED INDEX IDX_displayPubIndex ON PublisherWithCountryName(publisherID)
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
		BookBorrowers.mail, BorrowerNumbers.phoneNumber, Countries.countryName, Cities.cityName, 
		BorrowerAddresses.street, BorrowerAddresses.zipCode, BookBorrowers.addressID
		FROM BookBorrowers
			INNER JOIN BorrowerAddresses ON BorrowerAddresses.addressID = BookBorrowers.addressID
			INNER JOIN BorrowerNumbers ON BorrowerNumbers.numberID = BookBorrowers.numberID
			INNER JOIN Countries ON Countries.countryID = BorrowerAddresses.countryID
			INNER JOIN Cities ON Cities.cityID = BorrowerAddresses.cityID
GO

CREATE OR ALTER VIEW completeBorrowerDataB AS
	SELECT BookBorrowers.borrowerID, BookBorrowers.firstName, BookBorrowers.middleName, BookBorrowers.lastName,
		BookBorrowers.mail, BorrowerNumbers.phoneNumber, BorrowerNumbers.numberID, Countries.countryID, Cities.cityID, BorrowerAddresses.street, BorrowerAddresses.zipCode, 
		BookBorrowers.addressID
		FROM BookBorrowers
			INNER JOIN BorrowerAddresses ON BorrowerAddresses.addressID = BookBorrowers.addressID
			INNER JOIN BorrowerNumbers ON BorrowerNumbers.numberID = BookBorrowers.numberID
			INNER JOIN Countries ON Countries.countryID = BorrowerAddresses.countryID
			INNER JOIN Cities ON Cities.cityID = BorrowerAddresses.cityID
GO

CREATE OR ALTER VIEW RentalRequestDetails WITH SCHEMABINDING AS
	SELECT request.rentalID, borrower.borrowerID, (borrower.firstName + ' ' 
		+ borrower.middleName + ' ' + borrower.lastName) AS accountOwner, book.title, 
		(authors.firstName + ' ' + authors.lastName) AS fullName, book.edition, book.ISBN, 
		rentalDate, returnDate FROM dbo.RentalRequests request
		INNER JOIN dbo.Books book ON request.bookID = book.bookID
		INNER JOIN dbo.BookAuthors authors ON book.authorID = authors.authorID
		INNER JOIN dbo.BookBorrowers borrower ON borrower.borrowerID = request.borrowerID

	GO
	CREATE UNIQUE CLUSTERED INDEX IDX_requestID ON RentalRequestDetails(rentalID)
	CREATE NONCLUSTERED INDEX IDX_displayRequestID ON RentalRequestDetails(rentalID)
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

-- AUTHORS
IF NOT OBJECTPROPERTY ( object_id('BookAuthors'), 'TableHasActiveFulltextIndex') = 1 
BEGIN
	CREATE FULLTEXT CATALOG AuthorCatalog
	CREATE FULLTEXT INDEX ON BookAuthors (
		firstName LANGUAGE 1033,
		lastName LANGUAGE 1033
	)
	KEY INDEX PK_AUTHORID ON AuthorCatalog
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

IF NOT OBJECTPROPERTY ( object_id('PublisherWithCountryName'), 'TableHasActiveFulltextIndex') = 1 
BEGIN
	CREATE FULLTEXT CATALOG PublisherCatalog
	CREATE FULLTEXT INDEX ON PublisherWithCountryName (
		publisherName LANGUAGE 1033,
		countryName LANGUAGE 1033
	)
	KEY INDEX IDX_pubID ON CallNumberCatalog
		WITH CHANGE_TRACKING AUTO,
		STOPLIST = OFF
END

SELECT * FROM RentalRequestDetails

IF NOT OBJECTPROPERTY ( object_id('RentalRequestDetails'), 'TableHasActiveFulltextIndex') = 1 
BEGIN
	CREATE FULLTEXT CATALOG RentalRequestCatalog
	CREATE FULLTEXT INDEX ON RentalRequestDetails (
		accountOwner LANGUAGE 1033,
		title LANGUAGE 1033,
		fullName LANGUAGE 1033,
		ISBN LANGUAGE 1033
	)
	KEY INDEX IDX_requestID ON RentalRequestCatalog
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
DROP VIEW RentalRequestDetails
DROP VIEW RentalDetails
GO
