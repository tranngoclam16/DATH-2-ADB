use DATH#2
go

create procedure getProductList
	(@start int, @num int)
as
begin

	SELECT * 
	FROM (SELECT ROW_NUMBER() OVER (ORDER BY SP.MaSP) AS ROWNUMBER,SP.MaSP, SP.TenSP, convert(varchar,cast(DonGia as money), 1) as DonGia, convert(varchar,cast(GiamGia as money), 1) as GiamGia 
         FROM SanPham SP )  AS T 
	WHERE T.ROWNUMBER >= @start AND T.ROWNUMBER < (@start+@num)
end


go
create procedure getFilteredProduct (@start int, @num int, @lh varchar(max), @th varchar(max))
as
begin
	if (@lh != '')
	begin
		SELECT * 
		FROM (SELECT ROW_NUMBER() OVER (ORDER BY SP.MaSP) AS ROWNUMBER, MaSP, TenSP, convert(varchar,cast(DonGia as money), 1) as DonGia, convert(varchar,cast(GiamGia as money), 1) as GiamGia
			FROM SanPham SP 
			WHERE CHARINDEX(cast(MaLoai as varchar(10)), @lh) > 0)  AS T 
		WHERE T.ROWNUMBER >= @start AND T.ROWNUMBER <= (@start+@num)
	end
	else if (@th != '')
	begin
		SELECT * 
		FROM (SELECT ROW_NUMBER() OVER (ORDER BY SP.MaSP) AS ROWNUMBER, MaSP, TenSP, convert(varchar,cast(DonGia as money), 1) as DonGia, convert(varchar,cast(GiamGia as money), 1) as GiamGia
			FROM SanPham SP 
			WHERE CHARINDEX(cast(MaLoai as varchar(10)), @th) > 0)  AS T 
		WHERE T.ROWNUMBER > @start AND T.ROWNUMBER < (@start+@num)
	end
	else
	begin
		SELECT * 
		FROM (SELECT ROW_NUMBER() OVER (ORDER BY SP.MaSP) AS ROWNUMBER, MaSP, TenSP, convert(varchar,cast(DonGia as money), 1) as DonGia, convert(varchar,cast(GiamGia as money), 1) as GiamGia
			FROM SanPham SP 
			WHERE CHARINDEX(cast(MaLoai as varchar(10)), @lh) > 0 or CHARINDEX(cast(MaLoai as varchar(10)), @lh) > 0)  AS T 
		WHERE T.ROWNUMBER > @start AND T.ROWNUMBER <= (@start+@num)
	end
end
go


