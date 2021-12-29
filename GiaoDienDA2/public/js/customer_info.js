function fetchTable (value, kh) {
    var url = 'http://localhost:3000/BillListKH';
    fetch(url,{
        method: 'POST',
        headers: {
          "Content-type":'application/json'
        },
        body: JSON.stringify({start:value, SDT:kh})
      })
    .then (response => {response.json().then((data) => {
        length = data['tableLength']
        data = data['data']
        console.log(data)
        var source = document.getElementById('entry-template').innerHTML;
        var template = Handlebars.compile(source);
        var html = template(data);
        $('#listBill').html(html);
        document.getElementById("currentPage").innerHTML = currentPage + '/' + length/100
      })
    });
  }
function fetchData (value) {
    var url = 'http://localhost:3000/Info';
    fetch(url,{
        method: 'POST',
        headers: {
          "Content-type":'application/json'
        },
        body: JSON.stringify({SDT:value})
      })
    .then (response => {response.json().then((data) => {
        data = data[0];
        console.log(data)
        document.getElementById('template-SDT').innerHTML = data["SDT"];
        document.getElementById('template-HoTen').innerHTML = data["HoTen"];
        document.getElementById('template-GioiTinh').innerHTML = data["GioiTinh"];
        document.getElementById('template-NgaySinh').innerHTML = data["NgaySinh"];
        document.getElementById('template-DiaChi').innerHTML = data["DiaChi"];
        document.getElementById('template-Email').innerHTML = data["Email"];
        var the=data["LoaiThe"]
        if(the==1)
        {
            document.getElementById('template-LoaiThe').innerHTML="Thẻ thường";
        }
        else if(the==2)
        {
            document.getElementById('template-LoaiThe').innerHTML="Thẻ VIP GOLD ";
        } 
        else if(the==3)
        {
            document.getElementById('template-LoaiThe').innerHTML="Thẻ VIP DIMOND ";
        } 
            
      })});
  }