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
    res.sendFile(path.join(staticPath,"index1.html"));
})


/*--------------------------------KHÁCH HÀNG-------------------------------------*/
app.get('/LogInKH', (req, res) => {
    res.sendFile(path.join(staticPath,"login.html"));
})

app.post('/LogInKH', (req, res) => {
    let {username, password} = req.body;
    dboperator.getKH(username).then(result =>{
        console.log('result:',result);
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
    console.log(dkn.SDT)
    dboperator.getKH(dkn.SDT).then(result =>{
        console.log(result[0]);
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
