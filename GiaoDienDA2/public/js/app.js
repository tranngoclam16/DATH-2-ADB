document.querySelectorAll('.dropdown > a').forEach(e => {
    e.addEventListener('click', (event) => event.preventDefault())
})

document.querySelectorAll('.mega-dropdown > a').forEach(e => {
    e.addEventListener('click', (event) => event.preventDefault())
})

document.querySelector('#mb-menu-toggle').addEventListener('click', () => document.querySelector('#header-wrapper').classList.add('active'))

document.querySelector('#mb-menu-close').addEventListener('click', () => document.querySelector('#header-wrapper').classList.remove('active'))

const logoutBtn = document.querySelector('#logout')
const actionBtn = document.querySelector('#signin-signup')
const menu = document.querySelector('#user-menu')


window.onload = () => {
    let user = JSON.parse(sessionStorage.user || null)
    if (user != null){
        actionBtn.innerHTML = 'Hello, '+ user.HoTen;
        logoutBtn.innerHTML = 'Log out'
        logoutBtn.addEventListener('click', ()=>{
            sessionStorage.clear();
            location.reload();
        })
    } else {
        actionBtn.innerHTML = 'Sign in/Sign up'
        logoutBtn.style.display = 'none';
        menu.style.display = 'none';
          /* $(logoutBtn).attr('hidden', 'checked');
          actionBtn.addEventListener('click', () => {
            location.href = '/LogInKH'
          }) */
    }
}

const addToCart = (product) => {
        let user = JSON.parse(sessionStorage.user)
        user = user.MaKH
        //sessionStorage.setItem(user,JSON.stringify(products))
        let data = JSON.parse(sessionStorage.getItem(user));
        if (data == null){
            data = []
        }

        product = {
            item: 1,
            MaSP: product.MaSP,
            TenSP: product.TenSP,
            DonGia: product.DonGia,
            GiamGia: product.GiamGia
        }
        data.push(product)
}