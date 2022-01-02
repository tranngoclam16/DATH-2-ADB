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

create TRIGGER SLDaBan_SP on CTDH
for INSERT, UPDATE, DELETE
as
BEGIN
	IF TRIGGER_NESTLEVEL() > 1
		RETURN

	DECLARE @sl int, @masp bigint, @sldb int

	IF EXISTS (SELECT 0 FROM inserted)
	Begin
		SET @sl = (SELECT SoLuong from INSERTED)
		SET @masp = (SELECT SP.MaSP from INSERTED I join SanPham SP on I.MaSP = SP.MaSP)
		SET @sldb = (SELECT SLDaBan from SanPham WHERE SanPham.MaSP = @masp) 

		UPDATE SanPham
		Set SLDaBan = @sldb + @sl
		WHERE EXISTS(SELECT * from INSERTED I WHERE I.MaSP = SanPham.MaSP)
	End

	ELSE
	Begin
		SET @sl = (SELECT SoLuong from DELETED)
		SET @masp = (SELECT SP.MaSP from DELETED D join SanPham SP on D.MaSP = SP.MaSP)
		SET @sldb = (SELECT SLDaBan from SanPham WHERE SanPham.MaSP = @masp) 

		UPDATE SanPham
		Set SLDaBan = @sldb - @sl
		WHERE EXISTS(SELECT * from DELETED D WHERE D.MaSP = SanPham.MaSP)

	End
END
GO

CREATE TRIGGER so_luong_ton
ON CTDH
FOR INSERT, DELETE
AS
BEGIN
DECLARE @mach varchar(8), @slt int, @sl int
IF EXISTS (SELECT 0 FROM inserted)
	BEGIN
		SET @sl = (SELECT SoLuong FROM inserted)
		SET @mach = (SELECT MaCH FROM inserted i JOIN DonHang ON DonHang.MaDH=i.MaDH)
		SET @slt = (SELECT SoLuongTon FROM CH_SP JOIN inserted i ON i.MaSP=CH_SP.MaSP WHERE MaCH = @mach)
		IF (@slt >= @sl)
			BEGIN
				UPDATE CH_SP
				SET SoLuongTon=SoLuongTon-@sl
				FROM CH_SP, inserted i
				WHERE i.MaSP=CH_SP.MaSP AND CH_SP.MaCH=@mach
			END
		ELSE 
			BEGIN
				PRINT(N'Vượt quá số lượng tồn')
				RAISERROR('Vượt quá số lượng tồn của cửa hàng',16,1)
				ROLLBACK TRANSACTION
			END
	END 
ELSE 
	BEGIN
		SET @sl = (SELECT SoLuong FROM deleted)
		SET @mach = (SELECT MaCH FROM deleted d JOIN DonHang ON DonHang.MaDH=d.MaDH)
		--SET @slt = (SELECT SoLuongTon FROM CH_SP JOIN deleted d ON d.MaSP=CH_SP.MaSP WHERE MaCH = @mach)
		UPDATE CH_SP
		SET SoLuongTon=SoLuongTon+@sl
		FROM CH_SP, deleted d
		WHERE d.MaSP=CH_SP.MaSP AND CH_SP.MaCH=@mach
	END 
END

--TEST DATA
--SELECT * FROM CH_SP
--WHERE MaCH='CH000006'
--SELECT * FROM CTDH WHERE MaDH = 0

--INSERT INTO CTDH (MaDH, MaSP, SoLuong) VALUES (0,1,8)
--DELETE FROM CTDH WHERE MaDH = 0 AND MaSP = 1
--INSERT INTO CTDH (MaDH, MaSP, SoLuong) VALUES (0,1,130)
--DELETE FROM CTDH WHERE MaDH = 0 AND MaSP = 1