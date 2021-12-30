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

async function getTKDT(bd,kt,MaCH){
    //console.log('dboperator ', MaKH)
    try{
        let pool=await sql.connect(config);
        let bills=await pool.request()
        .input('bd', sql.Date, bd)
        .input('kt', sql.Date, kt)
        .input('mach', sql.VarChar(8), MaCH)
        .output('doanhthu', sql.Float)
        .output('sldaban', sql.Int)
        .execute("getStoreStatisticByDay")
        console.log("product: ",bills)
        return {doanhthu: bills.output.doanhthu,sldaban:bills.output.sldaban, data: bills.recordset};
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
module.exports={
    getKH:getKH,
    addCustomer:addCustomer,
    getCustomerBillList:getCustomerBillList,
    getDetailBill:getDetailBill,
    getBill:getBill,
    getLSTL:getLSTL,
    getTKDT:getTKDT,
    getTKSLT:getTKSLT
}