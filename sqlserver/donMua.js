document.addEventListener("DOMContentLoaded", function () {
    LoadTabs();
});

async function LoadTabs() {
    try {
        const DataList = await fetchDataListOrderFromServer();

        const DataListChoXN = DataList.filter(element => element.TT === 1);
        const DataListDangVC = DataList.filter(element => element.TT === 2);
        const dataListBill = await fetchDataListBillFromServer();
        const DataListDaHuy = DataList.filter(element => element.TT === 0);
        await LoadTab(DataListChoXN, 1);
        await LoadTab(DataListDangVC, 2);
        await LoadTab(dataListBill, 3);
        await LoadTab(DataListDaHuy, 0);
    } catch (e) {
        console.log(e)
    }
}

async function LoadTab(Data, TT) {
    if (Data) {
        const DataLength = Data.length
        if (TT == 0) {
            document.getElementById("count_0").innerHTML = DataLength == 0 ? null : `(${DataLength})`;
            const list_0 = document.getElementById("list_0");
            list_0.innerHTML = ""
            if (DataLength != 0) {
                Data.forEach(async data => {
                    const rowContent = await CreateRowContent(data);
                    list_0.appendChild(rowContent);
                });
            }
        } else if (TT == 1) {
            document.getElementById("count_1").innerHTML = DataLength == 0 ? null : `(${DataLength})`;
            const list_1 = document.getElementById("list_1");
            list_1.innerHTML = ""
            if (DataLength != 0) {
                Data.forEach(async data => {
                    const rowContent = await CreateRowContent(data);
                    list_1.appendChild(rowContent);
                });
            }
        } else if (TT == 2) {
            document.getElementById("count_2").innerHTML = DataLength == 0 ? null : `(${DataLength})`;
            const list_2 = document.getElementById("list_2");
            list_2.innerHTML = ""
            if (DataLength != 0) {
                Data.forEach(async data => {
                    const rowContent = await CreateRowContent(data);
                    list_2.appendChild(rowContent);
                });
            }
        } else {
            document.getElementById("count_3").innerHTML = DataLength == 0 ? null : `(${DataLength})`;
            const list_3 = document.getElementById("list_3");
            list_3.innerHTML = ""
            if (DataLength != 0) {
                Data.forEach(async data => {
                    const rowContent = await CreateRowContent(data);
                    list_3.appendChild(rowContent);
                });
            }
        }
    }
}

async function CreateRowContent(data) {
    try {
        const orderItem = document.createElement("article");
        orderItem.classList.add("order-item");
        const ListBook = await fetchGetDetailFromServer(data.ID);
        for (const data of ListBook) {
            const rowData = await CreateRow(data);
            if (rowData) {
                orderItem.appendChild(rowData);
            }
        }

        const orderTotal = document.createElement("div");
        orderTotal.classList.add("order-item__total");

        const totalPrice = document.createElement("div");
        totalPrice.classList.add("order-item__total-price");

        const totalText = document.createElement("span");
        totalText.textContent = "Thành tiền:";

        const totalAmount = document.createElement("span");
        totalAmount.textContent = data.Price * 1000 + 'đ';

        totalPrice.appendChild(totalText);
        totalPrice.appendChild(totalAmount);

        const cancelButton = document.createElement("button");
        cancelButton.classList.add("order-item__btn");
        if (data.TT == 0 || data.TT == 3) {
            cancelButton.style.backgroundColor = "rgb(0, 169, 255)"
            cancelButton.style.color = "white"
            cancelButton.textContent = "Mua lại";
        } else {
            cancelButton.style.backgroundColor = "#fff"
            cancelButton.style.color = "#555"
            cancelButton.textContent = "Hủy Đơn Hàng";
            cancelButton.addEventListener('click', async function (e) {
                try {
                    await fetchCancelOrderFromServer(data.ID, 0)
                    alert("Hủy thành công!")
                    LoadTabs()
                } catch (e) {
                    console.log(e)
                }
            })
        }

        orderTotal.appendChild(totalPrice);
        orderTotal.appendChild(cancelButton);

        orderItem.appendChild(orderTotal);

        return orderItem;
    } catch (e) {
        console.log(e)
        return null
    }
}

async function CreateRow(data) {
    const orderInfo = document.createElement("div");
    orderInfo.classList.add("order-item__info");

    const orderLeft = document.createElement("div");
    orderLeft.classList.add("order-item__left");

    const figure = document.createElement("figure");
    figure.classList.add("order-item__thumb");

    const img = document.createElement("img");
    img.src = data.Image;
    img.alt = "";
    img.classList.add("order-item__img");

    figure.appendChild(img);

    const orderTitle = document.createElement("div");
    orderTitle.classList.add("order-item__title");

    const titleText1 = document.createElement("p");
    titleText1.classList.add("order-item__text");
    titleText1.textContent = data.Name;

    const titleText2 = document.createElement("p");
    titleText2.classList.add("order-item__text");
    titleText2.textContent = "Số lượng: 1";

    orderTitle.appendChild(titleText1);
    orderTitle.appendChild(titleText2);

    orderLeft.appendChild(figure);
    orderLeft.appendChild(orderTitle);

    const orderPrice = document.createElement("div");
    orderPrice.classList.add("order-item__price");

    const oldPrice = document.createElement("span");
    oldPrice.classList.add("order-item__price--old");
    oldPrice.textContent = data.Price * 1000 + "đ";

    const currentPrice = document.createElement("span");
    currentPrice.classList.add("order-item__price--current");
    currentPrice.textContent = data.Price * (100 - data.Sale) / 100 * 1000 + "đ";

    orderPrice.appendChild(oldPrice);
    orderPrice.appendChild(currentPrice);

    orderInfo.appendChild(orderLeft);
    orderInfo.appendChild(orderPrice);

    return orderInfo
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

async function fetchGetDetailFromServer(ID) {
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

async function fetchCancelOrderFromServer(ID, TT) {
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