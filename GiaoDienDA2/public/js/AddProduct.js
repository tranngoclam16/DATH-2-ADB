function fetchTable (value,MaCH) {  
    var url = 'http://localhost:3000/AddProduct';
    fetch(url,{
        method: 'POST',
        headers: {
          "Content-type":'application/json'
        },
        body: JSON.stringify({start:value,MaCH:MaCH})
      })
    .then (response => {response.json().then((data) => {
        length = data['tableLength']
        dataT = data['data']
        console.log(data)
        var source = document.getElementById('entry-template').innerHTML;
        var template = Handlebars.compile(source);
        var html = template(dataT);
        $('#listProduct').html(html);
        document.getElementById("currentPage").innerHTML = currentPage + '/' + length/100
      })
    });
  }

