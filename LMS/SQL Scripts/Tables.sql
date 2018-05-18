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
		genre NVARCHAR(MAX) NULL)
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
		mail NVARCHAR(MAX) NULL)
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
		AND TABLE_NAME = 'BorrowerAddresses')
	BEGIN
		CREATE TABLE BorrowerAddresses (
		adresslID INT IDENTITY(1, 1) PRIMARY KEY NOT NULL,
		borrowerID INT FOREIGN KEY REFERENCES BookBorrowers(borrowerID) NOT NULL,
		city NVARCHAR(MAX) NULL,
		street NVARCHAR(MAX) NULL,
		zipCode INT NULL)

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


--DROP TABLE UserAccounts, BookBorrowers
--DROP TABLE BorrowerAddresses
GO
CREATE OR ALTER VIEW BorrowerAccounts AS
SELECT b.firstName, b.middleName, b.lastName, a.city, a.street, a.zipCode, 
	u.username, u.[password] FROM BookBorrowers b, UserAccounts u, BorrowerAddresses a

--drop view BorrowerAccounts
--select * from BorrowerAccounts