document.addEventListener("DOMContentLoaded", function () {
    fetchDataDSSPFromServer()
});

function fetchDataDSSPFromServer() {
    fetch('http://localhost:5000/dssp')
        .then(response => response.json())
        .then(data => {
            if (Object.keys(data).length === 0) {
                console.log("Dữ liệu rỗng!");
            } else {
                console.log(data);
                fillDataTable(data)
            }
        })
        .catch(error => console.error('Lỗi:', error));
}

function fillDataTable(dssp) {
    const tableBody = document.getElementById('tableBody');
    tableBody.innerHTML = '';
    dssp.forEach(function (sp) {
        var body = createElementBook(sp)
        tableBody.appendChild(body)
    });
}

function createElementBook(sp) {
    var row = document.createElement('tr');

    var BookID = document.createElement('td');
    BookID.style.width = '5%'
    BookID.textContent = sp.BookID;

    var BookImage = document.createElement('td');
    BookImage.style.width = '100px'
    var Image = document.createElement('img')
    Image.src = sp.BookImage;
    Image.style.width = '100px'
    BookImage.appendChild(Image)
    
    var BookName = document.createElement('td');
    BookName.style.width = '20%'
    BookName.textContent = sp.BookName;
    
    var TheLoai = document.createElement('td');
    TheLoai.style.width = '10%'
    TheLoai.textContent = sp.TheLoai;

    var BookPrice = document.createElement('td');
    BookPrice.style.width = '10%'
    BookPrice.textContent = sp.BookPrice + '.000 đ';

    var BookSale = document.createElement('td');
    BookSale.style.width = '5%'
    BookSale.textContent = sp.BookSale;

    var BookContent = document.createElement('td');
    BookContent.style.width = '100%'
    BookContent.textContent = sp.BookContent;

    row.appendChild(BookID);
    row.appendChild(BookImage);
    row.appendChild(BookName);
    row.appendChild(TheLoai);
    row.appendChild(BookPrice);
    row.appendChild(BookSale);
    row.appendChild(BookContent);
    
    return row;
}