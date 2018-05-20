EXEC AddCountry 'Bhutan'
EXEC AddCountry 'Philippines'
EXEC AddCountry 'Brazil'
EXEC AddCountry 'France'
EXEC AddCountry 'Libia'
EXEC AddCountry 'Philippines'
EXEC AddCountry 'Germany'
EXEC AddCountry 'United States'
EXEC AddCountry 'England'
GO

SELECT * FROM Countries

EXEC AddCity 'New York City'
EXEC AddCity 'Mandaluyong City'
EXEC AddCity 'Marikina City'
EXEC AddCity 'Taguig City'
EXEC AddCity 'Pasig City'
EXEC AddCity 'Pasay City'
EXEC AddCity 'Quezon City'
EXEC AddCity 'Aldgate'
GO

SELECT * FROM Cities

EXEC CreateUser 'Arvin', 'Collado', 'Alvarez', 'arvin@mail.com', '1111', 'rvn', 2, 1, 'Elm st.', 1008
EXEC CreateUser 'John', 'Smith', 'Heather', 'john@mail.com', '21241', 'jsh', 2, 1, 'flem st.', 1010
EXEC CreateUser 'Skratta', 'Purora', 'Mommin', 'scaty@mail.com', 'password', 'spm', 2, 1, 'lost st.', 1042
GO

EXEC AddAuthor 'Rick', 'Russel','Riordan'
GO
EXEC AddPublisher 'Hyperion Books', 11
GO

EXEC AddBook 1, 1, 'The Sea of Monsters', '0-7868-5686-6', 'LB2395.C61.2011', '2', 'Fantasy', 2011
GO

select * from UserAccounts
select * from BookBorrowers
select * from BorrowerAddresses