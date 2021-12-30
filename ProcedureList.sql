use DATH#2
GO

/*
Danh sách các procedure đã tồn tại:

	Tạo tài khoản khách hàng: sp_CreateAccount_KH
	Xem lịch sử tích lũy: getLSTL
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
--------------------------------------------------------------
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
-----------------------------------------------------------------------
--Xem lịch sử tích lũy
create procedure getLSTL
	(@start int,@bd date,@kt date,@makh varchar(10), @num int, @tong int output)
as
begin
	select @tong = count(DH.MaDH) 
	from DonHang DH 
	where DH.MaKH=@makh 
	and DH.NgayLap>=@bd and DH.NgayLap<=@kt

	SELECT * 
	FROM (SELECT ROW_NUMBER() OVER (ORDER BY DH.MaDH) AS ROWNUMBER,DH.MaDH, convert(varchar, NgayLap, 113) as NgayLap, TongTien, LoaiDH,TichLuy,(DH.TongTien*DH.TichLuy*0.01) AS DiemTichLuy
         FROM DonHang DH 
		where DH.MaKH=@makh and DH.NgayLap>=@bd and DH.NgayLap<=@kt )  AS T 
	WHERE T.ROWNUMBER >= @start AND T.ROWNUMBER < (@start+@num)
end
GO
--DROP PROC getLSTL
------------------------------------------------------------------------------
--Thống kê doanh thu đã bán theo ngày, số lượng đã bán, số lượng tồn
create procedure getStoreStatisticByDay
	@bd date,
	@kt date,
	@mach varchar(8),
	@doanhthu float output,
	@sldaban int output
as
BEGIN
	select @doanhthu= (select sum(DH.TongTien) from DonHang DH where DH.MaCH=@mach and DH.NgayLap>=@bd and DH.NgayLap<=@kt)
	select @sldaban= (select sum(CTDH.SoLuong) FROM DonHang DH join CTDH on DH.MaDH= CTDH.MaDH
						where DH.MaCH= @mach and DH.NgayLap>=@bd and DH.NgayLap<=@kt)

	select CH_SP.MaCH,CH_SP.MaSP, CH_SP.TenSP,T.sldb,CH_SP.SoLuongTon
	from CH_SP 
	LEFT join (select CTDH.MaSP,sum(CTDH.SoLuong) as 'sldb'
					FROM DonHang DH join CTDH on DH.MaDH= CTDH.MaDH
					where DH.MaCH=@mach and DH.NgayLap>=@bd and DH.NgayLap<=@kt 
					group by (CTDH.MaSP)) AS T
	on T.MaSP=CH_SP.MaSP
	where CH_SP.MaCH=@mach
END
GO
--DROP PROC getStoreStatisticByDay
-----------------------------------------------------------------------
--Thống kê sản phẩm < n theo cửa hàng
create procedure getTKSLT
	(@start int,@mach varchar(8),@slt int, @num int, @tong int output)
as
begin
	select @tong = count(MaSP)
	from CH_SP
	where CH_SP.MaCH=@mach and SoLuongTon<=@slt

	SELECT * 
	FROM (SELECT ROW_NUMBER() OVER (ORDER BY MaSP) AS ROWNUMBER,MaCH,MaSP, TenSP, SoLuongTon
         FROM CH_SP 
		where CH_SP.MaCH=@mach and CH_SP.SoLuongTon<=@slt )  AS T 
	WHERE T.ROWNUMBER >= @start AND T.ROWNUMBER < (@start+@num)
end
GO
--DROP PROC getTKSLT
-----------------------------------------------------------------------
--Thống kê sản phẩm < n của tất cả cửa hàng
create procedure getTKSLTAll
	(@start int,@slt int, @num int, @tong int output)
as
begin
	select @tong = count(MaSP)
	from CH_SP
	where SoLuongTon<=@slt

	SELECT * 
	FROM (SELECT ROW_NUMBER() OVER (ORDER BY MaSP) AS ROWNUMBER,MaCH,MaSP, TenSP, SoLuongTon
         FROM CH_SP 
		where CH_SP.SoLuongTon<=@slt )  AS T 
	WHERE T.ROWNUMBER >= @start AND T.ROWNUMBER < (@start+@num)
end
GO
--DROP PROC getTKSLTAll
