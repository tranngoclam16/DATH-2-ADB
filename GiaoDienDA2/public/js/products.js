let product_list = document.querySelector('#products')
let brand_list = document.querySelector('#brands')

function fetchProductList (value) {  
    let objToPost = { 
        start: value,
        LH: '',
        TH: '' 
    }
    fetch('/ProductList', {
    method: 'POST',
    headers: {
      "Content-type": 'application/json'
    },
    credentials: 'include',
    body: JSON.stringify(objToPost)
  })
    .then(res => {
        res.json().then(data =>{
            //renderProducts(data)
            //document.getElementById('.products').remove()
            let prod = ''
            data.forEach(e => {
                if(parseInt(e.GiamGia)==0){
                    prod += `
                        <div class="col-4 col-md-6 col-sm-12">
                            <div class="product-card">
                                <div class="product-card-img">
                                    <img src=./img/products/1.jpg alt="">
                                    <img src=./img/products/1.jpg alt="">
                                </div>
                                <div class="product-card-info">
                                    <div class="product-btn">
                                        <a href="/ProductDetail/${e.MaSP}" class="btn-flat btn-hover btn-shop-now">shop now</a>
                                        <button class="btn-flat btn-hover btn-cart-add">
                                            <i class='bx bxs-cart-add'></i>
                                        </button>
                                        <button class="btn-flat btn-hover btn-cart-add">
                                            <i class='bx bxs-heart'></i>
                                        </button>
                                    </div>
                                    <div class="product-card-name">
                                        ${e.TenSP}
                                    </div>
                                    <div class="product-card-price">
                                        <span class="curr-price">${e.DonGia}</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    `
                    //product_list.insertAdjacentHTML("beforeend", prod)
                }
                else {
                    prod += `
                    <div class="col-4 col-md-6 col-sm-12">
                        <div class="product-card">
                            <div class="product-card-img">
                                <img src=./img/products/1.jpg alt="">
                                <img src=./img/products/1.jpg alt="">
                            </div>
                            <div class="product-card-info">
                                <div class="product-btn">
                                    <a href="./product-detail.html" class="btn-flat btn-hover btn-shop-now">shop now</a>
                                    <button class="btn-flat btn-hover btn-cart-add">
                                        <i class='bx bxs-cart-add'></i>
                                    </button>
                                    <button class="btn-flat btn-hover btn-cart-add">
                                        <i class='bx bxs-heart'></i>
                                    </button>
                                </div>
                                <div class="product-card-name">
                                    ${e.TenSP}
                                </div>
                                <div class="product-card-price">
                                    <span><del>${e.DonGia}</del></span>
                                    <span class="curr-price">${e.GiamGia}</span>
                                </div>
                            </div>
                        </div>
                    </div>
                    `
                    //product_list.insertAdjacentHTML("beforeend", prod)
                }
            })
            product_list.innerHTML = prod
        })
    })
  }

function fetchFilteredProduct (value, LH, TH) {  
    console.log(value)
    console.log(LH)
    console.log(TH)
    let objToPost = { 
        start: value,
        LH: LH,
        TH: TH 
    }
    fetch('/ProductList', {
    method: 'POST',
    headers: {
      "Content-type": 'application/json'
    },
    credentials: 'include',
    body: JSON.stringify(objToPost)
  })
    .then(res => {
        res.json().then(data =>{
            //renderProducts(data)
            //document.getElementById('.products').remove()
            let prod = ''
            data.forEach(e => {
                if(parseInt(e.GiamGia)==0){
                    prod += `
                        <div class="col-4 col-md-6 col-sm-12">
                            <div class="product-card">
                                <div class="product-card-img">
                                    <img src=./img/products/1.jpg alt="">
                                    <img src=./img/products/1.jpg alt="">
                                </div>
                                <div class="product-card-info">
                                    <div class="product-btn">
                                        <a href="/ProductDetail/${e.MaSP}" class="btn-flat btn-hover btn-shop-now">shop now</a>
                                        <button class="btn-flat btn-hover btn-cart-add">
                                            <i class='bx bxs-cart-add'></i>
                                        </button>
                                        <button class="btn-flat btn-hover btn-cart-add">
                                            <i class='bx bxs-heart'></i>
                                        </button>
                                    </div>
                                    <div class="product-card-name">
                                        ${e.TenSP}
                                    </div>
                                    <div class="product-card-price">
                                        <span class="curr-price">${e.DonGia}</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    `
                    //product_list.insertAdjacentHTML("beforeend", prod)
                }
                else {
                    prod += `
                    <div class="col-4 col-md-6 col-sm-12">
                        <div class="product-card">
                            <div class="product-card-img">
                                <img src=./img/products/1.jpg alt="">
                                <img src=./img/products/1.jpg alt="">
                            </div>
                            <div class="product-card-info">
                                <div class="product-btn">
                                    <a href="./product-detail.html" class="btn-flat btn-hover btn-shop-now">shop now</a>
                                    <button class="btn-flat btn-hover btn-cart-add">
                                        <i class='bx bxs-cart-add'></i>
                                    </button>
                                    <button class="btn-flat btn-hover btn-cart-add">
                                        <i class='bx bxs-heart'></i>
                                    </button>
                                </div>
                                <div class="product-card-name">
                                    ${e.TenSP}
                                </div>
                                <div class="product-card-price">
                                    <span><del>${e.DonGia}</del></span>
                                    <span class="curr-price">${e.GiamGia}</span>
                                </div>
                            </div>
                        </div>
                    </div>
                    `
                    //product_list.insertAdjacentHTML("beforeend", prod)
                }
            })
            product_list.innerHTML = prod
        })
    })
  }

function check(value){
    let LH = sessionStorage.LH || ''
    let TH = sessionStorage.TH || ''
    if (LH!=''){
        let arr = LH.split(';')
        arr.forEach(e =>{
            let id = '#LH' + e
            console.log(id)
            $(id).attr('checked', 'checked');
        })
    }
    if(TH!=''){
        let arr = TH.split(';')
        arr.forEach(e =>{
            let id = '#TH' + e
            console.log(id)
            $(id).attr('checked', 'checked');
        })
    }
    console.log('filtered: ', LH != '' || TH !='')
    if (LH != '' || TH !=''){
        fetchFilteredProduct(value, LH, TH)
    }
    else fetchProductList(value)
}
function BrandList () {  
    fetch('/BrandList', {
    method: 'POST',
    headers: {
      "Content-type": 'application/json'
    },
    credentials: 'include',
  })
    .then(res => {
        res.json().then(data =>{
            console.log(data)
            data.forEach(e => {
                let prod = `
                <li>
                    <div class="group-checkbox">
                        <input type="checkbox" id="TH${e.MaTH}" onclick="typeCheck(this)">
                        <label for="TH${e.MaTH}">
                            ${e.Ten}
                            <i class='bx bx-check'></i>
                        </label>
                    </div>
                </li>
                    `
                brand_list.insertAdjacentHTML("beforeend", prod)
               
            })
        })
    })
  }


function typeCheck(element)
{
    console.log($(element).is(':checked'))
    if ($(element).is(':checked')){
        var id = $(element).attr('id');
        if (id.includes('LH')){
            let temp = sessionStorage.LH || ''
            temp += id.substring(2) + ';'
            sessionStorage.LH = temp
        }
        else {
            let temp = sessionStorage.TH || ''
            temp += id.substring(2) + ';'
            sessionStorage.TH = temp
        }
    }
    else {
        //$(element).removeAttr('checked');
        var id = $(element).attr('id');
        console.log(id)
        if (id.includes('LH')){
            let temp = sessionStorage.LH || ''
            id = id.substring(2)+';'
            temp = temp.split(id).join("");
            //temp.replace(new RegExp(id, 'g'), "");
            sessionStorage.LH = temp
        }
        else {
            let temp = sessionStorage.TH || ''
            id = id.substring(2)+';'
            temp = temp.split(id).join("");
            sessionStorage.TH = temp
        }
    }
    location.reload('/ProductList')
    /* let LH = sessionStorage.LH || ''
    let TH = sessionStorage.TH || ''
    if (LH != '' || TH !=''){
        fetchFilteredProduct(value, LH, TH)
    }
    else fetchProductList(value) */
}

let filter_col = document.querySelector('#filter-col')

document.querySelector('#filter-toggle').addEventListener('click', () => filter_col.classList.toggle('active'))

document.querySelector('#filter-close').addEventListener('click', () => filter_col.classList.toggle('active'))