--set statistics time on;
--------------------------------------------------------INDEX QUẬN--------------------------------------------------------
--DECLARE @Quan nvarchar(100)
--SET @Quan = N'Quận 6'
--SELECT DonHang.* FROM DonHang INNER JOIN CuaHang ON DonHang.MaCH=CuaHang.MaCH
--	INNER JOIN KhachHang ON KhachHang.SDT=DonHang.MaKH
--WHERE CuaHang.Quan = @Quan

CREATE NONCLUSTERED INDEX idx_ma_cua_hang
ON DonHang (MaCH) 
INCLUDE (MaDH, MaNV, MAKH, NgayLap, MaTT, MaTinhTrang, SoThe, TongTien, ChietKhau, LoaiDH, TichLuy)

CREATE NONCLUSTERED INDEX idx_cua_hang_quan
ON CuaHang (Quan)


--------------------------------------------------------INDEX MÃ SẢN PHẨM--------------------------------------------------------
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


--------------------------------------------------------INDEX MÃ LOẠI HÀNG TRONG SanPham--------------------------------------------------------
----Query 1
--SELECT SanPham.*, LoaiHang.MoTa FROM SanPham INNER JOIN LoaiHang ON SanPham.MaLoai=LoaiHang.MaLoai
----Query 2
--SELECT SanPham.* FROM SanPham INNER JOIN LoaiHang ON SanPham.MaLoai=LoaiHang.MaLoai
--WHERE LoaiHang.MoTa = N'Sữa bột cao cấp'

CREATE NONCLUSTERED INDEX idx_ma_loai_hang
ON SanPham (MaLoai)
INCLUDE (MaTH, TenSP, DonGia, GiamGia, SLDaBan)


--------------------------------------------------------INDEX MÃ KHÁCH HÀNG TRONG DonHang--------------------------------------------------------
----Query test
--SELECT * FROM DonHang INNER JOIN KhachHang ON DonHang.MaKH=KhachHang.SDT

CREATE NONCLUSTERED INDEX idx_ma_khach_hang
ON DonHang (MaKH)
INCLUDE (MaDH, MaNV, MaCH, NgayLap, MaTT, MaTinhTrang, SoThe, TongTien, ChietKhau, LoaiDH, TichLuy)


--------------------------------------------------------INDEX SỐ LƯỢNG TỒN TRONG CH_SP-------------------------------------------------------
----Query test
--SELECT SanPham.* FROM SanPham INNER JOIN CH_SP ON CH_SP.MaSP=SanPham.MaSP INNER JOIN CuaHang ON CuaHang.MaCH=CH_SP.MaCH
--WHERE CH_SP.SoLuongTon < 100 AND CuaHang.MaCH = 'CH000001'

CREATE NONCLUSTERED INDEX idx_so_luong_ton
ON CH_SP (MaCH,SoLuongTon)


--------------------------------------------------------INDEX SỐ LƯỢNG CTDH-------------------------------------------------------
----Query test: Tìm sản phẩm được bán nhiều nhất trong mỗi đơn hàng
--SELECT MaDH, MaSP FROM CTDH
--GROUP BY MaDH, MaSP
--HAVING SUM(SoLuong) >= ALL (SELECT SUM(ct2.SoLuong) FROM CTDH ct2 GROUP BY ct2.MaSP, ct2.MaDH)

CREATE NONCLUSTERED INDEX idx_so_luong_ctdh
ON CTDH (SoLuong)
