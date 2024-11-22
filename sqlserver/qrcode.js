const openPopupBtn = document.getElementById('open-popupqr-btn');
const closePopupBtn = document.getElementById('close-popupqr-btn');
const popup = document.getElementById('popupqr');
const bodyOverlay = document.getElementById('body-overlay');
const qrcode = document.querySelector('.qrcodeimg')

const checkInforUser = () => {
    const nameUser = document.getElementById('nameUser').value
    const emailUser = document.getElementById('emailUser').value
    const sdtUser = document.getElementById('sdtUser').value
    const addressUser = document.getElementById('addressUser').value
    if (nameUser.trim() == "" || emailUser.trim() == "" || sdtUser.trim() == "" || addressUser.trim() == "") {
        return false;
    }
    return true;
}
const Bank = {
    Bank_ID: 'MB',
    Bank_nummber: '221003160903'
}

function generateRandomString() {
    const characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    let result = '';
    const charactersLength = characters.length;
    for (let i = 0; i <= 7; i++) {
        result += characters.charAt(Math.floor(Math.random() * charactersLength));
    }
    return result
}

openPopupBtn.addEventListener('click', async function (e) {
    if (!checkInforUser()) {
        alert("Cần nhập đầy đủ thông tin trước")
    } else {
        var payBankRadio = document.getElementById("pay_bank");
        if (payBankRadio.checked) {
            var verificationCodes = generateRandomString()
            document.getElementById('codext').innerHTML = verificationCodes;
            let priceqrTotal = priceTotal.innerText * 1000;
            document.getElementById('TotalPayment').innerHTML = priceTotal.innerText;
            let QR = `https://img.vietqr.io/image/${Bank.Bank_ID}-${Bank.Bank_nummber}-qr_only.png?amount=${priceqrTotal}&addInfo=PAYMENT MA: ${verificationCodes}`;
            console.log(verificationCodes);
            console.log(QR);
            qrcode.src = QR;
            popup.style.display = 'block';
            bodyOverlay.style.display = 'block';
            document.body.classList.add('opened');
            setTimeout(() => {
                setInterval(() => {
                    checkPaid(priceqrTotal, verificationCodes);
                }, 1000);
            }, 20000);
        } else {
            // const rawdata = sessionStorage.getItem('totalDSPayment');
            const rawdata = sessionStorage.getItem('ListBookPayment');
            const data = JSON.parse(rawdata);
            const dataBookID = data.map(item => item.BookID.trim());
            fetchSuccessPayFromServer(dataBookID);
        }
    }
});

closePopupBtn.addEventListener('click', function (e) {
    popup.style.display = 'none';
    bodyOverlay.style.display = 'none';
    document.body.classList.remove('opened');
});

const API_Key = 'AK_CS.06a618a036af11efb7127b03250987c0.HFNqHvGRz5pDcoI1zM1cH7QCLGqobDXCv09hYRZ6zDfISnQPiTs8zviyRjWI639u72Q9OJfa'
const API_Get_Paid = 'https://oauth.casso.vn/v2/transactions'

let isSucess = false;
async function checkPaid(priceqrTotal, verificationCodes) {
    if (isSucess) {
        return;
    } else {
        try {
            const response = await fetch(API_Get_Paid, {
                headers: {
                    Authorization: `apikey ${API_Key}`,
                    "Content-Type": "application/json",
                }
            })
            const data = await response.json();
            var DSPaid = data.data.records;
            var length = data.data.records.length - 1;
            var amount = DSPaid[length].amount
            var description = DSPaid[length].description
            console.log(DSPaid[length]);
            if (amount >= priceqrTotal && description.includes(verificationCodes)) {
                alert('Thanh toán thành công')
                isSucess = true;
                await fetchSuccessPayFromServer();
                window.location.href = "/"
            } else {
                console.log('Chưa có giao dịch!');
            }
        } catch (e) {
            alert('Lỗi' + e.message)
        }
    }
}

function openPopup() {
    document.getElementById("popup").style.display = "block";
}

function closePopup() {
    document.getElementById("popup").style.display = "none";
}

window.onclick = function (event) {
    var popup = document.getElementById("popup");
    if (event.target === popup) {
        popup.style.display = "none";
    }
}

async function fetchSuccessPayFromServer(dataBookID) {
    try {
        const nameUser = document.getElementById('nameUser').value
        const emailUser = document.getElementById('emailUser').value
        const sdtUser = document.getElementById('sdtUser').value
        const addressUser = document.getElementById('addressUser').value
        const priceTotal = document.getElementById('price-total').innerHTML
        let PthVC = PthTT = 0
        if (document.getElementById("ghht").checked) {
            PthVC = 1;
        }
        if (document.getElementById("pay_bank").checked) {
            PthTT = 1;
        }
        var dataUser = await getuser();
        const formData = {
            UserName: dataUser.user.UserName,
            Book_IDS: dataBookID,
            inforUser: {
                nameUser: nameUser.trim(),
                emailUser: emailUser.trim(),
                sdtUser: sdtUser.trim(),
                addressUser: addressUser.trim(),
            },
            priceTotal,
            PthVC,
            PthTT,
        };
        await fetch('http://localhost:5000/successPay', {
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
                if (data.message == "Successfully") {
                    alert("Đặt hàng thành công!")
                    window.location.href = "/"
                }
            })
            .catch(error => {
                console.error('Error:', error);
            });
    } catch (e) {
        alert(e)
    }
}