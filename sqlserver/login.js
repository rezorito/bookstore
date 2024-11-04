const username = document.getElementById("username");
const password = document.getElementById("password");

var button = document.getElementById('login');
var checklogin = document.getElementById('checklogin');

// Thêm sự kiện click vào button
button.addEventListener('click', async function(e) {
    e.preventDefault();
    const formData = {
        username: username.value,
        password: password.value
    };
    const response = await fetch('http://localhost:5000/login', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify(formData),
    });
    const data = await response.json();
    if (data.loggedIn) {
        alert('Đăng nhập thành công!');
        window.location.href = '../views/home.html'
    } else {
        alert('Đăng nhập thất bại: ' + data.message);
    }
});

checklogin.addEventListener('click', async function(e) {
    e.preventDefault();
    if ( await checklogin()) {
        alert('Bạn đã đăng nhập!');
    } else {
        alert('Bạn chưa đăng nhập!');
        // window.location.href = '../views/DangNhap.html'
    }
});
