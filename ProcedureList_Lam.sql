use DATH#2
go

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
