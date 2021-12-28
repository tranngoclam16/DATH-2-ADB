/*==============================================================*/
/* DBMS name:      Microsoft SQL Server 2014                    */
/* Created on:     12/1/2021 8:35:09 AM                         */
/*==============================================================*/


if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('CH_SP') and o.name = 'FK_CH_SP_RELATIONS_CUAHANG')
alter table CH_SP
   drop constraint FK_CH_SP_RELATIONS_CUAHANG
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('CH_SP') and o.name = 'FK_CH_SP_RELATIONS_SANPHAM')
alter table CH_SP
   drop constraint FK_CH_SP_RELATIONS_SANPHAM
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('CTDH') and o.name = 'FK_CTDH_RELATIONS_DONHANG')
alter table CTDH
   drop constraint FK_CTDH_RELATIONS_DONHANG
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('CTDH') and o.name = 'FK_CTDH_RELATIONS_SANPHAM')
alter table CTDH
   drop constraint FK_CTDH_RELATIONS_SANPHAM
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('CTPD') and o.name = 'FK_CTPD_CO_SANPHAM')
alter table CTPD
   drop constraint FK_CTPD_CO_SANPHAM
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('CTPD') and o.name = 'FK_CTPD_RELATIONS_PHIEUDOI')
alter table CTPD
   drop constraint FK_CTPD_RELATIONS_PHIEUDOI
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('CTPD') and o.name = 'FK_CTPD_TONTAI_SANPHAM')
alter table CTPD
   drop constraint FK_CTPD_TONTAI_SANPHAM
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('CTPN') and o.name = 'FK_CTPN_RELATIONS_PHIEUNHA')
alter table CTPN
   drop constraint FK_CTPN_RELATIONS_PHIEUNHA
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('CTPN') and o.name = 'FK_CTPN_RELATIONS_SANPHAM')
alter table CTPN
   drop constraint FK_CTPN_RELATIONS_SANPHAM
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('CTPT') and o.name = 'FK_CTPT_RELATIONS_PHIEUTRA')
alter table CTPT
   drop constraint FK_CTPT_RELATIONS_PHIEUTRA
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('CTPT') and o.name = 'FK_CTPT_RELATIONS_SANPHAM')
alter table CTPT
   drop constraint FK_CTPT_RELATIONS_SANPHAM
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('CTTinhTrangDonHang') and o.name = 'FK_CTTINHTR_RELATIONS_DONHANG')
alter table CTTinhTrangDonHang
   drop constraint FK_CTTINHTR_RELATIONS_DONHANG
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('CTTinhTrangDonHang') and o.name = 'FK_CTTINHTR_RELATIONS_TINHTRAN')
alter table CTTinhTrangDonHang
   drop constraint FK_CTTINHTR_RELATIONS_TINHTRAN
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('DonHang') and o.name = 'FK_DONHANG_RELATIONS_CUAHANG')
alter table DonHang
   drop constraint FK_DONHANG_RELATIONS_CUAHANG
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('DonHang') and o.name = 'FK_DONHANG_RELATIONS_HINHTHUC')
alter table DonHang
   drop constraint FK_DONHANG_RELATIONS_HINHTHUC
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('DonHang') and o.name = 'FK_DONHANG_RELATIONS_KHACHHAN')
alter table DonHang
   drop constraint FK_DONHANG_RELATIONS_KHACHHAN
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('DonHang') and o.name = 'FK_DONHANG_RELATIONS_PHIEUGIA')
alter table DonHang
   drop constraint FK_DONHANG_RELATIONS_PHIEUGIA
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('DonHang') and o.name = 'FK_DONHANG_RELATIONS_NHANVIEN')
alter table DonHang
   drop constraint FK_DONHANG_RELATIONS_NHANVIEN
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('HDDienTu') and o.name = 'FK_HDDIENTU_RELATIONS_DONHANG')
alter table HDDienTu
   drop constraint FK_HDDIENTU_RELATIONS_DONHANG
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('KhachHang') and o.name = 'FK_KHACHHAN_RELATIONS_THETHANH')
alter table KhachHang
   drop constraint FK_KHACHHAN_RELATIONS_THETHANH
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('NhanVien') and o.name = 'FK_NHANVIEN_QUANLY_NHANVIEN')
alter table NhanVien
   drop constraint FK_NHANVIEN_QUANLY_NHANVIEN
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('NhanVien') and o.name = 'FK_NHANVIEN_RELATIONS_CUAHANG')
alter table NhanVien
   drop constraint FK_NHANVIEN_RELATIONS_CUAHANG
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('PhieuDoi') and o.name = 'FK_PHIEUDOI_RELATIONS_DONHANG')
alter table PhieuDoi
   drop constraint FK_PHIEUDOI_RELATIONS_DONHANG
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('PhieuGiaoHang') and o.name = 'FK_PHIEUGIA_RELATIONS_DONHANG')
alter table PhieuGiaoHang
   drop constraint FK_PHIEUGIA_RELATIONS_DONHANG
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('PhieuNhap') and o.name = 'FK_PHIEUNHA_RELATIONS_CUAHANG')
alter table PhieuNhap
   drop constraint FK_PHIEUNHA_RELATIONS_CUAHANG
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('PhieuTra') and o.name = 'FK_PHIEUTRA_RELATIONS_DONHANG')
alter table PhieuTra
   drop constraint FK_PHIEUTRA_RELATIONS_DONHANG
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('SanPham') and o.name = 'FK_SANPHAM_RELATIONS_LOAIHANG')
alter table SanPham
   drop constraint FK_SANPHAM_RELATIONS_LOAIHANG
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('ThuongHieu_LoaiHang') and o.name = 'FK_THUONGHI_THUONGHIE_THUONGHI')
alter table ThuongHieu_LoaiHang
   drop constraint FK_THUONGHI_THUONGHIE_THUONGHI
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('ThuongHieu_LoaiHang') and o.name = 'FK_THUONGHI_THUONGHIE_LOAIHANG')
alter table ThuongHieu_LoaiHang
   drop constraint FK_THUONGHI_THUONGHIE_LOAIHANG
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('CH_SP')
            and   name  = 'Relationship_23_FK'
            and   indid > 0
            and   indid < 255)
   drop index CH_SP.Relationship_23_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('CH_SP')
            and   name  = 'Relationship_22_FK'
            and   indid > 0
            and   indid < 255)
   drop index CH_SP.Relationship_22_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('CH_SP')
            and   type = 'U')
   drop table CH_SP
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('CTDH')
            and   name  = 'Relationship_21_FK'
            and   indid > 0
            and   indid < 255)
   drop index CTDH.Relationship_21_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('CTDH')
            and   name  = 'Relationship_20_FK'
            and   indid > 0
            and   indid < 255)
   drop index CTDH.Relationship_20_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('CTDH')
            and   type = 'U')
   drop table CTDH
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('CTPD')
            and   name  = 'Relationship_28_FK'
            and   indid > 0
            and   indid < 255)
   drop index CTPD.Relationship_28_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('CTPD')
            and   name  = 'Relationship_19_FK'
            and   indid > 0
            and   indid < 255)
   drop index CTPD.Relationship_19_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('CTPD')
            and   name  = 'Relationship_18_FK'
            and   indid > 0
            and   indid < 255)
   drop index CTPD.Relationship_18_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('CTPD')
            and   type = 'U')
   drop table CTPD
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('CTPN')
            and   name  = 'Relationship_25_FK'
            and   indid > 0
            and   indid < 255)
   drop index CTPN.Relationship_25_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('CTPN')
            and   name  = 'Relationship_24_FK'
            and   indid > 0
            and   indid < 255)
   drop index CTPN.Relationship_24_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('CTPN')
            and   type = 'U')
   drop table CTPN
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('CTPT')
            and   name  = 'Relationship_17_FK'
            and   indid > 0
            and   indid < 255)
   drop index CTPT.Relationship_17_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('CTPT')
            and   name  = 'Relationship_16_FK'
            and   indid > 0
            and   indid < 255)
   drop index CTPT.Relationship_16_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('CTPT')
            and   type = 'U')
   drop table CTPT
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('CTTinhTrangDonHang')
            and   name  = 'Relationship_27_FK'
            and   indid > 0
            and   indid < 255)
   drop index CTTinhTrangDonHang.Relationship_27_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('CTTinhTrangDonHang')
            and   name  = 'Relationship_26_FK'
            and   indid > 0
            and   indid < 255)
   drop index CTTinhTrangDonHang.Relationship_26_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('CTTinhTrangDonHang')
            and   type = 'U')
   drop table CTTinhTrangDonHang
go

if exists (select 1
            from  sysobjects
           where  id = object_id('CuaHang')
            and   type = 'U')
   drop table CuaHang
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('DonHang')
            and   name  = 'Relationship_14_FK'
            and   indid > 0
            and   indid < 255)
   drop index DonHang.Relationship_14_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('DonHang')
            and   name  = 'Relationship_11_FK'
            and   indid > 0
            and   indid < 255)
   drop index DonHang.Relationship_11_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('DonHang')
            and   name  = 'Relationship_8_FK'
            and   indid > 0
            and   indid < 255)
   drop index DonHang.Relationship_8_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('DonHang')
            and   name  = 'Relationship_5_FK'
            and   indid > 0
            and   indid < 255)
   drop index DonHang.Relationship_5_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('DonHang')
            and   name  = 'Relationship_2_FK'
            and   indid > 0
            and   indid < 255)
   drop index DonHang.Relationship_2_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('DonHang')
            and   type = 'U')
   drop table DonHang
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('HDDienTu')
            and   name  = 'Relationship_7_FK'
            and   indid > 0
            and   indid < 255)
   drop index HDDienTu.Relationship_7_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('HDDienTu')
            and   type = 'U')
   drop table HDDienTu
go

if exists (select 1
            from  sysobjects
           where  id = object_id('HinhThucThanhToan')
            and   type = 'U')
   drop table HinhThucThanhToan
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('KhachHang')
            and   name  = 'Relationship_1_FK'
            and   indid > 0
            and   indid < 255)
   drop index KhachHang.Relationship_1_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('KhachHang')
            and   type = 'U')
   drop table KhachHang
go

if exists (select 1
            from  sysobjects
           where  id = object_id('LoaiHang')
            and   type = 'U')
   drop table LoaiHang
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('NhanVien')
            and   name  = 'Relationship_13_FK'
            and   indid > 0
            and   indid < 255)
   drop index NhanVien.Relationship_13_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('NhanVien')
            and   name  = 'QuanLy_FK'
            and   indid > 0
            and   indid < 255)
   drop index NhanVien.QuanLy_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('NhanVien')
            and   type = 'U')
   drop table NhanVien
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('PhieuDoi')
            and   name  = 'Relationship_10_FK'
            and   indid > 0
            and   indid < 255)
   drop index PhieuDoi.Relationship_10_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('PhieuDoi')
            and   type = 'U')
   drop table PhieuDoi
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('PhieuGiaoHang')
            and   name  = 'Relationship_6_FK'
            and   indid > 0
            and   indid < 255)
   drop index PhieuGiaoHang.Relationship_6_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('PhieuGiaoHang')
            and   type = 'U')
   drop table PhieuGiaoHang
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('PhieuNhap')
            and   name  = 'Relationship_9_FK'
            and   indid > 0
            and   indid < 255)
   drop index PhieuNhap.Relationship_9_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('PhieuNhap')
            and   type = 'U')
   drop table PhieuNhap
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('PhieuTra')
            and   name  = 'Relationship_12_FK'
            and   indid > 0
            and   indid < 255)
   drop index PhieuTra.Relationship_12_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('PhieuTra')
            and   type = 'U')
   drop table PhieuTra
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('SanPham')
            and   name  = 'Relationship_4_FK'
            and   indid > 0
            and   indid < 255)
   drop index SanPham.Relationship_4_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('SanPham')
            and   type = 'U')
   drop table SanPham
go

if exists (select 1
            from  sysobjects
           where  id = object_id('TheThanhVien')
            and   type = 'U')
   drop table TheThanhVien
go

if exists (select 1
            from  sysobjects
           where  id = object_id('ThuongHieu')
            and   type = 'U')
   drop table ThuongHieu
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('ThuongHieu_LoaiHang')
            and   name  = 'ThuongHieu_LoaiHang2_FK'
            and   indid > 0
            and   indid < 255)
   drop index ThuongHieu_LoaiHang.ThuongHieu_LoaiHang2_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('ThuongHieu_LoaiHang')
            and   name  = 'ThuongHieu_LoaiHang_FK'
            and   indid > 0
            and   indid < 255)
   drop index ThuongHieu_LoaiHang.ThuongHieu_LoaiHang_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('ThuongHieu_LoaiHang')
            and   type = 'U')
   drop table ThuongHieu_LoaiHang
go

if exists (select 1
            from  sysobjects
           where  id = object_id('TinhTrangDonHang')
            and   type = 'U')
   drop table TinhTrangDonHang
go

/*==============================================================*/
/* Table: CH_SP                                                 */
/*==============================================================*/
create table CH_SP (
   MaSP                 int                  not null,
   MaCH                 varchar(8)           null,
   SoLuongTon           int                  null
)
go

/*==============================================================*/
/* Index: Relationship_22_FK                                    */
/*==============================================================*/




create nonclustered index Relationship_22_FK on CH_SP (MaCH ASC)
go

/*==============================================================*/
/* Index: Relationship_23_FK                                    */
/*==============================================================*/




create nonclustered index Relationship_23_FK on CH_SP (MaSP ASC)
go

/*==============================================================*/
/* Table: CTDH                                                  */
/*==============================================================*/
create table CTDH (
   MaDH                 bigint               not null,
   MaSP                 int                  not null,
   SoLuong              int                  null,
   DonGia               int                  null,
   ThanhTien            int                  null
)
go

/*==============================================================*/
/* Index: Relationship_20_FK                                    */
/*==============================================================*/




create nonclustered index Relationship_20_FK on CTDH (MaDH ASC)
go

/*==============================================================*/
/* Index: Relationship_21_FK                                    */
/*==============================================================*/




create nonclustered index Relationship_21_FK on CTDH (MaSP ASC)
go

/*==============================================================*/
/* Table: CTPD                                                  */
/*==============================================================*/
create table CTPD (
   MaSP                 int                  not null,
   MaPD                 int                  not null,
   San_MaSP             int                  not null,
   SoLuongDoi           int                  null,
   DonGiaDoi            int                  null,
   ThanhTienDoi         int                  null,
   SoLuongNhan          int                  null,
   DonGiaNhan           int                  null,
   ThanhTienNhan        int                  null
)
go

/*==============================================================*/
/* Index: Relationship_18_FK                                    */
/*==============================================================*/




create nonclustered index Relationship_18_FK on CTPD (MaPD ASC)
go

/*==============================================================*/
/* Index: Relationship_19_FK                                    */
/*==============================================================*/




create nonclustered index Relationship_19_FK on CTPD (San_MaSP ASC)
go

/*==============================================================*/
/* Index: Relationship_28_FK                                    */
/*==============================================================*/




create nonclustered index Relationship_28_FK on CTPD (MaSP ASC)
go

/*==============================================================*/
/* Table: CTPN                                                  */
/*==============================================================*/
create table CTPN (
   MaPN                 int                  not null,
   MaSP                 int                  not null,
   SoLuong              int                  null
)
go

/*==============================================================*/
/* Index: Relationship_24_FK                                    */
/*==============================================================*/




create nonclustered index Relationship_24_FK on CTPN (MaPN ASC)
go

/*==============================================================*/
/* Index: Relationship_25_FK                                    */
/*==============================================================*/




create nonclustered index Relationship_25_FK on CTPN (MaSP ASC)
go

/*==============================================================*/
/* Table: CTPT                                                  */
/*==============================================================*/
create table CTPT (
   MaPT                 int                  null,
   MaSP                 int                  not null,
   SoLuong              int                  null,
   DonGia               int                  null,
   ThanhTien            int                  null
)
go

/*==============================================================*/
/* Index: Relationship_16_FK                                    */
/*==============================================================*/




create nonclustered index Relationship_16_FK on CTPT (MaPT ASC)
go

/*==============================================================*/
/* Index: Relationship_17_FK                                    */
/*==============================================================*/




create nonclustered index Relationship_17_FK on CTPT (MaSP ASC)
go

/*==============================================================*/
/* Table: CTTinhTrangDonHang                                    */
/*==============================================================*/
create table CTTinhTrangDonHang (
   MaDH                 bigint               not null,
   MaTT                 int                  not null,
   NgayCapNhat          datetime             null
)
go

/*==============================================================*/
/* Index: Relationship_26_FK                                    */
/*==============================================================*/




create nonclustered index Relationship_26_FK on CTTinhTrangDonHang (MaDH ASC)
go

/*==============================================================*/
/* Index: Relationship_27_FK                                    */
/*==============================================================*/




create nonclustered index Relationship_27_FK on CTTinhTrangDonHang (MaTT ASC)
go

/*==============================================================*/
/* Table: CuaHang                                               */
/*==============================================================*/
create table CuaHang (
   MaCH                 varchar(8)           not null,
   DiaChi               varchar(255)         null,
   SDT                  varchar(10)          null,
   TGMoCua              int                  null,
   TGDongCua            int                  null,
   TinhTrangCH          varchar(20)          null,
   constraint PK_CUAHANG primary key (MaCH)
)
go

/*==============================================================*/
/* Table: DonHang                                               */
/*==============================================================*/
create table DonHang (
   MaDH                 bigint               not null,
   MaPGH                int                  null,
   MaNV                 varchar(8)           not null,
   MaTT                 int                  not null,
   MaCH                 varchar(8)           not null,
   Kha_SDT              varchar(10)          not null,
   NgayLap              datetime             null,
   SDT                  varchar(10)          null,
   SoThe                varchar(20)          null,
   TongTien             int                  null,
   ChietKhau            int                  null,
   constraint PK_DONHANG primary key (MaDH)
)
go

/*==============================================================*/
/* Index: Relationship_2_FK                                     */
/*==============================================================*/




create nonclustered index Relationship_2_FK on DonHang (Kha_SDT ASC)
go

/*==============================================================*/
/* Index: Relationship_5_FK                                     */
/*==============================================================*/




create nonclustered index Relationship_5_FK on DonHang (MaPGH ASC)
go

/*==============================================================*/
/* Index: Relationship_8_FK                                     */
/*==============================================================*/




create nonclustered index Relationship_8_FK on DonHang (MaNV ASC)
go

/*==============================================================*/
/* Index: Relationship_11_FK                                    */
/*==============================================================*/




create nonclustered index Relationship_11_FK on DonHang (MaCH ASC)
go

/*==============================================================*/
/* Index: Relationship_14_FK                                    */
/*==============================================================*/




create nonclustered index Relationship_14_FK on DonHang (MaTT ASC)
go

/*==============================================================*/
/* Table: HDDienTu                                              */
/*==============================================================*/
create table HDDienTu (
   So                   int                  not null,
   MaDH                 bigint               not null,
   CongTy               varchar(255)         null,
   DiaChi               varchar(255)         null,
   MaSoThue             char(10)             null,
   constraint PK_HDDIENTU primary key (So)
)
go

/*==============================================================*/
/* Index: Relationship_7_FK                                     */
/*==============================================================*/




create nonclustered index Relationship_7_FK on HDDienTu (MaDH ASC)
go

/*==============================================================*/
/* Table: HinhThucThanhToan                                     */
/*==============================================================*/
create table HinhThucThanhToan (
   MaTT                 int                  not null,
   MoTa                 varchar(255)         null,
   constraint PK_HINHTHUCTHANHTOAN primary key (MaTT)
)
go

/*==============================================================*/
/* Table: KhachHang                                             */
/*==============================================================*/
create table KhachHang (
   HoTen                varchar(100)         null,
   SDT                  varchar(10)          not null,
   LoaiThe              int                  not null,
   GioiTinh             varchar(3)           null,
   NgaySinh             datetime             null,
   DiaChi               varchar(255)         null,
   Email                varchar(50)          null,
   constraint PK_KHACHHANG primary key (SDT)
)
go

/*==============================================================*/
/* Index: Relationship_1_FK                                     */
/*==============================================================*/




create nonclustered index Relationship_1_FK on KhachHang (LoaiThe ASC)
go

/*==============================================================*/
/* Table: LoaiHang                                              */
/*==============================================================*/
create table LoaiHang (
   MaLoai               int                  not null,
   MoTa                 varchar(255)         null,
   constraint PK_LOAIHANG primary key (MaLoai)
)
go

/*==============================================================*/
/* Table: NhanVien                                              */
/*==============================================================*/
create table NhanVien (
   MaNV                 varchar(8)           not null,
   MaCH                 varchar(8)           not null,
   Nha_MaNV             varchar(8)           null,
   HoTen                varchar(100)         null,
   CMND                 varchar(12)          null,
   SDT                  varchar(10)          null,
   NgaySinh             datetime             null,
   NgayVaoLam           datetime             null,
   constraint PK_NHANVIEN primary key (MaNV)
)
go

/*==============================================================*/
/* Index: QuanLy_FK                                             */
/*==============================================================*/




create nonclustered index QuanLy_FK on NhanVien (Nha_MaNV ASC)
go

/*==============================================================*/
/* Index: Relationship_13_FK                                    */
/*==============================================================*/




create nonclustered index Relationship_13_FK on NhanVien (MaCH ASC)
go

/*==============================================================*/
/* Table: PhieuDoi                                              */
/*==============================================================*/
create table PhieuDoi (
   MaPD                 int                  not null,
   MaDH                 bigint               not null,
   NgayLap              datetime             null,
   TongChenhlLech       int                  null,
   LyDo                 varchar(255)         null,
   constraint PK_PHIEUDOI primary key (MaPD)
)
go

/*==============================================================*/
/* Index: Relationship_10_FK                                    */
/*==============================================================*/




create nonclustered index Relationship_10_FK on PhieuDoi (MaDH ASC)
go

/*==============================================================*/
/* Table: PhieuGiaoHang                                         */
/*==============================================================*/
create table PhieuGiaoHang (
   MaPGH                int                  not null,
   MaDH                 bigint               not null,
   NguoiNhan            varchar(50)          null,
   SDT                  varchar(10)          null,
   DiaChi               varchar(255)         null,
   PhiVanChuyen         int                  null,
   TienHang             int                  null,
   TongThu              int                  null,
   DVVanChuyen          varchar(100)         null,
   constraint PK_PHIEUGIAOHANG primary key (MaPGH)
)
go

/*==============================================================*/
/* Index: Relationship_6_FK                                     */
/*==============================================================*/




create nonclustered index Relationship_6_FK on PhieuGiaoHang (MaDH ASC)
go

/*==============================================================*/
/* Table: PhieuNhap                                             */
/*==============================================================*/
create table PhieuNhap (
   MaPN                 int                  not null,
   MaCH                 varchar(8)           not null,
   NgayLap              datetime             null,
   constraint PK_PHIEUNHAP primary key (MaPN)
)
go

/*==============================================================*/
/* Index: Relationship_9_FK                                     */
/*==============================================================*/




create nonclustered index Relationship_9_FK on PhieuNhap (MaCH ASC)
go

/*==============================================================*/
/* Table: PhieuTra                                              */
/*==============================================================*/
create table PhieuTra (
   MaPT                 int                  not null,
   MaDH                 bigint               not null,
   NgayLap              datetime             null,
   TongGiaTri           int                  null,
   LyDo                 varchar(255)         null,
   constraint PK_PHIEUTRA primary key (MaPT)
)
go

/*==============================================================*/
/* Index: Relationship_12_FK                                    */
/*==============================================================*/




create nonclustered index Relationship_12_FK on PhieuTra (MaDH ASC)
go

/*==============================================================*/
/* Table: SanPham                                               */
/*==============================================================*/
create table SanPham (
   MaSP                 int                  not null,
   MaLoai               int                  not null,
   TenSP                varchar(100)         null,
   DonGia               int                  null,
   GiamGia              int                  null,
   SLDaBan              int                  null,
   constraint PK_SANPHAM primary key (MaSP)
)
go

/*==============================================================*/
/* Index: Relationship_4_FK                                     */
/*==============================================================*/




create nonclustered index Relationship_4_FK on SanPham (MaLoai ASC)
go

/*==============================================================*/
/* Table: TheThanhVien                                          */
/*==============================================================*/
create table TheThanhVien (
   LoaiThe              int                  not null,
   MoTa                 varchar(255)         null,
   constraint PK_THETHANHVIEN primary key (LoaiThe)
)
go

/*==============================================================*/
/* Table: ThuongHieu                                            */
/*==============================================================*/
create table ThuongHieu (
   MaTH                 int                  not null,
   Ten                  varchar(255)         null,
   MoTa                 varchar(255)         null,
   DiaChi               varchar(255)         null,
   SDT                  varchar(10)          null,
   NguoiDaiDien         varchar(100)         null,
   XuatXu               varchar(50)          null,
   constraint PK_THUONGHIEU primary key (MaTH)
)
go

/*==============================================================*/
/* Table: ThuongHieu_LoaiHang                                   */
/*==============================================================*/
create table ThuongHieu_LoaiHang (
   MaTH                 int                  not null,
   MaLoai               int                  not null,
   constraint PK_THUONGHIEU_LOAIHANG primary key (MaTH, MaLoai)
)
go

/*==============================================================*/
/* Index: ThuongHieu_LoaiHang_FK                                */
/*==============================================================*/




create nonclustered index ThuongHieu_LoaiHang_FK on ThuongHieu_LoaiHang (MaTH ASC)
go

/*==============================================================*/
/* Index: ThuongHieu_LoaiHang2_FK                               */
/*==============================================================*/




create nonclustered index ThuongHieu_LoaiHang2_FK on ThuongHieu_LoaiHang (MaLoai ASC)
go

/*==============================================================*/
/* Table: TinhTrangDonHang                                      */
/*==============================================================*/
create table TinhTrangDonHang (
   MaTT                 int                  not null,
   MoTa                 varchar(255)         null,
   constraint PK_TINHTRANGDONHANG primary key (MaTT)
)
go

alter table CH_SP
   add constraint FK_CH_SP_RELATIONS_CUAHANG foreign key (MaCH)
      references CuaHang (MaCH)
go

alter table CH_SP
   add constraint FK_CH_SP_RELATIONS_SANPHAM foreign key (MaSP)
      references SanPham (MaSP)
go

alter table CTDH
   add constraint FK_CTDH_RELATIONS_DONHANG foreign key (MaDH)
      references DonHang (MaDH)
go

alter table CTDH
   add constraint FK_CTDH_RELATIONS_SANPHAM foreign key (MaSP)
      references SanPham (MaSP)
go

alter table CTPD
   add constraint FK_CTPD_CO_SANPHAM foreign key (San_MaSP)
      references SanPham (MaSP)
go

alter table CTPD
   add constraint FK_CTPD_RELATIONS_PHIEUDOI foreign key (MaPD)
      references PhieuDoi (MaPD)
go

alter table CTPD
   add constraint FK_CTPD_TONTAI_SANPHAM foreign key (MaSP)
      references SanPham (MaSP)
go

alter table CTPN
   add constraint FK_CTPN_RELATIONS_PHIEUNHA foreign key (MaPN)
      references PhieuNhap (MaPN)
go

alter table CTPN
   add constraint FK_CTPN_RELATIONS_SANPHAM foreign key (MaSP)
      references SanPham (MaSP)
go

alter table CTPT
   add constraint FK_CTPT_RELATIONS_PHIEUTRA foreign key (MaPT)
      references PhieuTra (MaPT)
go

alter table CTPT
   add constraint FK_CTPT_RELATIONS_SANPHAM foreign key (MaSP)
      references SanPham (MaSP)
go

alter table CTTinhTrangDonHang
   add constraint FK_CTTINHTR_RELATIONS_DONHANG foreign key (MaDH)
      references DonHang (MaDH)
go

alter table CTTinhTrangDonHang
   add constraint FK_CTTINHTR_RELATIONS_TINHTRAN foreign key (MaTT)
      references TinhTrangDonHang (MaTT)
go

alter table DonHang
   add constraint FK_DONHANG_RELATIONS_CUAHANG foreign key (MaCH)
      references CuaHang (MaCH)
go

alter table DonHang
   add constraint FK_DONHANG_RELATIONS_HINHTHUC foreign key (MaTT)
      references HinhThucThanhToan (MaTT)
go

alter table DonHang
   add constraint FK_DONHANG_RELATIONS_KHACHHAN foreign key (Kha_SDT)
      references KhachHang (SDT)
go

alter table DonHang
   add constraint FK_DONHANG_RELATIONS_PHIEUGIA foreign key (MaPGH)
      references PhieuGiaoHang (MaPGH)
go

alter table DonHang
   add constraint FK_DONHANG_RELATIONS_NHANVIEN foreign key (MaNV)
      references NhanVien (MaNV)
go

alter table HDDienTu
   add constraint FK_HDDIENTU_RELATIONS_DONHANG foreign key (MaDH)
      references DonHang (MaDH)
go

alter table KhachHang
   add constraint FK_KHACHHAN_RELATIONS_THETHANH foreign key (LoaiThe)
      references TheThanhVien (LoaiThe)
go

alter table NhanVien
   add constraint FK_NHANVIEN_QUANLY_NHANVIEN foreign key (Nha_MaNV)
      references NhanVien (MaNV)
go

alter table NhanVien
   add constraint FK_NHANVIEN_RELATIONS_CUAHANG foreign key (MaCH)
      references CuaHang (MaCH)
go

alter table PhieuDoi
   add constraint FK_PHIEUDOI_RELATIONS_DONHANG foreign key (MaDH)
      references DonHang (MaDH)
go

alter table PhieuGiaoHang
   add constraint FK_PHIEUGIA_RELATIONS_DONHANG foreign key (MaDH)
      references DonHang (MaDH)
go

alter table PhieuNhap
   add constraint FK_PHIEUNHA_RELATIONS_CUAHANG foreign key (MaCH)
      references CuaHang (MaCH)
go

alter table PhieuTra
   add constraint FK_PHIEUTRA_RELATIONS_DONHANG foreign key (MaDH)
      references DonHang (MaDH)
go

alter table SanPham
   add constraint FK_SANPHAM_RELATIONS_LOAIHANG foreign key (MaLoai)
      references LoaiHang (MaLoai)
go

alter table ThuongHieu_LoaiHang
   add constraint FK_THUONGHI_THUONGHIE_THUONGHI foreign key (MaTH)
      references ThuongHieu (MaTH)
go

alter table ThuongHieu_LoaiHang
   add constraint FK_THUONGHI_THUONGHIE_LOAIHANG foreign key (MaLoai)
      references LoaiHang (MaLoai)
go

