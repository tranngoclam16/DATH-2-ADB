const signUpButton = document.getElementById('signUp');
const signInButton = document.getElementById('signIn');
const container = document.getElementById('container');

signUpButton.addEventListener('click', () => {
  container.classList.add("right-panel-active");
});

signInButton.addEventListener('click', () => {
  container.classList.remove("right-panel-active");
});


login_submit.addEventListener('click', function(){
  let objToPost = { 
      username: $("#username").val(),
      password: $("#passwordLI").val()
  }

  console.log(objToPost);
  if (username!="" && password!=""){
      senData('http://localhost:3000/LogInKH', objToPost)
  }
  else alert("Vui lòng nhập đầy đủ thông tin!")

});

register_submit.addEventListener('click',() => {
  let objToPost = { 
      HoTen: $('#HoTen').val(),
      SDT: $('#SDT').val(),
      GioiTinh: $('#GioiTinh').val(),
      NgaySinh: $('#NgaySinh').val(),
      DiaChi: $('#DiaChi').val(),
      Email: $('#email').val(),
      Password: $('#password').val()
  }
  console.log(objToPost)
  if (objToPost.SDT.length != 10 || !Number(objToPost.SDT.length))
      alert("Số điện thoại không hợp lệ")
  else if (objToPost.Password.length < 6)
      alert("Mật khẩu phải có ít nhất 6 kí tự!")
  else 
      senData('http://localhost:3000/SignUpKH', objToPost)
})

const senData = (path, data) => {
  fetch(path, {
      method: 'POST',
      headers: new Headers({'Content-Type': 'application/json'}),
      body: JSON.stringify(data)
  })
  .then (response => {
      response.json().then((data) => {
          //console.log(data)
          processData(data)
      });
      
  });
}

const processData = (data)=> {
  console.log(data)
  if(data.alert){
      alert(data.alert)
  } else if (data.SDT){
      alert('Welcome to our website!')
      sessionStorage.user = JSON.stringify(data)
      location.replace('/Info')
  }
}



