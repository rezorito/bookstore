const express = require('express');
const cors = require('cors');
const sql = require('mssql');

const app = express();
app.use(cors());

// Cấu hình kết nối với cơ sở dữ liệu
const config = {
    user: 'sa',
    password: 'rezorito',
    server: 'RezoRito\\RITO',
    database: 'QLBOOKSTORE',
    options: {
        trustServerCertificate: true
    }
};

// Kết nối với cơ sở dữ liệu
sql.connect(config, (err) => {
    if (err) {
        console.error('Lỗi kết nối:', err);
        return;
    }
    console.log('Kết nối thành công!');
});

// Xử lý yêu cầu GET từ trang web
app.get('/', (req, res) => {
    res.send('Xin chào, đây là trang chủ!');
});

app.get('/data', (req, res) => {
    const request = new sql.Request();
    request.query('SELECT * FROM Book', (err, recordset) => {
        if (err) {
            console.error('Lỗi truy vấn:', err);
            res.status(500).send('Lỗi truy vấn cơ sở dữ liệu.');
            return;
        }
        res.json(recordset.recordset);
    });
});

const PORT = 5000;
app.listen(PORT, () => {
    console.log(`Server đang chạy tại http://localhost:${PORT}`);
});