document.addEventListener("DOMContentLoaded", function () {
    checkUserLogin();
    showLogin();
});

const showLogin = async () => {
    const token = localStorage.getItem('token');
    var unLoginElements = document.getElementById('UnLoginUser')
    var LoginElements = document.getElementById('LoginUser')
    if (!token) {
        unLoginElements.style.display = 'block'
        LoginElements.style.display = 'none'
        cartShow.style.display = 'none'
    } else {
        const dataUser = await getuser();
        unLoginElements.style.display = 'none'
        LoginElements.style.display = 'block'
        document.getElementById("UserName_LG").innerText = dataUser.user.UserName;
    }
}

document.getElementById('btn_MyAccount').addEventListener('click', async function (e) {
    const token = localStorage.getItem('token');
    const dataUser = await getuser();
    console.log(dataUser)
    if (dataUser.user.Permission == 0) {
        window.location.href = "/WInforUser"
    } else {
        window.location.href = "/WAdmin"
    }
})

document.getElementById('logOut').addEventListener('click', function (e) {
    localStorage.removeItem('token');
    window.location.href = '/WLogin';
})