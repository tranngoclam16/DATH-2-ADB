function fetchData (value) {
    console.log(value)
   // console.log("url:",url)
    fetch('/billinfo', {
            method: 'POST',
            headers: new Headers({'Content-Type': 'application/json'}),
            credentials: 'include',
            body: JSON.stringify({MaDH: value})
    })
    .then(response => {
        if (response.ok) {
            return response.json();
        } else {
            throw new Error(response.statusText);
        }
    })
    .then(data => {
        data = data[0];
        //console.log(data)
        document.getElementById('template-MaDH').innerHTML = data["MaDH"];
        document.getElementById('template-NgayLap').innerHTML = data["NgayLap"];
        document.getElementById('template-SDT').innerHTML = data["MaKH"];
        document.getElementById('template-MaCH').innerHTML = data["MaCH"];
        document.getElementById('template-MaNV').innerHTML = data["MaNV"];
        document.getElementById('template-SoThe').innerHTML = data["SoThe"];
        
        document.getElementById('template-TongTien').innerHTML = data["TongTien"];
        document.getElementById('template-ThanhToan').innerHTML = data["MaTT"];

        var the=data["LoaiDH"]
        if(the==1)
        {
            document.getElementById('template-LoaiDH').innerHTML="Offline";
        }
        else if(the==2)
        {
            document.getElementById('template-LoaiDH').innerHTML="Online";
        } 

        var tinhtrang=data["MaTinhTrang"]
        if(tinhtrang==1)
        {
            document.getElementById('template-MaTinhTrang').innerHTML="Đơn hàng đã hủy";
        }
        else if(tinhtrang==2)
        {
            document.getElementById('template-MaTinhTrang').innerHTML="Đơn hàng đã xác nhận";
        } 
        if(tinhtrang==3)
        {
            document.getElementById('template-MaTinhTrang').innerHTML="Đơn hàng đang được chuẩn bị";
        }
        else if(tinhtrang==4)
        {
            document.getElementById('template-MaTinhTrang').innerHTML="Đơn hàng đang giao";
        } 
        else if(tinhtrang==5)
        {
            document.getElementById('template-MaTinhTrang').innerHTML="Đơn hàng giao thành công";
        } 
        

        var thanhtoan=data["MaTT"]
        if(thanhtoan==1)
        {
            document.getElementById('template-ThanhToan').innerHTML="Thanh toán khi nhận hàng";
        }
        if(thanhtoan==2)
        {
            document.getElementById('template-ThanhToan').innerHTML="Thanh toán bằng thẻ nội địa";
        }
        if(thanhtoan==3)
        {
            document.getElementById('template-ThanhToan').innerHTML="Thanh toán bằng thẻ quốc tế";
        }
        if(thanhtoan==4)
        {
            document.getElementById('template-ThanhToan').innerHTML="Thanh toán bằng ZaloPay";
        }
        if(thanhtoan==5)
        {
            document.getElementById('template-ThanhToan').innerHTML="Thanh toán qua chuyển khoản ngân hàng";
        }
        if(thanhtoan==6)
        {
            document.getElementById('template-ThanhToan').innerHTML="Thanh toán bằng tiền mặt";
        }
        if(thanhtoan==7)
        {
            document.getElementById('template-ThanhToan').innerHTML="Thanh toán bằng ví điện tử";
        }
      });
  }
  
 function fetchTable (value) {
    fetch('../../detailBill', {
        method: 'POST',
        headers: new Headers({'Content-Type': 'application/json'}),
        credentials: 'include',
        body: JSON.stringify({MaDH: value})
    })
      .then(response => {
          response.json().then(data =>{
            console.log(data)
           
            data = data['data']
            var source = document.getElementById('entry-template').innerHTML;
            var template = Handlebars.compile(source);
            var html = template(data);
            $('#listBillDetail').html(html);
          })
      });
  }