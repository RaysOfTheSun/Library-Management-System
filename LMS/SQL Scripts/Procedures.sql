--Library User Related Procedures
CREATE OR ALTER PROCEDURE CreateUser(@first NVARCHAR(50), @middle NVARCHAR(50), @last NVARCHAR(50), 
	@mail NVARCHAR(255), @pass NVARCHAR(128), @countryID INT, @cityID NVARCHAR(60), @street NVARCHAR(100), @zip INT) AS
	BEGIN TRAN 
		BEGIN TRY
			INSERT INTO BorrowerAddresses VALUES (@countryID, @cityID, @street, @zip)
			INSERT INTO BookBorrowers(firstName,middleName,lastName,mail,addressID) VALUES (@first, @middle, @last, @mail, IDENT_CURRENT('BorrowerAddresses'))
			INSERT INTO UserAccounts VALUES (IDENT_CURRENT('BookBorrowers'), @mail, @pass)
			COMMIT TRAN
		END TRY
		BEGIN CATCH
			ROLLBACK TRAN
		END CATCH
GO

--Book Data Related Procedures
CREATE OR ALTER PROCEDURE AddAuthor (@first NVARCHAR(50), @middle NVARCHAR(50), @last NVARCHAR(50)) AS
	INSERT INTO BookAuthors VALUES (@first, @middle, @last)
GO

CREATE OR ALTER PROCEDURE AddPublisher(@publisherName NVARCHAR(70), @cityID INT) AS
	INSERT INTO BookPublishers VALUES (@publisherName, @cityID)
GO

CREATE OR ALTER PROCEDURE UpdatePublisher(@publisherName NVARCHAR(70), @cityID INT, @id INT) AS
	UPDATE BookPublishers SET publisherName = @publisherName, city = @cityID WHERE publisherID = @id
GO

CREATE OR ALTER PROCEDURE UpdateAuthor(@first NVARCHAR(50), @middle NVARCHAR(50), @last NVARCHAR(50), @id INT) AS
	UPDATE BookAuthors SET firstName = @first, middleName = @middle, lastName = @last  WHERE authorID = @id
GO

CREATE OR ALTER PROCEDURE UpdateBook(@authorID INT, @publisherID INT, @title NVARCHAR(100), @ISBN NVARCHAR(20), 
	@edition INT, @genre NVARCHAR(20), @publishYr SMALLINT, @id INT) AS
	UPDATE Books SET title = @title, authorID = @authorID, publisherID = @publisherID, 
		publishYear = @publishYr, ISBN = @ISBN, edition = @edition, genre = @genre WHERE bookID = @id
GO

CREATE OR ALTER PROCEDURE AddBook(@authorID INT, @publisherID INT, @title NVARCHAR(100), @ISBN NVARCHAR(20), 
	@edition INT, @genre NVARCHAR(20), @publishYr SMALLINT) AS
	INSERT INTO Books VALUES (@title, @authorID, @publisherID, @publishYr, @ISBN, @edition, @genre)
GO

--Location Related Procedures
CREATE OR ALTER PROCEDURE AddCity(@cityName NVARCHAR(MAX)) AS
	INSERT INTO Cities VALUES (@cityName)
GO

CREATE OR ALTER PROCEDURE AddCountry(@countryName NVARCHAR(MAX)) AS
	INSERT INTO Countries VALUES (@countryName )
GO

select * from BookAuthors
select * from BookBorrowers
select * from BookPublishers

SELECT BookBorrowers.firstName, BookBorrowers.middleName, 
	BookBorrowers.lastName, BorrowerAddresses.zipCode, Countries.countryName 
	from BookBorrowers
	INNER JOIN BorrowerAddresses ON BookBorrowers.borrowerID = BorrowerAddresses.addressID 
	INNER JOIN Countries ON BorrowerAddresses.countryID = Countries.countryID
--Book Rental Related Procedures