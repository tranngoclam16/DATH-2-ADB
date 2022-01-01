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