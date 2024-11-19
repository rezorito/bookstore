
function fetchDataCTSPFromServer(bookID) {
    fetch('http://localhost:5000/ctsp?id=' + bookID)
        .then(response => response.json())
        .then(data => {
            if (Object.keys(data).length === 0) {
                console.log("Dữ liệu rỗng!");
            } else {
                window.location.href = '/WCTSP';
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
            createBookCTElement(bookCT);
        });
    }
});

function createBookCTElement(bookCTData) {
    document.querySelector('.product__img').src = bookCTData.BookImage;
    if (bookCTData.BookSale == 0) {
        const element1 = document.querySelector('.product__sale');
        element1.style.display = 'none';
        document.querySelector('.product__price--current').textContent = bookCTData.BookPrice * 1000 + 'đ';
        const element2 = document.querySelector('.product__price--old');
        element2.style.display = 'none';
        const element3 = document.querySelector('.product__price-text');
        element3.style.display = 'none';
    } else {
        priceSale = bookCTData.BookPrice * bookCTData.BookSale / 100 * 1000;
        priceCurrent = bookCTData.BookPrice * 1000 - priceSale ;
        document.querySelector('.product__sale').textContent = bookCTData.BookSale + '%';
        document.querySelector('.product__price--current').textContent = priceCurrent + 'đ';
        document.querySelector('.product__price--old').textContent = bookCTData.BookPrice * 1000 + 'đ';
        document.querySelector('.product__price-text').textContent = '(Bạn đã tiết kiệm được ' + priceSale + 'đ)';
    }
    document.querySelector('.product__title').textContent = bookCTData.BookName;
    document.querySelector('.product__id').textContent = bookCTData.bookID;
    document.querySelector('.product-add__btn').addEventListener('click', () => {
        AddCart(bookCTData)
    });

    document.querySelector('.product-desc__sub-title').textContent = bookCTData.BookName;
    document.querySelector('.product-desc__content').textContent = bookCTData.BookContent;
}