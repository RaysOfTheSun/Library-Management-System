EXEC CreateUser 'Arvin', 'Collado', 'Alvarez', 'arvin@mail.com', '1111', 'rvn', 2, 1, 'Elm st.', 1008
EXEC CreateUser 'John', 'Smith', 'Heather', 'john@mail.com', '21241', 'jsh', 2, 1, 'flem st.', 1010
EXEC CreateUser 'Skratta', 'Purora', 'Mommin', 'scaty@mail.com', 'password', 'spm', 2, 1, 'lost st.', 1042
GO

EXEC AddCAddCountry 'Bhutan'
EXEC AddCAddCountry 'Philippines'
EXEC AddCAddCountry 'Brazil'
EXEC AddCAddCountry 'France'
EXEC AddCAddCountry 'Libia'
EXEC AddCAddCountry 'Philippines'
EXEC AddCAddCountry 'Germany'
EXEC AddCAddCountry 'United States of America'
GO

EXEC AddBook 1, 1, 'The Sea of Monsters', '0-7868-5686-6', 'LB2395.C61.2011', '2', 'Fantasy', 2011

EXEC AddAuthor 'Rick', 'Russel','Riordan'
EXEC AddPublisher 'Hyperion Books', 11
GO