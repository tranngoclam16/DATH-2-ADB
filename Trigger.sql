use DATH#2
go

CREATE TRIGGER ThanhTien_CTDH on CTDH
for INSERT, UPDATE
as
BEGIN
	UPDATE CTDH
	SET ThanhTien = SoLuong * DonGia
END
GO

CREATE TRIGGER TongTien_DonHang on DonHang
for INSERT, UPDATE, DELETE
as
BEGIN
	UPDATE DonHang
	SET TongTien = (SELECT SUM(CTDH.ThanhTien - CTDH.ThanhTien * DonHang.ChietKhau)
				from CTDH
				WHERE CTDH.MaDH = DonHang.MaDH)
	WHERE EXISTS(SELECT * from INSERTED I WHERE I.MaDH = DonHang.MaDH)
	or EXISTS(SELECT * from DELETED D WHERE D.MaDH = DonHang.MaDH)
END
GO