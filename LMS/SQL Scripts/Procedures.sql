--Library User Related Procedures
CREATE OR ALTER PROCEDURE CreateUser(@first NVARCHAR(50), @middle NVARCHAR(50), @last NVARCHAR(50), 
	@mail NVARCHAR(255), @pass NVARCHAR(128), @countryID INT, @cityID INT, @street NVARCHAR(100), @zip SMALLINT,
	@number NVARCHAR(255)) AS
	BEGIN TRAN 
		BEGIN TRY
			INSERT INTO BorrowerAddresses VALUES (@countryID, @cityID, @street, @zip)
			INSERT INTO BorrowerNumbers VALUES (@number)
			INSERT INTO BookBorrowers(firstName,middleName,lastName,mail,addressID, numberID) VALUES (@first, @middle, @last, 
				@mail, IDENT_CURRENT('BorrowerAddresses'), IDENT_CURRENT('BorrowerNumbers'))
			INSERT INTO UserAccounts VALUES (IDENT_CURRENT('BookBorrowers'), @mail, @pass)
			COMMIT TRAN
		END TRY
		BEGIN CATCH
			ROLLBACK TRAN
		END CATCH
GO

CREATE OR ALTER PROCEDURE UpdateUserDetails (@first NVARCHAR(50), @middle NVARCHAR(50), @last NVARCHAR(50),
	@mail NVARCHAR(255), @number NVARCHAR(255), @countryID INT, @cityID INT, @street NVARCHAR(100), 
	@zip SMALLINT, @addressID INT, @bID INT, @nID INT) AS
	BEGIN TRAN
		BEGIN TRY
			UPDATE BookBorrowers SET firstName = @first, middleName = @middle, lastName = @last,
			mail = @mail WHERE borrowerID = @bID
			UPDATE BorrowerAddresses SET countryID = @countryID, cityID = @cityID, zipCode = @zip, street = @street
				WHERE addressID = @addressID
			UPDATE BorrowerNumbers SET phoneNumber = @number WHERE numberID = @nID
			COMMIT TRAN
		END TRY
		BEGIN CATCH
			ROLLBACK TRAN
		END CATCH
GO

CREATE OR ALTER PROCEDURE DeleteUserDetails (@bID INT) AS
	BEGIN TRAN
		BEGIN TRY
			DECLARE @addressID INT
			SELECT @addressID = addressID FROM BookBorrowers WHERE borrowerID = @bID
			DELETE FROM BookRentals WHERE borrowerID = @bID
			DELETE FROM UserAccounts WHERE [owner] = @bID
			DELETE FROM BookBorrowers WHERE borrowerID = @bID
			DELETE FROM BorrowerAddresses WHERE addressID = @addressID
			COMMIT TRAN
		END TRY
		BEGIN CATCH
			ROLLBACK TRAN
		END CATCH
GO

CREATE OR ALTER PROCEDURE UpdateUserAccount (@userName NVARCHAR(255), @pass NVARCHAR(128), @id INT) AS
	BEGIN TRAN
		BEGIN TRY
			UPDATE UserAccounts SET username = @userName, [password] = @pass WHERE [owner] = @id
			COMMIT TRAN
		END TRY
		BEGIN CATCH
			ROLLBACK TRAN
		END CATCH
GO

CREATE OR ALTER PROCEDURE DeleteUserAccount (@id INT) AS
	BEGIN TRAN
		BEGIN TRY
			DELETE FROM UserAccounts WHERE [owner] = @id
			COMMIT TRAN
		END TRY
		BEGIN CATCH
			ROLLBACK TRAN
		END CATCH
GO

--Book Data Related Procedures
CREATE OR ALTER PROCEDURE AddAuthor (@first NVARCHAR(50), @last NVARCHAR(50)) AS
	BEGIN TRAN
		BEGIN TRY
			INSERT INTO BookAuthors VALUES (@first, @last)
			COMMIT TRAN
		END TRY
		BEGIN CATCH
			ROLLBACK TRAN
		END CATCH
GO

CREATE OR ALTER PROCEDURE AddPublisher(@publisherName NVARCHAR(70), @countryID INT) AS
	BEGIN TRAN
		BEGIN TRY
			INSERT INTO BookPublishers VALUES (@publisherName, @countryID)
			COMMIT TRAN
		END TRY
		BEGIN CATCH
			ROLLBACK TRAN
		END CATCH
GO

CREATE OR ALTER PROCEDURE UpdatePublisher(@publisherName NVARCHAR(70), @countryID INT, @id INT) AS
	BEGIN TRAN
		BEGIN TRY
			UPDATE BookPublishers SET publisherName = @publisherName, countryID = @countryID 
				WHERE publisherID = @id
			COMMIT TRAN
		END TRY
		BEGIN CATCH
			ROLLBACK TRAN
		END CATCH
GO

CREATE OR ALTER PROCEDURE UpdateAuthor(@first NVARCHAR(50), @last NVARCHAR(50), @id INT) AS
	BEGIN TRAN
		BEGIN TRY
			UPDATE BookAuthors SET firstName = @first, lastName = @last  WHERE authorID = @id
			COMMIT TRAN
		END TRY
		BEGIN CATCH
			ROLLBACK TRAN
		END CATCH
GO

CREATE OR ALTER PROCEDURE DeleteAuthor(@id INT) AS 
	BEGIN TRAN
		BEGIN TRY
			DELETE FROM LibraryIndex WHERE bookID IN 
				(SELECT bookID FROM Books WHERE authorID = @id)
			DELETE FROM BookStatuses WHERE bookID IN 
				(SELECT bookID FROM Books WHERE authorID = @id)
			DELETE FROM Books WHERE authorID = @id
			DELETE FROM BookAuthors WHERE authorID = @id
			COMMIT TRAN
		END TRY
		BEGIN CATCH
			ROLLBACK TRAN
		END CATCH
GO

CREATE OR ALTER PROCEDURE DeletePublisher(@id INT) AS
	BEGIN TRAN
		BEGIN TRY
			DELETE FROM LibraryIndex WHERE bookID IN 
				(SELECT bookID FROM Books WHERE publisherID = @id)
			DELETE FROM BookStatuses WHERE bookID IN 
				(SELECT bookID FROM Books WHERE publisherID = @id)
			DELETE Books WHERE publisherID = @id
			DELETE FROM BookPublishers WHERE publisherID = @id
			COMMIT TRAN
		END TRY
		BEGIN CATCH
			ROLLBACK TRAN
		END CATCH
GO

CREATE OR ALTER PROCEDURE DeleteBook(@id INT) AS
	BEGIN TRAN
		BEGIN TRY
			DELETE FROM BookStatuses WHERE bookID = @id
			DELETE FROM LibraryIndex WHERE bookID = @id
			DELETE FROM BookSynopses WHERE bookID = @id
			DELETE FROM Books WHERE bookID = @id
			COMMIT TRAN
		END TRY
		BEGIN CATCH
			ROLLBACK TRAN
		END CATCH
GO

CREATE OR ALTER PROCEDURE UpdateBook(@authorID INT, @publisherID INT, @title NVARCHAR(100), @ISBN NVARCHAR(20), 
	@edition INT, @genre NVARCHAR(20), @publishYr SMALLINT, @bookCount INT, @synopsis NVARCHAR(MAX), @id INT) AS
	BEGIN TRAN
		BEGIN TRY
			UPDATE Books SET title = @title, authorID = @authorID, publisherID = @publisherID, 
				publishYear = @publishYr, ISBN = @ISBN, edition = @edition, genre = @genre WHERE bookID = @id
			UPDATE BookStatuses SET bookCount = @bookCount WHERE bookID = @id
			UPDATE BookSynopses SET bookSynopsis = @synopsis WHERE bookID = @id
			COMMIT TRAN
		END TRY
		BEGIN CATCH
			ROLLBACK TRAN
		END CATCH
GO

CREATE OR ALTER PROCEDURE AddBook(@authorID INT, @publisherID INT, @title NVARCHAR(100), @ISBN NVARCHAR(20), 
	@edition INT, @genre NVARCHAR(20), @publishYr SMALLINT, @bookCount SMALLINT, @synopsis NVARCHAR(MAX)) AS
		BEGIN TRAN
		BEGIN TRY
			INSERT INTO Books VALUES (@title, @authorID, @publisherID, @publishYr, @ISBN, @edition, @genre)
			INSERT INTO BookStatuses VALUES (IDENT_CURRENT('Books'), @bookCount)
			INSERT INTO LibraryIndex (bookID) VALUES (IDENT_CURRENT('Books'))
			INSERT INTO BookSynopses VALUES (IDENT_CURRENT('Books'), @synopsis)
			COMMIT TRAN
		END TRY
		BEGIN CATCH
			ROLLBACK TRAN
		END CATCH
GO

CREATE OR ALTER PROCEDURE UpdateCallNumber (@indexID INT, @callNumber NVARCHAR(20)) AS
	BEGIN TRAN
		BEGIN TRY
			UPDATE LibraryIndex SET callNumber = @callNumber WHERE indexID = @indexID
			COMMIT TRAN
		END TRY
		BEGIN CATCH
			ROLLBACK TRAN
		END CATCH
GO

--Location Related Procedures
CREATE OR ALTER PROCEDURE AddCity(@cityName NVARCHAR(MAX)) AS
	BEGIN TRAN
		BEGIN TRY
			INSERT INTO Cities VALUES (@cityName)
			COMMIT TRAN
		END TRY
		BEGIN CATCH
			ROLLBACK TRAN
		END CATCH
GO

CREATE OR ALTER PROCEDURE AddCountry(@countryName NVARCHAR(MAX)) AS
	BEGIN TRAN
		BEGIN TRY
			INSERT INTO Countries VALUES (@countryName )
			COMMIT TRAN
		END TRY
		BEGIN CATCH
			ROLLBACK TRAN
		END CATCH
GO

--Book Rental Related Procedures
CREATE OR ALTER PROCEDURE AddRequest(@bookID INT, @borrowerID INT) AS
	BEGIN TRAN
		BEGIN TRY
			DECLARE @count INT
			SELECT @count = bookCount FROM BookStatuses WHERE bookID = @bookID
			IF (@count > 0) 
			BEGIN
				INSERT INTO RentalRequests VALUES (@bookID, @borrowerID,GETDATE(),  DATEADD(day, 14, GETDATE()))
				UPDATE BookStatuses SET bookCount = bookCount - 1 WHERE bookID = @bookID
				COMMIT TRAN
			END
			ELSE
				ROLLBACK TRAN
		END TRY
		BEGIN CATCH
			ROLLBACK TRAN
		END CATCH
GO

CREATE OR ALTER PROCEDURE DeleteRequest(@rentalID INT) AS
	BEGIN TRAN
		BEGIN TRY
			DECLARE @bookID INT
			SELECT @bookID = bookID FROM RentalRequests WHERE rentalID = @rentalID
			DELETE FROM RentalRequests WHERE rentalID = @rentalID
			UPDATE BookStatuses SET bookCount = (bookCount + 1) WHERE bookID = @bookID
			COMMIT TRAN
		END TRY
		BEGIN CATCH
			ROLLBACK TRAN
		END CATCH
GO

CREATE OR ALTER PROCEDURE AddRental(@requestID INT) AS
	BEGIN TRAN
		BEGIN TRY
			DECLARE @borrowerID INT
			DECLARE @bookID INT
			DECLARE @rentalDate DATE
			DECLARE @returnDate DATE
			SELECT @borrowerID = borrowerID FROM RentalRequests WHERE rentalID = @requestID
			SELECT @bookID = bookID FROM RentalRequests WHERE rentalID = @requestID
			SELECT @returnDate = returnDate FROM RentalRequests WHERE rentalID = @requestID
			SELECT @rentalDate = rentalDate FROM RentalRequests WHERE rentalID = @requestID
			INSERT INTO BookRentals VALUES ( @bookID, @borrowerID, @rentalDate, @returnDate)
			DELETE FROM RentalRequests WHERE rentalID = @requestID
			COMMIT TRAN
		END TRY
		BEGIN CATCH
			ROLLBACK TRAN
		END CATCH
GO

CREATE OR ALTER PROCEDURE DeleteRentalDetails(@rentalID INT) AS
	BEGIN TRAN
		BEGIN TRY
			DECLARE @bookID INT
			SELECT @bookID = bookID FROM BookRentals WHERE rentalID = @rentalID
			DELETE FROM BookRentals WHERE rentalID = @rentalID
			UPDATE BookStatuses SET bookCount = bookCount + 1 WHERE bookID = @bookID
			COMMIT TRAN
		END TRY
		BEGIN CATCH
			ROLLBACK TRAN
		END CATCH
GO

CREATE OR ALTER PROCEDURE ExtendRetal(@rentalID INT, @date DATE) AS
	BEGIN TRAN
		BEGIN TRY
			UPDATE BookRentals SET returnDate = @date WHERE rentalID = @rentalID
			COMMIT TRAN
		END TRY
		BEGIN CATCH
			ROLLBACK TRAN
		END CATCH
