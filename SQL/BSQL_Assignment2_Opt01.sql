CREATE DATABASE Asignment2_Opt01
GO

--A
CREATE TABLE Trainee(
    TraineeId SMALLINT PRIMARY KEY IDENTITY,
    FullName NVARCHAR(30) NOT NULL,
    BirthDate DATE NOT NULL,
    Gender VARCHAR(10) NOT NULL CHECK(Gender = 'Male' OR Gender = 'Female'),
    EtIQ SMALLINT NOT NULL CHECK(EtIQ >=0 AND EtIQ <= 20),
    EtGmath SMALLINT NOT NULL CHECK(EtGmath >=0 AND EtGmath <= 20),
    EtEnglish SMALLINT NOT NULL CHECK(EtEnglish >=0 AND EtEnglish <= 50),
    TrainingClass  VARCHAR(10) NOT NULL,
    EvaluationNote NTEXT
)
GO
DROP TABLE Trainee
GO

INSERT Trainee(FullName, BirthDate, Gender, EtIQ, EtGmath, EtEnglish, TrainingClass, EvaluationNote, FsoftAccount) VALUES
(N'Nguyễn Văn Quang', '20000504', 'Male', 10, 20, 50, 'FA16', null, 'QuangNV51'),
(N'Nguyễn Văn Hùng', '20000504', 'Male', 1, 20, 50, 'FA16', null, 'HungNV'),
(N'Lương Duy Thạch', '20000106', 'Male', 18, 15, 17, 'FA16', null, 'ThachLD'),
(N'Dương Thị Thúy', '20000806', 'Female', 20, 20, 28, 'FA16', null, 'ThuyDT'),
(N'Nguyễn Văn Mạnh', '20010301', 'Male', 10, 20, 39, 'FA15', null, 'ManhNV'),
(N'Trần Thị Như Yến', '20000202', 'Female', 0, 2, 28, 'FA15', null, 'YenTTN'),
(N'Nguyễn Minh Mẫn', '19990204', 'Male', 20, 20, 50, 'FA15', null, 'ManNM'),
(N'Phan Văn Khánh', '20001104', 'Male', 10, 20, 50, 'FA15', null, 'KhanhPV'),
(N'Dương Thị Ngọc Giàu', '20020404', 'Female', 15, 10, 30, 'FA18', null, 'GiauDTN'),
(N'Nguyễn Minh Quan', '20000204', 'Male', 10, 17, 20, 'FA18', null, 'QuanNM'),
(N'Nguyễn Hữu Hùng', '19980504', 'Male', 10, 17, 30, 'FA18', null, 'HungNH'),
(N'Lê Sơn Thiên Hậu', '19930704', 'Male', 10, 14, 32, 'FA18', null, 'HauLST')

-- Them trường FsoftAccount
ALTER TABLE Trainee ADD FsoftAccount VARCHAR(20) NOT NULL UNIQUE

-- Tạo view
CREATE VIEW EtPass AS 
SELECT * FROM Trainee WHERE EtIQ + EtGmath >=20 AND EtIQ >=8 AND EtGmath >=8 AND EtEnglish >=18

-- select view
SELECT * FROM EtPass

-- Select tổng các trainee pass theo tháng sinh
SELECT COUNT(MONTH(EtPass.BirthDate)), MONTH(EtPass.BirthDate) FROM EtPass GROUP BY MONTH(EtPass.BirthDate)

-- Hien thi những Trainee có tên dài nhất
SELECT TOP 3 WITH TIES * FROM Trainee ORDER BY LEN(FullName) DESC