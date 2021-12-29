use DATH#2
GO

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