const express = require("express");
const cors = require("cors");
const sql = require("mssql");
const session = require("express-session");
const { engine } = require("express-handlebars");
const open = require('open');

const app = express();
app.use(cors());
app.use(express.json());
const fs = require('fs');
const path = require('path');
const multer = require("multer");
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
    res.render('home', { title: 'Trang chủ', isHome: isHome, layout: 'layouts/layout' });
});

app.get('/WLogin', (req, res) => {
    const isHome = true;
    res.render('DangNhap', { title: 'Đăng nhập', isHome: isHome, layout: 'layouts/layout' });
});

app.get('/WRegister', (req, res) => {
    const isHome = true;
    res.render('DangKy', { title: 'Đăng ký', isHome: isHome, layout: 'layouts/layout' });
});

app.get('/WInforUser', (req, res) => {
    const isHome = true;
    res.render('Admin', { title: 'Thông tin tài khoản', isHome: isHome, layout: 'layouts/layout' });
});

app.get('/WCTSP', (req, res) => {
    const isHome = true;
    res.render('CTSanPham', { title: 'Đăng ký', isHome: isHome, layout: 'layouts/layout' });
});

app.get('/WSearch', (req, res) => {
    const isHome = true;
    res.render('Search', { title: 'Kết quả tìm kiếm', isHome: isHome, layout: 'layouts/layout' });
});

app.get('/WTN', (req, res) => {
    const isHome = true;
    res.render('TLThieuNhi', { title: 'Sách thiếu nhi', isHome: isHome, layout: 'layouts/layout' });
});
app.get('/WVH', (req, res) => {
    const isHome = true;
    res.render('TLVanHoc', { title: 'Sách văn học', isHome: isHome, layout: 'layouts/layout' });
});
app.get('/WTT', (req, res) => {
    const isHome = true;
    res.render('TLTrinhTham', { title: 'Sách trinh thám', isHome: isHome, layout: 'layouts/layout' });
});
app.get('/WCK', (req, res) => {
    const isHome = true;
    res.render('TLChuKy', { title: 'Sách có chữ ký', isHome: isHome, layout: 'layouts/layout' });
});
app.get('/WVPP', (req, res) => {
    const isHome = true;
    res.render('TLVanPP', { title: 'Văn phòng phẩm', isHome: isHome, layout: 'layouts/layout' });
});

app.get('/WGioHang', (req, res) => {
    const isHome = true;
    res.render('purchaseOrder', { title: 'Giỏ hàng', isHome: isHome, layout: 'layouts/layoutOrder' });
});
app.get('/WThanhToan', (req, res) => {
    const isHome = true;
    res.render('thanhtoan', { title: 'Thanh toán', isHome: isHome, layout: 'layouts/layoutOrder' });
});
app.get('/WDonMua', (req, res) => {
    const isHome = true;
    res.render('donMua', { title: 'Đơn mua', isHome: isHome, layout: 'layouts/layoutOrder' });
});

app.get('/WAdmin', (req, res) => {
    const isHome = true;
    res.render('admin/admin', { layout: 'layouts/layoutAdmin' });
});
app.get('/WAdmin/WListBook', (req, res) => {
    const isHome = true;
    res.render('admin/product-list', { layout: 'layouts/layoutAdmin' });
});
app.get('/WAdmin/WListOrder', (req, res) => {
    const isHome = true;
    res.render('admin/order-list', { layout: 'layouts/layoutAdmin' });
});
app.get('/WAdmin/WListBill', (req, res) => {
    const isHome = true;
    res.render('admin/bill-list', { layout: 'layouts/layoutAdmin' });
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


/////////////////////////////////////////////////////

// Cấu hình Multer
const storage = multer.diskStorage({
    destination: (req, file, cb) => {
        const uploadDir = path.join(__dirname, "assets/img_sql"); // Đảm bảo đường dẫn đúng
        cb(null, uploadDir);
    },
    filename: (req, file, cb) => {
        cb(null, Date.now() + path.extname(file.originalname)); // Đặt tên file duy nhất
    },
});

const upload = multer({ storage: storage });

app.post("/upload", upload.single("image"), async (req, res) => {
    try {
        if (!req.file) {
            return res.status(400).json({ error: "Không có file nào được chọn." });
        }
        const finalFileName = req.file.filename;
        const imagePath = "/img_sql/" + finalFileName;
        res.json({ message: "Ảnh đã được lưu thành công!", fileName: finalFileName, imagePath });
    } catch (error) {
        console.error("Lỗi:", error);
        res.status(500).json({ error: "Đã xảy ra lỗi khi lưu ảnh." });
    }
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
app.post("/get_inforUser", (req, res) => {
    const { UserName } = req.body;
    const request = new sql.Request();
    request.input("UserName", sql.VarChar, UserName);
    request.query("SELECT Name, Email, SDT, Address, Gender, CONVERT(VARCHAR, Date, 23) as Date, Image From Infor_user WHERE User_ID = @UserName;", (err, recordset) => {
        if (err) {
            console.error("Lỗi truy vấn:", err);
            return res.status(500).send("Lỗi truy vấn cơ sở dữ liệu.");
        }
        res.json(recordset.recordset);
    });
});

app.post("/update_inforUser", (req, res) => {
    const { User_ID, Name, Email, SDT, Address, Gender, Date
        // ,Image 
    } = req.body;
    const request = new sql.Request();
    request.input("User_ID", sql.VarChar, User_ID);
    request.input("Name", sql.NVarChar, Name);
    request.input("Email", sql.VarChar, Email);
    request.input("SDT", sql.VarChar, SDT);
    request.input("Date", sql.Date, Date);
    request.input("Address", sql.NVarChar, Address);
    request.input("Gender", sql.NVarChar, Gender);
    request.query("UPDATE Infor_user Set Name = @Name, Email = @Email, SDT = @SDT, Address = @Address, Gender = @Gender, Date = @Date WHERE User_ID = @User_ID;", (err, recordset) => {
        if (err) {
            console.error("Lỗi truy vấn:", err);
            res.status(500).json({ message: "Lỗi truy vấn cơ sở dữ liệu." });
            return;
        }
        res.json({ message: "Infor fix successfully" });
    });
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
app.post("/add-product", upload.single("image"), async (req, res) => {
    try {
        if (!req.file) {
            return res.status(400).json({ error: "Không có file nào được chọn." });
        }
        const finalFileName = req.file.filename;
        const imagePath = "/img_sql/" + finalFileName;
        const bookData = JSON.parse(req.body.book);
        const { BookID, BookName, BookPrice, BookSale, BookContent, TheLoaiID } = bookData;
        const request = new sql.Request();
        request.input("BookID", sql.Char, BookID);
        request.input("BookName", sql.NVarChar, BookName);
        request.input("BookPrice", sql.Float, BookPrice);
        request.input("BookSale", sql.Float, BookSale);
        request.input("BookContent", sql.NVarChar, BookContent);
        request.input("BookImage", sql.VarChar, imagePath);
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
    } catch (error) {
        console.error("Lỗi:", error);
        res.status(500).json({ error: "Đã xảy ra lỗi khi lưu ảnh." });
    }
});

app.put("/fix-product", upload.single("image"), (req, res) => {
    try {
        const bookData = JSON.parse(req.body.book);
        const image_delete = req.body.image_delete;
        let imagePath = image_delete;
        if (req.file) {
            const folderPath = path.join(__dirname, 'assets');
            const filePath = path.join(folderPath, image_delete);
            fs.unlink(filePath, (err) => {
                if (err) {
                    console.error('Lỗi khi xóa file:', err);
                }
            });
            //Ảnh mới
            const finalFileName = req.file.filename;
            imagePath = "/img_sql/" + finalFileName;

        }
        const { BookID, BookName, BookPrice, BookSale, BookContent, TheLoaiID } = bookData;
        const request = new sql.Request();
        request.input("BookID", sql.Char, BookID);
        request.input("BookName", sql.NVarChar, BookName);
        request.input("BookPrice", sql.Float, BookPrice);
        request.input("BookSale", sql.Float, BookSale);
        request.input("BookContent", sql.NVarChar, BookContent);
        request.input("BookImage", sql.VarChar, imagePath);
        request.input("TheLoaiID", sql.Char, TheLoaiID);
        request.query(
            "UPDATE Book SET Name = @BookName, Price = @BookPrice, Sale = @BookSale, Content = @BookContent, Image = @BookImage, Category_ID = @TheLoaiID WHERE ID = @BookID; ",
            (err, recordset) => {
                if (err) {
                    console.error("Lỗi truy vấn:", err);
                    res.status(500).json({ message: "Lỗi truy vấn cơ sở dữ liệu." });
                    return;
                }
                res.json({ message: "Product fix successfully", image_delete });
            }
        );
    } catch (error) {
        console.error("Lỗi:", error);
        res.status(500).json({ error: "Đã xảy ra lỗi khi lưu ảnh." });
    }
});

app.delete("/delete-product", (req, res) => {
    try {
        const BookID = req.body.bookID;
        const image_delete = req.body.image_delete;
        const folderPath = path.join(__dirname, 'assets');
        const filePath = path.join(folderPath, image_delete);
        fs.unlink(filePath, (err) => {
            if (err) {
                console.error('Lỗi khi xóa file:', err);
            }
        });

        const request = new sql.Request();
        request.input("BookID", sql.Char, BookID);
        request.query("DELETE FROM Book WHERE ID = @BookID;", (err, result) => {
            if (err) {
                console.error("Lỗi truy vấn:", err);
                res.status(500).json({ message: "Lỗi truy vấn cơ sở dữ liệu." });
                return;
            }
            res.json({ message: "Product deleted successfully" });
        });
    } catch (error) {
        console.error("Lỗi:", error);
        res.status(500).json({ error: "Đã xảy ra lỗi khi lưu ảnh." });
    }
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

function generateRandomID() {
    const characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    let result = '';
    const charactersLength = characters.length;
    for (let i = 0; i <= 7; i++) {
        result += characters.charAt(Math.floor(Math.random() * charactersLength));
    }
    return result
}

// PT Vận chuyển
// 0 - Nhanh
// 1- Hỏa tốc
// PT Thanh toán
// 0 - trả khi nhận
// 1 - chuyển khoản
// Tình trạng (TT)
// 0 - Hủy thanh toán
// 1 - Chờ xác nhận
// 2 - Đang vận chuyển
// 3 - Đã thanh toán
app.post("/successPay", async (req, res) => {
    const { UserName, Book_IDS, inforUser, priceTotal, PthVC, PthTT } = req.body;
    const timestamp = Date.now();
    const date = new Date(timestamp);
    const year = date.getFullYear();
    const month = String(date.getMonth() + 1).padStart(2, '0'); // Tháng bắt đầu từ 0, cộng thêm 1
    const day = String(date.getDate()).padStart(2, '0'); // Đảm bảo 2 chữ số cho ngày
    const formattedDate = `${year}-${month}-${day}`;

    if (!Array.isArray(Book_IDS) || Book_IDS.length === 0) {
        res.status(400).json({ message: "Invalid Book_IDS array." });
        return;
    }
    const request = new sql.Request();
    const dataBookID = Book_IDS.map(item => item);
    const bookIDsString = dataBookID.map(id => `'${id}'`).join(',');
    const IDHD = generateRandomID();
    const sqlQuery1 = `INSERT INTO [Order] (ID, User_ID, Date, Price, PthVC, PthTT, TT, Address, UserName, Email, SDT) VALUES (@IDHD, @UserName, '${formattedDate}', @priceTotal, @PthVC, @PthTT, 1, @Address, @nameUser, @Email, @SDT);`
    const sqlQuery2 = `INSERT INTO [Order_detail] (Order_ID, Book_ID) VALUES` + dataBookID.map(id => `(@IDHD, '${id}')`).join(',');
    const sqlQuery3 = `DELETE FROM Cart WHERE UserName = @UserName AND Book_ID IN (${bookIDsString});`;
    request.input("IDHD", sql.Char, IDHD);
    request.input("UserName", sql.VarChar, UserName);
    request.input("priceTotal", sql.Float, priceTotal);
    request.input("PthVC", sql.Int, PthVC);
    request.input("PthTT", sql.Int, PthTT);
    request.input("nameUser", sql.NVarChar, inforUser.nameUser);
    request.input("Email", sql.VarChar, inforUser.emailUser);
    request.input("SDT", sql.VarChar, inforUser.sdtUser);
    request.input("Address", sql.NVarChar, inforUser.addressUser);
    try {
        const result1 = await request.query(sqlQuery1);
        const result2 = await request.query(sqlQuery2);
        const result3 = await request.query(sqlQuery3);

        res.json({ message: "Successfully" });
    } catch (err) {
        console.error("Lỗi truy vấn:", err);
        res.status(500).json({ message: "Lỗi truy vấn cơ sở dữ liệu." });
    }
});

//Admin Đơn hàng / Hóa đơn
app.get("/list_order", (req, res) => {
    const request = new sql.Request();
    request.query(
        `SELECT ID, UserName, Email, SDT, Address, PthVC, PthTT, CONVERT(VARCHAR, Date, 23) as Date, CONVERT(VARCHAR, DatePay, 23) as DatePay, Price, TT FROM [Order] WHERE TT != 3`,
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

app.post("/fix_tt_order", (req, res) => {
    const { ID, TT } = req.body;
    const request = new sql.Request();
    request.input("ID", sql.VarChar, ID);
    request.input("TT", sql.Int, TT);
    let formattedDate = null;
    if (TT == 3) {
        const timestamp = Date.now();
        const date = new Date(timestamp);
        const year = date.getFullYear();
        const month = String(date.getMonth() + 1).padStart(2, '0'); // Tháng bắt đầu từ 0, cộng thêm 1
        const day = String(date.getDate()).padStart(2, '0'); // Đảm bảo 2 chữ số cho ngày
        formattedDate = `${year}-${month}-${day}`;
    }
    request.input('DatePay', sql.Date, formattedDate);
    request.query(`UPDATE [Order] SET TT = @TT, DatePay = @DatePay WHERE ID = @ID;`, (err, result) => {
        if (err) {
            console.error("Lỗi truy vấn:", err);
            res.status(500).json({ message: "Lỗi truy vấn cơ sở dữ liệu." });
            return;
        }
        res.json({ message: "TT order fix successfully" });
    });
});

app.post("/order_detail", (req, res) => {
    const { ID } = req.body;
    const request = new sql.Request();
    request.input("ID", sql.VarChar, ID);
    request.query("SELECT Book_ID From Order_detail WHERE Order_ID = @ID;", (err, recordset) => {
        if (err) {
            console.error("Lỗi truy vấn:", err);
            res.status(500).send("Lỗi truy vấn cơ sở dữ liệu.");
            return;
        }
        const bookIDsString = recordset.recordset.map(item => `'${item.Book_ID}'`).join(',');
        request.query(`SELECT * From Book WHERE ID in (${bookIDsString});`, (err1, recordse1) => {
            if (err1) {
                console.error("Lỗi truy vấn:", err);
                res.status(500).send("Lỗi truy vấn cơ sở dữ liệu.");
                return;
            }
            res.json(recordse1.recordset);
        });
    });
});

app.get("/list_bill", (req, res) => {
    const request = new sql.Request();
    request.query(
        `SELECT ID, UserName, Email, SDT, Address, PthVC, PthTT, CONVERT(VARCHAR, Date, 23) as Date, CONVERT(VARCHAR, DatePay, 23) as DatePay, Price, TT FROM [Order] WHERE TT = 3`,
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

const PORT = process.env.PORT || 5000;
app.listen(PORT, () => {
    console.log(`Server đang chạy tại http://localhost:${PORT}`);
    open(`http://localhost:${PORT}`);
});


// SELECT [Order].ID, [Order].User_ID, Infor_user.Name
// FROM [Order], Infor_user, Login
// WHERE [Order].User_ID = Login.UserName
// AND Login.UserName = Infor_user.User_ID;