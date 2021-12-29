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
module.exports={
    getKH:getKH,
    addCustomer:addCustomer,
    getCustomerBillList:getCustomerBillList,
    getDetailBill:getDetailBill,
    getBill:getBill
}