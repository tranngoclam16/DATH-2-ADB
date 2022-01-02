let slide_index = 0
let slide_play = true
let slides = document.querySelectorAll('.slide')

hideAllSlide = () => {
    slides.forEach(e => {
        e.classList.remove('active')
    })
}

showSlide = () => {
    hideAllSlide()
    slides[slide_index].classList.add('active')
}

nextSlide = () => slide_index = slide_index + 1 === slides.length ? 0 : slide_index + 1

prevSlide = () => slide_index = slide_index - 1 < 0 ? slides.length - 1 : slide_index - 1

// pause slide when hover slider

document.querySelector('.slider').addEventListener('mouseover', () => slide_play = false)

// enable slide when mouse leave out slider
document.querySelector('.slider').addEventListener('mouseleave', () => slide_play = true)

// slider controll

document.querySelector('.slide-next').addEventListener('click', () => {
    nextSlide()
    showSlide()
})

document.querySelector('.slide-prev').addEventListener('click', () => {
    prevSlide()
    showSlide()
})

showSlide()

// setInterval(() => {
//     if (!slide_play) return
//     nextSlide()
//     showSlide()
// }, 3000);

// render products

let products =[
    {
      ROWNUMBER: 1,
      MaSP: 0,
      TenSP: 'Bộ lau nhà thông minh',
      DonGia: '1249000.00',
      GiamGia: '187350.00'
    },
    {
      ROWNUMBER: 2,
      MaSP: 1,
      TenSP: 'Thùng sữa tươi tiệt trùng ít đường 200ml',
      DonGia: '1309000.00',
      GiamGia: '196350.00'
    },
    {
      ROWNUMBER: 3,
      MaSP: 2,
      TenSP: 'Giỏ xách quai đựng quần áo',
      DonGia: '1679000.00',
      GiamGia: '251850.00'
    },
    {
      ROWNUMBER: 4,
      MaSP: 3,
      TenSP: 'Cháo tươi Cá lóc',
      DonGia: '969000.00',
      GiamGia: '145350.00'
    },
    {
      ROWNUMBER: 5,
      MaSP: 5,
      TenSP: 'Combo 3 gói Bỉm tã dán 18 miếng (S, 4-8kg)',
      DonGia: '1319000.00',
      GiamGia: '197850.00'
    },
    {
      ROWNUMBER: 6,
      MaSP: 6,
      TenSP: 'Sữa đậu đen, óc chó hạnh nhân',
      DonGia: '1919000.00',
      GiamGia: '287850.00'
    },
    {
      ROWNUMBER: 7,
      MaSP: 7,
      TenSP: 'Giá phơi khô bình sữa',
      DonGia: '939000.00',
      GiamGia: '140850.00'
    },
    {
      ROWNUMBER: 8,
      MaSP: 8,
      TenSP: 'Quần áo mặc nhà họa tiết oto 12-18M',
      DonGia: '249000.00',
      GiamGia: '37350.00'
    },
    {
      ROWNUMBER: 9,
      MaSP: 9,
      TenSP: 'Combo 2 Thực phẩm bổ sung bánh xốp ăn dặm vị phô mai',
      DonGia: '99000.00',
      GiamGia: '14850.00'
    }
  ]

let product_list = document.querySelector('#latest-products')
let best_product_list = document.querySelector('#best-products')

products.forEach(e => {
    let prod = `
        <div class="col-3 col-md-6 col-sm-12">
            <div class="product-card">
                <div class="product-card-img">
                    <img src="./img/products/1.jpg" alt="">
                    <img src="./img/products/2.jpg" alt="">
                </div>
                <div class="product-card-info">
                    <div class="product-btn">
                        <button class="btn-flat btn-hover btn-shop-now">shop now</button>
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
                        <span class="curr-price">${parseFloat(e.DonGia)-parseFloat(e.GiamGia)}</span>
                    </div>
                </div>
            </div>
        </div>
    `

    product_list.insertAdjacentHTML("beforeend", prod)
    best_product_list.insertAdjacentHTML("afterbegin", prod)
})


