document.addEventListener("DOMContentLoaded", function () {
    fetchDataDSSPFromServer();
});

function fetchDataDSSPFromServer() {
    fetch('http://localhost:5000/dssp')
        .then(response => response.json())
        .then(data => {
            if (Object.keys(data).length === 0) {
                console.log("Dữ liệu rỗng!");
            } else {
                console.log(data);
                sessionStorage.setItem('dsspall', JSON.stringify(data));
                displayBannerProducts();
            }
        })
        .catch(error => console.error('Lỗi:', error));
}

function displayBannerProducts() {
    var bannerTTData = JSON.parse(sessionStorage.getItem('dsspall'));
    if (bannerTTData) {
        var container1 = document.getElementById('banner1');
        container1.innerHTML = ''
        var banner1 = bannerTTData;
        banner1.sort(function (a, b) {
            return a.BookCount - b.BookCount;
        });
        var i = 0;
        banner1.forEach(function (book) {
            if (i < 10) {
                i++;
                var bookElement = createBookElement(book);
                container1.appendChild(bookElement);
            }
        });
    }

    if (bannerTTData) {
        var container2 = document.getElementById('banner2');
        container2.innerHTML = ''
        var banner2 = bannerTTData;
        banner2.sort(function (a, b) {
            return a.BookCount - b.BookCount;
        });
        var i = 0;
        banner2.forEach(function (book) {
            if (i < 10) {
                i++;
                var bookElement = createBookElement(book);
                container2.appendChild(bookElement);
            }
        });
    }

    var linkctsp = document.querySelectorAll("[id^='linkCTSP_']");
    linkctsp.forEach(function (link) {
        link.addEventListener('click', function (event) {
            event.preventDefault();
            var linkID = this.getAttribute('id');
            var bookID = linkID.substring(9);
            fetchDataCTSPFromServer(bookID);
        });
    });
}

function createBookElement(book) {
    var columnDiv = document.createElement('div');
    columnDiv.classList.add('grid__column-10-2');

    var productDiv = document.createElement('div');
    productDiv.classList.add('home-product-item');

    var link = document.createElement('a');
    link.href = "#";
    link.id = "linkCTSP_" + book.BookID;

    var image = document.createElement('img');
    image.classList.add('home-product-item__img');
    image.src = book.BookImage;
    image.alt = "";

    var title = document.createElement('h4');
    title.classList.add('home-product-item__name');
    title.textContent = book.BookName;

    var priceDiv = document.createElement('div');
    priceDiv.classList.add('home-product-item__price');

    if (book.BookSale != 0) {
        var currentPrice = document.createElement('p');
        currentPrice.classList.add('home-product-item__current-price');
        currentPrice.innerHTML = '<span>' + book.BookPrice + '.000' + '</span><sup>đ</sup>';

        var oldPriceTotal = Math.floor(book.BookPrice + book.BookPrice * book.BookSale / 100);
        var oldPrice = document.createElement('span');
        oldPrice.classList.add('home-product-item__old-price');
        oldPrice.innerHTML = oldPriceTotal + '.000' + '<sup>đ</sup>';

        var saleOffDiv = document.createElement('div');
        saleOffDiv.classList.add('home-product-item__sale-off');

        var saleOffPercent = document.createElement('span');
        saleOffPercent.classList.add('home-product-item__sale-off-percent');
        saleOffPercent.textContent = '-' + book.BookSale + ' %';

        saleOffDiv.appendChild(saleOffPercent);
        priceDiv.appendChild(currentPrice);
        priceDiv.appendChild(oldPrice);
        productDiv.appendChild(saleOffDiv);

    } else {
        var currentPrice = document.createElement('p');
        currentPrice.classList.add('home-product-item__current-price');
        currentPrice.innerHTML = '<span>' + book.BookPrice + '.000' + '</span><sup>đ</sup>';

        priceDiv.appendChild(currentPrice);
    }

    var button = document.createElement('button');
    button.classList.add('btn', 'btn-addtocart');
    button.textContent = 'Thêm vào giỏ hàng';
    button.addEventListener('click', function (e) {
        AddCart(book);
    })

    productDiv.appendChild(link);
    link.appendChild(image);
    link.appendChild(title);
    productDiv.appendChild(priceDiv);
    productDiv.appendChild(button);

    columnDiv.appendChild(productDiv);

    return columnDiv;
}
