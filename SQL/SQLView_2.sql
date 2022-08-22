select * from student

-- tạo bảng subject với id tự tăng nếu không truyền vào
CREATE TABLE subject 
(
    idSubject INT PRIMARY KEY IDENTITY(0,3),
    -- IDETITY(0,2) là bắt đầu từ 0 và tăng 2 đơn vị 
    name NVARCHAR(20)
)
GO
-- insert dữ liệu vào cho subject

INSERT subject(name) VALUES 
(N'Toán'),
(N'Lý'),
(N'Hóa'),
(N'Sinh'),
(N'Anh văn')
GO
DROP TABLE subject

-- View là tạo ra một bảng ảo
-- Dữ liệu của view sẽ được update khi dữ liệu các bảng view select thay đổi
-- vd khi tạo bảng menu thì tạo view rồi select từ bảng món ăn, khi thay đổi giá hay gì thì nó sẽ thay đổi menu
GO
CREATE VIEW teacherAtClass as
SELECT t.nameTeacher, t.emailTeacher, t.dateTeacher, c.nameClass FROM teacher t inner join class c on t.idClass = c.idClass
GO

-- select view
SELECT * from teacherAtClass
GO
