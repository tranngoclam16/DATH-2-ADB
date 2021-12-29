function fetchTable (value,bd,kt,kh) {
    var url = 'http://localhost:3000/LSTL';
    fetch(url,{
        method: 'POST',
        headers: {
          "Content-type":'application/json'
        },
        body: JSON.stringify({start:value, StartDate:bd,EndDate:kt,SDT:kh})
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