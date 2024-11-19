const express = require("express");
const cors = require("cors");
const sql = require("mssql");
const session = require("express-session");
const { engine } = require("express-handlebars");
const open = require('open');

const app = express();
app.use(cors());
app.use(express.json()); // Middleware để xử lý JSON trong yêu cầu
const path = require('path');
const expressLayouts = require('express-ejs-layouts');
const jwt = require('jsonwebtoken');
const SECRET_KEY = 'rezorito';

const config = {
    user: "sa",
    password: "rezorito",
    server: "RezoRito\\RITO",
    database: "QLBOOKSTORE",
    options: {
        trustServerCertificate: true,
    },
};

sql.connect(config, (err) => {
    if (err) {
        console.error("Lỗi kết nối:", err);
        return;
    }
    console.log("Kết nối thành công!");
});

// app.engine("handlebars", hbs.engine({ defaultLayout: "home" }));
// app.set("view engine", "handlebars");
// app.use(session({
//     secret: 'rezorito',
//     resave: false,
//     saveUninitialized: true,
//     cookie: { secure: false } // Khi sử dụng HTTPS, nên đặt thành true
// }));

// Trang đăng nhập

app.set('view engine', 'ejs');
app.set('viewNews', path.join(__dirname, 'viewNews'));
app.use(expressLayouts);

// Cấu hình thư mục chứa các file tĩnh (CSS, JS)
app.use(express.static(path.join(__dirname, 'assets')));
app.use(express.static(path.join(__dirname, 'sqlserver')));

app.get('/', (req, res) => {
    const isHome = false;
    res.render('home', { title: 'Trang chủ', isHome: isHome, layout: 'layouts/layout'});
});

app.get('/WLogin', (req, res) => {
    const isHome = true;
    res.render('DangNhap', { title: 'Đăng nhập' , isHome: isHome, layout: 'layouts/layout'});
});

app.get('/WRegister', (req, res) => {
    const isHome = true;
    res.render('DangKy', { title: 'Đăng ký' , isHome: isHome, layout: 'layouts/layout'});
});

app.get('/WInforUser', (req, res) => {
    const isHome = true;
    res.render('Admin', { title: 'Thông tin tài khoản' , isHome: isHome, layout: 'layouts/layout'});
});

app.get('/WCTSP', (req, res) => {
    const isHome = true;
    res.render('CTSanPham', { title: 'Đăng ký' , isHome: isHome, layout: 'layouts/layout'});
});

app.get('/WSearch', (req, res) => {
    const isHome = true;
    res.render('Search', { title: 'Kết quả tìm kiếm' , isHome: isHome, layout: 'layouts/layout'});
});

app.get('/WTN', (req, res) => {
    const isHome = true;
    res.render('TLThieuNhi', { title: 'Sách thiếu nhi' , isHome: isHome, layout: 'layouts/layout'});
});
app.get('/WVH', (req, res) => {
    const isHome = true;
    res.render('TLVanHoc', { title: 'Sách văn học' , isHome: isHome, layout: 'layouts/layout'});
});
app.get('/WTT', (req, res) => {
    const isHome = true;
    res.render('TLTrinhTham', { title: 'Sách trinh thám' , isHome: isHome, layout: 'layouts/layout'});
});
app.get('/WCK', (req, res) => {
    const isHome = true;
    res.render('TLChuKy', { title: 'Sách có chữ ký' , isHome: isHome, layout: 'layouts/layout'});
});
app.get('/WVPP', (req, res) => {
    const isHome = true;
    res.render('TLVanPP', { title: 'Văn phòng phẩm' , isHome: isHome, layout: 'layouts/layout'});
});

app.get('/WGioHang', (req, res) => {
    const isHome = true;
    res.render('purchaseOrder', { title: 'Giỏ hàng' , isHome: isHome, layout: false });
});
app.get('/WThanhToan', (req, res) => {
    const isHome = true;
    res.render('thanhtoan', { title: 'Thanh toán' , isHome: isHome, layout: false });
});

app.get('/WAdmin', (req, res) => {
    const isHome = true;
    res.render('admin/admin', { layout: 'layouts/layoutAdmin' });
});
app.get('/WAdmin/WListBook', (req, res) => {
    const isHome = true;
    res.render('admin/product-list', { layout: 'layouts/layoutAdmin' });
});
app.get('/WAdmin/WAddBook', (req, res) => {
    const isHome = true;
    res.render('admin/productCreate-admin', { layout: 'layouts/layoutAdmin' });
});

app.post("/login", async (req, res) => {
    const { username, password } = req.body;
    const request = new sql.Request();
    request.input("username", sql.VarChar, username);
    request.input("password", sql.VarChar, password);
    const result = await request.query("SELECT * FROM Login WHERE UserName = @username AND PassWord = @password");
    if (result.recordset.length > 0) {
        tt_user.user = result.recordset[0];
        c
        tt_user.loggedIn = true;
        console.log("login", tt_user);
        res.json(tt_user);
    } else {
        res.json(tt_user);
    }
});

////////////////////////////////////////////////////////////
app.post('/api/login', async (req, res) => {
    const { username, password } = req.body;
    const request = new sql.Request();
    request.input("username", sql.VarChar, username);
    request.input("password", sql.VarChar, password);
    const result = await request.query("SELECT * FROM Login WHERE UserName = @username AND PassWord = @password");
    // Kiểm tra thông tin đăng nhập (giả sử đúng)
    if (result.recordset.length > 0) {
        const user = result.recordset[0];
        const token = jwt.sign(user, SECRET_KEY, { expiresIn: '1h' });
        res.json({ token });
    } else {
        res.status(401).json({ message: 'Tên đăng nhập hoặc mật khẩu không đúng' });
    }
});

// Middleware xác thực
const authMiddleware = (req, res, next) => {
    const token = req.headers.authorization?.split(' ')[1];

    if (!token) {
        return res.status(401).json({ message: 'Không có token, truy cập bị từ chối' });
    }

    try {
        const decoded = jwt.verify(token, SECRET_KEY);
        req.user = decoded;
        next();
    } catch (error) {
        res.status(403).json({ message: 'Token không hợp lệ' });
    }
};

app.get('/api/userInfo', authMiddleware, (req, res) => {
    const user = req.user;
    res.json({ message: 'User information retrieved successfully', user });
});

// Route được bảo vệ
app.get('/api/protected', authMiddleware, (req, res) => {
    res.json({ message: 'Chào mừng đến với route được bảo vệ', user: req.user });
});
/////////////////////////////////////////////////////

app.post("/add-user", (req, res) => {
    const { dk_tk, dk_mk } = req.body;
    const request = new sql.Request();
    request.input("dk_tk", sql.VarChar, dk_tk);
    request.input("dk_mk", sql.VarChar, dk_mk);
    request.query(
        `
            INSERT INTO Login (UserName, PassWord, Permission)
            VALUES (@dk_tk, @dk_mk, 0)
        `,
        (err, result) => {
            if (err) {
                console.error("Lỗi truy vấn:", err);
                res.status(500).json({ message: "Lỗi truy vấn cơ sở dữ liệu." });
                return;
            }
            res.json({ message: "Product added successfully" });
        }
    );
});

//Trang category
app.get("/cate", (req, res) => {
    const TheLoaiID = req.query.id;
    const request = new sql.Request();
    request.input("TheLoaiID", sql.VarChar, TheLoaiID);
    request.query(
        `
        SELECT Book.ID as BookID, 
               Book.Name as BookName, 
               Book.Price as BookPrice, 
               Book.Sale as BookSale, 
               Book.Content as BookContent, 
               Book.Image as BookImage, 
               Book.Count as BookCount, 
			   Category.ID as TheLoaiID
        FROM Book
        Where Book.Category_ID = @TheLoaiID
    `,
        (err, recordset) => {
            if (err) {
                console.error("Lỗi truy vấn:", err);
                res.status(500).send("Lỗi truy vấn cơ sở dữ liệu.");
                return;
            }
            res.json(recordset.recordset);
        }
    );
});

//Trang admin
app.get("/dssp", (req, res) => {
    const request = new sql.Request();
    request.query(
        `
        SELECT Book.ID as BookID, 
               Book.Name as BookName, 
               Book.Price as BookPrice, 
               Book.Sale as BookSale, 
               Book.Content as BookContent, 
               Book.Image as BookImage, 
               Book.Count as BookCount, 
               Category.Name as TheLoai,
			   Category.ID as TheLoaiID
        FROM Book, Category
        WHERE Book.Category_ID = Category.ID
    `,
        (err, recordset) => {
            if (err) {
                console.error("Lỗi truy vấn:", err);
                res.status(500).send("Lỗi truy vấn cơ sở dữ liệu.");
                return;
            }
            res.json(recordset.recordset);
        }
    );
});

//Trang chi tiết sản phẩm
app.get("/ctsp", (req, res) => {
    const bookID = req.query.id;
    const request = new sql.Request();
    request.input("bookID", sql.Char, bookID);
    request.query(
        `SELECT ID as BookID, 
               Name as BookName, 
               Price as BookPrice, 
               Sale as BookSale, 
               Content as BookContent, 
               Image as BookImage, 
               Count as BookCount
                FROM Book WHERE ID = @bookID`,
        (err, recordset) => {
            if (err) {
                console.error("Lỗi truy vấn:", err);
                res.status(500).send("Lỗi truy vấn cơ sở dữ liệu.");
                return;
            }
            res.json(recordset.recordset);
        }
    );
});

//Thêm/Sửa/Xóa sản phẩm
app.post("/add-product", (req, res) => {
    const { BookID, BookName, BookPrice, BookSale, BookContent, BookImage, TheLoaiID } = req.body;
    const request = new sql.Request();
    request.input("BookID", sql.Char, BookID);
    request.input("BookName", sql.NVarChar, BookName);
    request.input("BookPrice", sql.Float, BookPrice);
    request.input("BookSale", sql.Float, BookSale);
    request.input("BookContent", sql.NVarChar, BookContent);
    request.input("BookImage", sql.VarChar, BookImage);
    request.input("TheLoaiID", sql.Char, TheLoaiID);
    request.query(
        "INSERT INTO Book (ID, Name, Price, Category_ID, Sale, Content, Image) VALUES (@BookID, @BookName, @BookPrice, @TheLoaiID, @BookSale, @BookContent, @BookImage);",
        (err, result) => {
            if (err) {
                console.error("Lỗi truy vấn:", err);
                res.status(500).json({ message: "Lỗi truy vấn cơ sở dữ liệu." }); // Send error as JSON
                return;
            }
            res.json({ message: "Product added successfully" }); // Send success message as JSON
        }
    );
});

app.put("/fix-product", (req, res) => {
    const { BookID, BookName, BookPrice, BookSale, BookContent, BookImage, TheLoaiID } = req.body;
    const request = new sql.Request();
    request.input("BookID", sql.Char, BookID);
    request.input("BookName", sql.NVarChar, BookName);
    request.input("BookPrice", sql.Float, BookPrice);
    request.input("BookSale", sql.Float, BookSale);
    request.input("BookContent", sql.NVarChar, BookContent);
    request.input("BookImage", sql.VarChar, BookImage);
    request.input("TheLoaiID", sql.Char, TheLoaiID);
    request.query(
        "UPDATE Book SET Name = @BookName, Price = @BookPrice, Sale = @BookSale, Content = @BookContent, Image = @BookImage, Category_ID = @TheLoaiID WHERE ID = @BookID; ",
        (err, recordset) => {
            if (err) {
                console.error("Lỗi truy vấn:", err);
                res.status(500).send("Lỗi truy vấn cơ sở dữ liệu.");
                return;
            }
            res.send("Product fix successfully");
        }
    );
});

app.delete("/delete-product", (req, res) => {
    const BookID = req.body.BookID;
    const request = new sql.Request(); // Khởi tạo đối tượng request
    request.input("BookID", sql.Char, BookID);
    request.query("DELETE FROM Book WHERE ID = @BookID;", (err, result) => {
        if (err) {
            console.error("Lỗi truy vấn:", err);
            res.status(500).json({ message: "Lỗi truy vấn cơ sở dữ liệu." });
            return;
        }
        res.json({ message: "Product deleted successfully" });
    });
});

//The loai
app.get("/cateTN", (req, res) => {
    const request = new sql.Request();
    request.query(
        `
        SELECT ID as BookID, 
               Name as BookName, 
               Price as BookPrice, 
               Sale as BookSale, 
               Content as BookContent, 
               Image as BookImage, 
               Count as BookCount 
        FROM Book
        Where Book.Category_ID = 'TN'
    `,
        (err, recordset) => {
            if (err) {
                console.error("Lỗi truy vấn:", err);
                res.status(500).send("Lỗi truy vấn cơ sở dữ liệu.");
                return;
            }
            res.json(recordset.recordset);
        }
    );
});

app.get("/cateVH", (req, res) => {
    const request = new sql.Request();
    request.query(
        `
        SELECT ID as BookID, 
               Name as BookName, 
               Price as BookPrice, 
               Sale as BookSale, 
               Content as BookContent, 
               Image as BookImage, 
               Count as BookCount 
        FROM Book
        Where Book.Category_ID = 'VH'
    `,
        (err, recordset) => {
            if (err) {
                console.error("Lỗi truy vấn:", err);
                res.status(500).send("Lỗi truy vấn cơ sở dữ liệu.");
                return;
            }
            res.json(recordset.recordset);
        }
    );
});

app.get("/cateTT", (req, res) => {
    const request = new sql.Request();
    request.query(
        `
        SELECT ID as BookID, 
               Name as BookName, 
               Price as BookPrice, 
               Sale as BookSale, 
               Content as BookContent, 
               Image as BookImage, 
               Count as BookCount 
        FROM Book
        Where Book.Category_ID = 'TT'
    `,
        (err, recordset) => {
            if (err) {
                console.error("Lỗi truy vấn:", err);
                res.status(500).send("Lỗi truy vấn cơ sở dữ liệu.");
                return;
            }
            res.json(recordset.recordset);
        }
    );
});

app.get("/cateCK", (req, res) => {
    const request = new sql.Request();
    request.query(
        `
        SELECT ID as BookID, 
               Name as BookName, 
               Price as BookPrice, 
               Sale as BookSale, 
               Content as BookContent, 
               Image as BookImage, 
               Count as BookCount 
        FROM Book
        Where Book.Category_ID = 'CK'
    `,
        (err, recordset) => {
            if (err) {
                console.error("Lỗi truy vấn:", err);
                res.status(500).send("Lỗi truy vấn cơ sở dữ liệu.");
                return;
            }
            res.json(recordset.recordset);
        }
    );
});

app.get("/cateVPP", (req, res) => {
    const request = new sql.Request();
    request.query(
        `
        SELECT ID as BookID, 
               Name as BookName, 
               Price as BookPrice, 
               Sale as BookSale, 
               Content as BookContent, 
               Image as BookImage, 
               Count as BookCount
        FROM Book
        Where Book.Category_ID = 'VPP'
    `,
        (err, recordset) => {
            if (err) {
                console.error("Lỗi truy vấn:", err);
                res.status(500).send("Lỗi truy vấn cơ sở dữ liệu.");
                return;
            }
            res.json(recordset.recordset);
        }
    );
});

//Search
app.get("/dsbook", (req, res) => {
    const request = new sql.Request();
    request.query(
        `
        SELECT Name
        FROM Book
    `,
        (err, recordset) => {
            if (err) {
                console.error("Lỗi truy vấn:", err);
                res.status(500).send("Lỗi truy vấn cơ sở dữ liệu.");
                return;
            }
            res.json(recordset.recordset);
        }
    );
});

app.post("/searchdsbook", (req, res) => {
    const BookName = req.body.BookName;
    const request = new sql.Request();
    request.input("BookName", sql.NVarChar, BookName);
    request.query(
        `
        SELECT Book.ID as BookID, 
           Book.Name as BookName, 
           Book.Price as BookPrice, 
           Book.Sale as BookSale, 
           Book.Content as BookContent, 
           Book.Image as BookImage, 
           Category.Name as TheLoai,
           Category.ID as TheLoaiID
    FROM Book, Category
    WHERE Book.Category_ID = Category.ID AND Book.Name LIKE N'%${BookName}%'
    `,
        (err, recordset) => {
            if (err) {
                console.error("Lỗi truy vấn:", err);
                res.status(500).send("Lỗi truy vấn cơ sở dữ liệu.");
                return;
            }
            res.json(recordset.recordset);
        }
    );
});

app.post("/getcart", (req, res) => {
    const UserName = req.body.UserName;
    const request = new sql.Request();
    request.input("UserName", sql.VarChar, UserName);
    request.query(
        `
        SELECT Book.ID as BookID, 
               Book.Name as BookName, 
               Book.Price as BookPrice, 
               Book.Sale as BookSale, 
               Book.Content as BookContent, 
               Book.Image as BookImage
        FROM Book, Cart
        WHERE Book.ID = Cart.Book_ID AND UserName = @UserName
    `,
        (err, recordset) => {
            if (err) {
                console.error("Lỗi truy vấn:", err);
                res.status(500).send("Lỗi truy vấn cơ sở dữ liệu.");
                return;
            }
            res.json(recordset.recordset);
        }
    );
});

//Cart
app.post("/add-cart", (req, res) => {
    const { BookID, UserName } = req.body;
    const request = new sql.Request();
    request.input("BookID", sql.Char, BookID);
    request.input("UserName", sql.VarChar, UserName);
    request.query("INSERT INTO Cart (UserName, Book_ID) VALUES (@UserName, @BookID);", (err, result) => {
        if (err) {
            console.error("Lỗi truy vấn:", err);
            res.status(500).json({ message: "Lỗi truy vấn cơ sở dữ liệu." });
            return;
        }
        res.json({ message: "Product Cart added successfully" });
    });
});

app.delete("/delete-cart", (req, res) => {
    const { BookID, UserName } = req.body;
    const request = new sql.Request(); // Khởi tạo đối tượng request
    request.input("BookID", sql.Char, BookID);
    request.input("UserName", sql.VarChar, UserName);
    request.query("DELETE FROM Cart WHERE UserName = @UserName AND Book_ID = @BookID;", (err, result) => {
        if (err) {
            console.error("Lỗi truy vấn:", err);
            res.status(500).json({ message: "Lỗi truy vấn cơ sở dữ liệu." });
            return;
        }
        res.json({ message: "Product deleted successfully" });
    });
});

app.delete("/successPay", (req, res) => {
    const { UserName, Book_IDS } = req.body;

    if (!Array.isArray(Book_IDS) || Book_IDS.length === 0) {
        res.status(400).json({ message: "Invalid Book_IDS array." });
        return;
    }
    const request = new sql.Request();
    // Xây dựng danh sách tham số cho Book_IDs
    const params = Book_IDS.map((id, index) => `'${Book_IDS[index].BookID}'`).join(", ");
    const sqlQuery = `DELETE FROM Cart WHERE UserName = @UserName AND Book_ID IN (${params});`;
    // Đưa các giá trị vào request
    request.input("UserName", sql.VarChar, UserName);

    request.query(sqlQuery, (err, result) => {
        if (err) {
            console.error("Lỗi truy vấn:", err);
            res.status(500).json({ message: "Lỗi truy vấn cơ sở dữ liệu." });
            return;
        }
        res.json({ message: "Product deleted successfully" });
    });
});

const PORT = process.env.PORT || 5000;
app.listen(PORT, () => {
    console.log(`Server đang chạy tại http://localhost:${PORT}`);
    open(`http://localhost:${PORT}`);
});
