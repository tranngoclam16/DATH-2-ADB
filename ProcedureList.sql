use DATH#2
GO

/*
Danh sách các procedure đã tồn tại:

	Tạo tài khoản khách hàng: sp_CreateAccount_KH
	Xem lịch sử mua hàng: xem_LichSuMuaHang_KH

*/


--Tạo tài khoản khách hàng
CREATE PROC sp_CreateAccount_KH
	@HoTen nvarchar(100),
	@SDT varchar(10),
	@GioiTinh varchar(3),
	@NgaySinh datetime,
	@DiaChi nvarchar(255),
	@Email varchar(50),
	@pword varchar(20)
AS
BEGIN
	BEGIN TRANSACTION
		BEGIN TRY
			INSERT INTO KhachHang VALUES (@HoTen,@SDT,1,@GioiTinh,@NgaySinh,@DiaChi,@Email,@pword); 
		COMMIT TRANSACTION
		END TRY
		BEGIN CATCH
		IF @@trancount>0
			BEGIN	
				print('loi')
				ROLLBACK TRANSACTION 
			END
	END CATCH
END;
GO
--DROP PROC sp_CreateAccount_KH

--Xem lịch sử mua hàng
CREATE PROCEDURE xem_LichSuMuaHang_KH
	@sdtKH varchar(10)
as
BEGIN TRAN
	if not EXISTS
	(
		SELECT * from KhachHang
		WHERE KhachHang.SDT = @sdtKH
	)
	BEGIN
		Raiserror('Không tồn tại Số điện thoại khách hàng này.', 16, 1)
		ROLLBACK TRAN
	END

	else
	BEGIN
		SELECT * from DonHang
		WHERE DonHang.MaKH = @sdtKH
	END
COMMIT TRAN
GO