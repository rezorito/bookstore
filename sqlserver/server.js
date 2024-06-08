const express = require('express');
const cors = require('cors');
const sql = require('mssql');

const app = express();
app.use(cors());
app.use(express.json()); // Middleware để xử lý JSON trong yêu cầu

const config = {
    user: 'sa',
    password: 'rezorito',
    server: 'RezoRito\\RITO',
    database: 'QLBOOKSTORE',
    options: {
        trustServerCertificate: true
    }
};

sql.connect(config, (err) => {
    if (err) {
        console.error('Lỗi kết nối:', err);
        return;
    }
    console.log('Kết nối thành công!');
});

// Trang đăng nhập
app.post('/login', (req, res) => {
    const { username, password } = req.body;
    const request = new sql.Request();
    request.input('username', sql.VarChar, username);
    request.input('password', sql.VarChar, password);
    request.query('SELECT * FROM Login WHERE UserName = @username AND PassWord = @password', (err, recordset) => {
        if (err) {
            console.error('Lỗi truy vấn:', err);
            res.status(500).send('Lỗi truy vấn cơ sở dữ liệu.');
            return;
        }
        res.json(recordset.recordset);
    });
});

//Trang category
app.get('/cate', (req, res) => {
    const TheLoaiID = req.query.id;
    const request = new sql.Request();
    request.input('TheLoaiID', sql.VarChar, TheLoaiID);
    request.query(`
        SELECT *
        FROM Book
        Where Book.Category_ID = @TheLoaiID
    `, (err, recordset) => {
        if (err) {
            console.error('Lỗi truy vấn:', err);
            res.status(500).send('Lỗi truy vấn cơ sở dữ liệu.');
            return;
        }
        res.json(recordset.recordset);
    });
});

//Trang admin
app.get('/dssp', (req, res) => {
    const request = new sql.Request();
    request.query(`
        SELECT Book.ID as BookID, 
               Book.Name as BookName, 
               Book.Price as BookPrice, 
               Book.Sale as BookSale, 
               Book.Content as BookContent, 
               Book.Image as BookImage, 
               Category.Name as TheLoai
        FROM Book
        INNER JOIN Category ON Book.Category_ID = Category.ID
    `, (err, recordset) => {
        if (err) {
            console.error('Lỗi truy vấn:', err);
            res.status(500).send('Lỗi truy vấn cơ sở dữ liệu.');
            return;
        }
        res.json(recordset.recordset);
    });
});

//Trang chi tiết sản phẩm
app.get('/ctsp', (req, res) => {
    const bookID = req.query.id;
    const request = new sql.Request();
    request.input('bookID', sql.Char, bookID);
    request.query('SELECT * FROM Book WHERE ID = @bookID', (err, recordset) => {
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
