
async function checklogin() {
    const responseb = await fetch('http://localhost:5000/checklogin', {
        method: 'GET',
        headers: {
            'Content-Type': 'application/json',
        },
    });
    const datab = await responseb.json();
    if (datab.loggedIn) {
        return true
    } else {
        return false
    }
}

async function getuser() {
    const responseb = await fetch('http://localhost:5000/checklogin', {
        method: 'GET',
        headers: {
            'Content-Type': 'application/json',
        },
    });
    const datab = await responseb.json();
    return datab;
}

async function checkuserlogin() {
    if (await checklogin()) {
        var unLoginElements = document.getElementById('UnLoginUser')
        unLoginElements.style.display = 'none'
        var LoginElements = document.getElementById('LoginUser')
        LoginElements.style.display = 'block'
        var userL = await getuser();
        document.getElementById('UserName_LG').innerHTML = userL.user.UserName;

    } else {
        var unLoginElements = document.getElementById('UnLoginUser')
        unLoginElements.style.display = 'block'
        var LoginElements = document.getElementById('LoginUser')
        LoginElements.style.display = 'none'
    }
}

// async function AddCart(book) {
//     if (await checklogin()) {
//         var userL = await getuser();
//         fetchAddCartFromServer(book, userL)
//     } else {
//         alert("Chưa đăg nhập")
//         window.location.href = '../views/DangNhap.html'
//     }
// }

async function fetchAddCartFromServer(book, userL) {
    const formData = {
        BookID: book.BookID,
        UserName: userL.user.UserName,
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

document.getElementById('logOut').addEventListener('click', function (e) {
    fetchLogOutFromServer();
})

function fetchLogOutFromServer() {
    fetch('http://localhost:5000/logout', {
        method: 'PUT',
        headers: {
            'Content-Type': 'application/json'
        },
    })
        .then(response => response.json())
        .then(data => {
            alert(data.message); // Access the message from the JSON response
            window.location.href = '../views/home.html';
        })
        .catch(error => {
            console.error('Error:', error);
        });
}