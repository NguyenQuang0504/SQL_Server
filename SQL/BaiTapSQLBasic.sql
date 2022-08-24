CREATE DATABASE BaiTapSQLBasic
GO

CREATE TABLE SanPham 
(
    MaSP VARCHAR(10) NOT NULL PRIMARY KEY,
    TenSP NVARCHAR(30) NOT NULL,
    MaLoaiSP VARCHAR(10) NOT NULL,
    GiaBan MONEY NOT NULL CHECK(GiaBan > 0)
)
GO 

CREATE TABLE LoaiSP 
(
    MaLoaiSP VARCHAR(10) NOT NULL PRIMARY KEY,
    TenLoaiSP NVARCHAR(30) NOT NULL
)
GO 

CREATE TABLE NhanVien 
(
    MaNV VARCHAR(10) NOT NULL PRIMARY KEY,
    HoTenNV NVARCHAR(30) NOT NULL,
    GioiTinh VARCHAR(6) NOT NULL CHECK(GioiTinh = 'Male' OR GioiTinh = 'Female'),
    QueQuan NVARCHAR(50) NOT NULL,
    Tuoi SMALLINT NOT NULL CHECK(Tuoi > 0 AND Tuoi <100)
)
GO 

ALTER TABLE NhanVien
ALTER COLUMN QueQuan NVARCHAR(50) NULL;

CREATE TABLE BanHang 
(
    MaSP VARCHAR(10) NOT NULL,
    MaNV VARCHAR(10) NOT NULL,
    SoLuong SMALLINT NOT NULL CHECK(SoLuong >0)
    CONSTRAINT PK_BanHang PRIMARY KEY(MaSP, MaNV),
    FOREIGN KEY(MaSP) REFERENCES SanPham(MaSP),
    FOREIGN KEY (MaNV) REFERENCES NhanVien(MaNV)
)
GO 

INSERT LoaiSP VALUES
('Type001', N'Sản phẩm Gia Dụng'),
('Type002', N'Sản phẩm Ăn uống'),
('Type003', N'Sản phẩm Dịch vụ'),
('Type004', N'Sản phẩm Hóa học')

ALTER TABLE SanPham ADD CONSTRAINT FK_SanPham FOREIGN KEY(MaLoaiSP) REFERENCES LoaiSP(MaLoaiSP)

INSERT SanPham VALUES 
('SP001', N'Nước tẩy rửa áo quần', 'Type001', 100000),
('SP002', N'Nước tẩy rửa chén', 'Type001', 50000),
('SP003', N'Nước GiaVen', 'Type001', 200000),
('SP004', N'Trái đào', 'Type002', 10000),
('SP005', N'Chén', 'Type001', 100000)
GO

INSERT BanHang(MaNV, MaSP, SoLuong) VALUES
('NV01', 'SP001', 10),
('NV01', 'SP002', 10),
('NV03', 'SP001', 10),
('NV02', 'SP003', 10),
('NV03', 'SP002', 10),
('NV04', 'SP001', 10)


--Question 1
INSERT NhanVien VALUES 
('NV011', N'Nguyễn Chí Phèo', 'Male', N'Nam Định', 36),
('NV07', N'Nguyễn Thị Nở', 'Female', N'Nam Định', 19),
('NV08', N'Nguyễn Văn Quang', 'Male', N'Huế', 22),
('NV09', N'Dương Thị Thúy', 'Female', N'Huế', 25),
('NV010', N'Trần Thị Yến', 'Female', N'Kon Tum', 28)
GO 

-- Question 2 Delete Employee Female live Kon Tum
DELETE FROM NhanVien WHERE QueQuan = N'Kon Tum'
SELECT @@ROWCOUNT

-- Question 3 tang gia tri san pham thuoc loai Type001
UPDATE SanPham SET GiaBan = GiaBan*2 WHERE MaLoaiSP = 'Type001'
SELECT @@ROWCOUNT

-- Question 4 Liet ke toan bo thong tin nhan vien trong cty
SELECT * FROM NhanVien

-- Question 5 Liet ke nhung nhan vien 23 tuoi tro len va que o binh dinh
SELECT * FROM NhanVien WHERE Tuoi >= 23 AND QueQuan = N'Bình Định'

-- Question 6 Lệt kê những Mã sản phẩm của sản phẩm đã được bán
SELECT SanPham.MaSP FROM SanPham WHERE TenSP IN (
SELECT SanPham.TenSP FROM SanPham INNER JOIN BanHang ON SanPham.MaSP = BanHang.MaSP GROUP BY SanPham.TenSP
)

-- Question 7 Liệt kê Nhân viên có họ Nguyễn
SELECT * FROM NhanVien WHERE HoTenNV LIKE N'Nguyễn %'

--Question 8 Liệt kê Nhân viên tên Hoa
SELECT * FROM NhanVien WHERE HoTenNV LIKE N'%Hoa'

--Question 9 Liệt kê sản phẩm tên bao gồm 12 ký tự
SELECT * FROM SanPham WHERE LEN(TenSP) = 12

--Question 10 Liệt kê sản phẩm thuộc loại mỹ phẩm
SELECT * FROM SanPham INNER JOIN LoaiSP ON SanPham.MaLoaiSP =LoaiSP.MaLoaiSP WHERE LoaiSP.TenLoaiSP = N'Mỹ phẩm'

-- Question 11 Liệt kê sản phẩm giá bản < 20000 hoặc chưa từng được bán lần nào
SELECT * FROM SanPham WHERE GiaBan < 20000 OR TenSP NOT IN (
SELECT SanPham.TenSP FROM SanPham INNER JOIN BanHang ON SanPham.MaSP = BanHang.MaSP GROUP BY SanPham.TenSP
)

-- Question 12 Liệt kê những nhân viên chưa bán được sản phẩm nào và những nhân viên chỉ bản được sản phẩm nước tẩy rửa áo quần
SELECT * FROM NhanVien WHERE MaNV NOT IN (
SELECT NhanVien.MaNV FROM NhanVien INNER JOIN BanHang ON NhanVien.MaNV = BanHang.MaNV INNER JOIN SanPham ON SanPham.MaSP = BanHang.MaSP WHERE TenSP != N'Nước tẩy rửa áo quần'
)

-- Question 13 Liet ke nhung nhan vien que o Gia Lai va chua tung ban sp nao
SELECT * FROM NhanVien WHERE MaNV NOT IN (
SELECT NhanVien.MaNV FROM NhanVien INNER JOIN BanHang ON BanHang.MaNV = NhanVien.MaNV INNER JOIN SanPham ON SanPham.MaSP = BanHang.MaSP
) AND QueQuan = N'Kon Tum'

--Query 14 Hãy liệt kê MaSP, TênSP, Mã Loại SP, Giá Bán, Tên Loại SP của tất cả những sản phẩm đã có niêm yết giá bán
SELECT SanPham.MaSP, SanPham.TenSP, SanPham.MaLoaiSP, SanPham.GiaBan, LoaiSP.TenLoaiSP FROM SanPham INNER JOIN LoaiSP ON SanPham.MaLoaiSP =LoaiSP.MaLoaiSP WHERE SanPham.GiaBan != null

-- Query 15 Hãy liệt kê MãNV, Họ tên NV, Giới Tính, Quê Quán của nhân viên và mã sản phẩm, tên sản phẩm, loại sản phẩm, tên loại sản phẩm, 
--số lượng đã bán của tất cả các những nhân viên đã từng bán được hàng.
SELECT NhanVien.MaNV, NhanVien.HoTenNV, NhanVien.GioiTinh, NhanVien.QueQuan, SanPham.MaSP, SanPham.TenSP, LoaiSP.MaLoaiSP, LoaiSP.TenLoaiSP, BanHang.SoLuong FROM NhanVien INNER JOIN BanHang ON NhanVien.MaNV = BanHang.MaNV INNER JOIN SanPham ON SanPham.MaSP = BanHang.MaSP INNER JOIN LoaiSP ON LoaiSP.MaLoaiSP =SanPham.MaLoaiSP

-- Question 16 Hãy liệt kê Mã Loại SP, Tên loại SP của những loại sản phẩm đã từng được bán 
SELECT LoaiSP.TenLoaiSP, LoaiSP.MaLoaiSP FROM LoaiSP WHERE MaLoaiSP IN (
SELECT SanPham.MaLoaiSP FROM SanPham INNER JOIN BanHang ON SanPham.MaSP = BanHang.MaSP GROUP BY SanPham.MaLoaiSP
)

-- Question 17 Liệt kê tên của nhân viên, nếu trùng thì hiển thị 1 lần
SELECT DISTINCT NhanVien.HoTenNV FROM NhanVien

--Question 18 Hãy liệt kê MaNV, TênNV, Quê Quán của tất cả nhân viên, nếu bạn nào chưa có quê quán thì mục quê quán sẽ hiển thị là 'Cõi trên xuống'
SELECT NhanVien.MaNV, NhanVien.HoTenNV, COALESCE(NhanVien.QueQuan, N'Cõi trên xuống') AS QueQuan FROM NhanVien 
SELECT NhanVien.MaNV, NhanVien.HoTenNV, ISNULL(NhanVien.QueQuan, N'Cõi trên xuống') AS QueQuan FROM NhanVien 
-- COALESCE thì có thể dùng với nhiều thuộc tính 

-- Question 19 Hãy liệt kê 5 nhân viên có tuổi đời cao nhất trong công ty
SELECT TOP 5 WITH TIES * FROM NhanVien ORDER BY Tuoi DESC

--Question 20 Hãy liệt kê những nhân viên có tuổi đời từ 25 đến 35 tuổi
SELECT * FROM NhanVien WHERE Tuoi BETWEEN 25 AND 35


-- BT2
-- Question 1Liệt kê mã loại sản phẩm và số lượng sản phẩm của từng loại sản phẩm
SELECT SanPham.MaLoaiSP, COUNT(SanPham.MaLoaiSP) FROM SanPham INNER JOIN LoaiSP ON SanPham.MaLoaiSP = LoaiSP.MaLoaiSP GROUP BY(SanPham.MaLoaiSP)

-- Question 2Liệt kê mã nhân viên, họ tên nhân viên và mã sản phẩm của những sản phẩm mà nhân viên đó đã bán
SELECT NhanVien.MaNV, NhanVien.HoTenNV, SanPham.MaSP FROM NhanVien INNER JOIN BanHang ON NhanVien.MaNV = BanHang.MaNV INNER JOIN SanPham ON BanHang.MaSP = SanPham.MaSP ORDER BY NhanVien.MaNV

-- Question 3 Liệt kê mã nhân viên, họ tên nhân viên và mã sản phẩm của những sản phẩm mà nhân viên đó đã bán
SELECT NhanVien.MaNV, NhanVien.HoTenNV, SanPham.MaSP FROM NhanVien LEFT JOIN BanHang ON NhanVien.MaNV = BanHang.MaNV LEFT JOIN SanPham ON BanHang.MaSP = SanPham.MaSP ORDER BY NhanVien.MaNV

-- Question 4 Liệt kê mã sản phẩm, tên sản phẩm, mã loại sản phẩm, tên loại sản phẩm của tất cả các sản phẩm hiện có
SELECT SanPham.MaSP, SanPham.TenSP, LoaiSP.MaLoaiSP, LoaiSP.TenLoaiSP FROM SanPham INNER JOIN LoaiSP ON SanPham.MaLoaiSP = LoaiSP.MaLoaiSP

-- Question 5 Liệt kê những nhân viên đã từng bán được ít nhất 10 sản phẩm
SELECT DISTINCT NhanVien.MaNV, NhanVien.HoTenNV FROM NhanVien INNER JOIN BanHang ON NhanVien.MaNV = BanHang.MaNV INNER JOIN SanPham ON BanHang.MaSP = SanPham.MaSP GROUP BY NhanVien.MaNV, NhanVien.HoTenNV  HAVING SUM(BanHang.SoLuong) >=10 ORDER BY NhanVien.MaNV

--Query 6 Liệt kê các loại sản phẩm có ít nhất 20 sản phẩm, ngoại trừ loại sản phẩm: Kem dưỡng da
SELECT LoaiSP.MaLoaiSP, LoaiSP.TenLoaiSP FROM LoaiSP INNER JOIN SanPham ON SanPham.MaLoaiSP = LoaiSP.MaLoaiSP GROUP BY LoaiSP.MaLoaiSP, LoaiSP.TenLoaiSP HAVING COUNT(SanPham.MaSP) >= 1 AND LoaiSP.TenLoaiSP NOT IN (N'Sản phẩm Gia Dụng')

-- Query 7 Liệt kê số lượng nhân viên phân loại theo giới tính, quê quán và tuổi (cùng giới tính, quê quán và tuổi thì cùng nhóm)
SELECT COUNT(*), NhanVien.Tuoi FROM NhanVien GROUP BY NhanVien.GioiTinh, NhanVien.QueQuan, NhanVien.Tuoi

--Question 8 Liệt kê mã nhân viên, tên sản phẩm, loại sản phẩm của sản phẩm mà nhân viên đó đã bán cho mỗi một nhân viên

--Question 9 Đếm số lượng nhân viên đã bán sản phẩm có mã sản phẩm là 'SP001'
SELECT COUNT(*) FROM NhanVien INNER JOIN BanHang ON BanHang.MaNV = NhanVien.MaNV INNER JOIN SanPham ON BanHang.MaSP = SanPham.MaSP WHERE SanPham.MaSP = 'SP001'

--Question 10 Đếm số lượng nhân viên có quê ở Hà Tĩnh từng bán các sản phẩm thuộc loại sản phẩm có tên là 'Bột giặt'
SELECT COUNT(*) FROM NhanVien WHERE MaNV IN (
SELECT NhanVien.MaNV FROM NhanVien INNER JOIN BanHang ON BanHang.MaNV = NhanVien.MaNV INNER JOIN SanPham ON  BanHang.MaSP = SanPham.MaSP INNER JOIN LoaiSP ON SanPham.MaLoaiSP = LoaiSP.MaLoaiSP WHERE NhanVien.QueQuan = N'Huế' AND LoaiSP.TenLoaiSP = N'Sản phẩm gia dụng'
)