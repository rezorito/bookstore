

var button = document.getElementById('login');
var checklogin = document.getElementById('checklogin');

// Thêm sự kiện click vào button
button.addEventListener('click', async function (e) {
    e.preventDefault();
    const username = document.getElementById("username");
    const password = document.getElementById("password");
    if (username.value.trim() == "" || password.value.trim() == "") {
        alert('Chưa nhập tài khoản hoặc mật khẩu');
    } else {
        const formData = {
            username: username.value,
            password: password.value
        };
        try {
            const response = await fetch('http://localhost:5000/api/login', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify(formData),
            });
            const data = await response.json();
            // if (data.loggedIn) {
            //     alert('Đăng nhập thành công!');
            //     window.location.href = '/'
            // } else {
            //     alert('Đăng nhập thất bại: ' + data.message);
            // }
            if (response.ok) {
                localStorage.setItem('token', data.token);
                window.location.href = '/';
            } else {
                alert(data.message || 'Đăng nhập thất bại');
            }
        } catch (error) {
            console.error('Lỗi:', error);
            alert('Có lỗi xảy ra!');
        }
    }
});

checklogin.addEventListener('click', async function (e) {
    e.preventDefault();
    if (await checklogin()) {
        alert('Bạn đã đăng nhập!');
    } else {
        alert('Bạn chưa đăng nhập!');
        // window.location.href = '../views/DangNhap.html'
    }
});

document.addEventListener('DOMContentLoaded', function (e) {
})