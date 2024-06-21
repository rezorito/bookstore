
/////////////////////////////////////////////////////
const btn = document.querySelectorAll(".btn-addtocart")
// console.log(btn)
var giohang = new Array();
var sp;

btn.forEach(function(button,index){
    button.addEventListener("click", function(event){{
        var btnItem = event.target
        var product = btnItem.parentElement
        var productImg = product.querySelector(".home-product-item__img").src
        var productName = product.querySelector(".home-product-item__name").innerText
        var productPrice = product.querySelector(".home-product-item__current-price span").innerText
        // console.log(productImg, productName, productPrice)
        sp = new Array(productImg, productName, productPrice);
        addcart(productImg, productName, productPrice)
    }})
})

function addcart(productImg, productName, productPrice) {
    var addli = document.createElement("li")
    addli.className = "header__cart-item"
    var cartItem = document.querySelectorAll(".header__cart-item")
    for (var i=0; i<cartItem.length; i++) {
        var productT = document.querySelectorAll(".header__cart-item-name")
        // console.log(productT[i].innerText)
        if(productT[i].innerText == productName) {
            alert("Sản phẩm đã có trong giỏ hàng")
            return
        }
    }
    giohang.push(sp);
    sessionStorage.setItem("giohang",JSON.stringify(giohang));
    var licontent = `
                    <img src="${productImg}" alt="" class="header__cart-img">
                    <div class="header__cart-item-info">
                        <div class="header__cart-item-head">
                            <a class="header__cart-item-name">${productName}</a>
                            <span class="header__cart-item-quantity">Số lượng: <input type="number" value="1" min="1"></span>
                            <span class="header__cart-item-price">Giá/sp: <span>${productPrice}</span><sup>đ</sup></span>
                        </div>
                        <div class="header__cart-item-body">
                            <i class="header__cart-item-remove fa-solid fa-xmark"></i>
                        </div>
                    </div>
                    `
    addli.innerHTML = licontent
    var cartList = document.querySelector(".header__cart-list-item")
    // console.log(cartList)
    cartList.append(addli)
    cartTotal()
    deleteItem()
    showcountgiohang();
}

// TÍNH TỔNG TIỀN HÀNG

function cartTotal() {
    var cartItem = document.querySelectorAll(".header__cart-item")
    var totalC = 0
    // console.log(cartItem)
    for (var i=0; i<cartItem.length; i++) {
        var inputValue = cartItem[i].querySelector("input").value
        console.log(inputValue)
        var productPrice = cartItem[i].querySelector(".header__cart-item-price span").innerHTML
        // console.log(productPrice)
        totalA = inputValue*productPrice*1000
        // totalB = totalA.toLocaleString('de-DE')
        totalC = totalC + totalA
        // console.log(totalC)
    }
    var totalPrice = document.querySelector(".header__cart-total-price span")
    totalPrice.innerHTML = totalC.toLocaleString('de-DE')
    inputQuantity()
    // cartNum()
}

// =---------------------------Xóa---------------------------
function deleteItem() {
    var cartItem = document.querySelectorAll(".header__cart-item")
    for (var i=0; i<cartItem.length; i++) {
        var productT = document.querySelectorAll(".header__cart-item-remove")
        productT[i].addEventListener("click", function(event){
            var cartDelete = event.target
            var cartItemR = cartDelete.parentElement.parentElement.parentElement
            var productName = cartItemR.querySelector(".header__cart-item-name").innerText

            cartItemR.remove()
            giohang = giohang.filter(item => item[1] !== productName); 
            sessionStorage.setItem("giohang", JSON.stringify(giohang));
            showcountgiohang()
            cartTotal()
            // console.log(cartItemR)
        })
    }
}


function inputQuantity() {
    var cartItem = document.querySelectorAll(".header__cart-item")
    for (var i=0; i<cartItem.length; i++) {
        var inputChange = cartItem[i].querySelector("input")
        inputChange.addEventListener("change", function(){
            cartTotal()
        })
    }
}


const cartbtn = document.querySelector(".fa-times")
const cartShow = document.querySelector(".header__cart-btn")
cartShow.addEventListener("click", function(){
    document.querySelector(".cart").style.right="0"
})

cartbtn.addEventListener("click", function(){
    document.querySelector(".cart").style.right="-100%"
})

// ----------------------------------------------------
// function cartNum() {
//     var cartItem = document.querySelectorAll("tbody tr")
//     // console.log(cartItem)
//     var totalValue = 0;
//     for (var i=0; i<cartItem.length; i++) {
//             var inputValue = cartItem[i].querySelector("input").value
//             totalValue = totalValue + inputValue

//     }
//     totalValueA = document.querySelector(".header__cart-notice")
//     totalValueA.innerHTML = totalValue
// }

function showcountgiohang() {
    var gh = sessionStorage.getItem("giohang");
    var giohang = JSON.parse(gh);
    document.getElementById("countgiohang").innerText = giohang.length;
}

function themvaogiohang(x) {
    var boxsp = x.parentElement.children;
    var hinh = boxsp[0].src;
    var ten = boxsp[1].innerText
    var sl = boxsp[3].value;
    var gia = boxsp[2].children[0].innerText;
    var ttgh = '<tr><td style="display: flex; align-items: center;"><img style="width: 70px" src="'+hinh+'" alt=""><span class="titleProduct">'+ten+'</span></td><td><span class="PriceS">'+gia+'</span><sup>đ</sup></td><td><input style="width: 30px; outline: none;" type="number" value="'+sl+'" min="1" id="sls" onchange="tinhthanhtoan()"></td><td style="cursor: pointer;" ><span class="deletebtn">Xóa</span></td></tr>';
    sp = new Array(hinh, ten, gia);
    giohang.push(sp);
    sessionStorage.setItem("giohang",JSON.stringify(giohang));
    document.getElementById("mycart").innerHTML = ttgh;
    document.getElementById("countgiohang").innerText = 1;
    tinhthanhtoan();
}

function tinhthanhtoan() {
    var gias = document.querySelector(".PriceS").innerHTML;
    var sls = document.getElementById("sls").value;
    var tt = sls * gias * 1000;
    document.getElementById("tientt").innerText = tt.toLocaleString('de-DE');
}

function showthanhtoan() {
    var gh = sessionStorage.getItem("giohang");
    var giohang = JSON.parse(gh);
    var ttgh = "";
    var tamtinh = 0;
    for(let i=0; i<giohang.length; i++) {
        ttgh += '<div class="cart-info__item">' +
        '<img src="' + giohang[i][0] + '" alt="">' +
        '<label for="">' + giohang[i][1] + '</label>' +
        '<span class="header_notice">1</span>' +
        '<p><span>' + giohang[i][2] + '</span><sup>đ</sup></p>' +
        '</div>';
        tamtinh += giohang[i][2] * 1000;
    }
    var phiship = 35000;
    var tongtien = tamtinh + phiship;
    ttgh += '<div class="discountcode">' +
            '<input type="text" placeholder="Mã giảm giá">' +
            '<button>Áp dụng</button>' +
        '</div>' +
        '<div class="price1">' +
            '<div class="price2">' +
                '<label>Tạm tính</label>' +
                '<p><span id="tamtinht">' + tamtinh.toLocaleString('de-DE') + '</span><sup>đ</sup></p>' +
            '</div>' +
            '<div class="price2">' +
                '<label>Phí ship</label>' +
                '<p><span id="phishipt">' + phiship.toLocaleString('de-DE') + '</span><sup>đ</sup></p>' +
            '</div>' +
        '</div>' +
        '<div class="total-price">' +
            '<h3>Tổng tiền</h3>' +
            '<p><span id="tongtient">' + tongtien.toLocaleString('de-DE') + '</span><sup>đ</sup></p>' +
        '</div>';

    document.getElementById("chitiettt").innerHTML = ttgh;
}

function phiship(x) {
    var xx = x.parentElement.children;
    var tongtien = 0;
    var tamtinh = document.getElementById("tamtinht").innerHTML;
    var phiship = xx[1].children[0].children[0].innerHTML;
    document.getElementById("phishipt").innerHTML = phiship.toLocaleString('de-DE');
    tongtien = phiship*1000;
    tongtien += tamtinh*1000;
    document.getElementById("tongtient").innerHTML = tongtien.toLocaleString('de-DE');
}





