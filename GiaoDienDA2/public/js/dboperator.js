var config=require('./db');
const sql=require('mssql/msnodesqlv8');

async function getKH(SDT){
    try{
        let pool=await sql.connect(config);
        let products=await pool.request().query("SELECT * FROM KhachHang WHERE SDT = '" + SDT + "'");
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

module.exports={
    getKH:getKH,
    addCustomer:addCustomer
}