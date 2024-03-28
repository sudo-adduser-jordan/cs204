-- CREATE TABLES

    CREATE TABLE Client (
        ClientID            INT NOT NULL AUTO_INCREMENT,
        ClientFirstName     VARCHAR(255) NOT NULL,
        ClientLastName      VARCHAR(255) NOT NULL,
        ClientDoB           INT NOT NULL,
        Occupation          VARCHAR(255) NOT NULL,
        PRIMARY KEY (ClientID)
    );

    CREATE TABLE Author (
        AuthorID            INT NOT NULL AUTO_INCREMENT,
        AuthorFirstName     VARCHAR(255) NOT NULL,
        AuthorLastName      VARCHAR(255) NOT NULL,
        AuthorNationality   VARCHAR(255) NOT NULL,
        PRIMARY KEY (AuthorID)
    );

    CREATE TABLE Book (
        BookID              INT NOT NULL AUTO_INCREMENT,
        BookTitle           VARCHAR(255) NOT NULL,
        BookAuthor          INT NOT NULL,
        Genre               VARCHAR(255) NOT NULL,
        PRIMARY KEY (BookID),
        FOREIGN KEY (BookAuthor)    REFERENCES Author (AuthorID)
    );

    CREATE TABLE Borrower (
        BorrowID            INT NOT NULL AUTO_INCREMENT,
        ClientID            INT NOT NULL,
        BookID              INT NOT NULL,
        BorrowDate          DATE NOT NULL,
        PRIMARY KEY (BorrowID),
        FOREIGN KEY (ClientID)      REFERENCES Client (ClientID), 
        FOREIGN KEY (BookID)        REFERENCES Book (BookID)
    );

-- POPULATE DATABASE
    -- SHOW GLOBAL VARIABLES LIKE 'local_infile'; 
    -- SET GLOBAL local_infile = TRUE;

    LOAD DATA LOCAL INFILE 'client.txt'     INTO TABLE client;
    LOAD DATA LOCAL INFILE 'borrower.txt'   INTO TABLE borrower;
    LOAD DATA LOCAL INFILE 'book.txt'       INTO TABLE book;
    LOAD DATA LOCAL INFILE 'author.txt'     INTO TABLE author;

-- INDEXES
    CREATE INDEX index_name
        ON table_name (column1, column2, ...);
    
    CREATE UNIQUE INDEX index_name
        ON table_name (column1, column2, ...); 

-- QUERIES
    -- Display all contents of the Clients table
        SELECT * 
        FROM Client

    -- First names, last names, ages and occupations of all clients
        SELECT ClientFirstName, ClientLastName, ClientDoB 
        FROM Client

    -- First and last names of clients that borrowed books in March 2018
        SELECT ClientFirstName, ClientLastName 
        FROM Client 
        WHERE ClientId IN (
            SELECT ClientId
            FROM Borrower 
            WHERE BorrowDate >= Date('2018-03-01') AND BorrowDate <= Date('2018-03-31')); 

     -- First and last names of the top 5 authors clients borrowed in 2017
        SELECT Author.AuthorFirstName, Author.AuthorLastName
        FROM Author 
            INNER JOIN Book ON Book.BookAuthor = Author.AuthorId
            INNER JOIN Borrower ON Borrower.BookId = Book.BookId
        WHERE BorrowDate >= Date('2017-01-01') AND BorrowDate <= Date('2017-12-31')
        GROUP BY Author.AuthorId
        ORDER BY COUNT(Author.AuthorId) DESC
        LIMIT 5;

     -- Nationalities of the least 5 authors that clients borrowed during the years 2015-2017
        SELECT Author.AuthorNationality 
        FROM Author 
            INNER JOIN Book ON Book.BookAuthor = Author.AuthorId
            INNER JOIN Borrower ON Borrower.BookId = Book.BookId
        WHERE BorrowDate >= Date('2015-01-01') AND BorrowDate <= Date('2017-12-31')
        GROUP BY Author.AuthorNationality
        ORDER BY COUNT(Author.AuthorNationality) ASC
        LIMIT 5;

    -- The book that was most borrowed during the years 2015-2017
        SELECT Book.BookTitle 
        FROM Book 
            INNER JOIN Borrower ON Borrower.BookId = Book.BookId
        WHERE BorrowDate >= Date('2015-01-01') AND BorrowDate <= Date('2017-12-31')
        GROUP BY Book.BookID
        ORDER BY COUNT(Borrower.BookId) DESC
        LIMIT 1;

    -- Top borrowed genres for client born in years 1970-1980
        SELECT Book.Genre FROM Book 
            INNER JOIN Borrower ON Borrower.BookId = Book.BookId
            INNER JOIN Client ON Client.ClientId = Borrower.ClientId
        WHERE Client.ClientDoB >= 1970 AND Client.ClientDoB <= 1980
        GROUP BY Book.Genre
        ORDER BY COUNT(Book.Genre) DESC
        LIMIT 5;

    -- Top 5 occupations that borrowed the most in 2016
        SELECT Client.Occupation FROM Client
            INNER JOIN Borrower ON Borrower.ClientId = Client.ClientId
        WHERE Borrower.BorrowDate >= Date('2016-01-01') AND Borrower.BorrowDate <= Date('2016-12-31')
        GROUP BY Client.Occupation
        ORDER BY COUNT(Client.Occupation) DESC
        LIMIT 5;

    -- Average number of borrowed books by job title
        SELECT c.Occupation, COUNT(c.Occupation) / (SELECT COUNT(Occupation) 
                                                    FROM Client 
                                                    WHERE Occupation = c.Occupation 
                                                    GROUP BY Occupation
                                                    ) AS AverageBorrowed
        FROM Client c
            INNER JOIN Borrower ON Borrower.ClientId = c.ClientId
        GROUP BY c.Occupation
        ORDER BY AverageBorrowed DESC;

    -- Create a VIEW and display the titles that were borrowed by at least 20% of clients
        CREATE VIEW Titles_Borrowed AS
        SELECT Book.BookTitle 
        FROM Book
            INNER JOIN Borrower ON Borrower.BookId = Book.BookId
            INNER JOIN Client ON Client.ClientId = Borrower.ClientId
        GROUP BY Book.BookId
        HAVING COUNT(Book.BookId) / (SELECT COUNT(ClientId) FROM Client) >= 0.2;

    -- The top month of borrows in 2017
        SELECT MONTH(BorrowDate) 
        FROM Borrower 
        WHERE BorrowDate >= Date('2017-01-01') AND BorrowDate <= Date('2017-12-31')
        GROUP BY MONTH(BorrowDate)
        ORDER BY COUNT(MONTH(BorrowDate)) DESC
        LIMIT 1;

    -- Average number of borrows by age
        SELECT YEAR(CURDATE()) - ClientDoB AS Age, COUNT(YEAR(CURDATE()) - ClientDoB) / 
            (SELECT COUNT(YEAR(CURDATE()) - ClientDoB) 
            FROM Client 
            WHERE YEAR(CURDATE()) - ClientDoB = Age)
        AS Average 
        FROM Client
            INNER JOIN Borrower ON Borrower.ClientId = Client.ClientId
        GROUP BY Age
        ORDER BY Age ASC;

    -- The oldest and the youngest clients of the library
        (SELECT ClientFirstName, ClientLastName, ClientDoB 
        FROM Client
        ORDER BY ClientDoB ASC LIMIT 1) 
        UNION
        (SELECT ClientFirstName, ClientLastName, ClientDoB 
        FROM Client
        ORDER BY ClientDoB DESC LIMIT 1);

    -- First and last names of authors that wrote books in more than one Genre
        SELECT AuthorFirstName, AuthorLastName 
        FROM Author a
            INNER JOIN Book ON Book.BookAuthor = a.AuthorId
        WHERE (SELECT COUNT(*) 
                FROM (SELECT COUNT(DISTINCT Genre) 
                FROM Book 
                WHERE a.AuthorId = Book.BookAuthor 
                GROUP BY Genre) AS Number_Of_Genres) > 1
        GROUP BY AuthorId;


-- DROP TABLES

    DROP TABLE Borrower;
    DROP TABLE Book; 
    DROP TABLE Author;
    DROP TABLE Client;
