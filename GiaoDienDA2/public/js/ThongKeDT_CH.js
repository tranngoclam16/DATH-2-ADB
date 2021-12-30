function fetchTable (value,bd,kt,cn) {
    var url = 'http://localhost:3000/TKDT';
    fetch(url,{
        method: 'POST',
        headers: {
          "Content-type":'application/json'
        },
        body: JSON.stringify({start:value,StartDate:bd,EndDate:kt,MaCH:cn})
      })
    .then (response => {response.json().then((data) => {
        length = data['tableLength']
        dataT = data['data']
        console.log(data)
        var source = document.getElementById('entry-template').innerHTML;
        var template = Handlebars.compile(source);
        var html = template(dataT);
        $('#listProduct').html(html);
        document.getElementById("template-DoanhThu").innerHTML=data['doanhthu']
        document.getElementById("template-Tong").innerHTML=data['sldaban']
        document.getElementById("currentPage").innerHTML = currentPage + '/' + length/100
      })
    });
  }

  function fetchTableSL (value,mach,sl) {
    var url = 'http://localhost:3000/TKSLT';
    fetch(url,{
        method: 'POST',
        headers: {
          "Content-type":'application/json'
        },
        body: JSON.stringify({start:value, MaCH:mach,SL:sl})
      })
    .then (response => {response.json().then((data) => {
      length = data['tableLength']
      data = data['data']
      console.log(data)
      var source = document.getElementById('entry-template').innerHTML;
      var template = Handlebars.compile(source);
      var html = template(data);
      $('#listProduct').html(html);
      document.getElementById("currentPage").innerHTML = currentPage + '/' + length/100;
      document.getElementById("template-Tong").innerHTML = length;
      })
    });
  }

  function fetchTableAll (bd,kt) {
    var url = 'http://localhost:3000/TKDTALL';
    fetch(url,{
        method: 'POST',
        headers: {
          "Content-type":'application/json'
        },
        body: JSON.stringify({StartDate:bd,EndDate:kt})
      })
    .then (response => {response.json().then((data) => {
        dataT = data['data']
        console.log(data)
        var source = document.getElementById('entry-template').innerHTML;
        var template = Handlebars.compile(source);
        var html = template(dataT);
        $('#listProduct').html(html);
        document.getElementById("template-DoanhThu").innerHTML=data['doanhthu']
        document.getElementById("template-Tong").innerHTML=data['sldaban']
      })
    });
  }

  function fetchTableEmployee (bd,kt) {
    var url = 'http://localhost:3000/DTNV';
    fetch(url,{
        method: 'POST',
        headers: {
          "Content-type":'application/json'
        },
        body: JSON.stringify({StartDate:bd,EndDate:kt})
      })
    .then (response => {response.json().then((data) => {
        data = data['data']
        console.log(data)
        var source = document.getElementById('entry-template').innerHTML;
        var template = Handlebars.compile(source);
        var html = template(data);
        $('#listProduct').html(html);
      })
    });
  }