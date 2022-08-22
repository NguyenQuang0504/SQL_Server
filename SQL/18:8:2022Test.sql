CREATE table teacher(
    idTeacher int PRIMARY KEY,
    nameTeacher NVARCHAR(30),
    emailTeacher NVARCHAR(30)
)
GO

-- them du lieu cho bang teacher
INSERT teacher(idTeacher, nameTeacher, emailTeacher, idClass) 
VALUES 
    (3, N'Van Hieu', N'vanhieu@gmail.com',1),
    (4, N'Phan Tran Dang Khoa', N'khoah123@gmail.com', 2)
GO

--tao bang class
CREATE table class(
    idClass INT PRIMARY KEY,
    nameClass VARCHAR(10)
)
GO

-- them du lieu cho bang class
INSERT class(idClass, nameClass) VALUES (1, '18DT2'),(2, '18DT1') 
GO

-- them truong lam khoa ngoai cho bang teacher
ALTER TABLE teacher ADD idClass int
GO

-- tao khoa ngoai tu bang teacher den class
ALTER TABLE teacher ADD FOREIGN KEY (idClass) REFERENCES class(idClass)
GO
-- Lenh inner join hai bang class va teacher
SELECT * FROM teacher INNER JOIN class on teacher.idClass = class.idClass WHERE class.idClass = 1
GO
-- them thuoc tinh ngay sinh cho teacher
ALTER TABLE teacher add dateTeacher DATE
GO
-- them du lieu cho class teacher 
INSERT teacher(idTeacher, nameTeacher, idClass, dateTeacher) VALUES(5,N'Nguyễn Văn Quang', 1, '20000504')
go
select * from teacher
-- xap xep
select * from teacher ORDER BY idClass
-- update du lieu
update teacher set dateTeacher = '20200101' WHERE idClass = 1

-- groupby select total teacher on class
select COUNT(class.idClass) as countRow, class.idClass from teacher inner join class on class.idClass = teacher.idClass GROUP BY(class.idClass) HAVING class.idClass = 1
-- lay gioi han giong limit o mysql
SELECT Top 1 * From teacher ORDER BY nameTeacher DESC;
GO
-- them truong khoa ngoai den bang class cho bang student
alter table student add idClass int
 -- them khoa ngoai vao

 ALTER table student add FOREIGN KEY (idClass) REFERENCES class(idClass)
 GO
 --them du lieu vao cho bang student
 insert student(idStudent, nameStudent, idClass) VALUES 
 (1, N'Nguyen Van Quang', 1),
 (2, N'Nguyen Van B', 1),
 (3, N'Nguyen Van C', 2),
 (4, N'Nguyen Van D', 2),
 (5, N'Nguyen Van E', 2)
 GO
-- ket hop join nhieu ban kem dieu kien
SELECT TOP 1 WITH ties  * from student INNER JOIN class on student.idClass = class.idClass inner JOIN teacher on teacher.idClass = student.idClass where teacher.nameTeacher like '%T%' ORDER BY teacher.nameTeacher