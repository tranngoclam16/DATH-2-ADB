use DATH#2
go

CREATE TRIGGER SanPham_CTDH on CTDH
for INSERT, UPDATE
as
BEGIN
	IF TRIGGER_NESTLEVEL() > 1
		RETURN

	UPDATE CTDH
	SET TenSP = (SELECT SP.TenSP
				from SanPham SP
				WHERE CTDH.MaSP = SP.MaSP)
	WHERE EXISTS(SELECT * from INSERTED I WHERE I.MaDH = CTDH.MaDH)

	DECLARE @dongia int, @giamgia int
	UPDATE CTDH
	SET @dongia = (SELECT SP.DonGia
				from SanPham SP
				WHERE CTDH.MaSP = SP.MaSP),
		@giamgia = (SELECT SP.GiamGia
				from SanPham SP
				WHERE CTDH.MaSP = SP.MaSP),
		DonGia = @dongia - @giamgia
	WHERE EXISTS(SELECT * from INSERTED I WHERE I.MaDH = CTDH.MaDH)
END
GO

CREATE TRIGGER ThanhTien_TongTien_TichLuy on CTDH
for INSERT, UPDATE, DELETE
as
DECLARE @loaithe int
BEGIN
	IF TRIGGER_NESTLEVEL() > 1
		RETURN

	UPDATE CTDH
	SET ThanhTien = DonGia * SoLuong
	WHERE EXISTS(SELECT * from INSERTED I WHERE I.MaDH = CTDH.MaDH)

	UPDATE DonHang
	SET TongTien = (SELECT SUM(CTDH.ThanhTien)
					from CTDH
					WHERE CTDH.MaDH = DonHang.MaDH)
	WHERE EXISTS(SELECT * from INSERTED I WHERE I.MaDH = DonHang.MaDH)
	or EXISTS(SELECT * from DELETED D WHERE D.MaDH = DonHang.MaDH)

	SET @loaithe = (SELECT KH.LoaiThe
					from DonHang DH join KhachHang KH on DH.MaKH = KH.SDT
					WHERE EXISTS(SELECT * from INSERTED I WHERE I.MaDH = DH.MaDH))

	IF (@loaithe = 1) --Thẻ thường
		UPDATE DonHang
		SET TichLuy = TongTien*1/100
		WHERE EXISTS(SELECT * from INSERTED I WHERE I.MaDH = DonHang.MaDH)

	ELSE IF (@loaithe = 2) --Thẻ VIP GOLD
		UPDATE DonHang
		SET TichLuy = TongTien*3/100
		WHERE EXISTS(SELECT * from INSERTED I WHERE I.MaDH = DonHang.MaDH)

	ELSE IF (@loaithe = 3) --Thẻ VIP DIAMOND
		UPDATE DonHang
		SET TichLuy = TongTien*5/100
		WHERE EXISTS(SELECT * from INSERTED I WHERE I.MaDH = DonHang.MaDH)

END
GO

CREATE TRIGGER TichLuy_KH on CTDH
for INSERT, UPDATE
as
BEGIN
	IF TRIGGER_NESTLEVEL() > 1
		RETURN

	UPDATE KhachHang
	SET TienTichLuy = (SELECT SUM(DH.TichLuy)
					from DonHang DH
					WHERE KhachHang.SDT = DH.MaKH)
	WHERE EXISTS(SELECT * from INSERTED I join DonHang DH on I.MaDH = DH.MaDH
					WHERE DH.MaKH = KhachHang.SDT)
	or EXISTS(SELECT * from DELETED D join DonHang DH on D.MaDH = DH.MaDH
					WHERE DH.MaKH = KhachHang.SDT)
END
GO

