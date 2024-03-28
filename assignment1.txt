-- Computer Science 204 - Assignment 1: Creating & Manipulating a Database

-- Note to the person grading the assignment. Change the file extension to .sql 
-- for syntax highlighting. Cheers

-- PART A: CREATE TABLES
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

-- PART B: POPULATE DATABASE
    -- Load data from text file.
    LOAD DATA LOCAL INFILE 'client.txt'     INTO TABLE client;
    LOAD DATA LOCAL INFILE 'borrower.txt'   INTO TABLE borrower;
    LOAD DATA LOCAL INFILE 'book.txt'       INTO TABLE book;
    LOAD DATA LOCAL INFILE 'author.txt'     INTO TABLE author;

    -- The data can also be loaded with an INSERT statment. However this is method is more tedious
    -- and unrealistic with large datasets.
    -- VALUES excluded for brevity
    INSERT INTO Author (AuthorId, AuthorFirstName, AuthorLastName, AuthorNationality) VALUES
    INSERT INTO Book (BookId, BookTitle, BookAuthor, Genre) VALUES
    INSERT INTO Client (ClientId, ClientFirstName, ClientLastName, ClientDoB, Occupation) VALUES
    INSERT INTO Borrower (BorrowId, ClientId, BookId, BorrowDate) VALUES

-- PART C: QUERIES AND RESULTS
    -- Indexs
    -- WHERE AND JOIN 
        CREATE INDEX idx_customer_id ON customers (customer_id);
        CREATE INDEX idx_order_id ON orders (order_id);

    -- Query 1: Display all contents of the Clients table
        SELECT * 
        FROM Client
        -- Select all columns from the Client table.
    -- Result
        ClientID	ClientFirstName	ClientLastName	ClientDoB	Occupation
        1	Kaiden	Hill	2006	Student
        2	Alina	Morton	2010	Student
        3	Fania	Brooks	1983	Food Scientist
        4	Courtney	Jensen	2006	Student
        5	Brittany	Hill	1983	Firefighter
        6	Max	Rogers	2005	Student
        7	Margaret	McCarthy	1981	School Psychologist
        8	Julie	McCarthy	1973	Professor
        9	Ken	McCarthy	1974	Securities Clerk
        10	Britany	OQuinn	1984	Violinist
        11	Conner	Gardner	1998	Licensed Massage Therapist
        12	Mya	Austin	1960	Parquet Floor Layer
        13	Thierry	Rogers	2004	Student
        14	Eloise	Rogers	1984	Computer Security Manager
        15	Gerard	Jackson	1979	Oil Exploration Engineer
        16	Randy	Day	1986	Aircraft Electrician
        17	Jodie	Page	1990	Manufacturing Director
        18	Coral	Rice	1996	Window Washer
        19	Ayman	Austin	2002	Student
        20	Jaxson	Austin	1999	Repair Worker
        21	Joel	Austin	1973	Police Officer
        22	Alina	Austin	2010	Student
        23	Elin	Austin	1962	Payroll Clerk
        24	Ophelia	Wolf	2004	Student
        25	Eliot	McGuire	1967	Dentist
        26	Peter	McKinney	1968	Professor
        27	Annabella	Henry	1974	Nurse
        28	Anastasia	Baker	2001	Student
        29	Tyler	Baker	1984	Police Officer
        30	Lilian	Ross	1983	Insurance Agent
        31	Thierry	Arnold	1975	Bus Driver
        32	Angelina	Rowe	1979	Firefighter
        33	Marcia	Rowe	1974	Health Educator
        34	Martin	Rowe	1976	Ship Engineer
        35	Adeline	Rowe	2005	Student
        36	Colette	Rowe	1963	Professor
        37	Diane	Clark	1975	Payroll Clerk
        38	Caroline	Clark	1960	Dentist
        39	Dalton	Clayton	1982	Police Officer
        40	Steve	Clayton	1990	Bus Driver
        41	Melanie	Clayton	1987	Computer Engineer
        42	Alana	Wilson	2007	Student
        43	Carson	Byrne	1995	Food Scientist
        44	Conrad	Byrne	2007	Student
        45	Ryan	Porter	2008	Student
        46	Elin	Porter	1978	Computer Programmer
        47	Tyler	Harvey	2007	Student
        48	Arya	Harvey	2008	Student
        49	Serena	Harvey	1978	School Teacher
        50	Lilly	Franklin	1976	Doctor
        51	Mai	Franklin	1994	Dentist
        52	John	Franklin	1999	Firefighter
        53	Judy	Franklin	1995	Firefighter
        54	Katy	Lloyd	1992	School Teacher
        55	Tamara	Allen	1963	Ship Engineer
        56	Maxim	Lyons	1985	Police Officer
        57	Allan	Lyons	1983	Computer Engineer
        58	Marc	Harris	1980	School Teacher
        59	Elin	Young	2009	Student
        60	Diana	Young	2008	Student
        61	Diane	Young	2006	Student
        62	Alana	Bird	2003	Student
        63	Anna	Becker	1979	Security Agent
        64	Katie	Grant	1977	Manager
        65	Joan	Grant	2010	Student
        66	Bryan	Bell	2001	Student
        67	Belle	Miller	1970	Professor
        68	Peggy	Stevens	1990	Bus Driver
        69	Steve	Williamson	1975	HR Clerk
        70	Tyler	Williamson	1999	Doctor
        71	Izabelle	Williamson	1990	Systems Analyst
        72	Annabel	Williamson	1960	Cashier
        73	Mohamed	Waters	1966	Insurance Agent
        74	Marion	Newman	1970	Computer Programmer
        75	Ada	Williams	1986	Computer Programmer
        76	Sean	Scott	1983	Bus Driver
        77	Farrah	Scott	1974	Ship Engineer
        78	Christine	Lambert	1973	School Teacher
        79	Alysha	Lambert	2007	Student
        80	Maia	Grant	1984	School Teacher

    -- Query 2: First names, last names, ages and occupations of all clients
        SELECT ClientFirstName, ClientLastName, ClientDoB 
        FROM Client
        -- Select ClientFirstName, ClientLastName, ClientDoB columns from Client table.
    -- Result
        ClientFirstName	ClientLastName	ClientDoB
        Kaiden	Hill	2006
        Alina	Morton	2010
        Fania	Brooks	1983
        Courtney	Jensen	2006
        Brittany	Hill	1983
        Max	Rogers	2005
        Margaret	McCarthy	1981
        Julie	McCarthy	1973
        Ken	McCarthy	1974
        Britany	OQuinn	1984
        Conner	Gardner	1998
        Mya	Austin	1960
        Thierry	Rogers	2004
        Eloise	Rogers	1984
        Gerard	Jackson	1979
        Randy	Day	1986
        Jodie	Page	1990
        Coral	Rice	1996
        Ayman	Austin	2002
        Jaxson	Austin	1999
        Joel	Austin	1973
        Alina	Austin	2010
        Elin	Austin	1962
        Ophelia	Wolf	2004
        Eliot	McGuire	1967
        Peter	McKinney	1968
        Annabella	Henry	1974
        Anastasia	Baker	2001
        Tyler	Baker	1984
        Lilian	Ross	1983
        Thierry	Arnold	1975
        Angelina	Rowe	1979
        Marcia	Rowe	1974
        Martin	Rowe	1976
        Adeline	Rowe	2005
        Colette	Rowe	1963
        Diane	Clark	1975
        Caroline	Clark	1960
        Dalton	Clayton	1982
        Steve	Clayton	1990
        Melanie	Clayton	1987
        Alana	Wilson	2007
        Carson	Byrne	1995
        Conrad	Byrne	2007
        Ryan	Porter	2008
        Elin	Porter	1978
        Tyler	Harvey	2007
        Arya	Harvey	2008
        Serena	Harvey	1978
        Lilly	Franklin	1976
        Mai	Franklin	1994
        John	Franklin	1999
        Judy	Franklin	1995
        Katy	Lloyd	1992
        Tamara	Allen	1963
        Maxim	Lyons	1985
        Allan	Lyons	1983
        Marc	Harris	1980
        Elin	Young	2009
        Diana	Young	2008
        Diane	Young	2006
        Alana	Bird	2003
        Anna	Becker	1979
        Katie	Grant	1977
        Joan	Grant	2010
        Bryan	Bell	2001
        Belle	Miller	1970
        Peggy	Stevens	1990
        Steve	Williamson	1975
        Tyler	Williamson	1999
        Izabelle	Williamson	1990
        Annabel	Williamson	1960
        Mohamed	Waters	1966
        Marion	Newman	1970
        Ada	Williams	1986
        Sean	Scott	1983
        Farrah	Scott	1974
        Christine	Lambert	1973
        Alysha	Lambert	2007
        Maia	Grant	1984

    -- Query 3: First and last names of clients that borrowed books in March 2018
        SELECT ClientFirstName, ClientLastName 
        FROM Client 
        WHERE ClientId IN (
            SELECT ClientId
            FROM Borrower 
            WHERE BorrowDate >= Date('2018-03-01') AND BorrowDate <= Date('2018-03-31'));
        -- Select ClientFirstName, ClientLastName columns from Client table.
        -- Using a IN operator to select only the values within the DATE value March. 
    -- Result
        ClientFirstName	ClientLastName
        Maia	Grant
        Marcia	Rowe
        Alysha	Lambert
        Tyler	Baker
        Katy	Lloyd
        Angelina	Rowe
        Gerard	Jackson
        Carson	Byrne
    
     -- Query 4: First and last names of the top 5 authors clients borrowed in 2017
        SELECT Author.AuthorFirstName, Author.AuthorLastName
        FROM Author 
            INNER JOIN Book ON Book.BookAuthor = Author.AuthorId
            INNER JOIN Borrower ON Borrower.BookId = Book.BookId
        WHERE BorrowDate >= Date('2017-01-01') AND BorrowDate <= Date('2017-12-31')
        GROUP BY Author.AuthorId
        ORDER BY COUNT(Author.AuthorId) DESC
        LIMIT 5;
        -- Select Author.AuthorFirstName, Author.AuthorLastName columns from the Author Table.
        -- Join the Book table on the condition that the BookAuthor field in the Book table 
        -- matches the AuthorId field in the Author table.
        -- Join the Borrower table on the condition that the BookId field in the 
        -- Borrower table matches the BookId field in the Book table.
        -- Filter the results based on the BorrowDate.
        -- Group the results by AuthorId and order results in descending order.
        -- Return the top 5 results with the LIMIT operator.
    -- Result
        AuthorFirstName	AuthorLastName
        Sofia	Smith
        Elena	Martin
        Logan	Moore
        Maria	Brown
        Zoe	Roy
    
     -- Query 5: Nationalities of the least 5 authors that clients borrowed during the years 2015-2017
        SELECT Author.AuthorNationality 
        FROM Author 
            INNER JOIN Book ON Book.BookAuthor = Author.AuthorId
            INNER JOIN Borrower ON Borrower.BookId = Book.BookId
        WHERE BorrowDate >= Date('2015-01-01') AND BorrowDate <= Date('2017-12-31')
        GROUP BY Author.AuthorNationality
        ORDER BY COUNT(Author.AuthorNationality) ASC
        LIMIT 5;
        -- Select Author.AuthorNationality column from the Author Table.
        -- Join the Book table on the condition that the BookAuthor field in the Book table 
        -- matches the AuthorId field in the Author table.
        -- Join the Borrower table on the condition that the BookId field in the 
        -- Borrower table matches the BookId field in the Book table.
        -- Filter the results based on the BorrowDate.
        -- Group the results by AuthorNationality and order results in ascending order.
        -- Return the top 5 results with the LIMIT operator.
    -- Result
        AuthorNationality
        Spain
        Great Britain
        China
        Brazil
        France
    
    -- Query 6: The book that was most borrowed during the years 2015-2017
        SELECT Book.BookTitle 
        FROM Book 
            INNER JOIN Borrower ON Borrower.BookId = Book.BookId
        WHERE BorrowDate >= Date('2015-01-01') AND BorrowDate <= Date('2017-12-31')
        GROUP BY Book.BookID
        ORDER BY COUNT(Borrower.BookId) DESC
        LIMIT 1;
        -- Select Book.BookTitle column from the Book Table.
        -- Join the Borrower table on the condition that the BookId field in the 
        -- Borrower table matches the BookId field in the Book table.
        -- Filter the results based on the BorrowDate.
        -- Group the results by Book.BookID.
        -- Using the COUNT function, return the number of rows that matches the BookID.
        -- Order results in descending order.
        -- Return the top result with the LIMIT operator.
    -- Result
        BookTitle
        The perfect match





    
    -- Query 7: Top borrowed genres for client born in years 1970-1980
        SELECT Book.Genre FROM Book 
            INNER JOIN Borrower ON Borrower.BookId = Book.BookId
            INNER JOIN Client ON Client.ClientId = Borrower.ClientId
        WHERE Client.ClientDoB >= 1970 AND Client.ClientDoB <= 1980
        GROUP BY Book.Genre
        ORDER BY COUNT(Book.Genre) DESC
        LIMIT 5;
    -- Result
        Genre
        Science
        Fiction
        Well being
        Humor
        Society
    
    -- Query 8: Top 5 occupations that borrowed the most in 2016
        SELECT Client.Occupation FROM Client
            INNER JOIN Borrower ON Borrower.ClientId = Client.ClientId
        WHERE Borrower.BorrowDate >= Date('2016-01-01') AND Borrower.BorrowDate <= Date('2016-12-31')
        GROUP BY Client.Occupation
        ORDER BY COUNT(Client.Occupation) DESC
        LIMIT 5;
    -- Result
        Occupation
        Student
        Bus Driver
        Dentist
        Computer Programmer
        Police Officer
    
    -- Query 9: Average number of borrowed books by job title
        SELECT c.Occupation, COUNT(c.Occupation) / (SELECT COUNT(Occupation) 
                                                    FROM Client 
                                                    WHERE Occupation = c.Occupation 
                                                    GROUP BY Occupation
                                                    ) AS AverageBorrowed
        FROM Client c
            INNER JOIN Borrower ON Borrower.ClientId = c.ClientId
        GROUP BY c.Occupation
        ORDER BY AverageBorrowed DESC;
    -- Result
        Occupation	AverageBorrowed
        Nurse	7.0000
        Computer Security Manager	6.0000
        Computer Programmer	5.6667
        Dentist	5.6667
        Cashier	5.0000
        Manufacturing Director	5.0000
        Oil Exploration Engineer	5.0000
        Police Officer	4.5000
        Systems Analyst	4.0000
        Violinist	4.0000
        HR Clerk	4.0000
        Doctor	4.0000
        Bus Driver	4.0000
        Insurance Agent	4.0000
        Student	3.8182
        School Teacher	3.6000
        Professor	3.5000
        Firefighter	3.2500
        Manager	3.0000
        Repair Worker	3.0000
        Computer Engineer	3.0000
        Payroll Clerk	3.0000
        Ship Engineer	2.6667
        Food Scientist	2.5000
        Health Educator	2.0000
        Window Washer	2.0000
        Securities Clerk	2.0000
        Security Agent	2.0000
        School Psychologist	2.0000
        Aircraft Electrician	2.0000
        Licensed Massage Therapist	2.0000
        Parquet Floor Layer	2.0000

    -- Query 10: Create a VIEW and display the titles that were borrowed by at least 20% of clients
        CREATE VIEW Titles_Borrowed AS
        SELECT Book.BookTitle 
        FROM Book
            INNER JOIN Borrower ON Borrower.BookId = Book.BookId
            INNER JOIN Client ON Client.ClientId = Borrower.ClientId
        GROUP BY Book.BookId
        HAVING COUNT(Book.BookId) / (SELECT COUNT(ClientId) FROM Client) >= 0.2;

        SELECT *
        FROM Titles_Borrowed;   
    -- Result
        BookTitle
        Electrical transformers
    
    -- Query 11: The top month of borrows in 2017
        SELECT MONTH(BorrowDate) 
        FROM Borrower 
        WHERE BorrowDate >= Date('2017-01-01') AND BorrowDate <= Date('2017-12-31')
        GROUP BY MONTH(BorrowDate)
        ORDER BY COUNT(MONTH(BorrowDate)) DESC
        LIMIT 1;
    -- Result
        MONTH(BorrowDate)
        8
    
    -- Query 12: Average number of borrows by age
        SELECT YEAR(CURDATE()) - ClientDoB AS Age, COUNT(YEAR(CURDATE()) - ClientDoB) / 
            (SELECT COUNT(YEAR(CURDATE()) - ClientDoB) 
            FROM Client 
            WHERE YEAR(CURDATE()) - ClientDoB = Age)
        AS AverageBorrowed 
        FROM Client
            INNER JOIN Borrower ON Borrower.ClientId = Client.ClientId
        GROUP BY Age
        ORDER BY Age ASC;
    -- Result
        Age	AverageBorrowed
        14	2.3333
        16	6.0000
        17	5.0000
        18	3.6667
        19	4.5000
        20	1.5000
        21	5.0000
        22	2.0000
        23	4.5000
        25	3.6667
        26	2.0000
        28	2.0000
        29	4.5000
        30	10.0000
        32	3.0000
        34	5.5000
        37	2.0000
        38	3.0000
        39	4.0000
        40	5.5000
        41	3.0000
        42	3.0000
        43	2.0000
        44	1.0000
        45	4.3333
        46	5.5000
        47	3.0000
        48	3.5000
        49	2.6667
        50	3.2500
        51	3.6667
        54	4.5000
        56	4.0000
        57	3.0000
        58	1.0000
        61	2.5000
        62	3.0000
        64	3.6667
    
    -- Query 13: The oldest and the youngest clients of the library
        (SELECT ClientFirstName, ClientLastName, ClientDoB 
        FROM Client
        ORDER BY ClientDoB ASC LIMIT 1) 
        UNION
        (SELECT ClientFirstName, ClientLastName, ClientDoB 
        FROM Client
        ORDER BY ClientDoB DESC LIMIT 1);
    -- Result
        ClientFirstName	ClientLastName	ClientDoB
        Mya	Austin	1960
        Alina	Morton	2010

    -- Query 14: First and last names of authors that wrote books in more than one Genre
        SELECT AuthorFirstName, AuthorLastName 
        FROM Author a
            INNER JOIN Book ON Book.BookAuthor = a.AuthorId
        WHERE (SELECT COUNT(*) 
                FROM (SELECT COUNT(DISTINCT Genre) 
                FROM Book 
                WHERE a.AuthorId = Book.BookAuthor 
                GROUP BY Genre) AS Number_Of_Genres) > 1
        GROUP BY AuthorId;
    -- Result
        No rows.