const createNav = () => {
    let nav = document.querySelector('.navbar');

    nav.innerHTML = `
    <div id="mySidenav" class="sidenav">
    <a href="javascript:void(0)" class="closebtn" onclick="closeNav()">&times;</a>
    <a href="/TKDT">Thống kê doanh thu cửa hàng</a>
    <a href="/TKSLT">Kiểm tra số lượng tồn</a>
    <a href="#">Clients</a>
    <a href="#">Contact</a>
  </div>
  <span style="color:#f07585;font-size:30px;cursor:pointer" onclick="openNav()">&#9776; MENU</span>`;
}

createNav();
function openNav() {
    document.getElementById("mySidenav").style.width = "250px";
    document.getElementById("main").style.marginLeft = "250px";
  }
  function closeNav() {
    document.getElementById("mySidenav").style.width = "0";
    document.getElementById("main").style.marginLeft = "0";
  }