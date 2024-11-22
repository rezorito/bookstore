async function checkUserLogin() {
    const token = localStorage.getItem('token');
    if (!token) {
        alert('Bạn cần đăng nhập trước!');
        window.location.href = '/WLogin';
        return false; // Trả về false nếu không có token
    } else {
        try {
            const response = await fetch('http://localhost:5000/api/protected', {
                method: 'GET',
                headers: {
                    'Authorization': `Bearer ${token}`,
                },
            });

            if (!response.ok) {
                alert('Phiên đăng nhập hết hạn, vui lòng đăng nhập lại.');
                localStorage.removeItem('token');
                window.location.href = '/WLogin';
                return false; // Trả về false nếu token không hợp lệ
            }

            return true; // Trả về true nếu token hợp lệ
        } catch (error) {
            alert('Có lỗi xảy ra, vui lòng thử lại sau.');
            window.location.href = '/WLogin';
            return false; // Trả về false nếu có lỗi
        }
    }
}
