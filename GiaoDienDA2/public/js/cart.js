/* if (document.readyState == 'loading') {
    document.addEventListener('DOMContentLoaded', ready)
} else {
    ready()
}

function ready() {
    var removeCartItemButtons = document.getElementsByClassName('btn-danger')
    for (var i = 0; i < removeCartItemButtons.length; i++) {
        var button = removeCartItemButtons[i]
        button.addEventListener('click', removeCartItem)
    }

    var quantityInputs = document.getElementsByClassName('cart-quantity-input')
    for (var i = 0; i < quantityInputs.length; i++) {
        var input = quantityInputs[i]
        input.addEventListener('change', quantityChanged)
    }

    var addToCartButtons = document.getElementsByClassName('shop-item-button')
    for (var i = 0; i < addToCartButtons.length; i++) {
        var button = addToCartButtons[i]
        button.addEventListener('click', addToCartClicked)
    }

    document.getElementsByClassName('btn-purchase')[0].addEventListener('click', purchaseClicked)
}

function purchaseClicked() {
    alert('Thank you for your purchase')
    var cartItems = document.getElementsByClassName('cart-items')[0]
    while (cartItems.hasChildNodes()) {
        cartItems.removeChild(cartItems.firstChild)
    }
    updateCartTotal()
}

function removeCartItem(event) {
    var buttonClicked = event.target
    buttonClicked.parentElement.parentElement.remove()
    updateCartTotal()
}

function quantityChanged(event) {
    var input = event.target
    if (isNaN(input.value) || input.value <= 0) {
        input.value = 1
    }
    updateCartTotal()
}

function addToCartClicked(event) {
    var button = event.target
    var shopItem = button.parentElement.parentElement
    var title = shopItem.getElementsByClassName('shop-item-title')[0].innerText
    var price = shopItem.getElementsByClassName('shop-item-price')[0].innerText
    var imageSrc = shopItem.getElementsByClassName('shop-item-image')[0].src
    addItemToCart(title, price, imageSrc)
    updateCartTotal()
}

function addItemToCart(title, price, imageSrc) {
    var cartRow = document.createElement('div')
    cartRow.classList.add('cart-row')
    var cartItems = document.getElementsByClassName('cart-items')[0]
    var cartItemNames = cartItems.getElementsByClassName('cart-item-title')
    for (var i = 0; i < cartItemNames.length; i++) {
        if (cartItemNames[i].innerText == title) {
            alert('This item is already added to the cart')
            return
        }
    }
    var cartRowContents = `
        <div class="cart-item cart-column">
            <img class="cart-item-image" src="${imageSrc}" width="100" height="100">
            <span class="cart-item-title">${title}</span>
        </div>
        <span class="cart-price cart-column">${price}</span>
        <div class="cart-quantity cart-column">
            <input class="cart-quantity-input" type="number" value="1">
            <button class="counter-btn decrement">-</button>
            <p class="item-count">1</p>
            <button class="counter-btn increment">+</button>
            <button class="btn btn-danger" type="button">REMOVE</button>
        </div>`
    cartRow.innerHTML = cartRowContents
    cartItems.append(cartRow)
    cartRow.getElementsByClassName('btn-danger')[0].addEventListener('click', removeCartItem)
    cartRow.getElementsByClassName('cart-quantity-input')[0].addEventListener('change', quantityChanged)
}

function updateCartTotal() {
    var cartItemContainer = document.getElementsByClassName('cart-items')[0]
    var cartRows = cartItemContainer.getElementsByClassName('cart-row')
    var total = 0
    for (var i = 0; i < cartRows.length; i++) {
        var cartRow = cartRows[i]
        var priceElement = cartRow.getElementsByClassName('cart-price')[0]
        var quantityElement = cartRow.getElementsByClassName('cart-quantity-input')[0]
        var price = parseFloat(priceElement.innerText.replace('$', ''))
        var quantity = quantityElement.value
        total = total + (price * quantity)
    }
    total = Math.round(total * 100) / 100
    document.getElementsByClassName('cart-total-price')[0].innerText = '$' + total
} */


const createSmallCards = (data)=>{
    return `
    <div class="sm-product">
        <img src="../img/products/1.jpg" class="sm-product-img" alt="">
        <div class="sm-text">
            <p class="sm-product-name">${data.TenSP}</p>
        </div>
        <div class="item-counter">
            <button class="counter-btn decrement">-</button>
            <p class="item-count">${data.item}</p>
            <button class="counter-btn increment">+</button>
        </div>
        <p class="sm-price" data-price="${data.DonGia}">${parseFloat(data.DonGia)*data.item*1000}</p>
        <button class="sm-delete-btn">
            x
        </button>
    </div>
    `;
}
let totalBill=0

const setProduct = ()=>{
    const element = document.querySelector(`.cart`);
    let data=sessionStorage.products
    if(data==null){
        element.innerHTML=`<img src="../img/empty-cart.png" class="empty-img" alt="">`
    }else{
        data = JSON.parse(data)
        for(let i = 0; i <data.length;i++){
            element.innerHTML += createSmallCards(data[i])
            totalBill += parseFloat(data[i].DonGia) * data[i].item *1000
        }
        updateBill()
    }
    setupEnvents();
}
const updateBill=() =>{
    let billPrice = document.querySelector('.bill')
    billPrice.innerHTML=`${totalBill}`
}

const setupEnvents = ()=>{
    const counterMinus = document.querySelectorAll('.decrement')
    const counterPlus = document.querySelectorAll('.increment')
    const counts = document.querySelectorAll('.item-count')
    const price = document.querySelectorAll('.sm-price')
    const deleteBtn = document.querySelectorAll(`.sm-delete-btn`)

    let product = sessionStorage.products
    if (product!=null){
        product = JSON.parse(product)
    }
    counts.forEach((item, i ) =>{
        let cost = parseFloat(price[i].getAttribute('data-price'))
        console.log(cost)

        counterMinus[i].addEventListener('click',()=>{
            if(item.innerHTML > 1 ){
                item.innerHTML--;
                totalBill -= cost*1000;
                price[i].innerHTML = parseFloat(item.innerHTML)*cost*1000
                updateBill()
                product[i].item = parseFloat(item.innerHTML);
                sessionStorage.products = JSON.stringify(product);
            }
        })

        counterPlus[i].addEventListener('click',()=>{
            if(item.innerHTML < 9 ){
                item.innerHTML++;
                totalBill += cost*1000;
                price[i].innerHTML = parseFloat(item.innerHTML)*cost*1000
                updateBill();
                product[i].item = parseFloat(item.innerHTML);
                sessionStorage.products = JSON.stringify(product);
            }
        })
    })

    deleteBtn.forEach((item, i) =>{
        console.log(item)
        console.log(i)
        item.addEventListener('click', ()=>{
            
            product = product.filter((data, index) => index != i)
            sessionStorage.products = JSON.stringify(product)
            location.reload()
        })
    })
}
setProduct()