/* window.onload = () =>{
    if(!sessionStorage.user){
        location.replace('/LogInKH')
    }
} */

const placeOderBtn = document.querySelector('.place-order-btn')
placeOderBtn.addEventListener('click', ()=>{
    let info =getInfo()
    let user = sessionStorage.user
    user = JSON.parse(user)
    let objToPost = {
        makh: user.SDT,
        name: info.name,
        sdt: info.sdt,
        address: info.address,
        ward: info.ward,
        district: info.district,
        city: info.city,
        payment: parseInt(info.pay),
        products: JSON.parse(sessionStorage.products),
        total: totalBill
    }
    console.log(objToPost)
    if(info){
        fetch('/addOrder', {
            method: 'POST',
            headers: {
                "Content-type": 'application/json'
            },
            credentials: 'include',
            body: JSON.stringify(objToPost)
        }).then(res =>{
            res.json().then(data =>{
                if(data=='Đặt hàng thành công'){
                               alert(data)
                sessionStorage.removeItem('products')
                location.replace('/')
                }
                else{
                    alert(data)
                }
            })
        })
    }
})

const getInfo = () =>{
    let name = $('#fullname').val()
    let sdt = $('#telnum').val()
    let address = $('#address').val()
    let ward = $('#ward').val()
    let district = $('#district').val()
    let city = $('#city').val()
    let pay = $('#payment :selected').val()

    if(!name.length || !sdt.length || !address.length || !ward.length || !district.length || !city.length || !pay.length ){
        alert('Fill all the inputs first')
    }
    else{
        return {name, sdt, address, ward, district, city, pay}
    }
}