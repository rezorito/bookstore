document.addEventListener("DOMContentLoaded", function () {
    LoadOrderSP();
    ListBookPay = [];
});
let ListBookPay = [];

async function fetchDataPaySPFromServer(UserName) {
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

async function LoadOrderSP() {
    var dataUser = await getuser();
    if (dataUser.user == null) {
        alert("Lỗi : Hãy đăng nhập trước!")
    } else {
        var dataPay = await fetchDataPaySPFromServer(dataUser.user.UserName)
        if (dataPay == null) {
            const payList = document.getElementById('DSOrder');
            payList.innerHTML = ''
            document.getElementById('orderTotal').innerHTML = 0;
        } else {
            const payList = document.getElementById('DSOrder');
            payList.innerHTML = ''
            var priceSP = 0;
            dataPay.forEach(function (item) {
                priceSP += item.BookPrice;
                var Element = createCartItemRow(item);
                payList.appendChild(Element);
            });
        }
    }
}

function createCartItemRow(book) {
    const row = document.createElement('tr');

    const checkboxCell = document.createElement('td');
    const checkbox = document.createElement('input');
    checkbox.type = 'checkbox';
    checkbox.className = 'product-checkbox';
    checkbox.name = book.BookID;
    checkbox.addEventListener('change', function (event) {
        if (event.target.checked) {
            var price = document.getElementById('orderTotal').innerHTML;
            var Total = parseInt(price) + parseFloat(book.BookPrice);
            document.getElementById('orderTotal').innerHTML = Total;
            ListBookPay.push(book)
        } else {
            var price = document.getElementById('orderTotal').innerHTML;
            var Total = parseInt(price) - parseFloat(book.BookPrice);
            document.getElementById('orderTotal').innerHTML = Total;
            const index = ListBookPay.indexOf(book);
            if (index > -1) {
                ListBookPay.splice(index, 1);
            }
        }
    });
    checkboxCell.appendChild(checkbox);
    row.appendChild(checkboxCell);

    const detailsCell = document.createElement('td');
    const cartItemDiv = document.createElement('div');
    cartItemDiv.className = 'cart-item';

    const imageDiv = document.createElement('div');
    imageDiv.className = 'cart-item__image';
    const image = document.createElement('img');
    image.src = book.BookImage;
    image.alt = '';
    imageDiv.appendChild(image);

    const detailsDiv = document.createElement('div');
    detailsDiv.className = 'cart-item__details';
    const nameDiv = document.createElement('div');
    nameDiv.className = 'cart-item__name';
    nameDiv.textContent = book.BookName;
    detailsDiv.appendChild(nameDiv);

    cartItemDiv.appendChild(imageDiv);
    cartItemDiv.appendChild(detailsDiv);
    detailsCell.appendChild(cartItemDiv);
    row.appendChild(detailsCell);

    const priceCell = document.createElement('td');
    priceCell.innerHTML = `<span>${book.BookPrice}</span>.000<sup>đ</sup>`;
    row.appendChild(priceCell);

    const quantityCell = document.createElement('td');
    const quantityDiv = document.createElement('div');
    quantityDiv.className = 'cart-item__quantity';
    const quantityInput = document.createElement('input');
    quantityInput.type = 'number';
    quantityInput.className = 'countsp';
    quantityInput.value = '1';
    quantityInput.addEventListener('change', function (event) {
        const newValue = event.target.value;
        var BookPriceTotal = book.BookPrice * newValue;
        document.getElementById('bookPricecut').innerHTML = BookPriceTotal;
    });
    quantityDiv.appendChild(quantityInput);
    quantityCell.appendChild(quantityDiv);
    row.appendChild(quantityCell);

    const totalCell = document.createElement('td');
    totalCell.innerHTML = `<span id = "bookPricecut">${book.BookPrice}</span>.000<sup>đ</sup>`;
    row.appendChild(totalCell);

    const removeCell = document.createElement('td');
    const removeButton = document.createElement('button');
    removeButton.className = 'remove-btn';
    removeButton.textContent = 'Xóa';
    removeButton.addEventListener('click', async function (e) {
        var userL = await getuser();
        fetchDeleteCartFromServer(book, userL);
    })
    removeCell.appendChild(removeButton);
    row.appendChild(removeCell);
    return row;
};

var btnPay = document.getElementById('ShowPayment').addEventListener('click', async function () {
    var dataUser = await getuser();
    var dataPay = await fetchDataPaySPFromServer(dataUser.user.UserName)
    if (dataPay == null) {
        alert('Ko có sản phẩm trong giỏ hàng!');
    } else {
        const checkboxes = document.querySelectorAll('.product-checkbox');
        // var DSPayment = [];
        var count = 0;
        checkboxes.forEach(function (checkbox) {
            if (checkbox.checked) {
                // var book = dataPay.filter(book => book.BookID === checkbox.name);
                // console.log(book)
                // DSPayment.push(book[0])
                count++;
            }
        });
        if (count == 0) {
            alert("Bạn chưa chọn sản phẩm để thanh toán!")
        } else {
            // var jsonData = JSON.stringify(DSPayment);
            // var encodedData = encodeURIComponent(jsonData);
            // window.location.href = `/WThanhToan?data=${encodedData}`
            sessionStorage.setItem("ListBookPayment", JSON.stringify(ListBookPay))
            window.location.href = `/WThanhToan`
        }
    }
})

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
            LoadOrderSP();
        })
        .catch(error => {
            console.error('Error:', error);
        });
}


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