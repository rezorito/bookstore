document.addEventListener('DOMContentLoaded', function (e) {
    LoadListBill();
})

async function LoadListBill() {
    try {
        const bodyTable = document.getElementById("tableBody")
        bodyTable.innerHTML = "";
        const dataListBill = await fetchDataListBillFromServer();
        if (dataListBill) {
            dataListBill.forEach(dataBill => {
                const rowData = CreateRowBill(dataBill);
                bodyTable.appendChild(rowData);
            });
        }
    } catch (e) {
        console.log(e)
    }
}

function CreateRowBill(dataBill) {
    const row = document.createElement("tr");
    const cell1 = document.createElement("td");
    cell1.style.width = "5%";
    cell1.textContent = dataBill.ID;

    const cell2 = document.createElement("td");
    cell2.style.width = "5%";
    cell2.textContent = dataBill.UserName;

    const cell3 = document.createElement("td");
    cell3.style.width = "15%";
    cell3.textContent = dataBill.Address;

    const cell4 = document.createElement("td");
    cell4.style.width = "5%";
    cell4.textContent = dataBill.Date;

    const cell5 = document.createElement("td");
    cell5.style.width = "5%";
    cell5.textContent = dataBill.DatePay;

    const cell6 = document.createElement("td");
    cell6.style.width = "5%";
    cell6.textContent = dataBill.Price * 1000 + "đ";

    const cell7 = document.createElement("td");
    cell7.style.width = "5%";

    const btnWrap = document.createElement("div");
    btnWrap.classList.add("btn-wrap");

    const button = document.createElement("button");
    button.title = "Xem";
    button.classList.add("btn", "btn-info");
    button.setAttribute("data-toggle", "modal");
    button.setAttribute("data-target", "#detailModal");

    const icon = document.createElement("i");
    icon.classList.add("fa", "fa-fw", "fa-eye");

    button.appendChild(icon);
    button.addEventListener('click', function (e) {
        ModalDetail(dataBill)
    })
    btnWrap.appendChild(button);
    cell7.appendChild(btnWrap);

    row.appendChild(cell1);
    row.appendChild(cell2);
    row.appendChild(cell3);
    row.appendChild(cell4);
    row.appendChild(cell5);
    row.appendChild(cell6);
    row.appendChild(cell7);

    return row;
}

async function ModalDetail(dataBill) {
    document.getElementById("id_order").innerHTML = dataBill.ID;
    document.getElementById("userName_order").innerHTML = dataBill.UserName;
    document.getElementById("email_order").innerHTML = dataBill.Email;
    document.getElementById("sdt_order").innerHTML = dataBill.SDT;
    document.getElementById("address_order").innerHTML = dataBill.Address;
    if (dataBill.PthVC == 0) {
        document.getElementById("pthvc_order").innerHTML = "Giao hàng nhanh";
    } else {
        document.getElementById("pthvc_order").innerHTML = "Giao hàng hỏa tốc";
    }
    if (dataBill.PthTT == 0) {
        document.getElementById("pthtt_order").innerHTML = "Thanh toán khi nhận hàng (COD)";
    } else {
        document.getElementById("pthtt_order").innerHTML = "Chuyển khoản thanh toán";
    }
    document.getElementById("date_order").innerHTML = dataBill.Date;
    document.getElementById("price_order").innerHTML = dataBill.Price * 1000 + 'đ';
    document.getElementById("tt_order").innerHTML = "Đã thanh toán";

    const bookArray = await fetchGetBillDetailFromServer(dataBill.ID);
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

async function fetchDataListBillFromServer() {
    try {
        const response = await fetch('http://localhost:5000/list_bill');
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

async function fetchGetBillDetailFromServer(ID) {
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