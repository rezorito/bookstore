document.addEventListener("DOMContentLoaded", function () {
    fetchDataDSSPFromServer();
    checkUserLogin();
});

function fetchDataDSSPFromServer() {
    fetch('http://localhost:5000/dssp')
        .then(response => response.json())
        .then(data => {
            if (Object.keys(data).length === 0) {
                console.log("Dữ liệu rỗng!");
            } else {
                console.log(data);
                // fillDataTable(data)
                //
                sessionStorage.setItem('dsspall', JSON.stringify(data));
            }
        })
        .catch(error => console.error('Lỗi:', error));
}

function fillDataTable(page) {
    var dsspall = JSON.parse(sessionStorage.getItem('dsspall'));
    if (dsspall) {
        const startIndex = (page - 1) * itemsdsPerPage;
        const endIndex = startIndex + itemsdsPerPage;
        const paginatedProducts = dsspall.slice(startIndex, endIndex);
        const tableBody = document.getElementById('tableBody');
        tableBody.innerHTML = ''
        console.log(paginatedProducts);
        paginatedProducts.forEach(function (sp) {
            var body = createElementBook(sp)
            tableBody.appendChild(body)
        });
    }
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

    // var BookContent = document.createElement('td');
    // BookContent.style.width = '100%'
    // BookContent.textContent = sp.BookContent;

    var actionCell = document.createElement('td');
    actionCell.style.width = '10%';
    var actionButton = document.createElement('button');
    actionButton.style.border = 'none';
    actionButton.style.background = 'none';
    actionButton.style.cursor = 'pointer';
    actionButton.title = 'Sửa'
    var icon = document.createElement('img');
    icon.src = '../assets/img/icon_fix.png'; // Replace with the path to your icon image
    icon.style.width = '40px'; // Adjust the width as needed
    icon.style.height = '30px'; // Adjust the height as needed
    actionButton.addEventListener('click', function () {
        showdlfix(sp);
    });
    actionButton.appendChild(icon);
    actionCell.appendChild(actionButton);

    // Append the button to the td
    actionCell.appendChild(actionButton);
    row.appendChild(BookID);
    row.appendChild(BookImage);
    row.appendChild(BookName);
    row.appendChild(TheLoai);
    row.appendChild(BookPrice);
    row.appendChild(BookSale);
    // row.appendChild(BookContent);
    row.appendChild(actionCell);

    return row;
}

const itemsdsPerPage = 15;
let currentdsPage = 1;

function setupdsPagination() {
    var dsspall = JSON.parse(sessionStorage.getItem('dsspall'));
    console.log(dsspall)
    const totalPages = Math.ceil(dsspall.length / itemsdsPerPage);
    const pagination = document.getElementById('ds_pagination');
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
    if (currentdsPage === 1) {
        back.style.display = 'none';
    } else {
        backLink.addEventListener('click', (event) => {
            currentdsPage--;
            fillDataTable(currentdsPage);
            setupdsPagination();
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
        if (i === currentdsPage) {
            page.classList.add('pagination-item--active');
        }
        pageLink.addEventListener('click', () => {
            currentdsPage = i;
            fillDataTable(currentdsPage);
            setupdsPagination();
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
    if (currentdsPage === totalPages) {
        next.style.display = 'none';
    } else {
        nextLink.addEventListener('click', (event) => {
            currentdsPage++;
            fillDataTable(currentdsPage);
            setupdsPagination();
        });
    }
    pagination.appendChild(next);
}

//chọn ảnh
function select_img() {
    var popup = document.getElementById("popupimg");
    var changeButton = document.getElementById("changeButtonimg");
    const closePopupBtn = document.getElementById('close-popupimg-btn');
    var submitButton = document.getElementById("submitimg");
    var imageUrl = document.getElementById("imageUrl");
    var imageFile = document.getElementById("imageFile");
    var selectedImage = document.getElementById("sp_in_img");
    const bodyOverlay = document.getElementById('body-overlay');

    changeButton.onclick = function () {
        popup.style.display = "block";
        bodyOverlay.style.display = 'block';
        document.body.classList.add('opened');
    }
    closePopupBtn.onclick = function () {
        popup.style.display = "none";
        bodyOverlay.style.display = 'none';
        document.body.classList.remove('opened');
    }
    window.onclick = function (event) {
        if (event.target == popup) {
            popup.style.display = "none";
            bodyOverlay.style.display = 'none';
            document.body.classList.remove('opened');
        }
    }
    submitButton.addEventListener('click', (event) => {
        var img;
        if (imageUrl.value) {
            img = imageUrl.value;
            updateImage(img);
        } else if (imageFile.files[0]) {
            var reader = new FileReader();
            reader.onload = function (e) {
                img = e.target.result;
                updateImage(img);
            };
            reader.readAsDataURL(imageFile.files[0]);
        } else {
            updateImage('');
        }
        function updateImage(imageSrc) {
            popup.style.display = "none";
            bodyOverlay.style.display = 'none';
            document.body.classList.remove('opened');
            selectedImage.src = imageSrc;
            reset()
        }
        function reset() {
            imageUrl.value = '';
            imageFile.value = null;
        }
    });
}

//làm việc với bảng dssp


function showdlfix(sp) {
    document.getElementById('sp_in_id').value = sp.BookID;
    document.getElementById('sp_in_name').value = sp.BookName;
    // document.getElementById('sp_in_author').value = ;
    document.getElementById('sp_in_cate').value = sp.TheLoaiID.trim();
    document.getElementById('sp_in_img').src = sp.BookImage;
    document.getElementById('sp_in_sale').value = sp.BookSale;
    document.getElementById('sp_in_cost').value = sp.BookPrice * 1000;
    document.getElementById('sp_in_desp').value = sp.BookContent;
}

function actiontable() {
    var buttonadd = document.getElementById('button_addsp')
    var buttonfix = document.getElementById('button_fixsp')
    var buttondelete = document.getElementById('button_deletesp')
    var buttonreset = document.getElementById('button_reset_in')

    buttonreset.addEventListener('click', (event) => {
        document.getElementById('sp_in_id').value = '';
        document.getElementById('sp_in_name').value = '';
        // document.getElementById('sp_in_author').value = '';
        document.getElementById('sp_in_cate').value = 'TN';
        document.getElementById('sp_in_img').src = null;
        document.getElementById('sp_in_sale').value = '';
        document.getElementById('sp_in_cost').value = '';
        document.getElementById('sp_in_desp').value = '';
    });

    buttonadd.addEventListener('click', async (event) => {
        var BookID = document.getElementById('sp_in_id').value;
        var BookName = document.getElementById('sp_in_name').value;
        // var productAuthor = document.getElementById('sp_in_author').value;
        var TheLoaiID = document.getElementById('sp_in_cate').value;
        var BookImage = document.getElementById('sp_in_img').src;
        var BookSale = document.getElementById('sp_in_sale').value;
        var BookPrice = document.getElementById('sp_in_cost').value;
        var BookContent = document.getElementById('sp_in_desp').value;
        console.log(BookID);
        console.log(BookName);
        console.log(TheLoaiID);
        console.log(BookImage);
        console.log(BookSale);
        console.log(BookPrice);
        console.log(BookContent);
        fetchAddSPFromServer(BookID, BookName, BookPrice, BookSale, BookContent, BookImage, TheLoaiID)
        fetchDataDSSPFromServer();
        fillDataTable(currentdsPage)
        setupdsPagination()
    });

    buttonfix.addEventListener('click', async (event) => {
        var BookID = document.getElementById('sp_in_id').value;
        var BookName = document.getElementById('sp_in_name').value;
        // var productAuthor = document.getElementById('sp_in_author').value;
        var TheLoaiID = document.getElementById('sp_in_cate').value;
        var BookImage = document.getElementById('sp_in_img').src;
        var BookSale = document.getElementById('sp_in_sale').value;
        var BookPrice = document.getElementById('sp_in_cost').value / 1000;
        var BookContent = document.getElementById('sp_in_desp').value;
        await fetchFixSPFromServer(BookID, BookName, BookPrice, BookSale, BookContent, BookImage, TheLoaiID)
        fetchDataDSSPFromServer();
        fillDataTable(currentdsPage)
        setupdsPagination()
    });

    buttondelete.addEventListener('click', (event) => {
        var BookID = document.getElementById('sp_in_id').value;
        fetchDeleteSPFromServer(BookID)
        fetchDataDSSPFromServer();
        fillDataTable(currentdsPage)
        setupdsPagination()
    });
}

async function fetchAddSPFromServer(BookID, BookName, BookPrice, BookSale, BookContent, BookImage, TheLoaiID) {
    const formData = {
        BookID: BookID,
        BookName: BookName,
        BookPrice: BookPrice,
        BookSale: BookSale,
        BookContent: BookContent,
        BookImage: BookImage,
        TheLoaiID: TheLoaiID,
    };

    await fetch('http://localhost:5000/add-product', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify(formData)
    })
        .then(response => {
            if (!response.ok) {
                throw new Error('Network response was not ok ' + response.statusText);
            }
            return response.json();
        })
        .then(data => {
            console.log(data);
        })
        .catch(error => {
            console.error('Error:', error);
        });
}

function fetchFixSPFromServer(BookID, BookName, BookPrice, BookSale, BookContent, BookImage, TheLoaiID) {
    const formData = {
        BookID: BookID,
        BookName: BookName,
        BookPrice: BookPrice,
        BookSale: BookSale,
        BookContent: BookContent,
        BookImage: BookImage,
        TheLoaiID: TheLoaiID,
    };

    fetch('http://localhost:5000/fix-product', {
        method: 'PUT',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify(formData)
    })
        .then(response => response.json())
        .then(data => {
            console.log(data);
        })
        .catch(error => {
            console.error('Error:', error);
        });
}

function fetchDeleteSPFromServer(BookID) {
    const formData = {
        BookID: BookID,
    };
    fetch('http://localhost:5000/delete-product', {
        method: 'DELETE',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify(formData)
    })
        .then(response => {
            if (!response.ok) {
                throw new Error('Network response was not ok ' + response.statusText);
            }
            return response.json();
        })
        .then(data => {
            console.log(data);
        })
        .catch(error => {
            console.error('Error:', error);
        });
}

document.addEventListener("DOMContentLoaded", async function () {
    // checkuserlogin();
    var isAdmin = document.getElementById('isAdmin');
    var isUser = document.getElementById('isUser');
    var dataUser = await getuser();
    if (dataUser.user.Permission == 1) {
        isUser.style.display = 'none'
        isAdmin.style.display = 'block'
        fillDataTable(currentdsPage)
        setupdsPagination()
        actiontable();
        select_img()
    } else {
        isUser.style.display = 'block'
        isAdmin.style.display = 'none'
    }
});