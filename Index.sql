--set statistics time on;
--------------------------------------------------------INDEX QUẬN--------------------------------------------------------
--DECLARE @Quan nvarchar(100)
--SET @Quan = N'Quận 6'
--SELECT DonHang.* FROM DonHang INNER JOIN CuaHang ON DonHang.MaCH=CuaHang.MaCH
--	INNER JOIN KhachHang ON KhachHang.SDT=DonHang.MaKH
--WHERE CuaHang.Quan = @Quan

CREATE NONCLUSTERED INDEX idx_don_hang
ON DonHang (MaCH) 
INCLUDE (MaDH, MaNV, MAKH, NgayLap, MaTT, MaTinhTrang, SoThe, TongTien, ChietKhau, LoaiDH, TichLuy)


--------------------------------------------------------INDEX TÊN SẢN PHẨM--------------------------------------------------------
----Query 1
--SELECT * FROM CTDH INNER JOIN SanPham ON CTDH.MaSP = SanPham.MaSP
----Query 2
--SELECT * FROM CTDH INNER JOIN SanPham ON CTDH.MaSP = SanPham.MaSP
--WHERE SanPham.TenSP LIKE N'%sữa%'

CREATE NONCLUSTERED INDEX idx_ten_sp
ON CTDH (MaSP)
INCLUDE (TenSP, SoLuong, DonGia, ThanhTien)


--------------------------------------------------------INDEX THƯƠNG HIỆU--------------------------------------------------------
----Query 1
--SELECT * FROM SanPham INNER JOIN ThuongHieu ON SanPham.MaTH=ThuongHieu.MaTH
----Query 2
--SELECT * FROM SanPham INNER JOIN ThuongHieu ON SanPham.MaTH=ThuongHieu.MaTH
--WHERE ThuongHieu.Ten LIKE N'%Baby%'

CREATE NONCLUSTERED INDEX idx_thuong_hieu
ON SanPham (MaTH)
INCLUDE (MaLoai, TenSp, DonGia, GiamGia, SLDaBan)


--------------------------------------------------------INDEX THƯƠNG HIỆU--------------------------------------------------------