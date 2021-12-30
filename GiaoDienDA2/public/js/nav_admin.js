const createNav = () => {
    let nav = document.querySelector('.navbar');

    nav.innerHTML = `
    <div id="mySidenav" class="sidenav">
    <a href="javascript:void(0)" class="closebtn" onclick="closeNav()">&times;</a>
    <a href="/TKDT">Thống Kê Sản Phẩm Của Cửa Hàng</a>
    <a href="/TKSLT">Kiểm tra số lượng tồn</a>
    <a href="/TKDTALL">Thống Kê Doanh Thu Hệ Thống</a>
    <a href="/DTNV">Doanh Thu Nhân Viên</a>
    <a href="/AddProduct">Danh sách sản phẩm</a>
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