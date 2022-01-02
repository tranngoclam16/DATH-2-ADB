use DATH#2
GO

--Tạo tài khoản khách hàng
create PROC sp_CreateAccount_KH
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
			INSERT INTO KhachHang VALUES (@HoTen,@SDT,1,@GioiTinh,@NgaySinh,@DiaChi,@Email,@pword, 0); 
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
	@start int,
	@num int, 
	@bd date,
	@kt date,
	@mach varchar(8),
	@doanhthu bigint output,
	@sldaban int output,
	@tong int output
as
BEGIN
	select @doanhthu= (select sum(DH.TongTien) from DonHang DH where DH.MaCH=@mach and DH.NgayLap>=@bd and DH.NgayLap<=@kt)
	select @sldaban= (select sum(CTDH.SoLuong) FROM DonHang DH join CTDH on DH.MaDH= CTDH.MaDH
						where DH.MaCH= @mach and DH.NgayLap>=@bd and DH.NgayLap<=@kt)

	select @tong=count(*) 
	from CH_SP where CH_SP.MaCH=@mach
	SELECT * 
	FROM (SELECT ROW_NUMBER() OVER (ORDER BY (T.sldb) DESC) AS ROWNUMBER,CH_SP.MaCH,CH_SP.MaSP, CH_SP.TenSP,T.sldb,CH_SP.SoLuongTon
         FROM CH_SP 
		LEFT join (select CTDH.MaSP,sum(CTDH.SoLuong) as 'sldb'
					FROM DonHang DH join CTDH on DH.MaDH= CTDH.MaDH
					where DH.MaCH=@mach and DH.NgayLap>=@bd and DH.NgayLap<=@kt 
					group by (CTDH.MaSP)) AS T
	on T.MaSP=CH_SP.MaSP
	where CH_SP.MaCH=@mach )  AS U 
	WHERE U.ROWNUMBER >= @start AND U.ROWNUMBER < (@start+@num)
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
------------------------------------------------------------------------------
--Thống kê doanh thu đã bán theo ngày của hệ thống
create procedure getStoreStatisticALL
	@bd date,
	@kt date,
	@doanhthu bigint output,
	@sldaban int output
as
BEGIN
	select @doanhthu= (select sum(DH.TongTien) from DonHang DH where DH.NgayLap>=@bd and DH.NgayLap<=@kt)
	select @sldaban= (select sum(CTDH.SoLuong) FROM DonHang DH join CTDH on DH.MaDH= CTDH.MaDH
						where DH.NgayLap>=@bd and DH.NgayLap<=@kt)

	select CuaHang.MaCH,CuaHang.DiaChi,CuaHang.Phuong,CuaHang.Quan,CuaHang.ThanhPho,
			CuaHang.ThanhPho,CuaHang.SDT,CuaHang.NVQuanLy,T.DoanhThu
	from CuaHang
	LEFT join (select DH.MaCH,sum(DH.TongTien) AS 'DoanhThu'
					FROM DonHang DH 
					where DH.NgayLap>=@bd and DH.NgayLap<=@kt 
					group by (DH.MaCH)) AS T
	on T.MaCH= CuaHang.MaCH
END
GO
--DROP PROC getStoreStatisticALL
------------------------------------------------------------------------------
--Doanh Thu Nhân Viên
create procedure getDTNV
	@bd date,
	@kt date
as
BEGIN
	select NhanVien.MaNV,NhanVien.MaCH,NhanVien.QuanLy,NhanVien.HoTen, NhanVien.CMND, SDT, 
	convert(varchar, NgaySinh, 113) as NgaySinh, convert(varchar, NgayVaoLam, 113) as NgayVaoLam,
	T.DoanhThu
	from NhanVien
	LEFT join (select DH.MaNV,sum(DH.TongTien) AS 'DoanhThu'
					FROM DonHang DH 
					where DH.NgayLap>=@bd and DH.NgayLap<=@kt 
					group by (DH.MaNV)) AS T
	on T.MaNV= NhanVien.MaNV
END
GO
--DROP PROC getDTNV
------------------------------------------------------------------------------
--Thêm sản phẩm
create procedure addProduct
	@maloai int,
	@math int,
	@tensp nvarchar(100),
	@dongia int,
	@giamgia int
as
BEGIN
	insert into SanPham values (@maloai,@math,@tensp,@dongia,@giamgia,0)
END
GO
--DROP PROC addProduct




create procedure getProductList
	(@start int, @num int, @search nvarchar(max))
as
begin

	SELECT * 
	FROM (SELECT ROW_NUMBER() OVER (ORDER BY SP.MaSP) AS ROWNUMBER,SP.MaSP, SP.TenSP, convert(varchar,cast(DonGia as money), 1) as DonGia, convert(varchar,cast(DonGia-GiamGia as money), 1) as GiamGia 
         FROM SanPham SP 
		 where charindex(@search, TenSP) !=0)  AS T 
	WHERE T.ROWNUMBER >= @start AND T.ROWNUMBER < (@start+@num)
end


go
create procedure getFilteredProduct (@start int, @num int, @lh varchar(max), @th varchar(max), @search nvarchar(max))
as
begin
	if (@lh != '')
	begin
		SELECT * 
		FROM (SELECT ROW_NUMBER() OVER (ORDER BY SP.MaSP) AS ROWNUMBER, MaSP, TenSP, convert(varchar,cast(DonGia as money), 1) as DonGia, convert(varchar,cast(DonGia-GiamGia as money), 1) as GiamGia
			FROM SanPham SP 
			WHERE CHARINDEX(cast(MaLoai as varchar(10)), @lh) > 0 and charindex(@search, TenSP) !=0)  AS T 
		WHERE T.ROWNUMBER >= @start AND T.ROWNUMBER <= (@start+@num)
	end
	else if (@th != '')
	begin
		SELECT * 
		FROM (SELECT ROW_NUMBER() OVER (ORDER BY SP.MaSP) AS ROWNUMBER, MaSP, TenSP, convert(varchar,cast(DonGia as money), 1) as DonGia, convert(varchar,cast(DonGia-GiamGia as money), 1) as GiamGia
			FROM SanPham SP 
			WHERE CHARINDEX(cast(MaLoai as varchar(10)), @th) > 0 and charindex(@search, TenSP) !=0)  AS T 
		WHERE T.ROWNUMBER > @start AND T.ROWNUMBER < (@start+@num)
	end
	else
	begin
		SELECT * 
		FROM (SELECT ROW_NUMBER() OVER (ORDER BY SP.MaSP) AS ROWNUMBER, MaSP, TenSP, convert(varchar,cast(DonGia as money), 1) as DonGia, convert(varchar,cast(DonGia-GiamGia as money), 1) as GiamGia
			FROM SanPham SP 
			WHERE CHARINDEX(cast(MaLoai as varchar(10)), @lh) > 0 or CHARINDEX(cast(MaLoai as varchar(10)), @lh) > 0 and charindex(@search, TenSP) !=0)  AS T 
		WHERE T.ROWNUMBER > @start AND T.ROWNUMBER <= (@start+@num)
	end
end
go

create proc getProductDetail (@masp int)
as
begin
	select TenSP, DonGia, convert(varchar,cast(DonGia-GiamGia as money), 1) as GiamGia, TH.Ten as TenTH
	from SanPham SP join ThuongHieu TH on SP.MaTH = TH.MaTH
	where SP.MaSP = @masp
end
go

create PROCEDURE sp_ThemDonHang
	@MaKH varchar(10),
	@DiaChi nvarchar(30),
	@Phuong nvarchar(30),
	@Quan nvarchar(30),
	@Tinh nvarchar(30),
	@TenNguoiNhan nvarchar(100),
	@SDT varchar(10),
	@TongTien float,
	@ThanhToan int,
	@MaDonHang int output
AS
BEGIN
	BEGIN TRAN
		BEGIN TRY
			declare @TichLuy int
			 select @TichLuy = case
				when LoaiThe = 1 then 1
				when LoaiThe = 2 then 3
				when LoaiThe = 3 then 5
				end
			from KhachHang
			where SDT = @MaKH

			
			INSERT INTO DonHang (MaKH, NgayLap, MaTT, TongTien, ChietKhau, TichLuy, LoaiDH) 
			VALUES (@MaKH, getDate(),@ThanhToan, @TongTien, 0, @TichLuy, 2)

			insert into PhieuGiaoHang (MaDH, NguoiNhan, SDT, DiaChi, Phuong, Quan, ThanhPho, TienHang, PhiVanChuyen)
			Values(@MaDonHang, @TenNguoiNhan, @SDT, @DiaChi, @Phuong, @Quan, @Tinh, @TongTien, @TongTien /100 *5)
			
			select @MaDonHang= MaDH 
			from DonHang 
			where MaKH = @MaKH and NgayLap >= all (select NgayLap
													from DonHang where MaKH = @MaKH)
			select @MaDonHang
		COMMIT TRAN
		END TRY
		BEGIN CATCH
			IF @@trancount>0
				BEGIN	
					print('loi')
					ROLLBACK TRANSACTION 
				END
		END CATCH
END
GO
declare @s int
exec sp_ThemDonHang '0930000000', '5', '5', '5', '5', '5', '5', 19, 1, @MaDonHang = @s output
select @s

go

create PROCEDURE sp_ThemChiTietDonHang
	(@MaDH int,
	@MaSP varchar(6),
	@SoLuong int,
	@Quan nvarchar(max),
	@error int output)
AS
BEGIN 
		BEGIN TRY
			if not exists (select * from DonHang where @MaDH= MaDH)
				begin
					print('1')
					raiserror(N'Không tồn tại đơn hàng',15,1)
				end
			declare @sl int, @ch varchar(10)
			set @ch = (select top 1 MaCH
			from CuaHang
			where Quan = @Quan)
			if not exists (select * from CH_SP where MaSP=@MaSP and MaCH = @ch)
				begin
					set @error=3
					return
				end
			set @sl=(select SoLuongTon from CH_SP where MaSP=@MaSP and MaCH = @ch)
			print(@sl)
			if (@sl-@SoLuong>=0)
			begin
					INSERT INTO CTDH(MaDH,MaSP,SoLuong) VALUES(@MaDH,@MaSP,@SoLuong)
					set @error=0
					return
			end
			else
			begin
				print('2')
				set @error=2
				raiserror(N'Số lượng đặt vượt quá số lượng trong kho',15,1)
			end
		END TRY
		BEGIN CATCH
			IF @@trancount>0
				BEGIN	
					print(N'Lỗi')
				END
		END CATCH
END
go
create PROCEDURE sp_XoaDonHang
	(@MaDH int)
AS
BEGIN
	BEGIN TRAN
		BEGIN TRY
			IF NOT EXISTS (SELECT * FROM DonHang WHERE MaDH = @MaDH)
				begin
				print('2')
				raiserror(N'Không tồn tại đơn hàng',15,1)
				end
			ELSE
				BEGIN
				DELETE FROM CTDH WHERE MaDH = @MaDH
				DELETE FROM DonHang WHERE MaDH = @MaDH
				delete from PhieuGiaoHang where MaDH = @MaDH
				END
		COMMIT TRAN
		END TRY
	BEGIN CATCH
		IF @@trancount>0
				BEGIN	
					print(N'Lỗi')
					ROLLBACK TRANSACTION 
				END
		END CATCH
END
GO

