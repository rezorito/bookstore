const checkUserLogin = () => {
    const token = localStorage.getItem('token');
    if (!token) {
        alert('Bạn cần đăng nhập trước!');
        window.location.href = '/WLogin';
        return;
    } else {
        fetch('http://localhost:5000/api/protected', {
            method: 'GET',
            headers: {
                'Authorization': `Bearer ${token}`,
            },
        })
        .then(response => {
            if (!response.ok) {
                alert('Phiên đăng nhập hết hạn, vui lòng đăng nhập lại.');
                localStorage.removeItem('token');
                window.location.href = '/WLogin';
            } else {
                return true;
            }
        })
        .catch(() => {
            alert('Có lỗi xảy ra, vui lòng thử lại sau.');
            window.location.href = '/WLogin';
        });
    }
}

