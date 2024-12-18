document.addEventListener("DOMContentLoaded", function () {
    loadPaySP();
    LoadInforUserTT();
});

function LoadSP() {
    // var urlParams = new URLSearchParams(window.location.search);
    // var encodedData = urlParams.get('data');
    // var jsonData = decodeURIComponent(encodedData);
    // console.log(jsonData);
    // sessionStorage.setItem('totalDSPayment', jsonData);
    var jsonData = sessionStorage.getItem('ListBookPayment');
    var data = JSON.parse(jsonData); 
    console.log(data);
    return data;
};

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

async function loadPaySP() {
    var dataUser = await getuser();
    if (dataUser.user == null) {
        alert("Lỗi : Hãy đăng nhập trước!")
    } else {
        console.log(dataUser.user.UserName);
        var dataPay = await LoadSP()
        if (dataPay == null) {
            
        } else {
            const payList = document.getElementById('TTSPPay');
            payList.innerHTML = ''
            var priceSP = 0;
            dataPay.forEach(function (item) {
                priceSP += item.BookPrice;
                var Element = createElementPay(item);
                payList.appendChild(Element);
            });
            document.getElementById('price-sp').innerHTML = priceSP;
            LoadPrice()
        }
    }
}

function createElementPay(item) {
    var cartItem = document.createElement('div');
    cartItem.className = 'cart-info__item';

    // Create an img element
    var img = document.createElement('img');
    img.src = item.BookImage;
    img.alt = '';

    // Create a label element
    var label = document.createElement('label');
    label.textContent = item.BookName;

    // Create a span element for header notice
    var headerNotice = document.createElement('span');
    headerNotice.className = 'header_notice';
    headerNotice.textContent = '1';

    // Create a p element with price
    var priceP = document.createElement('p');
    var priceSpan = document.createElement('span');
    priceSpan.textContent = item.BookPrice + '.000';
    var priceSup = document.createElement('sup');
    priceSup.textContent = 'đ';

    // Append price elements
    priceP.appendChild(priceSpan);
    priceP.appendChild(priceSup);

    // Append child elements to the cart item div
    cartItem.appendChild(img);
    cartItem.appendChild(label);
    cartItem.appendChild(headerNotice);
    cartItem.appendChild(priceP);
    return cartItem;
}

var shippingMethods = document.getElementsByName('ship');
for (var i = 0; i < shippingMethods.length; i++) {
    shippingMethods[i].addEventListener('change', LoadPrice);
}

function LoadPrice() {
    var priceSP = document.getElementById('price-sp').innerHTML;
    priceSP = Number(priceSP.replace(/\./g, ''));

    var shippingMethods = document.getElementsByName('ship');
    var selectedPrice = null;

    for (var i = 0; i < shippingMethods.length; i++) {
        if (shippingMethods[i].checked) {
            var priceElement = shippingMethods[i].parentNode.querySelector('.price span');
            selectedPrice = priceElement.textContent;
            break;
        }
    }
    selectedPrice = Number(selectedPrice.replace(/\./g, ''));
    document.getElementById('price-ship').innerHTML = selectedPrice;

    var totalPay = selectedPrice + priceSP;
    document.getElementById('price-total').innerHTML = totalPay;
}

async function LoadInforUserTT() {
    try {
        const dataUser = await getuser();
        const inforUser = await fetchDataInforUserTTFromServer(dataUser.user.UserName)
        document.getElementById("nameUser").value = inforUser[0].Name || "";
        document.getElementById("emailUser").value = inforUser[0].Email || "";
        document.getElementById("sdtUser").value = inforUser[0].SDT || "";
        document.getElementById("addressUser").value = inforUser[0].Address || "";
        console.log(inforUser)
    } catch (e) {
        console.log(e)
    }
}

async function fetchDataInforUserTTFromServer(UserName) {
    try {
        const response = await fetch("http://localhost:5000/get_inforUser", {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({
                UserName: UserName
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