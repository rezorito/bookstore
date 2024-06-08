const username = document.getElementById("username");
const password = document.getElementById("password");

var button = document.getElementById('login');

// Thêm sự kiện click vào button
button.addEventListener('click', function() {
    const formData = {
        username: username.value,
        password: password.value
    };

    fetch('http://localhost:5000/login', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify(formData)
    })
    .then(response => response.json())
    .then(data => {
        if (Object.keys(data).length === 0) {
            console.log("Dữ liệu rỗng!");
        } else {
            console.log(data);
            console.log("Đăng nhập thành công!");
        }
    })
    .catch(error => console.error('Lỗi:', error));
});
