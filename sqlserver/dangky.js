document.getElementById('Btn_DK').addEventListener('click', async function(e) {
    var dk_tk = document.getElementById('dk_tk').value;
    var dk_mk = document.getElementById('dk_mk').value;
    const formData = {
        dk_tk: dk_tk,
        dk_mk: dk_mk
    };
    await fetch('http://localhost:5000/add-user', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify(formData),
    })
    .then(response => {
        if (!response.ok) {
            throw new Error('Network response was not ok ' + response.statusText);
        }
        return response.json();
    })
    .then(data => {
        console.log(data);
        alert('Đăng ký thành công!')
        window.location.href = '/WLogin'
    })
    .catch(error => {
        console.error('Error:', error);
    });
})