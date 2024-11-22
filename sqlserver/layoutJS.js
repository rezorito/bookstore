
const showLogin = async () => {
    const token = localStorage.getItem('token');
    var unLoginElements = document.getElementById('UnLoginUser')
    var LoginElements = document.getElementById('LoginUser')
    var cartShow = document.getElementById('cartShow')
    if (!token) {
        unLoginElements.style.display = 'block'
        LoginElements.style.display = 'none'
        cartShow.style.display = 'none'
    } else {
        const dataUser = await getuser();
        unLoginElements.style.display = 'none'
        cartShow.style.display = 'block'
        LoginElements.style.display = 'block'
        document.getElementById('UserName_LG').innerHTML = dataUser.user.UserName;
    }
}

async function loadCart() {
    var dataUser = await getuser();
    if (dataUser.user == null) {
        const cartList = document.getElementById('cartList');
        const cartItemImage = document.createElement('img');
        cartItemImage.src = '/img/empty_cart.png';
        cartItemImage.alt = '';
        cartItemImage.className = 'header__cart-no-cart-img';
        cartList.appendChild(cartItemImage);
    } else {
        var dataCart = await fetchDataCartFromServer(dataUser.user.UserName)
        console.log(dataCart);
        if (dataCart == null) {
            const cartList = document.getElementById('cartList');
            cartList.innerHTML = ''
            document.getElementById('countgiohang').innerHTML = 0;
            document.getElementById('text_TotalPay').style.display = "none";
            document.getElementById('totalPay').innerHTML = 0;
            document.getElementById('isShowCart').style.display = "none";
            const cartItemImage = document.createElement('img');
            cartItemImage.src = '/img/empty_cart.png';
            cartItemImage.alt = '';
            cartItemImage.className = 'header__cart-no-cart-img';
            cartList.appendChild(cartItemImage);
        } else {
            const cartList = document.getElementById('cartList');
            cartList.innerHTML = ''
            var count = 0;
            var totalpay = 0;
            dataCart.forEach(function (item) {
                count++;
                totalpay += item.BookPrice;
                var Element = createElementCart(item);
                cartList.appendChild(Element);
            });
            document.getElementById('text_TotalPay').style.display = "flex";
            document.getElementById('isShowCart').style.display = "flex";
            document.getElementById('countgiohang').innerHTML = count;
            document.getElementById('totalPay').innerHTML = totalpay + '.000';
        }
    }
}

function createElementCart(item) {
    const cartItem = document.createElement('li');
    cartItem.className = 'header__cart-item';

    // Tạo phần tử img cho hình ảnh sản phẩm
    const cartItemImage = document.createElement('img');
    cartItemImage.src = item.BookImage;
    cartItemImage.alt = '';
    cartItemImage.className = 'header__cart-img';

    // Tạo phần tử div cho thông tin sản phẩm
    const cartItemInfo = document.createElement('div');
    cartItemInfo.className = 'header__cart-item-info';

    // Tạo phần tử div cho phần đầu của thông tin sản phẩm
    const cartItemHead = document.createElement('div');
    cartItemHead.className = 'header__cart-item-head';

    // Tạo phần tử a cho tên sản phẩm
    const cartItemName = document.createElement('a');
    cartItemName.className = 'header__cart-item-name';
    cartItemName.textContent = item.BookName;

    // Tạo phần tử span cho số lượng sản phẩm
    const cartItemQuantity = document.createElement('span');
    cartItemQuantity.className = 'header__cart-item-quantity';
    cartItemQuantity.textContent = `Số lượng: 1`;

    // Tạo phần tử span cho giá sản phẩm
    const cartItemPrice = document.createElement('span');
    cartItemPrice.className = 'header__cart-item-price';
    cartItemPrice.innerHTML = `<span>Giá/sp: </span><span>${item.BookPrice}<span>.000<sup>đ</sup></span></span>`;

    // Tạo phần tử div cho phần thân của thông tin sản phẩm
    const cartItemBody = document.createElement('div');
    cartItemBody.className = 'header__cart-item-body';

    // Tạo phần tử i cho nút xóa sản phẩm
    const cartItemRemove = document.createElement('i');
    cartItemRemove.className = 'header__cart-item-remove fa-solid fa-xmark';
    cartItemRemove.addEventListener('click', async function (e) {
        var dataUser = await getuser();
        fetchDeleteCartFromServer(item, dataUser);
    })

    // Thêm các phần tử con vào phần tử cha tương ứng
    cartItemHead.appendChild(cartItemName);
    cartItemHead.appendChild(cartItemQuantity);
    cartItemHead.appendChild(cartItemPrice);

    cartItemBody.appendChild(cartItemRemove);

    cartItemInfo.appendChild(cartItemHead);
    cartItemInfo.appendChild(cartItemBody);

    cartItem.appendChild(cartItemImage);
    cartItem.appendChild(cartItemInfo);

    return cartItem;
}

document.addEventListener("DOMContentLoaded", async function () {
    await showLogin();
    loadCart();
});

document.getElementById('logOut').addEventListener('click', function (e) {
    localStorage.removeItem('token');
    window.location.href = '/WLogin';
})

document.getElementById('showCart').addEventListener('click', async function (e) {
    window.location.href = "/WGioHang"
})

document.getElementById('btn_MyAccount').addEventListener('click', async function (e) {
    const token = localStorage.getItem('token');
    const dataUser = await getuser();
    console.log(dataUser)
    if (dataUser.user.Permission == 0) {
        window.location.href = "/WInforUser"
    } else {
        window.location.href = "/WAdmin"
    }
})