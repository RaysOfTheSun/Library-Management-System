--Library User Related Procedures
CREATE OR ALTER PROCEDURE CreateUser(@first NVARCHAR(50), @middle NVARCHAR(50), @last NVARCHAR(50), 
	@mail NVARCHAR(255), @pass NVARCHAR(128), @countryID INT, @cityID INT, @street NVARCHAR(100), @zip SMALLINT) AS
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

CREATE OR ALTER PROCEDURE UpdateUserDetails (@first NVARCHAR(50), @middle NVARCHAR(50), @last NVARCHAR(50),
	@mail NVARCHAR(255), @countryID INT, @cityID INT, @street NVARCHAR(100), @zip SMALLINT, @addressID INT, @bID INT) AS
		UPDATE BookBorrowers SET firstName = @first, middleName = @middle, lastName = @last,
		mail = @mail WHERE borrowerID = @bID
		UPDATE BorrowerAddresses SET countryID = @countryID, cityID = @cityID, zipCode = @zip, street = @street
			WHERE addressID = @addressID
GO

--select * from completeBorrowerData
--SELECT * FROM UserAccounts
--SELECT * FROM BookBorrowers

CREATE OR ALTER PROCEDURE DeleteUserDetails (@bID INT) AS
	DECLARE @addressID INT
	SELECT @addressID = addressID FROM BookBorrowers WHERE borrowerID = @bID
	DELETE FROM BookRentals WHERE borrowerID = @bID
	DELETE FROM UserAccounts WHERE [owner] = @bID
	DELETE FROM BookBorrowers WHERE borrowerID = @bID
	DELETE FROM BorrowerAddresses WHERE addressID = @addressID
GO

--SELECT * FROM UserAccounts
CREATE OR ALTER PROCEDURE UpdateUserAccount (@userName NVARCHAR(255), @pass NVARCHAR(128), @id INT) AS
	UPDATE UserAccounts SET username = @userName, [password] = @pass WHERE [owner] = @id
GO

CREATE OR ALTER PROCEDURE DeleteUserAccount (@id INT) AS
	DELETE FROM UserAccounts WHERE [owner] = @id
GO

--Book Data Related Procedures
CREATE OR ALTER PROCEDURE AddAuthor (@first NVARCHAR(50), @middle NVARCHAR(50), @last NVARCHAR(50)) AS
	INSERT INTO BookAuthors VALUES (@first, @middle, @last)
GO

CREATE OR ALTER PROCEDURE AddPublisher(@publisherName NVARCHAR(70), @countryID INT) AS
	INSERT INTO BookPublishers VALUES (@publisherName, @countryID)
GO

CREATE OR ALTER PROCEDURE UpdatePublisher(@publisherName NVARCHAR(70), @countryID INT, @id INT) AS
	UPDATE BookPublishers SET publisherName = @publisherName, countryID = @countryID WHERE publisherID = @id
GO

CREATE OR ALTER PROCEDURE UpdateAuthor(@first NVARCHAR(50), @middle NVARCHAR(50), @last NVARCHAR(50), @id INT) AS
	UPDATE BookAuthors SET firstName = @first, middleName = @middle, lastName = @last  WHERE authorID = @id
GO

CREATE OR ALTER PROCEDURE DeleteAuthor(@id INT) AS 
	DELETE FROM Books WHERE authorID = @id
	DELETE FROM BookAuthors WHERE authorID = @id
GO

CREATE OR ALTER PROCEDURE DeletePublisher(@id INT) AS
	DELETE Books WHERE publisherID = @id
	DELETE FROM BookPublishers WHERE publisherID = @id
GO

CREATE OR ALTER PROCEDURE DeleteBook(@id INT) AS
	DELETE FROM Books WHERE bookID = @id
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

SELECT * FROM BookDisplay
SELECT * FROM BookBorrowers
EXEC DeletePublisher 1

select * from completeBorrowerData
select * from BorrowerAccounts

--Book Rental Related Procedures

SELECT * FROM BorrowerAccounts

SELECT * FROM BookDisplay