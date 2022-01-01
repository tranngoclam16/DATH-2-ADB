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

CREATE TRIGGER ThanhTien_TongTien on CTDH
for INSERT, UPDATE, DELETE
as
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

END
GO

CREATE TRIGGER TichLuy_DH on DonHang
for INSERT
as
BEGIN
	DECLARE @loaithe int
	SET @loaithe = (SELECT KH.LoaiThe
					from DonHang DH join KhachHang KH on DH.MaKH = KH.SDT
					WHERE EXISTS(SELECT * from INSERTED I WHERE I.MaDH = DH.MaDH))

	IF (@loaithe = 1) --Thẻ thường
		UPDATE DonHang
		SET TichLuy = 1
		WHERE EXISTS(SELECT * from INSERTED I WHERE I.MaDH = DonHang.MaDH)

	ELSE IF (@loaithe = 2) --Thẻ VIP GOLD
		UPDATE DonHang
		SET TichLuy = 3
		WHERE EXISTS(SELECT * from INSERTED I WHERE I.MaDH = DonHang.MaDH)

	ELSE IF (@loaithe = 3) --Thẻ VIP DIAMOND
		UPDATE DonHang
		SET TichLuy = 5
		WHERE EXISTS(SELECT * from INSERTED I WHERE I.MaDH = DonHang.MaDH)

END
GO

CREATE TRIGGER TichLuy_KH on DonHang
for UPDATE
as
BEGIN
	IF TRIGGER_NESTLEVEL() > 1
		RETURN

	DECLARE @tichluy int, @tongtien int
	UPDATE KhachHang
	SET @tichluy = (SELECT DH.TichLuy
					from DonHang DH
					WHERE KhachHang.SDT = DH.MaKH),
		@tongtien = (SELECT DH.TongTien
					from DonHang DH
					WHERE KhachHang.SDT = DH.MaKH),
		TienTichLuy = @tongtien * @tichluy / 100
	WHERE EXISTS(SELECT * from INSERTED I WHERE I.MaKH = KhachHang.SDT)
END
GO