//Lấy dữ liệu sách categoryData
document.addEventListener("DOMContentLoaded", function () {
    var categoryLinks = document.querySelectorAll('.category-item__link');
    categoryLinks.forEach(function (link) {
        link.addEventListener('click', function (event) {
            event.preventDefault(); // Ngăn chặn hành vi mặc định của thẻ a
            var categoryId = this.getAttribute('id'); // Lấy ID của liên kết được nhấp
            fetchDataFromServer(categoryId); // Gửi yêu cầu đến server
        });
    });
});

function fetchDataFromServer(categoryId) {
    fetch('http://localhost:5000/cate?id=' + categoryId)
        .then(response => response.json())
        .then(data => {
            if (Object.keys(data).length === 0) {
                console.log("Dữ liệu rỗng!");
            } else {
                console.log(data);
                // Chuyển đến trang mới sau khi nhận được dữ liệu và xử lý hoàn thành
                window.location.href = '../views/TheLoai.html';
                // Lưu dữ liệu vào session storage để sử dụng trong trang mới
                sessionStorage.setItem('categoryData', JSON.stringify(data));
            }
        })
        .catch(error => console.error('Lỗi:', error));
}

// document.addEventListener("DOMContentLoaded", function () {
//     var categoryData = JSON.parse(sessionStorage.getItem('categoryData'));
//     if (categoryData) {
//         console.log(categoryData);
//         var container = document.getElementById('dssp');
//         container.innerHTML = ''
//         categoryData.forEach(function (book) {
//             var bookElement = createBookElement(book);
//             container.appendChild(bookElement);
//         });
//     }
// });

//Sắp xếp theo giá
document.addEventListener("DOMContentLoaded", function () {
    var sortLinks = document.querySelectorAll('.select-input__link');
    sortLinks.forEach(function (slink) {
        slink.addEventListener('click', function (event) {
            event.preventDefault(); // Ngăn chặn hành vi mặc định của thẻ a
            var slinkID = this.getAttribute('id'); // Lấy ID của liên kết được nhấp
            if (slinkID === "ASC") {
                var SortData = JSON.parse(sessionStorage.getItem('categoryData'));
                if (SortData) {
                    var container = document.getElementById('dssp');
                    container.innerHTML = ''
                    SortData.sort(function (a, b) {
                        return a.Price - b.Price;
                    });
                    console.log(SortData)
                    SortData.forEach(function (book) {
                        var bookElement = createBookElement(book);
                        container.appendChild(bookElement);
                    });
                }
            } else {
                var SortData = JSON.parse(sessionStorage.getItem('categoryData'));
                if (SortData) {
                    var container = document.getElementById('dssp');
                    container.innerHTML = ''
                    SortData.sort(function (a, b) {
                        return b.Price - a.Price;
                    });
                    console.log(SortData)
                    SortData.forEach(function (book) {
                        var bookElement = createBookElement(book);
                        container.appendChild(bookElement);
                    });
                }
            }
        });
    });
});

function createBookElement(book) {
    var columnDiv = document.createElement('div');
    columnDiv.classList.add('grid__column-10-2');

    var productDiv = document.createElement('div');
    productDiv.classList.add('home-product-item');

    var link = document.createElement('a');
    link.href = "#";
    link.id = "linkCTSP_" + book.ID;

    var image = document.createElement('img');
    image.classList.add('home-product-item__img');
    image.src = book.Image;
    image.alt = "";

    var title = document.createElement('h4');
    title.classList.add('home-product-item__name');
    title.textContent = book.Name;

    var priceDiv = document.createElement('div');
    priceDiv.classList.add('home-product-item__price');

    var currentPrice = document.createElement('p');
    currentPrice.classList.add('home-product-item__current-price');
    currentPrice.innerHTML = '<span>' + book.Price + '.000' + '</span><sup>đ</sup>';

    var saleOffDiv = document.createElement('div');
    saleOffDiv.classList.add('home-product-item__sale-off');

    var saleOffPercent = document.createElement('span');
    saleOffPercent.classList.add('home-product-item__sale-off-percent');
    saleOffPercent.textContent = '-' + book.Sale + ' %';

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

//Phân trang
const itemsPerPage = 15;
let currentPage = 1;

function displayProducts(page) {
    var categoryData = JSON.parse(sessionStorage.getItem('categoryData'));
    if (categoryData) {
        const startIndex = (page - 1) * itemsPerPage;
        const endIndex = startIndex + itemsPerPage;
        const paginatedProducts = categoryData.slice(startIndex, endIndex);
        var container = document.getElementById('dssp');
        container.innerHTML = ''
        console.log(paginatedProducts);
        paginatedProducts.forEach(function (book) {
            var bookElement = createBookElement(book);
            container.appendChild(bookElement);
        });
    }
}

function setupPagination() {
    var categoryData = JSON.parse(sessionStorage.getItem('categoryData'));
    const totalPages = Math.ceil(categoryData.length / itemsPerPage);
    const pagination = document.getElementById('pagination');
    pagination.innerHTML = '';

    //tạo nút back
    const back = document.createElement('li');
    back.className = "pagination-item"
    back.id = "back-arrow"
    const backLink = document.createElement('a')
    backLink.className = "pagination-item__link"
    backLink.href = '#';
    const backIcon = document.createElement('i')
    backIcon.className = "pagination-item__icon fas fa-angle-left"
    backLink.appendChild(backIcon)
    back.appendChild(backLink)
    if (currentPage === 1) {
        back.style.display = 'none';
    } else {
        backLink.addEventListener('click', (event) => {
            currentPage--;
            displayProducts(currentPage);
            setupPagination();
        });
    }
    pagination.appendChild(back);

    // Tạo các liên kết số trang
    for (let i = 1; i <= totalPages; i++) {
        const page = document.createElement('li');
        page.className = "pagination-item"
        const pageLink = document.createElement('a')
        pageLink.className = "pagination-item__link"
        pageLink.textContent = i;
        pageLink.href = '#';
        if (i === currentPage) {
            page.classList.add('pagination-item--active');
        }
        pageLink.addEventListener('click', () => {
            
            currentPage = i;
            displayProducts(currentPage);
            setupPagination();
        });
        page.appendChild(pageLink)
        pagination.appendChild(page);
    }

    // // Tạo nút next
    const next = document.createElement('li');
    next.className = "pagination-item"
    next.id = "back-arrow"
    const nextLink = document.createElement('a')
    nextLink.className = "pagination-item__link"
    nextLink.href = '#';
    const nextIcon = document.createElement('i')
    nextIcon.className = "pagination-item__icon fas fa-angle-right"
    nextLink.appendChild(nextIcon)
    next.appendChild(nextLink)
    if (currentPage === totalPages) {
        next.style.display = 'none';
    } else {
        nextLink.addEventListener('click', (event) => {
            currentPage++;
            displayProducts(currentPage);
            setupPagination();
        });
    }
    pagination.appendChild(next);
}

document.addEventListener("DOMContentLoaded", function () {
    displayProducts(currentPage)
    setupPagination()
});
