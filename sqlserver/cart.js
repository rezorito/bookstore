async function fetchDataCartFromServer(UserName) {
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

async function fetchAddCartFromServer(book, dataUser) {
    const formData = {
        BookID: book.BookID,
        UserName: dataUser.user.UserName,
    };

    fetch('http://localhost:5000/add-cart', {
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
            loadCart();
        })
        .catch(error => {
            console.error('Error:', error);
        });
}

function fetchDeleteCartFromServer(book, dataUser) {
    const formData = {
        BookID: book.BookID,
        UserName: dataUser.user.UserName,
    };
    fetch('http://localhost:5000/delete-cart', {
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
            loadCart();
        })
        .catch(error => {
            console.error('Error:', error);
        });
}

async function AddCart(book) {
    if (await checkUserLogin()) {
        var dataUser = await getuser();
        var dataCart = await fetchDataCartFromServer(dataUser.user.UserName)
        var isExist = false;
        if (dataCart != null) {
            dataCart.forEach(function (item) {
                if (item.BookID == book.BookID) {
                    isExist = true;
                }
            });
        }
        if (isExist) {
            alert("Đã có trong giỏ hàng!")
        } else {
            var dataUser = await getuser();
            await fetchAddCartFromServer(book, dataUser)
            isExist = false;
        }
    }
}