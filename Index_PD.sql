
--Index: Relationship_22_FK                                  
create nonclustered index Relationship_22_FK on CH_SP (MaCH ASC)
go


--Index: Relationship_23_FK                                    
create nonclustered index Relationship_23_FK on CH_SP (MaSP ASC)
go

--Index: Relationship_20_FK                                  
create nonclustered index Relationship_20_FK on CTDH (MaDH ASC)
go

--Index: Relationship_21_FK                                  
create nonclustered index Relationship_21_FK on CTDH (MaSP ASC)
go


--Index: Relationship_18_FK                                  
create nonclustered index Relationship_18_FK on CTPD (MaPD ASC)
go

--Index: Relationship_19_FK                                    
create nonclustered index Relationship_19_FK on CTPD (San_MaSP ASC)
go

--Index: Relationship_28_FK                                  
create nonclustered index Relationship_28_FK on CTPD (MaSP ASC)
go

--Index: Relationship_24_FK                                   
create nonclustered index Relationship_24_FK on CTPN (MaPN ASC)
go

--Index: Relationship_25_FK                                   
create nonclustered index Relationship_25_FK on CTPN (MaSP ASC)
go

--Index: Relationship_16_FK                                  
create nonclustered index Relationship_16_FK on CTPT (MaPT ASC)
go

--Index: Relationship_17_FK                                  
create nonclustered index Relationship_17_FK on CTPT (MaSP ASC)
go

-- Index: Relationship_26_FK                                  
create nonclustered index Relationship_26_FK on CTTinhTrangDonHang (MaDH ASC)
go

--Index: Relationship_27_FK                                  
create nonclustered index Relationship_27_FK on CTTinhTrangDonHang (MaTT ASC)
go


--Index: Relationship_2_FK                                   
create nonclustered index Relationship_2_FK on DonHang (Kha_SDT ASC)
go

--Index: Relationship_5_FK                                   
create nonclustered index Relationship_5_FK on DonHang (MaPGH ASC)
go

--Index: Relationship_8_FK                                    
create nonclustered index Relationship_8_FK on DonHang (MaNV ASC)
go

--Index: Relationship_11_FK                                   
create nonclustered index Relationship_11_FK on DonHang (MaCH ASC)
go

--Index: Relationship_14_FK                                   
create nonclustered index Relationship_14_FK on DonHang (MaTT ASC)
go

--Index: Relationship_7_FK                                    
create nonclustered index Relationship_7_FK on HDDienTu (MaDH ASC)
go

Index: Relationship_1_FK                                   
create nonclustered index Relationship_1_FK on KhachHang (LoaiThe ASC)
go

--Index: QuanLy_FK                                           
create nonclustered index QuanLy_FK on NhanVien (Nha_MaNV ASC)
go

--Index: Relationship_13_FK                                  
create nonclustered index Relationship_13_FK on NhanVien (MaCH ASC)
go

--Index: Relationship_10_FK                                   
create nonclustered index Relationship_10_FK on PhieuDoi (MaDH ASC)
go

--Index: Relationship_6_FK                                   
create nonclustered index Relationship_6_FK on PhieuGiaoHang (MaDH ASC)
go

--Index: Relationship_9_FK                                   
create nonclustered index Relationship_9_FK on PhieuNhap (MaCH ASC)
go

--Index: Relationship_12_FK                                   
create nonclustered index Relationship_12_FK on PhieuTra (MaDH ASC)
go

--Index: Relationship_4_FK                                    
create nonclustered index Relationship_4_FK on SanPham (MaLoai ASC)
go

--Index: ThuongHieu_LoaiHang_FK                               
create nonclustered index ThuongHieu_LoaiHang_FK on ThuongHieu_LoaiHang (MaTH ASC)
go

--Index: ThuongHieu_LoaiHang2_FK                              create nonclustered index ThuongHieu_LoaiHang2_FK on ThuongHieu_LoaiHang (MaLoai ASC)
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
   add constraint FK_CTPD_SANPHAMDOI foreign key (MaSPDoi)
      references SanPham (MaSP)
go

alter table CTPD
   add constraint FK_CTPD_PHIEUDOI foreign key (MaPD)
      references PhieuDoi (MaPD)
go

alter table CTPD
   add constraint FK_CTPD_SANPHAMNHAN foreign key (MaSPNhan)
      references SanPham (MaSP)
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

alter table CTTinhTrangDonHang
   add constraint FK_CTTINHTR_DONHANG foreign key (MaDH)
      references DonHang (MaDH)
go

alter table CTTinhTrangDonHang
   add constraint FK_CTTINHTR_TINHTRDH foreign key (MaTT)
      references TinhTrangDonHang (MaTT)
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
   add constraint FK_DONHANG_PHIEUGH foreign key (MaPGH)
      references PhieuGiaoHang (MaPGH)
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



