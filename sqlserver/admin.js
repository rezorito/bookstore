document.addEventListener("DOMContentLoaded", function () {
    checkUserLogin();
    LoadInforUser();
});

// document.getElementById('btn_change_img').addEventListener('click', function (e) {
//     e.preventDefault();
//     document.getElementById('fileInputImg').click();
// });

// document.getElementById('fileInputImg').addEventListener('change', function (event) {
//     const file = event.target.files[0];
//     if (file) {
//         const reader = new FileReader();
//         reader.onload = (e) => {
//             document.getElementById("user_avatar").src = e.target.result;
//         };
//         reader.readAsDataURL(file);
//     }
// });

async function LoadInforUser() {
    try {
        const dataUser = await getuser();
        const inforUser = await fetchDataInforUserFromServer(dataUser.user.UserName)
        document.getElementById("user_id").innerHTML = dataUser.user.UserName || "";
        document.getElementById("user_name").value = inforUser[0].Name || "";
        document.getElementById("user_email").value = inforUser[0].Email || "";
        document.getElementById("user_sdt").value = inforUser[0].SDT || "";
        document.getElementById("user_address").value = inforUser[0].Address || "";
        if (inforUser[0].Gender == 1) {
            document.getElementById("user_gt_1").checked = true;
        } else if (inforUser[0].Gender == 2) {
            document.getElementById("user_gt_2").checked = true;
        } else if (inforUser[0].Gender == 0) {
            document.getElementById("user_gt_0").checked = true;
        }
        document.getElementById("user_date").value = inforUser[0].Date || "";
        // document.getElementById("user_avatar").src = inforUser[0].Image || "";
    } catch (e) {
        console.log(e)
    }
}

document.getElementById("btn_Accept_Save").addEventListener('click', async function (e) {
    try {
        const dataUser = await getuser();
        const Name = document.getElementById("user_name").value;
        const Email = document.getElementById("user_email").value;
        const SDT = document.getElementById("user_sdt").value;
        const Address = document.getElementById("user_address").value;
        let Gender = '0';
        if (document.getElementById("user_gt_1").checked) {
            Gender = '1'
        } else if (document.getElementById("user_gt_2").checked) {
            Gender = '2'
        } else if (document.getElementById("user_gt_0").checked) {
            Gender = '0'
        }
        const Date = document.getElementById("user_date").value;
        fetch("http://localhost:5000/update_inforUser", {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({
                User_ID: dataUser.user.UserName,
                Name: Name ? Name : null,
                Email: Email ? Email : null,
                SDT: SDT ? SDT : null,
                Address: Address ? Address : null,
                Gender: Gender ? Gender : null,
                Date: Date ? Date : null,
            })
        })
            .then((response) => response.json())
            .then((data) => {
                alert(data.message);
                LoadInforUser()
            })
            .catch((error) => {
                console.error("Lỗi:", error);
            });
    } catch (e) {
        console.log(e)
    }
})

async function fetchDataInforUserFromServer(UserName) {
    try {
        const response = await fetch("http://localhost:5000/get_inforUser", {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({
                UserName: UserName
            }),
        });
        if (!response.ok) {
            throw new Error(`HTTP error! status: ${response.status}`);
        }
        const data = await response.json();
        return data;
    } catch (error) {
        console.error("Lỗi:", error);
        return null;
    }
}