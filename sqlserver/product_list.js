async function fetchDataDSSPFromServer() {
    try {
        const response = await fetch("http://localhost:5000/dssp");
        const data = await response.json();
        if (Object.keys(data).length === 0) {
            console.log("Dữ liệu rỗng!");
            return null;
        } else {
            return data;
        }
    } catch (error) {
        console.error("Lỗi:", error);
        return null;
    }
}

function createTableRow(Book) {
    const tr = document.createElement("tr");
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
    tr.querySelector(".btn-info").addEventListener("click", function () {
        ShowBook(Book);
        // alert(Book.BookID + " show");
    });
    tr.querySelector(".btn-dark").addEventListener("click", function () {
        EditBook(Book);
        // alert(Book.BookID + " edit");
    });
    tr.querySelector(".btn-danger").addEventListener("click", function () {
        DeleteBook(Book);
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
    console.log("Giá trị TheLoaiID:", Book.TheLoaiID);
    document.getElementById("img_Book_ed").src = Book.BookImage;
    document.getElementById("sale_Book_ed").value = Book.BookSale;
    document.getElementById("price_Book_ed").value = Book.BookPrice;
    document.getElementById("moTa_Book_ed").value = Book.BookContent;
}

function DeleteBook(Book) {
    alert("nani");
}

async function LoadDSBook() {
    const DSBook = await fetchDataDSSPFromServer();
    if (DSBook != null) {
        tableBody = document.getElementById("tableBody");
        DSBook.forEach(function (book) {
            var body = createTableRow(book);
            tableBody.appendChild(body);
        });
    }
}

document.querySelectorAll(".changeImg").forEach(function (element) {
    element.addEventListener("click", function () {
        document.getElementById("fileInput").click();
    });
});

document.getElementById("fileInput").addEventListener("change", function (event) {
    // Kiểm tra nếu có tệp được chọn
    const file = event.target.files[0];
    if (file) {
        // Tạo URL tạm thời cho tệp ảnh đã chọn
        const reader = new FileReader();
        reader.onload = function (e) {
            // Cập nhật nguồn ảnh
            document.getElementById("img_Book_ed").src = e.target.result;
            alert("Đường dẫn của ảnh: " + e.target.result);
        };
        reader.readAsDataURL(file);
    }
});

document.addEventListener("DOMContentLoaded", function () {
    LoadDSBook();
});
