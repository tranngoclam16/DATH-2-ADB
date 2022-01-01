var Db= require('./public/js/db');
var config=require('./public/js/db');
const sql=require('mssql/msnodesqlv8');
const dboperator=require('./public/js/dboperator');


const express = require('express');
const bodyParser = require('body-parser');
const cors = require('cors');
const morgan=require('morgan');
const path=require('path');
const app = express();
var router = express.Router();

app.use(morgan('dev'));

let staticPath = path.join(__dirname, "public")



app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());
app.use(cors());

app.use(express.json());
/*app.use('/api', router); */



app.use(express.static(staticPath));
// call  function

app.listen(3000, () => {
    console.log(`listenning on port 3000`);
  })

app.get('/',(reg,res)=>{
    res.sendFile(path.join(staticPath,"index.html"));
})

/*--------------------------------SẢN PHẨM---------------------------------------*/
app.get('/ProductList', (req, res) => {
    res.sendFile(path.join(staticPath,"products.html"));
})

app.post('/ProductList', (req, res) => {
    let {start, LH, TH, search} = req.body
    //res.json(start)
    if (!start || start<0)
    {
        start = 0
    }
    console.log('filtered: ', LH != '' || TH !='')
    if (LH != '' || TH !=''){
        dboperator.getFilteredProduct(start,num=10, LH, TH, search).then(result => {
            console.log(result)
            res.status(201).json(result);
        })
    }
    else {
        dboperator.getProductList(start,num=10, search).then(result => {
            console.log(result)
            res.status(201).json(result);
        })
    }
})

app.post('/BrandList', (req, res) => {
    dboperator.getBrandList().then(result => {
        res.status(201).json(result);
    })
})

app.get('/Search/:value', (req, res) => {
    res.sendFile(path.join(staticPath,"search.html"));
})

app.get('/ProductDetail/:value', (req, res) => {
    res.sendFile(path.join(staticPath,"product-detail.html"));
})

app.post('/ProductDetail', (req, res) => {
    let {id} = req.body
    //console.log(typeof parseInt(id))
    dboperator.getProductDetail(parseInt(id)).then(result => {
        res.status(201).json(result);
    })
})

/*--------------------------------KHÁCH HÀNG-------------------------------------*/
app.get('/LogInKH', (req, res) => {
    res.sendFile(path.join(staticPath,"login.html"));
})

app.post('/LogInKH', (req, res) => {
    let {username, password} = req.body;
    dboperator.getKH(username).then(result =>{
        //console.log('result:',result);
        if (result.length>0){
            if (username==result[0].SDT)
                if (password==result[0].pword){
                    return res.json(result[0])
                }
                else{
                    return res.json({'alert':'Sai tên đăng nhập hoặc mật khẩu. Bạn vui lòng thử lại.'})
                }
            else{
                return res.json({'alert':'Sai tên đăng nhập hoặc mật khẩu. Bạn vui lòng thử lại.'})
            }
        }
        else {
            return res.json({'alert':'Tài khoản đăng nhập không tồn tại.'})
        }  
          
    });
    
});

app.post('/SignUpKH', (req, res) => {
    let dkn = {...req.body};
    //console.log(dkn.SDT)
    dboperator.getKH(dkn.SDT).then(result =>{
        //console.log(result[0]);
        //console.log(flag)
        if (result[0]==null){
            console.log('valid')
            dboperator.addCustomer(dkn).then(result => {
                res.json(dkn);
            })
        }
        else 
        res.json({'alert':'Số điện thoại đã tồn tại. Vui lòng nhập số điện thoại khác!'});
    })
})

//View Info
app.get('/Info', (req, res) => {
    res.sendFile(path.join(staticPath,"customer_info.html"));
})
app.post('/Info', (req, res) => {
    console.log(req)
    let MaKH = req.body['SDT']
    console.log(MaKH)
    dboperator.getKH(MaKH).then(result => {
        console.log(result)
        res.json(result);
    })
})
//View bill list
app.post('/BillListKH', (req, res) => {
    let start = (req.body['start'])
    let makh = (req.body['SDT'])
    //res.json(start)
    if (!start || start<0)
    {
        start = 0
    }
    dboperator.getCustomerBillList(start,makh).then(result => {
        console.log(result)
        res.json(result);
    })
})

//show page billinfo
app.get('/billinfo/:MaDH', (req, res) => {
    res.sendFile(path.join(staticPath,"billinfo.html"));
})

//View bill info
app.post('/billinfo',(req,res)=>{
    let MaDH = {...req.body}
    dboperator.getBill(MaDH.MaDH).then(result => {
       res.json(result);
    })
})

//View bill detail
app.post('/detailBill', (req,res)=>{
    let MaDH = {...req.body}
    dboperator.getDetailBill(MaDH.MaDH).then(result => {
        //console.log('Detail bill')
        //console.log(result)
        res.json(result);
    })
 })

 //Lich su tich luy
app.get('/LSTL', (req, res) => {
    res.sendFile(path.join(staticPath,"LichSuTichLuy.html"));
})

app.post('/LSTL', (req, res) => {
    let start = (req.body['start'])
    let bd = (req.body['StartDate'])
    let kt = (req.body['EndDate'])
    let makh = (req.body['SDT'])
    //res.json(start)
    if (!start || start<0)
    {
        start = 0
    }
    dboperator.getLSTL(start,bd,kt,makh).then(result => {
        console.log(result)
        res.json(result);
    })
})

/*----------------------------------CỬA HÀNG---------------------------------------*/
//Thống kê doanh thu theo ngày
app.get('/TKDT', (req, res) => {
    res.sendFile(path.join(staticPath,"ThongKeDT_CH.html"));
})

app.post('/TKDT', (req, res) => {
    let start = (req.body['start'])
    let bd = (req.body['StartDate'])
    let kt = (req.body['EndDate'])
    let mach = (req.body['MaCH'])
   
    dboperator.getTKDT(start,bd,kt,mach).then(result => {
        console.log(result)
        res.json(result);
    })
})

//Thống kê sản phẩm theo số lượng tồn và cửa hàng
app.get('/TKSLT', (req, res) => {
    res.sendFile(path.join(staticPath,"TKSoLuongSP.html"));
})

app.post('/TKSLT', (req, res) => {
    let start = (req.body['start'])
    let sl = (req.body['SL'])
    let mach = (req.body['MaCH'])
    //res.json(start)
    if (!start || start<0)
    {
        start = 0
    }
    dboperator.getTKSLT(start,mach,sl).then(result => {
        console.log(result)
        res.json(result);
    })
})

//Thống kê doanh thu tất cả cửa hàng
app.get('/TKDTALL', (req, res) => {
    res.sendFile(path.join(staticPath,"TKDT_CH_ALL.html"));
})

app.post('/TKDTALL', (req, res) => {
    let bd = (req.body['StartDate'])
    let kt = (req.body['EndDate'])
   
    dboperator.getTKDTALL(bd,kt).then(result => {
        console.log(result)
        res.json(result);
    })
})

//Doanh Thu Nhân Viên
app.get('/DTNV', (req, res) => {
    res.sendFile(path.join(staticPath,"DoanhThuNhanVien.html"));
})

app.post('/DTNV', (req, res) => {
    let bd = (req.body['StartDate'])
    let kt = (req.body['EndDate'])
   
    dboperator.getDTNV(bd,kt).then(result => {
        console.log(result)
        res.json(result);
    })
})
//Thêm Sản Phẩm
app.get('/AddProduct', (req, res) => {
    res.sendFile(path.join(staticPath,"AddProduct.html"));
})
app.post('/AddProduct', (req, res) => {
    let start = (req.body['start'])
    let mach = (req.body['MaCH'])
    //res.json(start)
    if (!start || start<0)
    {
        start = 0
    }
    if (mach==""){
        dboperator.getProductAdmin(start).then(result => {
            console.log(result)
            res.json(result);
        })
    }
    else{
        dboperator.getProductAdminStore(start,mach).then(result => {
            console.log(result)
            res.json(result);
        })
    }
})

//Add Product
app.post('/AddProduct_add',(req,res)=>{
    let product = {...req.body};
     dboperator.addProduct(product).then(result => {
         console.log(result)
        res.status(201).json(result);
     }) 
 })
 //Add Product to agent
app.post('/AddProduct_addCH',(req,res)=>{
    let product = {...req.body};
    console.log("body")
    console.log(req.body)
     dboperator.addProductToAgent(product).then(result => {
        res.status(201).json(result);
     }) 
 })