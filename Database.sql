Create database DATH#2
go

use DATH#2
go

/* 
use master
drop database DATH#2 
*/


--Table: CH_SP           
create table CH_SP (
   MaSP bigint,
   MaCH varchar(8),
   SoLuongTon  int,
   primary key (MaSP, MaCH)
)
go

--Table: CTDH 
create table CTDH (
   MaDH			bigint,
   MaSP			bigint,
   SoLuong		int,
   DonGia		int,
   ThanhTien	int,
   primary key (MaDH, MaSP)
)
go


--Table: CTPD
create table CTPD (
   MaPD					int,
   MaSP					bigint,
   LoaiSP				int,--1 sp đổi ,2 sp nhận
   SoLuongDoi		    int,
   DonGiaDoi			int,
   ThanhTienDoi			int,
   primary key (MaPD, MaSP)
)
go

--Table: CTPN 
create table CTPN (
   MaPN		int,
   MaSP		bigint,
   SoLuong  int,
   primary key (MaPN, MaSP)
)
go


--Table: CTPT
create table CTPT (
   MaPT			int,
   MaSP			bigint,
   SoLuong		int,
   DonGia		int,
   ThanhTien	int,
   primary key (MaPT, MaSP)
)
go

--Table: CuaHang          
create table CuaHang (
   idCH                 int identity(1,1),
   MaCH                 varchar(8),--MaCH='CH'+idCH
   DiaChi               nvarchar(255),
   Phuong				nvarchar(100),
   Quan					nvarchar(100),
   ThanhPho				nvarchar(100),
   SDT                  varchar(10),
   NVQuanLy		        varchar(8),
   TGMoCua              int,
   TGDongCua            int,
   TinhTrangCH          nvarchar(20),
   constraint PK_CUAHANG primary key (MaCH)
)
go

--Table: TinhTrangDonHang  
create table TinhTrangDonHang (
   MaTinhTrang int identity(1,1) ,
   MoTa nvarchar(255)         ,
   constraint PK_TINHTRANGDONHANG primary key (MaTinhTrang)
)
go


--Table: DonHang          
create table DonHang (
   MaDH                 bigint identity(1,1),
   MaNV                 varchar(8),
   MaCH                 varchar(8),
   MaKH 	            varchar(10),
   NgayLap              datetime,
   MaTT					int,
   MaTinhTrang			int,
   SoThe                varchar(20),
   TongTien             int,
   ChietKhau            int,
   LoaiDH				int, --1:offline, 2:online
	TichLuy				int,
   constraint PK_DONHANG primary key (MaDH)
)
go


--Table: HDDienTu         
create table HDDienTu (
   So       int identity(1,1),
   MaDH     bigint,
   CongTy   nvarchar(255),
   DiaChi   nvarchar(255),
   MaSoThue char(10) ,
   constraint PK_HDDIENTU primary key (So)
)
go


--Table: HinhThucThanhToan
create table HinhThucThanhToan (
   MaTT int,
   MoTa nvarchar(255),
   constraint PK_HINHTHUCTHANHTOAN primary key (MaTT)
)
go

--Table: KhachHang        
create table KhachHang (
   HoTen    nvarchar(100),
   SDT      varchar(10), --username
   LoaiThe  int,
   GioiTinh varchar(3),
   NgaySinh datetime,
   DiaChi   nvarchar(255),
   Email    varchar(50),
   pword    varchar (20),
   constraint PK_KHACHHANG primary key (SDT)
)
go

--Table: LoaiHang         
create table LoaiHang (
   MaLoai   int identity(1,1),
   MoTa     nvarchar(255),
   constraint PK_LOAIHANG primary key (MaLoai)
)
go

--Table: NhanVien         
create table NhanVien (
   idNV					int identity (1,1),
   MaNV                 varchar(8),--MaNV ='NV+idNV'
   MaCH                 varchar(8),
   QuanLy               varchar(8),
   HoTen                nvarchar(100),
   CMND                 varchar(12),
   SDT                  varchar(10),
   NgaySinh             datetime ,
   NgayVaoLam           date,
   constraint PK_NHANVIEN primary key (MaNV)
)
go



--Table: PhieuDoi         
create table PhieuDoi (
   MaPD                 int identity(1,1),
   MaDH                 bigint,
   NgayLap              datetime,
   TongDoi				int,
   TongNhan				int,
   TongChenhlLech as (TongDoi-TongNhan),
   LyDo                 nvarchar(255),
   constraint PK_PHIEUDOI primary key (MaPD)
)
go



--Table: PhieuGiaoHang    
create table PhieuGiaoHang (
   MaPGH                int identity(1,1),
   MaDH                 bigint,
   NguoiNhan            varchar(50),
   SDT                  varchar(10),
   DiaChi               nvarchar(255),
   Phuong				nvarchar(100),
   Quan					nvarchar(100),
   ThanhPho				nvarchar(100),
   PhiVanChuyen         int,
   TienHang             int,
   TongThu              int,
   DVVanChuyen          nvarchar(100),
   constraint PK_PHIEUGIAOHANG primary key (MaPGH)
)
go



--Table: PhieuNhap        
create table PhieuNhap (
   MaPN		int identity(1,1),
   MaCH		varchar(8),
   NgayLap  datetime,
   constraint PK_PHIEUNHAP primary key (MaPN)
)
go



--Table: PhieuTra        
create table PhieuTra (
   MaPT					int identity(1,1),
   MaDH					bigint,
   NgayLap				datetime,
   TongGiaTri           int,
   LyDo					nvarchar(255),
   constraint PK_PHIEUTRA primary key (MaPT)
)
go

--Table: SanPham          
create table SanPham (
   MaSP		bigint identity(1,1) ,
   MaLoai   int ,
   TenSP	nvarchar(100),
   DonGia   int,
   GiamGia  int,
   SLDaBan  int,
   constraint PK_SANPHAM primary key (MaSP)
)
go

--Table: TheThanhVien     
create table TheThanhVien (
   LoaiThe  int identity(1,1),
   MoTa		nvarchar(255),
   constraint PK_THETHANHVIEN primary key (LoaiThe)
)
go

--Table: ThuongHieu      
create table ThuongHieu (
   MaTH					int identity(1,1),
   Ten					nvarchar(255),
   MoTa					nvarchar(255),
   DiaChi				nvarchar(255),
   SDT					varchar(10),
   NguoiDaiDien         nvarchar(100),
   XuatXu				nvarchar(50),
   constraint PK_THUONGHIEU primary key (MaTH)
)
go


--Table: ThuongHieu_LoaiHang
create table ThuongHieu_LoaiHang (
   MaTH		int ,
   MaLoai   int ,
   constraint PK_THUONGHIEU_LOAIHANG primary key (MaTH, MaLoai)
)
go


alter table CH_SP
   add constraint FK_CH_SP_CUAHANG foreign key (MaCH)
      references CuaHang (MaCH)
go

alter table CH_SP
   add constraint FK_CH_SP_SANPHAM foreign key (MaSP)
      references SanPham (MaSP)
go

alter table CTDH
   add constraint FK_CTDH_DONHANG foreign key (MaDH)
      references DonHang (MaDH)
go

alter table CTDH
   add constraint FK_CTDH_SANPHAM foreign key (MaSP)
      references SanPham (MaSP)
go

alter table CTPD
   add constraint FK_CTPD_SANPHAMDOI foreign key (MaSP)
      references SanPham (MaSP)
go

alter table CTPD
   add constraint FK_CTPD_PHIEUDOI foreign key (MaPD)
      references PhieuDoi (MaPD)
go


alter table CTPN
   add constraint FK_CTPN_PHIEUNHAP foreign key (MaPN)
      references PhieuNhap (MaPN)
go

alter table CTPN
   add constraint FK_CTPN_SANPHAM foreign key (MaSP)
      references SanPham (MaSP)
go

alter table CTPT
   add constraint FK_CTPT_PHIEUTRA foreign key (MaPT)
      references PhieuTra (MaPT)
go

alter table CTPT
   add constraint FK_CTPT_SANPHAM foreign key (MaSP)
      references SanPham (MaSP)
go


alter table DonHang
   add constraint FK_DONHANG_CUAHANG foreign key (MaCH)
      references CuaHang (MaCH)
go

alter table DonHang
   add constraint FK_DONHANG_HINHTHUCTT foreign key (MaTT)
      references HinhThucThanhToan (MaTT)
go

alter table DonHang
   add constraint FK_DONHANG_KHACHHANG foreign key (MaKH)
      references KhachHang (SDT)
go
alter table DonHang
   add constraint FK_DONHANG_TinhTrangDonHang foreign key (MaTinhTrang)
      references TinhTrangDonHang (MaTinhTrang)
go

alter table DonHang
   add constraint FK_DONHANG_NHANVIEN foreign key (MaNV)
      references NhanVien (MaNV)
go

alter table HDDienTu
   add constraint FK_HDDIENTU_DONHANG foreign key (MaDH)
      references DonHang (MaDH)
go

alter table KhachHang
   add constraint FK_KHACHHAN_THETV foreign key (LoaiThe)
      references TheThanhVien (LoaiThe)
go

alter table NhanVien
   add constraint FK_NHANVIEN_QUANLY_NHANVIEN foreign key (QuanLy)
      references NhanVien (MaNV)
go

alter table NhanVien
   add constraint FK_NHANVIEN_CUAHANG foreign key (MaCH)
      references CuaHang (MaCH)
go

alter table CuaHang
	add constraint FK_CUAHANG_NVQuanLy foreign key (NVQuanLy)
      references NhanVien (MaNV)
go

alter table PhieuDoi
   add constraint FK_PHIEUDOI_DONHANG foreign key (MaDH)
      references DonHang (MaDH)
go

alter table PhieuGiaoHang
   add constraint FK_PHIEUGH_DONHANG foreign key (MaDH)
      references DonHang (MaDH)
go

alter table PhieuNhap
   add constraint FK_PHIEUNHAP_CUAHANG foreign key (MaCH)
      references CuaHang (MaCH)
go

alter table PhieuTra
   add constraint FK_PHIEUTRA_DONHANG foreign key (MaDH)
      references DonHang (MaDH)
go

alter table SanPham
   add constraint FK_SANPHAM_LOAIHANG foreign key (MaLoai)
      references LoaiHang (MaLoai)
go

alter table ThuongHieu_LoaiHang
   add constraint FK_THUONGHIEU_LOAIHANG1 foreign key (MaTH)
      references ThuongHieu (MaTH)
go

alter table ThuongHieu_LoaiHang
   add constraint FK_THUONGHIEU_LOAIHANG2 foreign key (MaLoai)
      references LoaiHang (MaLoai)



insert into HinhThucThanhToan values
(1, N'Thanh toán khi nhận hàng'),
(2, N'Thanh toán bằng thẻ nội địa'),
(3, N'Thanh toán bằng thẻ quốc tế'),
(4, N'Thanh toán bằng Zalopay'),
(5, N'Thanh toán qua chuyển khoản ngân hàng'),
(6, N'Thanh toán bằng tiền mặt'),
(7, N'Thanh toán bằng ví điện tử')

insert into TinhTrangDonHang values
(N'Đơn hàng đã hủy'), --1
(N'Đơn hàng đã đã xác nhận'),--2
(N'Đơn hàng đang được chuẩn bị'),--3
(N'Đơn hàng đang giao'),--4
(N'Đơn hàng giao thành công')--5

INSERT INTO TheThanhVien VALUES
(N'Thẻ thường'),
(N'Thẻ VIP GOLD'),
(N'Thẻ VIP DIAMOND')