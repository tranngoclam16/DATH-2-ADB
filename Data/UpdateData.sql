--UPDATE CuaHang
--SET TGMoCua = 7, TGDongCua = 22, TinhTrangCH = N'Hoạt động'

-- UPDATE 1--NV quản lý trong nhân viên
CREATE TABLE #tempUP1 (MaCH varchar(8) , MaNVQL varchar(8))
INSERT INTO #tempUP1 (MaCH, MaNVQL)
	SELECT MaCH, NVQuanLy FROM CuaHang
UPDATE NhanVien
SET NhanVien.QuanLy = #tempUP1.MaNVQL
FROM NhanVien JOIN #tempUP1 ON NhanVien.MaCH = #tempUP1.MaCH
DROP TABLE #tempUP1

-- UPDATE 2--MaCH trong đơn hàng
CREATE TABLE #tempUP2 (MaCH varchar(8) , MaNV varchar(8))
INSERT INTO #tempUP2 (MaCH, MaNV)
	SELECT MaCH, MaNV FROM NhanVien
UPDATE DonHang
SET DonHang.MaCH = #tempUP2.MaCH
FROM DonHang INNER JOIN #tempUP2 ON DonHang.MaNV = #tempUP2.MaNV
DROP TABLE #tempUP2

-- UPDATE 3--Chiết khấu, Loại ĐH
UPDATE DonHang
SET ChietKhau = 0,
	LoaiDH =
	CASE MaTT
		WHEN 6 THEN 1
		ELSE 2
	END

-- UPDATE 4--Tích lũy trong đơn hàng
CREATE TABLE #tempUP4 (MaKH varchar(10) , LoaiThe int)
INSERT INTO #tempUP4 (MaKH, LoaiThe)
	SELECT SDT, LoaiThe FROM KhachHang
UPDATE DonHang
SET DonHang.TichLuy =
	CASE #tempUP4.LoaiThe
		WHEN 1 then 1
		WHEN 2 then 3
		WHEN 3 then 5
	END
FROM DonHang INNER JOIN #tempUP4 ON DonHang.MaKH = #tempUP4.MaKH
DROP TABLE #tempUP4

-- UPDATE 5--TenSP, DonGia trong CTDH
CREATE TABLE #tempUP5 (MaSP bigint, TenSP nvarchar(100), DonGia int)
INSERT INTO #tempUP5 (MaSP, TenSP, DonGia)
	(SELECT MaSP, TenSP, (DonGia-GiamGia) as DonGia FROM SanPham)
UPDATE CTDH
SET CTDH.TenSP = #tempUP5.TenSP,
	CTDH.DonGia = #tempUP5.DonGia
FROM CTDH INNER JOIN #tempUP5 ON CTDH.MaSP = #tempUP5.MaSP
DROP TABLE #tempUP5

--UPDATE 6--ThanhTien
UPDATE CTDH
SET ThanhTien = SoLuong*DonGia

--UPDATE 7--Tổng tiền trong đơn hàng
CREATE TABLE #tempUP7 (MaDH bigint, TongTien int)
INSERT INTO #tempUP7 (MaDH, TongTien)
	SELECT MaDH, SUM(ThanhTien) FROM CTDH GROUP BY MaDH
UPDATE DonHang
SET DonHang.TongTien = #tempUP7.TongTien
FROM DonHang INNER JOIN #tempUP7 ON DonHang.MaDH = #tempUP7.MaDH
DROP TABLE #tempUP7

--UPDATE 8--Tiền tích lũy của khách hàng
CREATE TABLE #tempUP8 (MaKH varchar(10), TienTichLuy int)
INSERT INTO #tempUP8 (MaKH, TienTichLuy)
	SELECT MaKH, SUM(TongTien / 100 * TichLuy) AS TienTichLuy FROM DonHang GROUP BY MaKH
UPDATE KhachHang
SET KhachHang.TienTichLuy = #tempUP8.TienTichLuy
FROM KhachHang INNER JOIN #tempUP8 ON #tempUP8.MaKH=KhachHang.SDT

--UPDATE 9--Tên Sản phẩm trong CH_SP
CREATE TABLE #tempUP9 (MaSP bigint, TenSP nvarchar(100))
INSERT INTO #tempUP9 (MaSP, TenSP)
	(SELECT MaSP, TenSP as DonGia FROM SanPham)
UPDATE CH_SP
SET CH_SP.TenSP = #tempUP9.TenSP
FROM CH_SP INNER JOIN #tempUP9 ON CH_SP.MaSP = #tempUP9.MaSP
DROP TABLE #tempUP9
