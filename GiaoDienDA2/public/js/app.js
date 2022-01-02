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

/* const cartBtn = document.querySelector('#cartBtn')
cartBtn.addEventListener('click', ()=>{
    let product = {
        MaSP: cartBtn.getAttribute('data-id'),
        TenSP: cartBtn.getAttribute('data-name'),
        DonGia: cartBtn.getAttribute('data-price')
    }
    addToCart(product)
    
}) */

const cartBtn = (e) => {
    let product = {
       /*  MaSP: $(e).data('id'),     
        TenSP: $(e).data('name'),
        DonGia: $(e).data('price') */
        item: 1,
        MaSP: e.getAttribute('data-id'),
        TenSP: decodeURIComponent(e.getAttribute('data-name')),
        DonGia: e.getAttribute('data-price')
    }
        let user = JSON.parse(sessionStorage.user)
        user = user.MaKH
        //sessionStorage.setItem(user,JSON.stringify(products))
        let data = sessionStorage.products;
        //console.log(data)
        let temp = []
        if (data == null){
            temp =[]
        }
        else temp = JSON.parse(data)

        /* product = {
            item: 1,
            MaSP: product.MaSP,
            TenSP: product.TenSP,
            DonGia: product.DonGia
        } */
        temp.push(product)
        sessionStorage.products=JSON.stringify(temp)
}