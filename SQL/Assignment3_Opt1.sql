CREATE DATABASE EMS
-- Create table Employee, Status = 1: are working
CREATE TABLE [dbo].[Employee](
	[EmpNo] [int] NOT NULL
,	[EmpName] [nchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
,	[BirthDay] [datetime] NOT NULL
,	[DeptNo] [int] NOT NULL
, 	[MgrNo] [nchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
,	[StartDate] [datetime] NOT NULL
,	[Salary] [money] NOT NULL
,	[Status] [int] NOT NULL
,	[Note] [nchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
,	[Level] [int] NOT NULL
) ON [PRIMARY]

GO

ALTER TABLE Employee 
ADD CONSTRAINT PK_Emp PRIMARY KEY (EmpNo)
GO

ALTER TABLE [dbo].[Employee]  
ADD  CONSTRAINT [chk_Level] 
	CHECK  (([Level]=(7) OR [Level]=(6) OR [Level]=(5) OR [Level]=(4) OR [Level]=(3) OR [Level]=(2) OR [Level]=(1)))
GO
ALTER TABLE [dbo].[Employee]  
ADD  CONSTRAINT [chk_Status] 
	CHECK  (([Status]=(2) OR [Status]=(1) OR [Status]=(0)))

GO
ALTER TABLE [dbo].[Employee]
ADD Email NCHAR(30) 
GO

ALTER TABLE [dbo].[Employee]
ADD CONSTRAINT chk_Email CHECK (Email IS NOT NULL)
GO

ALTER TABLE [dbo].[Employee] 
ADD CONSTRAINT chk_Email1 UNIQUE(Email)

GO
ALTER TABLE Employee
ADD CONSTRAINT DF_EmpNo DEFAULT 0 FOR EmpNo

GO
ALTER TABLE Employee
ADD CONSTRAINT DF_Status DEFAULT 0 FOR Status

GO
CREATE TABLE [dbo].[Skill](
	[SkillNo] [int] IDENTITY(1,1) NOT NULL
,	[SkillName] [nchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
,	[Note] [nchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]

GO
ALTER TABLE Skill
ADD CONSTRAINT PK_Skill PRIMARY KEY (SkillNo)

GO
CREATE TABLE [dbo].[Department](
	[DeptNo] [int] IDENTITY(1,1) NOT NULL
,	[DeptName] [nchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
,	[Note] [nchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]

GO
ALTER TABLE Department
ADD CONSTRAINT PK_Dept PRIMARY KEY (DeptNo)

GO
CREATE TABLE [dbo].[Emp_Skill](
	[SkillNo] [int] NOT NULL
,	[EmpNo] [int] NOT NULL
,	[SkillLevel] [int] NOT NULL
,	[RegDate] [datetime] NOT NULL
,	[Description] [nchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]

GO
ALTER TABLE Emp_Skill
ADD CONSTRAINT PK_Emp_Skill PRIMARY KEY (SkillNo, EmpNo)
GO

ALTER TABLE Employee  
ADD  CONSTRAINT [FK_1] FOREIGN KEY([DeptNo])
REFERENCES Department (DeptNo)

GO
ALTER TABLE Emp_Skill
ADD CONSTRAINT [FK_2] FOREIGN KEY ([EmpNo])
REFERENCES Employee([EmpNo])

GO
ALTER TABLE Emp_Skill
ADD CONSTRAINT [FK_3] FOREIGN KEY ([SkillNo])
REFERENCES Skill([SkillNo])

GO

--Question 1 Add 8 record
INSERT Department(DeptName, Note) VALUES
(N'Nhân sự', null),
(N'Hành chính', null),
(N'Kế toán', null),
(N'Tài chính', null),
(N'ANDROI', null),
(N'BIGDATA', null),
(N'CLOUND', null),
(N'IoT', null)

INSERT Skill(SkillName, Note) VALUES
(N'C++', null),
(N'C', null),
(N'C#', null),
(N'Java', null),
(N'.Net', null),
(N'PHP', null),
(N'Python', null),
(N'Ruby', null)

INSERT Employee(EmpNo, EmpName, BirthDay, DeptNo, StartDate, Salary, [Level], [Status], Note, Email, MgrNo) VALUES
(1, N'Nguyễn Văn Quang', '20010504', 1,'20220504', 900.5, 1, 0,N'Tốt', 'quang11a3@gmail.com',N'NV01'),
(2, N'Nguyễn Minh Hùng', '20020504', 2,'20220504', 700.5, 4, 0,N'Tốt', 'quang12a3@gmail.com',N'NV02'),
(3, N'Phan Văn Khánh', '20020309', 3,'20110406', 40.5, 5, 2, N'Tốt', 'quang13a3@gmail.com',N'NV03'),
(4, N'Nguyễn Văn Minh', '20090507', 4,'20220309', 300.5, 3, 1, N'Tốt', 'quang14a3@gmail.com',N'NV04'),
(5, N'Dương Thị Thúy', '20000204', 5,'20220708', 400.5, 2, 1, null, 'quang15a3@gmail.com',N'NV05'),
(6, N'Cao Tiến Luật', '20011004', 1,'20220604', 900.5, 1, 0, N'Tốt', 'quang16a3@gmail.com',N'NV06'),
(7, N'Lương Duy Thạch', '20020504', 2,'20200504', 700.5, 4, 0, N'Tốt', 'quang17a3@gmail.com',N'NV07'),
(8, N'Phạm Ngọc', '20020309', 3,'20191010', 40.5, 5, 2, N'Tốt', 'quang18a3@gmail.com',N'NV08'),
(9, N'Tiểu My', '20090507', 4,'20210304', 300.5, 3, 1, N'Tốt', 'quang19a3@gmail.com',N'NV09')
GO

INSERT Emp_Skill(SkillNo, EmpNo, SkillLevel, RegDate, [Description]) VALUES
(1, 2, 5, '20221003', null),
(1, 3, 2, '20210103', null),
(2, 1, 5, '20190203', null),
(3, 1, 5, '20011003', null),
(4, 4, 5, '20190528', null),
(5, 5, 5, '20221101', null),
(2, 6, 5, '20210303', null),
(7, 7, 5, '20211003', null),
(1, 8, 5, '20021203', null),
(3, 8, 5, '20221012', null),
(8, 6, 5, '20211012', null),
(3, 3, 5, '20221003', null)
GO

-- Question 1 Lấy tên, email và bộ phận của nhân viên làm ít nhất 6 tháng
SELECT Employee.EmpName, Employee.Email, Department.DeptName, Employee.StartDate FROM Employee INNER JOIN Department ON Employee.DeptNo = Department.DeptNo WHERE DATEDIFF(month, Employee.StartDate, GETDATE()) >= 6

-- Question 2 Select tên nhân viên có kỹ năng C++ hoặc .Net
SELECT Employee.EmpName, SkillName FROM Employee INNER JOIN Emp_Skill ON Emp_Skill.EmpNo = Employee.EmpNo INNER JOIN Skill ON Emp_Skill.SkillNo = Skill.SkillNo WHERE SkillName = N'C++' OR SkillName = '.Net'

--Question 4 Chỉ định các phòng ban có> = 2 nhân viên, in ra danh sách nhân viên của các phòng ban ngay sau mỗi phòng ban.
SELECT Department.DeptName, Employee.EmpName FROM Employee INNER JOIN Department ON Employee.DeptNo = Department.DeptNo AND Department.DeptName IN (
SELECT Department.DeptName FROM Employee INNER JOIN Department ON Employee.DeptNo = Department.DeptNo GROUP BY DeptName HAVING  COUNT(EmpName) >=2
) ORDER BY DeptName

-- Question 5 Liệt kê tất cả tên, email và số kỹ năng của nhân viên và sắp xếp thứ tự tăng dần theo tên của nhân viên.
SELECT Employee.EmpName, Employee.Email, COUNT(SkillName) AS NumSkill FROM Employee INNER JOIN Emp_Skill ON Emp_Skill.EmpNo = Employee.EmpNo INNER JOIN Skill ON Skill.SkillNo =Emp_Skill.SkillNo GROUP BY Employee.Email, EmpName ORDER BY EmpName 

-- Question 6 Tạo khung nhìn để liệt kê tất cả nhân viên đang làm việc (bao gồm: tên nhân viên và tên kỹ năng, tên bộ phận).
CREATE VIEW EmployeeWork AS
SELECT Employee.EmpName, Skill.SkillName, Department.DeptName FROM Employee INNER JOIN Emp_Skill ON Employee.EmpNo = Emp_Skill.EmpNo INNER JOIN Department ON Employee.DeptNo = Department.DeptNo INNER JOIN Skill ON Skill.SkillNo = Emp_Skill.SkillNo
