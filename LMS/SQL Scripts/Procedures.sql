-- Library User Related Procedures
CREATE OR ALTER PROCEDURE CreateUser(@first NVARCHAR(MAX), @middle NVARCHAR(MAX), @last NVARCHAR(MAX), 
	@mail NVARCHAR(MAX), @pass NVARCHAR(MAX), @login NVARCHAR(MAX), @country INT, @city NVARCHAR(MAX), @street NVARCHAR(MAX), @zip INT) AS
	INSERT INTO BorrowerAddresses VALUES (@country, @city, @street, @zip)
	INSERT INTO BookBorrowers(firstName,middleName,lastName,mail,addressID) VALUES (@first, @middle, @last, @mail, IDENT_CURRENT('BorrowerAddresses'))
	INSERT INTO UserAccounts VALUES (IDENT_CURRENT('BookBorrowers'), @login, @pass)
GO

-- Book Related Procedures
CREATE OR ALTER PROCEDURE AddAuthor (@authorFirstName NVARCHAR(MAX), @authorMiddleName NVARCHAR(MAX), 
	@authorLastName NVARCHAR(MAX)) AS
	INSERT INTO BookAuthors VALUES (@authorFirstName, @authorMiddleName, @authorLastName)
GO

CREATE OR ALTER PROCEDURE AddPublisher(@publisherName NVARCHAR(MAX), @cityID INT) AS
	INSERT INTO BookPublishers VALUES (@publisherName, @cityID)
GO

CREATE OR ALTER PROCEDURE AddBook(@authorID NVARCHAR(MAX), @publisherID NVARCHAR(MAX), @title NVARCHAR(MAX), @ISBN NVARCHAR(MAX), 
	@callNum NVARCHAR(MAX), @edition NVARCHAR(MAX), @genre NVARCHAR(MAX), @publishYr SMALLINT) AS
	INSERT INTO Books VALUES (@title, @authorID, @publisherID, @publishYr, @ISBN, @callNum, @edition, @genre)
GO

-- Location Related Procedures
CREATE OR ALTER PROCEDURE AddCity(@cityName NVARCHAR(MAX)) AS
	INSERT INTO Cities VALUES (@cityName)
GO

CREATE OR ALTER PROCEDURE AddCountry(@cityName NVARCHAR(MAX)) AS
	INSERT INTO Cities VALUES (@cityName)
GO


