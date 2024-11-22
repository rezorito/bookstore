document.addEventListener('DOMContentLoaded', function (e) {
    LoadListOrder();
})

async function LoadListOrder() {
    try {
        const bodyTable = document.getElementById("tableBody")
        bodyTable.innerHTML = "";
        const dataListOrder = await fetchDataListOrderFromServer();
        if (dataListOrder) {
            dataListOrder.forEach(dataOrder => {
                const rowData = CreateRowOrder(dataOrder);
                bodyTable.appendChild(rowData);
            });
        }
    } catch (e) {
        console.log(e)
    }
}

function CreateRowOrder(dataOrder) {
    const tr = document.createElement('tr');

    const td1 = document.createElement('td');
    td1.style.width = '5%';
    td1.textContent = dataOrder.ID;

    const td2 = document.createElement('td');
    td2.style.width = '5%';
    td2.textContent = dataOrder.UserName;

    const td3 = document.createElement('td');
    td3.style.width = '15%';
    td3.textContent = dataOrder.Address;

    const td4 = document.createElement('td');
    td4.style.width = '5%';
    td4.textContent = dataOrder.Date;

    const td5 = document.createElement('td');
    td5.style.width = '5%';
    td5.textContent = dataOrder.Price * 1000 + "đ";

    const td6 = document.createElement('td');
    td6.style.width = '5%';
    if (dataOrder.TT == 1) {
        td6.textContent = 'Chờ Xác Nhận';
    } else if (dataOrder.TT == 2) {
        td6.textContent = 'Đang vận chuyển';
    } else {
        td6.textContent = 'Đã hủy';
    }

    const td7 = document.createElement('td');
    td7.style.width = '10%';

    const btnWrap = document.createElement('div');
    btnWrap.classList.add('btn-wrap');

    const btnView = document.createElement('button');
    btnView.title = 'Xem';
    btnView.classList.add('btn', 'btn-info');
    btnView.setAttribute('data-toggle', 'modal');
    btnView.setAttribute('data-target', '#detailModal');
    const iconView = document.createElement('i');
    iconView.classList.add('fa', 'fa-fw', 'fa-eye');
    btnView.appendChild(iconView);
    btnView.addEventListener('click', function (e) {
        ModalDetail(dataOrder)
    })
    btnWrap.appendChild(btnView);

    const btnConfirmOrder = document.createElement('button');
    btnConfirmOrder.title = 'Xác nhận đơn hàng';
    btnConfirmOrder.classList.add('btn', 'btn-dark');
    const iconConfirmOrder = document.createElement('i');
    iconConfirmOrder.classList.add('fa', 'fa-fw', 'fa-check-square-o');
    btnConfirmOrder.appendChild(iconConfirmOrder);
    btnConfirmOrder.addEventListener('click', async function (e) {
        await fetchFixTTOrderFromServer(dataOrder.ID, 2);
    })
    btnWrap.appendChild(btnConfirmOrder);

    const btnConfirmPayment = document.createElement('button');
    btnConfirmPayment.title = 'Xác nhận thanh toán';
    btnConfirmPayment.classList.add('btn', 'btn-dark');
    const iconConfirmPayment = document.createElement('i');
    iconConfirmPayment.classList.add('fa', 'fa-fw', 'fa-credit-card');
    btnConfirmPayment.appendChild(iconConfirmPayment);
    btnConfirmPayment.addEventListener('click', async function (e) {
        await fetchFixTTOrderFromServer(dataOrder.ID, 3);
    })
    btnWrap.appendChild(btnConfirmPayment);

    const btnCancel = document.createElement('button');
    btnCancel.title = 'Hủy';
    btnCancel.classList.add('btn', 'btn-danger');
    const iconCancel = document.createElement('i');
    iconCancel.classList.add('fa', 'fa-fw', 'fa-times-circle-o');
    btnCancel.appendChild(iconCancel);
    btnCancel.addEventListener('click', async function (e) {
        await fetchFixTTOrderFromServer(dataOrder.ID, 0);
    })
    btnWrap.appendChild(btnCancel);

    if (dataOrder.TT == 1) {
        btnConfirmPayment.style.display = 'none'
    } else if (dataOrder.TT == 2) {
        btnConfirmOrder.style.display = 'none'
    } else {
        btnConfirmPayment.style.display = 'none';
        btnConfirmOrder.style.display = 'none';
        btnCancel.style.display = 'none'
    }

    td7.appendChild(btnWrap);

    tr.appendChild(td1);
    tr.appendChild(td2);
    tr.appendChild(td3);
    tr.appendChild(td4);
    tr.appendChild(td5);
    tr.appendChild(td6);
    tr.appendChild(td7);

    return tr;
}

async function ModalDetail(dataOrder) {
    document.getElementById("id_order").innerHTML = dataOrder.ID;
    document.getElementById("userName_order").innerHTML = dataOrder.UserName;
    document.getElementById("email_order").innerHTML = dataOrder.Email;
    document.getElementById("sdt_order").innerHTML = dataOrder.SDT;
    document.getElementById("address_order").innerHTML = dataOrder.Address;
    if (dataOrder.PthVC == 0) {
        document.getElementById("pthvc_order").innerHTML = "Giao hàng nhanh";
    } else {
        document.getElementById("pthvc_order").innerHTML = "Giao hàng hỏa tốc";
    }
    if (dataOrder.PthTT == 0) {
        document.getElementById("pthtt_order").innerHTML = "Thanh toán khi nhận hàng (COD)";
    } else {
        document.getElementById("pthtt_order").innerHTML = "Chuyển khoản thanh toán";
    }
    document.getElementById("date_order").innerHTML = dataOrder.Date;
    document.getElementById("price_order").innerHTML = dataOrder.Price * 1000 + 'đ';
    if (dataOrder.TT == 1) {
        document.getElementById("tt_order").innerHTML = "Chờ xác nhận";
    } else if (dataOrder.TT == 2) {
        document.getElementById("tt_order").innerHTML = "Đang giao hàng";
    } else {
        document.getElementById("tt_order").innerHTML = "Đã hủy";
    }

    const bookArray = await fetchGetOrderDetailFromServer(dataOrder.ID);
    const list_order_detail = document.getElementById("list_order_detail")
    list_order_detail.innerHTML = "";
    bookArray.forEach(book => {
        console.log(book)
        const rowBook = createElementBook(book);
        list_order_detail.appendChild(rowBook);
    })
}

function createElementBook(book) {
    const article = document.createElement('article');
    article.classList.add('order-item');

    const orderInfo = document.createElement('div');
    orderInfo.classList.add('order-item__info');

    const figure = document.createElement('figure');
    figure.classList.add('order-item__thumb');

    const img = document.createElement('img');
    img.src = book.Image;
    img.alt = '';
    img.classList.add('order-item__img');
    figure.appendChild(img);

    const content = document.createElement('div');
    content.classList.add('order-item__content');

    const title = document.createElement('p');
    title.classList.add('order-item__title');
    title.title = book.Name;
    title.textContent = book.Name;

    const qty = document.createElement('p');
    qty.classList.add('order-item__qty');
    qty.textContent = 'x1';

    const price = document.createElement('p');
    price.classList.add('order-item__price');
    price.textContent = book.Price * (100 - book.Sale) / 100 * 1000 + "đ";

    content.appendChild(title);
    content.appendChild(qty);
    content.appendChild(price);

    orderInfo.appendChild(figure);
    orderInfo.appendChild(content);

    article.appendChild(orderInfo);
    return article;
}

async function fetchDataListOrderFromServer() {
    try {
        const response = await fetch('http://localhost:5000/list_order');
        const data = await response.json();
        if (Object.keys(data).length === 0) {
            console.log("Dữ liệu rỗng!");
            return null;
        } else {
            return data;
        }
    } catch (error) {
        console.error('Lỗi:', error);
        return null;
    }
}

async function fetchFixTTOrderFromServer(ID, TT) {
    try {
        fetch("http://localhost:5000/fix_tt_order", {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({
                ID: ID,
                TT: TT
            })
        })
            .then((response) => response.json())
            .then((data) => {
                alert(data.message);
                LoadListOrder();
            })
            .catch((error) => {
                console.error("Lỗi:", error);
            });
    } catch (error) {
        console.error('Lỗi:', error);
        return null;
    }
}

async function fetchGetOrderDetailFromServer(ID) {
    try {
        const response = await fetch("http://localhost:5000/order_detail", {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({
                ID: ID
            }),
        });
        if (!response.ok) {
            throw new Error(`HTTP error! status: ${response.status}`);
        }
        const data = await response.json();
        return data;
    } catch (error) {
        console.error("Lỗi:", error);
        return null;
    }
}