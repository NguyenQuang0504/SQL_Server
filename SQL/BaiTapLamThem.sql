CREATE DATABASE BaiTapLamThem2
GO
DROP DATABASE BaiTapLamThem2
CREATE TABLE KHACHHANG 
(
    MaKH CHAR(10) NOT NULL PRIMARY KEY,
    TenKH NVARCHAR(30) NOT NULL,
    Email VARCHAR(30) NOT NULL UNIQUE,
    SoDT CHAR(11) NOT NULL UNIQUE,
    DiaChi NVARCHAR(20) NOT NULL
)

CREATE TABLE SANPHAM 
(
    MaSP CHAR(10) NOT NULL PRIMARY KEY,
    MaDM CHAR(10) NOT NULL,
    TenSP NVARCHAR(30) NOT NULL,
    SoLuong SMALLINT NOT NULL CHECK(SoLuong >=0),
    GiaTien MONEY NOT NULL CHECK(GiaTien >0),
    XuatXu CHAR(5) NOT NULL,
    FOREIGN KEY(MaDM) REFERENCES DMSANPHAM(MaDM)
) 
GO 
DROP TABLE SANPHAM
CREATE TABLE CHITIETDONHANG 
(
    MaDH CHAR(10) NOT NULL,
    MaSP CHAR(10) NOT NULL,
    SoLuong SMALLINT NOT NULL CHECK(SoLuong >=0),
    TongTien MONEY NOT NULL CHECK(TongTien >0),
    CONSTRAINT PK_CTDH PRIMARY KEY(MaDH, MaSP),
    FOREIGN KEY(MaDH) REFERENCES DONHANG(MaDH),
    FOREIGN KEY(MaSP) REFERENCES SANPHAM(MaSP)
)
GO 
DROP TABLE CHITIETDONHANG
CREATE TABLE DONHANG
(
    MaDH CHAR(10) NOT NULL PRIMARY KEY,
    MaKH CHAR(10) NOT NULL,
    MaTT CHAR(10) NOT NULL,
    NgayDat DATE NOT NULL,
    FOREIGN KEY(MaKH) REFERENCES KHACHHANG(MaKH),
    FOREIGN KEY(MaTT) REFERENCES THANHTOAN(MaTT)
)

CREATE TABLE THANHTOAN
(
    MaTT CHAR(10) NOT NULL PRIMARY KEY,
    PhuongThucTT NVARCHAR(20) NOT NULL
)

CREATE TABLE DMSANPHAM 
(
    MaDM CHAR(10) NOT NULL PRIMARY KEY,
    TenDM NVARCHAR(20) NOT NULL,
    MoTa NVARCHAR(50) NULL
)
GO 
ALTER TABLE DMSANPHAM ALTER COLUMN MoTa NVARCHAR(50) NULL
ALTER TABLE SANPHAM ALTER COLUMN XuatXu CHAR(20) NOT NULL

INSERT KHACHHANG VALUES 
('KH001','Tran Van An','antv@gmail.com','0905123564','Lang Son'),
('KH002','Phan Phuoc','phuocp@gmail.com','0932568984','Da Nang'),
('KH003','Tran Huu Anh','anhth@gmail.com','0901865232', 'Ha Noi')

INSERT DMSANPHAM VALUES
('DM01','Thoi Trang Nu', N'vay, ao danh cho nu'),
('DM02', 'Thoi Trang Nam', N'quan danh cho nam'),
('DM03','Trang suc', N'danh cho nu va nam')

INSERT SANPHAM VALUES
('SP001','DM01', N'Dam Maxi', 200, 195000,'VN'),
('SP002', 'DM01', N'Tui Da M???', 50, 3000000, 'HK'),
('SP003', 'DM02', N'Lac tay Uc', 300, 300000, 'HQ')

INSERT THANHTOAN VALUES
('TT01', 'Visa'),
('TT02', 'Master Card'),
('TT03','JCB')

INSERT DONHANG VALUES
('DH001', 'KH002', 'TT01', '20141020'),
('DH002','KH002','TT01', '20150515'),
('DH003', 'KH001','TT03', '20150402')

INSERT CHITIETDONHANG VALUES
('DH001', 'SP002', 3, 56000),
('DH003', 'SP001', 10, 7444),
('DH002', 'SP002', 10, 67144)

-- C??u 1: Li???t k?? th??ng tin to??n b??? S???n ph???m.
Select * from SANPHAM

--Cau 2: X??a to??n b??? kh??ch h??ng c?? DiaChi l?? 'Lang Son'.
DELETE FROM KHACHHANG WHERE DiaChi = N'Lang Son'

-- C??u 3: C???p nh???t gi?? tr??? c???a tr?????ng XuatXu trong b???ng SanPham th??nh 'Viet Nam' ?????i v???i tr?????ng XuatXu c?? gi?? tr??? l?? 'VN'.
UPDATE SANPHAM SET XuatXu = 'Viet Nam' WHERE XuatXu = 'VN'

--C??u 4: Li???t k?? th??ng tin nh???ng s???n ph???m c?? SoLuong l???n h??n 50 thu???c danh m???c l?? 'Thoi trang nu' v?? 
-- nh???ng S???n ph???m c?? SoLuong l???n h??n 100 thu???c danh m???c l?? 'Thoi trang nam'.
SELECT * FROM SANPHAM INNER JOIN DMSANPHAM ON SANPHAM.MaDM = DMSANPHAM.MaDM WHERE (SANPHAM.SoLuong > 50 AND DMSANPHAM.TenDM = 'Thoi trang nu') OR (SANPHAM.SoLuong > 100 AND DMSANPHAM.TenDM = 'Thoi trang nam')

--C??u 5: Li???t k?? nh???ng kh??ch h??ng c?? t??n b???t ?????u l?? k?? t??? 'A' v?? c?? ????? d??i l?? 5 k?? t???.
SELECT * FROM KHACHHANG WHERE KHACHHANG.TenKH LIKE '% A_____'

-- C??u 6: Li???t k?? to??n b??? S???n ph???m, s???p x???p gi???m d???n theo TenSP v?? t??ng d???n theo SoLuong.
SELECT * FROM SANPHAM ORDER BY SANPHAM.TenSP DESC, SoLuong ASC

-- C??u 7 ?????m c??c lo???i s???n ph???m t????ng ???ng theo t???ng kh??ch h??ng ???? ?????t h??ng, ch??? ?????m nh???ng lo???i S???n ph???m ???????c kh??ch hang ?????t h??ng tr??n 5 s???n ph???m.
SELECT COUNT(KHACHHANG.MaKH), KHACHHANG.MaKH, CHITIETDONHANG.MaSP FROM KHACHHANG INNER JOIN DONHANG ON KHACHHANG.MaKH = DONHANG.MaKH INNER JOIN CHITIETDONHANG ON CHITIETDONHANG.MaDH = DONHANG.MaDH
GROUP BY KHACHHANG.MaKH, CHITIETDONHANG.MaSP 

-- C??u 8: Li???t k?? t??n c???a to??n b??? kh??ch h??ng (t??n n??o gi???ng nhau th?? ch??? li???t k?? m???t l???n).
SELECT DISTINCT * FROM KHACHHANG

-- C??u 9: Li???t k?? MaKH, TenKH, TenSP, SoLuong, NgayDat, GiaTien,TongTien (c???a t???t c??? c??c l???n ?????t h??ng c???a kh??ch h??ng).
SELECT KHACHHANG.MaKH, KHACHHANG.TenKH, SANPHAM.TenSP, SANPHAM.SoLuong, DONHANG.NgayDat, SANPHAM.GiaTien, CHITIETDONHANG.TongTien 
FROM KHACHHANG INNER JOIN DONHANG ON DONHANG.MaKH = KHACHHANG.MaKH INNER JOIN CHITIETDONHANG ON CHITIETDONHANG.MaDH = DONHANG.MaDH INNER JOIN SANPHAM ON SANPHAM.MaSP = CHITIETDONHANG.MaSP

-- C??u 10: Li???t k?? MaKH, TenKH, MaDH, TenSP, SoLuong, TongTien c???a t???t c??? c??c l???n ?????t h??ng c???a kh??ch h??ng.
SELECT KHACHHANG.MaKH, KHACHHANG.TenKH, SANPHAM.TenSP, SANPHAM.SoLuong, DONHANG.NgayDat, SANPHAM.GiaTien, CHITIETDONHANG.TongTien 
FROM KHACHHANG INNER JOIN DONHANG ON DONHANG.MaKH = KHACHHANG.MaKH INNER JOIN CHITIETDONHANG ON CHITIETDONHANG.MaDH = DONHANG.MaDH INNER JOIN SANPHAM ON SANPHAM.MaSP = CHITIETDONHANG.MaSP

-- C??u 11: Li???t k?? MaKH, TenKH c???a nh???ng kh??ch h??ng ???? t???ng ?????t h??ng v???i th???c hi???n thanh to??n qua 'Visa' ho???c ???? th???c hi???n thanh to??n qua 'JCB'.
SELECT KHACHHANG.MaKH, KHACHHANG.TenKH FROM KHACHHANG INNER JOIN DONHANG ON DONHANG.MaKH = KHACHHANG.MaKH INNER JOIN CHITIETDONHANG ON CHITIETDONHANG.MaDH = DONHANG.MaDH INNER JOIN SANPHAM ON SANPHAM.MaSP = CHITIETDONHANG.MaSP INNER JOIN THANHTOAN ON THANHTOAN.MaTT = DONHANG.MaTT WHERE THANHTOAN.PhuongThucTT = 'JCB' OR THANHTOAN.PhuongThucTT = 'Visa'

-- C??u 12: Li???t k?? MaKH, TenKH c???a nh???ng kh??ch h??ng ch??a t???ng mua b???t k??? s???n ph???m n??o.
SELECT KHACHHANG.TenKH
FROM KHACHHANG LEFT JOIN DONHANG ON KHACHHANG.MaKH = DONHANG.MaKH LEFT JOIN CHITIETDONHANG ON CHITIETDONHANG.MaDH = DONHANG.MaDH LEFT JOIN SANPHAM ON SANPHAM.MaSP = CHITIETDONHANG.MaSP WHERE CHITIETDONHANG.MaSP IS NULL

-- C??u 13: Li???t k?? MaKH, TenKH, TenSP, SoLuong, GiaTien, PhuongThuc TT, NgayDat, 
-- Tong Tien c???a nh???ng Kh??ch h??ng c?? ?????a ch??? l?? 'Da Nang' v?? m???i th???c hi???n ?????t h??ng m???t l???n duy nh???t. K???t qu??? li???t k?? ???????c s???p x???p t??ng d???n c???a tr?????ng TenKH.
SELECT CHITIETDONHANG.MaDH ,KHACHHANG.MaKH, KHACHHANG.TenKH, SANPHAM.TenSP, SANPHAM.GiaTien, THANHTOAN.PhuongThucTT, DONHANG.NgayDat, CHITIETDONHANG.TongTien FROM KHACHHANG INNER JOIN DONHANG ON DONHANG.MaKH = KHACHHANG.MaKH INNER JOIN CHITIETDONHANG ON CHITIETDONHANG.MaDH = DONHANG.MaDH INNER JOIN SANPHAM ON SANPHAM.MaSP = CHITIETDONHANG.MaSP INNER JOIN THANHTOAN ON THANHTOAN.MaTT = DONHANG.MaTT WHERE KHACHHANG.MaKH IN (
SELECT KHACHHANG.MaKH FROM KHACHHANG INNER JOIN DONHANG ON KHACHHANG.MaKH = DONHANG.MaKH GROUP BY KHACHHANG.MaKH, KHACHHANG.DiaChi HAVING COUNT(KHACHHANG.MaKH) = 2 AND KHACHHANG.DiaChi = 'Da Nang'
) ORDER BY KHACHHANG.TenKH