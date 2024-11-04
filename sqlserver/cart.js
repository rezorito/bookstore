document.addEventListener("DOMContentLoaded", function () {
    loadCart();
});

document.getElementById('showCart').addEventListener('click', async function (e) {
    if (await checklogin()) {
        window.location.href = '../views/purchaseOrder.html'
    } else {
        alert("Bạn chưa đăng nhập!")
        window.location.href = '../views/DangNhap.html'
    }
})

// document.getElementById('payCart').addEventListener('click', async function (e) {
//     if (await checklogin()) {
//         alert("Bạn đã đăng nhập!")
//         window.location.href = '../views/thanhtoan.html'
//     } else {
//         alert("Bạn chưa đăng nhập!")
//         window.location.href = '../views/DangNhap.html'
//     }
// })

async function fetchDataCartFromServer(UserName) {
    const formData = {
        UserName: UserName,
    };
    try {
        const response = await fetch('http://localhost:5000/getcart', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(formData)
        });

        const data = await response.json();

        if (Object.keys(data).length === 0) {
            console.log("Dữ liệu rỗng!");
            return null;
        } else {
            console.log(data);
            return data;
        }
    } catch (error) {
        console.error('Lỗi:', error);
        return null; // Return null in case of error to keep the function consistent
    }
}

async function AddCart(book) {
    if (await checklogin()) {
        var dataUser = await getuser();
        var dataCart = await fetchDataCartFromServer(dataUser.user.UserName)
        var isExist = false;
        if(dataCart != null) {
            dataCart.forEach(function (item) {
                if (item.BookID == book.BookID) {
                    isExist = true;
                }
            });
        }
        if (isExist) {
            alert("Đã có trong giỏ hàng!")
        } else {
            var userL = await getuser();
            await fetchAddCartFromServer(book, userL)
            isExist = false;
        }
        // var userL = await getuser();
        // await fetchAddCartFromServer(book, userL)
    } else {
        alert("Chưa đăg nhập")
        window.location.href = '../views/DangNhap.html'
    }
}

async function loadCart() {
    var dataUser = await getuser();
    if (dataUser.user == null) {
        const cartList = document.getElementById('cartList');
        const cartItemImage = document.createElement('img');
        cartItemImage.src = '../assets/img/empty_cart.png';
        cartItemImage.alt = '';
        cartItemImage.className = 'header__cart-no-cart-img';
        cartList.appendChild(cartItemImage);
    } else {
        console.log(dataUser.user.UserName);
        var dataCart = await fetchDataCartFromServer(dataUser.user.UserName)
        console.log(dataCart);
        if (dataCart == null) {
            const cartList = document.getElementById('cartList');
            cartList.innerHTML = ''
            document.getElementById('countgiohang').innerHTML = 0;
            document.getElementById('totalPay').innerHTML = 0;
            const cartItemImage = document.createElement('img');
            cartItemImage.src = '../assets/img/empty_cart.png';
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
        var userL = await getuser();
        fetchDeleteCartFromServer(item, userL);
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

function fetchDeleteCartFromServer(book, userL) {
    const formData = {
        BookID: book.BookID,
        UserName: userL.user.UserName,
    };
    fetch('http://localhost:5000/delete-cart', {
        method: 'DELETE',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify(formData)
    })
        .then(response => {
            if (!response.ok) {
                throw new Error('Network response was not ok ' + response.statusText);
            }
            return response.json();
        })
        .then(data => {
            console.log(data);
            loadCart();
        })
        .catch(error => {
            console.error('Error:', error);
        });
}