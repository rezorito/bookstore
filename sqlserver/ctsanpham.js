document.addEventListener('DOMContentLoaded', function () {
    var linkctsp = document.querySelectorAll("[id^='linkCTSP_']");
    linkctsp.forEach(function (link) {
        link.addEventListener('click', function (event) {
            event.preventDefault();
            var linkID = this.getAttribute('id');
            var bookID = linkID.substring(9);
            fetchDataCTSPFromServer(bookID);
        });
    });
});

function fetchDataCTSPFromServer(bookID) {
    fetch('http://localhost:5000/ctsp?id=' + bookID)
        .then(response => response.json())
        .then(data => {
            if (Object.keys(data).length === 0) {
                console.log("Dữ liệu rỗng!");
            } else {
                window.location.href = '../views/CTSanPham.html';
                sessionStorage.setItem('bookData', JSON.stringify(data));
            }
        })
        .catch(error => console.error('Lỗi:', error));
}

document.addEventListener("DOMContentLoaded", function () {
    var bookCTData = JSON.parse(sessionStorage.getItem('bookData'));
    if (bookCTData) {
        console.log(bookCTData);
        var containerCT = document.getElementById('ctsp');
        bookCTData.forEach(function (bookCT) {
            var bookCTElement = createBookCTElement(bookCT);
            containerCT.appendChild(bookCTElement);
        });
    }
});

function createBookCTElement(bookCTData) {
    var rowDiv = document.createElement('div');
    rowDiv.classList.add('row');

    var firstColumnDiv = document.createElement('div');
    firstColumnDiv.classList.add('col-2');

    var image = document.createElement('img');
    image.src = bookCTData.Image;
    image.width = '100%';
    image.id = 'ProductImg';

    var secondColumnDiv = document.createElement('div');
    secondColumnDiv.classList.add('col-2');

    var productDiv = document.createElement('div');
    productDiv.classList.add('CTProduct');

    var title = document.createElement('h1');
    title.textContent = bookCTData.Name;

    var priceParagraph = document.createElement('p');
    var priceSpan = document.createElement('span');
    priceSpan.textContent = bookCTData.Price;
    priceParagraph.appendChild(priceSpan);
    priceParagraph.innerHTML += '.000 đ';

    var quantityInput = document.createElement('input');
    quantityInput.type = 'number';
    quantityInput.value = '1';
    quantityInput.min = '1';

    var addToCartButton = document.createElement('button');
    addToCartButton.classList.add('butn');
    addToCartButton.textContent = 'Thêm Vào Giỏ Hàng';
    addToCartButton.onclick = function () {
        themvaogiohang(this);
    };

    var descriptionTitle = document.createElement('h3');
    descriptionTitle.textContent = 'Mô Tả';
    var descriptionIcon = document.createElement('i');
    descriptionIcon.classList.add('fa', 'fa-indent');
    descriptionTitle.appendChild(descriptionIcon);

    var descriptionParagraph = document.createElement('p');
    descriptionParagraph.textContent = bookCTData.Content;

    // Append các phần tử vào nhau theo cấu trúc
    firstColumnDiv.appendChild(image);

    productDiv.appendChild(title);
    productDiv.appendChild(priceParagraph);
    productDiv.appendChild(quantityInput);
    productDiv.appendChild(addToCartButton);
    productDiv.appendChild(descriptionTitle);
    productDiv.appendChild(descriptionParagraph);

    secondColumnDiv.appendChild(productDiv);

    rowDiv.appendChild(firstColumnDiv);
    rowDiv.appendChild(secondColumnDiv);

    return rowDiv;
}