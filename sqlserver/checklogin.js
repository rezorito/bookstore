
const token = localStorage.getItem('token');

async function getuser() {
    try {
        const response = await fetch('http://localhost:5000/api/userInfo', {
            method: 'GET',
            headers: {
                Authorization: `Bearer ${token}`
            }
        });

        if (response.ok) {
            const data = await response.json();
            return data;
        } else {
            const errorData = await response.json();
            console.error('Failed to retrieve user info:', errorData.message || errorData);
        }
    } catch (error) {
        console.error('Error fetching user info:', error); 
    }
}

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
            window.location.href = '/';
        })
        .catch(error => {
            console.error('Error:', error);
        });
}