import {books} from './testdata'

document.getElementById("div1").innerHTML = books[1].name

// banner1-views/web

function createBookElement(book) {
    var columnDiv = document.createElement('div');
    columnDiv.classList.add('grid__column-10-2');

    var productDiv = document.createElement('div');
    productDiv.classList.add('home-product-item');

    var link = document.createElement('a');
    link.href = "../ChiTietSP.html";

    var image = document.createElement('img');
    image.classList.add('home-product-item__img');
    image.src = book.img;
    image.alt = "";

    var title = document.createElement('h4');
    title.classList.add('home-product-item__name');
    title.textContent = book.name;

    var priceDiv = document.createElement('div');
    priceDiv.classList.add('home-product-item__price');

    var currentPrice = document.createElement('p');
    currentPrice.classList.add('home-product-item__current-price');
    currentPrice.innerHTML = '<span>' + book.price + '</span><sup>đ</sup>';

    var saleOffDiv = document.createElement('div');
    saleOffDiv.classList.add('home-product-item__sale-off');

    var saleOffPercent = document.createElement('span');
    saleOffPercent.classList.add('home-product-item__sale-off-percent');
    saleOffPercent.textContent = '-' + book.sale;

    var button = document.createElement('button');
    button.classList.add('btn', 'btn-addtocart');
    button.textContent = 'Thêm vào giỏ hàng';

    saleOffDiv.appendChild(saleOffPercent);
    priceDiv.appendChild(currentPrice);

    productDiv.appendChild(link);
    link.appendChild(image);
    link.appendChild(title);
    productDiv.appendChild(priceDiv);
    productDiv.appendChild(saleOffDiv);
    productDiv.appendChild(button);

    columnDiv.appendChild(productDiv);

    return columnDiv;
}

var container = document.getElementById('book_container');

books.forEach(function(book) {
    var bookElement = createBookElement(book);
    container.appendChild(bookElement);
});