--Asignment2

CREATE DATABASE Assignment2_Opt03
GO

-- Create table movie
CREATE TABLE Movie 
(
    NameMovie NVARCHAR(50) NOT NULL,
    Duration SMALLINT NOT NULL CHECK(Duration >=1),
    Genre SMALLINT NOT NULL CHECK(Genre >=1 AND Genre<=8),
    Director NVARCHAR(30) NOT NULL,
    Amount MONEY NOT NULL,
    Comment NTEXT
    CONSTRAINT PK_Movie PRIMARY KEY(NameMovie, Director)  
)
GO

--Create table Actor
CREATE TABLE Actor 
(
    NameActor NVARCHAR(30) NOT NULL,
    Age SMALLINT NOT NULL CHECK(Age >=0 AND Age <=150),
    Salary MONEY NOT NULL,
    Nationality NVARCHAR(20) NOT NULL
    PRIMARY KEY(NameActor)
)
GO

-- Create table Actendln
CREATE TABLE Actendln 
(
    NameMovie NVARCHAR(50) NOT NULL,
    Director NVARCHAR(30) NOT NULL,
    NameActor NVARCHAR(30) NOT NULL,
    DateStart DATE NOT NULL,
    DateEnd DATE NOT NULL
    CONSTRAINT PK_Actendln PRIMARY KEY(NameMovie, Director, NameActor),
    CONSTRAINT FK_Movie FOREIGN KEY(NameMovie, Director) REFERENCES Movie(NameMovie, Director),
    FOREIGN KEY(NameActor) REFERENCES Actor(NameActor)
)
GO

-- Add ImageLink to Movie
ALTER TABLE Movie ADD ImageLink VARCHAR(100) NOT NULL UNIQUE

-- Add Data
INSERT Movie(NameMovie, Duration, Genre, Director, Amount, Comment, ImageLink) VALUES
(N'Kẻ cắp mặt trăng', 10, 2, N'AZXC', 1200.2, null, 'AERUDH.JPG'),
(N'JoinWick', 15, 3, N'MNMN', 10000.0, null, 'Joinwick.JPG'),
(N'Thám tử tư', 2, 3, N'ABC', 10.2, null, 'Thamtutu.JPG'),
(N'Zombie Thành Phố', 2, 4, N'DEF', 200.2, null, 'Zombie.JPG')

-- Add Data Actor
INSERT Actor(NameActor, Age, Salary, Nationality) VALUES
(N'Mick Join', 35, 100.5, N'USA'),
(N'Join Wick', 38, 20000, N'American'),
(N'Châu Thuận Phát', 45, 1000, N'China'),
(N'Jack', 28, 500, N'Việt Nam'),
(N'Justin', 29, 2000, N'American')

-- Add Constraint dateEnd>dateStart
ALTER TABLE Actendln ADD CONSTRAINT Date_Constraints CHECK(DateEnd > DateStart)

-- Add Data Actendln 
INSERT Actendln(NameMovie, Director, NameActor, DateStart, DateEnd) VALUES
(N'Kẻ cắp mặt trăng', N'AZXC', N'Jack', '20220401', '20230101'),
(N'Join Wick 1', N'MNMN', N'Join Wick', '20200101', '20230101'),
(N'Join Wick 1', N'MNMN', N'Mick Join', '20201001', '20230505'),
(N'Zombie Thành Phố', N'DEF', N'Jack', '20191029', '20191201'),
(N'Thám tử tư', N'ABC', N'Châu Thuận Phát', '20221001', '20221201'),
(N'Kẻ cắp mặt trăng', N'AZXC', N'Châu Thuận Phát', '20221001', '20230101')

-- Update Name movie
UPDATE Movie SET NameMovie = 'Join Wick 1' WHERE NameMovie = 'JoinWick'

-- Select All Actor olds 50
SELECT * FROM Actor WHERE Age > 30

--Select Actor and Salary and sort by Salary
SELECT NameActor, Salary FROM Actor ORDER BY Salary DESC

-- Select * movie Actor 
SELECT Actor.NameActor, Movie.NameMovie FROM Movie INNER JOIN Actendln ON Movie.NameMovie = Actendln.NameMovie AND Movie.Director = Actendln.Director INNER JOIN Actor ON Actor.NameActor = Actendln.NameActor ORDER BY Actor.NameActor 

-- Select * name Movie with Num actor >3
SELECT COUNT(Movie.NameMovie) as NumActor, Movie.NameMovie FROM Movie INNER JOIN Actendln ON Movie.NameMovie = Actendln.NameMovie AND Movie.Director = Actendln.Director INNER JOIN Actor ON Actor.NameActor = Actendln.NameActor GROUP BY(Movie.NameMovie) HAVING COUNT(Movie.NameMovie)  >=2