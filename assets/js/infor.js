function send()
{
    var cusname = document.getElementById('cusname').value;
    var cusemail = document.getElementById('cusemail').value;
    var cusphone= document.getElementById('cusphone').value;
    var nd = document.getElementById('nd').value;
    if(cusname == "" || cusemail == "" || cusphone == "" || nd == ""){
        alert("Điền đầy đủ thông tin");
        return;
    }
    if(isNaN(cusphone)){//is not a number
        alert("Vui lòng nhập đúng với định dang số điện thoại");
        return;
    }
    var choice = confirm('Xác nhận thông tin của bạn\nHọ tên: '+cusname+"\nEmail: "+cusemail+"\nSố điện thoại: "+cusphone+"\nNội dung: "+nd+"\n");
    if(choice == 1){
        alert("Chúng tôi sẽ sớm liên hệ lại với bạn");
        document.getElementsByTagName('form')[0].reset();
    }
}
