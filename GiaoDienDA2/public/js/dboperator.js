var config=require('./db');
const sql=require('mssql/msnodesqlv8');

async function getKH(SDT){
    try{
        let pool=await sql.connect(config);
        let products=await pool.request().query("SELECT HoTen,SDT,LoaiThe,GioiTinh,convert(varchar, NgaySinh, 113) as NgaySinh,DiaChi,Email,pword FROM KhachHang WHERE SDT = '" + SDT + "'");
        console.log(products.recordset)
        return products.recordset;
    }
    catch(error){
        console.log(error);
    }
}

async function addCustomer(dkn){
    try{
        let pool = await sql.connect(config);
        let insertProduct = await pool.request()
        .input('Hoten', sql.NVarChar(100), dkn.HoTen)
        .input('SDT', sql.VarChar(10), dkn.SDT)
        .input('GioiTinh', sql.VarChar(3), dkn.GioiTinh)
        .input('NgaySinh', sql.DateTime, dkn.NgaySinh)
        .input('DiaChi', sql.NVarChar(255), dkn.DiaChi)
        .input('Email', sql.VarChar(50), dkn.Email)
        .input('pword', sql.VarChar(20), dkn.Password)       
        .execute("sp_CreateAccount_KH")
        return insertProduct.recordsets;
    }
    catch(error){
        console.log(error);
    }
}

async function getCustomerBillList(start,MaKH, num=100){
    //console.log('dboperator ', MaKH)
    try{
        let pool=await sql.connect(config);
        length = await pool.request().query("SELECT COUNT(*) FROM DonHang WHERE MAKH='"+MaKH+"'")
        let products=await pool.request().query("SELECT MaDH, convert(varchar, NgayLap, 113) as NgayLap,TongTien, LoaiDH \
         FROM (SELECT ROW_NUMBER() OVER (ORDER BY MaDH) AS ROWNUMBER, * FROM DonHang WHERE MAKH='"+MaKH+"')  AS T WHERE T.ROWNUMBER >= "+start+" AND T.ROWNUMBER <" + (parseInt(start)+parseInt(num)));
        return {tableLength: length.recordsets[0][0][""], data: products.recordsets[0]};
    }
    catch(error){
        return error;
    }
}

async function getBill(MaDH){
    try{
        let pool=await sql.connect(config);
        let products=await pool.request().query("SELECT MaDH, MaNV, MaCH, MaKH,  convert(varchar, NgayLap, 113) as NgayLap, MaTT,MaTinhTrang,SoThe, TongTien,LoaiDH \
          FROM DonHang WHERE MaDH = '" + MaDH + "'");
        //console.log(products.recordset)
        return products.recordset;
    }
    catch(error){
        console.log(error);
    }
}

async function getDetailBill(MaDH){
    
    try{
        let pool=await sql.connect(config);
        var query = "SELECT COUNT(*) FROM CTDH where CTDH.MaDH ='"+MaDH+"'"
        
        //console.log(length.recordsets[0][0][""])
        query = "SELECT ROWNUMBER, T.MaDH, T.MaSP, SP.TenSP, T.SoLuong, T.DonGia, T.ThanhTien \
                FROM (SELECT ROW_NUMBER() OVER (ORDER BY MaSP) AS ROWNUMBER, * \
	            FROM CTDH where CTDH.MaDH ='"+MaDH+"')  AS T join SanPham SP on SP.MaSP=T.MaSP"
        //console.log(query)
        let products=await pool.request().query(query);
        //console.log(products.recordsets[0])
        
        return {data: products.recordsets[0]};
    }
    catch(error){
        console.log(error);
    }
} 

async function getLSTL(start,bd,kt,MaKH, num=100){
    //console.log('dboperator ', MaKH)
    try{
        let pool=await sql.connect(config);
        let bills=await pool.request()
        .input('start', sql.Int, start)
        .input('bd', sql.Date, bd)
        .input('kt', sql.Date, kt)
        .input('makh', sql.VarChar(10), MaKH)
        .input('num', sql.Int, num)
        .output('Tong', sql.Int)
        .execute("getLSTL")
        return {tableLength: bills.output.Tong, data: bills.recordset};
    }
    catch(error){
        return error;
    }
}

async function getTKDT(start,bd,kt,MaCH,num=100){
    //console.log('dboperator ', MaKH)
    try{
        let pool=await sql.connect(config);
        let bills=await pool.request()
        .input('start', sql.Int, start)
        .input('num', sql.Int, num)
        .input('bd', sql.Date, bd)
        .input('kt', sql.Date, kt)
        .input('mach', sql.VarChar(8), MaCH)
        .output('doanhthu', sql.BigInt)
        .output('sldaban', sql.Int)
        .output('tong', sql.Int)
        .execute("getStoreStatisticByDay")
        console.log("product: ",bills)
        return {tableLength: bills.output.tong,doanhthu: bills.output.doanhthu,sldaban:bills.output.sldaban, data: bills.recordset};
    }
    catch(error){
        return error;
    }
}

async function getTKSLT(start,MaCH,SL, num=100){
    //console.log('dboperator ', MaKH)
    try{

        if (MaCH==""){
            let pool=await sql.connect(config);
            let bills=await pool.request()
            .input('start', sql.Int, start)
            .input('slt', sql.Int, SL)
            .input('num', sql.Int, num)
            .output('tong',sql.Int)
            .execute("getTKSLTAll")
            return {tableLength: bills.output.tong, data: bills.recordset};
        }
        else{
            let pool=await sql.connect(config);
            let bills=await pool.request()
            .input('start', sql.Int, start)
            .input('mach', sql.VarChar(8), MaCH)
            .input('slt', sql.Int, SL)
            .input('num', sql.Int, num)
            .output('tong',sql.Int)
            .execute("getTKSLT")
            return {tableLength: bills.output.tong, data: bills.recordset};
        }
        
    }
    catch(error){
        return error;
    }
}

/*--------------------------------SẢN PHẨM---------------------------------------*/
async function getProductList(start, num=100, search){
    //console.log('dboperator ', MaKH)
    try{
        let pool=await sql.connect(config);
        let products=await pool.request()
        .input('start', sql.Int, start)
        .input('num', sql.Int, num)
        .input('search', sql.NVarChar, search)
        .execute("getProductList")
        return products.recordset;
    }
    catch(error){
        return error;
    }
}

async function getTKDTALL(bd,kt){
    //console.log('dboperator ', MaKH)
    try{
        let pool=await sql.connect(config);
        let bills=await pool.request()
        .input('bd', sql.Date, bd)
        .input('kt', sql.Date, kt)
        .output('doanhthu', sql.BigInt)
        .output('sldaban', sql.Int)
        .execute("getStoreStatisticALL")
        console.log("product: ",bills)
        return {doanhthu: bills.output.doanhthu,sldaban:bills.output.sldaban, data: bills.recordset};
    }
    catch(error){
        return error;
    }
}

async function getFilteredProduct(start, num=100, LH, TH, search){
    //console.log('dboperator ', MaKH)
    try{
        let pool=await sql.connect(config);
        let products=await pool.request()
        .input('start', sql.Int, start)
        .input('num', sql.Int, num)
        .input('lh', sql.VarChar, LH)
        .input('th', sql.VarChar, TH)
        .input('search', sql.NVarChar, search)
        .execute("getFilteredProduct")
        return products.recordset;
    }
    catch(error){
        return error;
    }
}
async function getDTNV(bd,kt){
    //console.log('dboperator ', MaKH)
    try{
        let pool=await sql.connect(config);
        let bills=await pool.request()
        .input('bd', sql.Date, bd)
        .input('kt', sql.Date, kt)
        .execute("getDTNV")
        console.log("product: ",bills)
        return {data: bills.recordset};
    }
    catch(error){
        return error;
    }
}

async function getBrandList(){
    //console.log('dboperator ', MaKH)
    try{
        let pool=await sql.connect(config);
        var query = "SELECT MaTH, Ten FROM ThuongHieu"
        let brands=await pool.request().query(query);
        //console.log(products.recordsets[0])
        
        return brands.recordset;
    }
    catch(error){
        return error;
    }
}
async function getProductAdmin(start,num=100){
    try{
        let pool=await sql.connect(config);
        length = await pool.request().query("SELECT COUNT(*) FROM SanPham")
        let products=await pool.request().query("SELECT * \
         FROM (SELECT ROW_NUMBER() OVER (ORDER BY MaSP) AS ROWNUMBER, * FROM SanPham)  AS T WHERE T.ROWNUMBER >= "+start+" AND T.ROWNUMBER <" + (parseInt(start)+parseInt(num)));
        return {tableLength: length.recordsets[0][0][""], data: products.recordsets[0]};
    }
    catch(error){
        return error;
    }
}

async function getProductAdminStore(start,MaCH,num=100){
    try{
        let pool=await sql.connect(config);
        length = await pool.request().query("SELECT COUNT(*) FROM CH_SP where CH_SP.MaCH='"+MaCH+"'")
        let products=await pool.request().query("SELECT * \
         FROM (SELECT ROW_NUMBER() OVER (ORDER BY CH_SP.MaSP) AS ROWNUMBER,  SanPham.* FROM CH_SP join SanPham on CH_SP.MaSP=SanPham.MaSP where CH_SP.MaCH='"+MaCH+"')  AS T WHERE T.ROWNUMBER >= "+start+" AND T.ROWNUMBER <" + (parseInt(start)+parseInt(num)));
        return {tableLength: length.recordsets[0][0][""], data: products.recordsets[0]};
    }
    catch(error){
        return error;
    }
}

async function addProduct(dkn){
    try{
        console.log("dbo:",dkn)
        let pool = await sql.connect(config);
        let insertProduct = await pool.request()
        .input('maloai', sql.Int, dkn.MaLoai)
        .input('math', sql.Int, dkn.MaTH)
        .input('tensp', sql.NVarChar(100), dkn.TenSP)
        .input('dongia', sql.Int, dkn.DonGia)
        .input('giamgia', sql.Int, dkn.GiaGiam)
        .execute("addProduct")
        return insertProduct.recordsets;
    }
    catch(error){
        console.log(error);
    }
}
async function addProductToAgent(dkn){
    try{
        let pool = await sql.connect(config);
        let insertProduct = await pool.request()
        .query("INSERT INTO CH_SP(MaCH,MaSP,SoLuongTon) VALUES('" + dkn.MaCH + "', " + dkn.MaSP + ", "+dkn.SoLuongTon+")");
        return insertProduct.recordsets;
    }
    catch(error){
        console.log(error);
    }
}

async function getProductDetail(id){
    try{
        let pool = await sql.connect(config);
        let product = await pool.request()
        .input('masp', sql.Int, id)
        .execute("getProductDetail")
        console.log(product.recordsets[0][0])
        return product.recordsets[0][0];
    }
    catch(error){
        console.log(error);
    }
}

async function addBill(bill){
    //var flag=1
    try{
        console.log("bill:", bill)
        let flag = 1
        let pool = await sql.connect(config);
        let insertBill = await pool.request()
        .input('MaKH', sql.VarChar(10), bill.makh)
        .input('DiaChi', sql.NVarChar(30), bill.address)
        .input('Phuong', sql.NVarChar(30), bill.ward)
        .input('Quan', sql.NVarChar(30), bill.district)
        .input('Tinh', sql.NVarChar(30), bill.city)
        .input('TenNguoiNhan', sql.NVarChar(100), bill.name)
        .input('SDT', sql.VarChar(10), bill.sdt)
        .input('TongTien', sql.Float, bill.total)
        .input('ThanhToan', sql.Int, bill.payment)
        .output('MaDonHang')
        .execute('sp_ThemDonHang')
        MaDH=insertBill.output.MaDonHang;
        console.log('MaDH:',MaDH)
        let temp = bill.products
        console.log(temp)
            for (i=0;i<temp.length;i++){
                   // console.log('sp: ',MaSP)
                let insertP= await pool.request()
                .input('MaDH',sql.Int,MaDH)
                .input('MaSP',sql.VarChar(6),temp[i].MaSP)
                .input('SoLuong',sql.Int,temp[i].item)
                .input('Quan', sql.NVarChar(30), bill.district)
                .output('error',sql.Int)
                .execute('sp_ThemChiTietDonHang')
                flag = insertP.output.error
                    //console.log(insertP.output.error)
                if (insertP.output.error!=0){
                    let pool1 = await sql.connect(config);
                    console.log('out of stock');
                    let de=await pool1.request()
                    .input('MaDH',sql.Int,MaDH)
                    .execute('sp_XoaDonHang')
                    if (insertP.output.error==2)
                        return 'Sản phẩm '+ temp[i].TenSP+ ' đặt vượt quá số lượng trong kho tại cửa hàng gần nhất'
                    else return 'Sản phẩm '+ temp[i].TenSP+ ' đã hết hàng tại cửa hàng gần nhất'
                } 
            }
        //console.log(insertBill.output.MaDonHang)
        return 'Đặt hàng thành công'
    }
    catch(error){
        console.log(error);
    }
    //return flag
}


module.exports={
    getKH:getKH,
    addCustomer:addCustomer,
    getCustomerBillList:getCustomerBillList,
    getDetailBill:getDetailBill,
    getBill:getBill,
    getLSTL:getLSTL,
    getProductList:getProductList,
    getBrandList:getBrandList,
    getFilteredProduct:getFilteredProduct,
    getTKDT:getTKDT,
    getTKSLT:getTKSLT,
    getTKDTALL:getTKDTALL,
    getDTNV:getDTNV,
    getProductAdmin:getProductAdmin,
    addProduct:addProduct,
    addProductToAgent:addProductToAgent,
    getProductDetail:getProductDetail,
    getProductAdminStore:getProductAdminStore,
    addBill:addBill
}