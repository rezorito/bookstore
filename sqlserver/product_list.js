async function fetchDataDSSPFromServer() {
    try {
        const response = await fetch('http://localhost:5000/dssp');
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

document.querySelector('.changeImg_add').addEventListener('click', function (e) {
    e.preventDefault();
    document.getElementById('fileInput_add').click();
});

document.getElementById('fileInput_add').addEventListener('change', function (event) {
    const file = event.target.files[0];
    if (file) {
        const reader = new FileReader();
        reader.onload = (e) => {
            document.getElementById("img_Book_add").src = e.target.result;
        };
        reader.readAsDataURL(file);
    }
});

document.getElementById('btn_Accept_add').addEventListener('click', function (e) {
    e.preventDefault();
    const BookID = document.getElementById("id_Book_add").value;
    const BookName = document.getElementById("name_Book_add").value;
    const BookPrice = document.getElementById("price_Book_add").value;
    const BookSale = document.getElementById("sale_Book_add").value;
    const BookContent = document.getElementById("moTa_Book_add").value;
    const TheLoaiID = document.getElementById("tl_Book_add").value;
    const fileInput = document.getElementById("fileInput_add");
    if (fileInput.files.length > 0 && BookID != "" && BookName != "" && BookPrice != "" && BookSale != "" && BookContent != "" && TheLoaiID != "") {
        const dataBook = {
            BookID: BookID,
            BookName: BookName,
            BookPrice: BookPrice,
            BookSale: BookSale,
            BookContent: BookContent,
            TheLoaiID: TheLoaiID
        }
        const formData = new FormData();
        formData.append("image", fileInput.files[0]);
        formData.append("book", JSON.stringify(dataBook));

        fetch("http://localhost:5000/add-product", {
            method: "POST",
            body: formData,
        })
            .then((response) => response.json())
            .then((data) => {
                alert(data.message);
                window.location.href = "/WAdmin/WListBook";
            })
            .catch((error) => {
                console.error("Lỗi:", error);
            });
    } else {
        alert("Vui lòng điền đầy đủ thông tin trước khi thêm!");
    }
});

function createTableRow(Book) {
    const tr = document.createElement('tr');
    tr.innerHTML = `
        <td style="width: 5%">${Book.BookID}</td>
        <td style="width: 20%">${Book.BookName}</td>
        <td style="width: 10%">${Book.TheLoai}</td>
        <td style="width: 10%">${Book.BookPrice}.000 đ</td>
        <td style="width: 5%">${Book.BookSale}%</td>
        <td style="width: 10%">
            <div class="btn-wrap">
                <a class="btn btn-info" style="color: #fff" data-toggle="modal" data-target="#detailModal">
                    Xem
                </a>
                <a class="btn btn-dark" style="color: #fff" data-toggle="modal" data-target="#updateModal">
                    Sửa
                </a>
                <button class="btn btn-danger" data-toggle="modal" data-target="#deleteModal">Xóa</button>
            </div>
        </td>
    `;
    tr.querySelector('.btn-info').addEventListener('click', function () {
        ShowBook(Book);
    });
    tr.querySelector('.btn-dark').addEventListener('click', function () {
        EditBook(Book);
    });
    tr.querySelector('.btn-danger').addEventListener('click', function () {
        document.getElementById("btn_Accept_delete").addEventListener('click', function(e) {
            DeleteBook(Book);
        })
    });
    return tr;
}

function ShowBook(Book) {
    document.getElementById("id_Book_dt").innerHTML = Book.BookID;
    document.getElementById("name_Book_dt").innerHTML = Book.BookName;
    document.getElementById("tl_Book_dt").innerHTML = Book.TheLoai;
    document.getElementById("img_Book_dt").src = Book.BookImage;
    document.getElementById("sale_Book_dt").innerHTML = Book.BookSale;
    document.getElementById("price_Book_dt").innerHTML = Book.BookPrice;
    document.getElementById("moTa_Book_dt").innerHTML = Book.BookContent;
}

function EditBook(Book) {
    document.getElementById("id_Book_ed").innerHTML = Book.BookID;
    document.getElementById("name_Book_ed").value = Book.BookName;
    document.getElementById("tl_Book_ed").value = Book.TheLoaiID.trim();
    document.getElementById("img_Book_ed").src = Book.BookImage;
    document.getElementById("sale_Book_ed").value = Book.BookSale;
    document.getElementById("price_Book_ed").value = Book.BookPrice;
    document.getElementById("moTa_Book_ed").value = Book.BookContent;
    document.getElementById('btn_Accept_ed').addEventListener('click', function (e) {
        e.preventDefault();
        const BookID = document.getElementById("id_Book_ed").innerHTML;
        const BookName = document.getElementById("name_Book_ed").value;
        const BookPrice = document.getElementById("price_Book_ed").value;
        const BookSale = document.getElementById("sale_Book_ed").value;
        const BookContent = document.getElementById("moTa_Book_ed").value;
        const TheLoaiID = document.getElementById("tl_Book_ed").value;
        const fileInput = document.getElementById("fileInput_ed");
        if (BookName != "" && BookPrice != "" && BookSale != "" && BookContent != "" && TheLoaiID != "") {
            const dataBook = {
                BookID: BookID,
                BookName: BookName,
                BookPrice: BookPrice,
                BookSale: BookSale,
                BookContent: BookContent,
                TheLoaiID: TheLoaiID
            }
            const formData = new FormData();
            if (fileInput.files.length > 0) {
                formData.append("image", fileInput.files[0]);
            }
            formData.append("book", JSON.stringify(dataBook));
            formData.append("image_delete", Book.BookImage);

            fetch("http://localhost:5000/fix-product", {
                method: "PUT",
                body: formData,
            })
                .then((response) => response.json())
                .then((data) => {
                    alert(data.message);
                    window.location.href = "/WAdmin/WListBook";
                })
                .catch((error) => {
                    console.error("Lỗi:", error);
                });
        } else {
            alert("Vui lòng điền đầy đủ thông tin trước khi sửa!");
        }
    });
}

document.querySelector('.changeImg_ed').addEventListener('click', function (e) {
    e.preventDefault();
    document.getElementById('fileInput_ed').click();
});

document.getElementById('fileInput_ed').addEventListener('change', function (event) {
    const file = event.target.files[0];
    if (file) {
        const reader = new FileReader();
        reader.onload = (e) => {
            document.getElementById("img_Book_ed").src = e.target.result;
        };
        reader.readAsDataURL(file);
    }
});

function DeleteBook(Book) {
    fetch("http://localhost:5000/delete-product", {
        method: 'DELETE',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({
            bookID: Book.BookID,    
            image_delete: Book.BookImage 
        })
    })
        .then((response) => response.json())
        .then((data) => {
            alert(data.message);
            window.location.href = "/WAdmin/WListBook";
        })
        .catch((error) => {
            console.error("Lỗi:", error);
        });
}

async function LoadDSBook() {
    const DSBook = await fetchDataDSSPFromServer();
    if (DSBook != null) {
        tableBody = document.getElementById("tableBody")
        DSBook.forEach(function (book) {
            var body = createTableRow(book)
            tableBody.appendChild(body)
        });
    }
}

document.addEventListener('DOMContentLoaded', function () {
    LoadDSBook();
})

