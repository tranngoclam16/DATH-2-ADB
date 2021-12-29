const sql = require('mssql/msnodesqlv8')

const config = {
     server: 'localhost', 
     database: 'DATH#2',
     driver: 'msnodesqlv8',
     options: {
       trustedConnection: true
     }
} 

module.exports=config;