--Library User Related Procedures
CREATE OR ALTER PROCEDURE CreateUser(@first NVARCHAR(50), @middle NVARCHAR(50), @last NVARCHAR(50), 
	@mail NVARCHAR(255), @pass NVARCHAR(128), @countryID INT, @cityID NVARCHAR(60), @street NVARCHAR(100), @zip INT) AS
	INSERT INTO BorrowerAddresses VALUES (@countryID, @cityID, @street, @zip)
	INSERT INTO BookBorrowers(firstName,middleName,lastName,mail,addressID) VALUES (@first, @middle, @last, @mail, IDENT_CURRENT('BorrowerAddresses'))
	INSERT INTO UserAccounts VALUES (IDENT_CURRENT('BookBorrowers'), @mail, @pass)
GO

--Book Data Related Procedures
CREATE OR ALTER PROCEDURE AddAuthor (@authorFirstName NVARCHAR(MAX), @authorMiddleName NVARCHAR(MAX), 
	@authorLastName NVARCHAR(MAX)) AS
	INSERT INTO BookAuthors VALUES (@authorFirstName, @authorMiddleName, @authorLastName)
GO

CREATE OR ALTER PROCEDURE AddPublisher(@publisherName NVARCHAR(MAX), @cityID INT) AS
	INSERT INTO BookPublishers VALUES (@publisherName, @cityID)
GO

CREATE OR ALTER PROCEDURE AddBook(@authorID NVARCHAR(MAX), @publisherID NVARCHAR(MAX), @title NVARCHAR(MAX), @ISBN NVARCHAR(MAX), 
	@edition NVARCHAR(MAX), @genre NVARCHAR(MAX), @publishYr SMALLINT) AS
	INSERT INTO Books VALUES (@title, @authorID, @publisherID, @publishYr, @ISBN, @edition, @genre)
GO

--Location Related Procedures
CREATE OR ALTER PROCEDURE AddCity(@cityName NVARCHAR(MAX)) AS
	INSERT INTO Cities VALUES (@cityName)
GO

CREATE OR ALTER PROCEDURE AddCountry(@countryName NVARCHAR(MAX)) AS
	INSERT INTO Countries VALUES (@countryName )
GO

--Book Rental Related Procedures