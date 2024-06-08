const books = [
    {
        id: 1,
        img: "https://product.hstatic.net/1000363117/product/8936071672704_85103de7755547f7995cbf7098e788d5_medium.jpg",
        name: "TÔI VẼ - PHƯƠNG PHÁP TỰ HỌC VẼ TRUYỆN TRANH",
        price: "80.000",
        sale: "-20%"
    },
    {
        id: 2,
        img: "https://product.hstatic.net/1000363117/product/tb30-1_7a670519dc344827af0cc77ba6c15afa_master.jpg",
        name: "CAN TRƯỜNG BƯỚC TIẾP (TÁI BẢN 2023)",
        price: "86.400",
        sale: "-10%"
    },
    {
        id: 3,
        img: "https://product.hstatic.net/1000363117/product/083ff9aa590e12891cd998cd1e2195d6_15a7dceb0aa54404b8bb3bee5140e952_medium.jpg",
        name: "GÁNH GÁNH... GỒNG GỒNG... (XUÂN PHƯỢNG HỒI KÝ)",
        price: "155.000",
        sale: "-3%"
    },
    {
        id: 4,
        img: "https://product.hstatic.net/1000363117/product/305afbf42b8effda0a194b6f690cc2f1_87eb9d4432524e68a8b1331a81d404d3_medium.jpg",
        name: "STORYTELLING WITH DATA - KỂ CHUYỆN THÔNG QUA DỮ LIỆU",
        price: "287.100",
        sale: "-10%"
    },
    {
        id: 5,
        img: "https://product.hstatic.net/1000363117/product/viet_nam_su_luoc_1_e857764da05944968090120af109fdc8_large_2bf522dc7ff74587be34231c5504ac97_medium.jpg",
        name: "VIỆT NAM SỬ LƯỢC (ẤN BẢN KỶ NIỆM 100 NĂM LẦN ĐẦU XUẤT BẢN)",
        price: "360.000",
        sale: "-20%"
    },
    {
        id: 6,
        img: "https://product.hstatic.net/1000363117/product/90-20-30-90-bai-hoc-vo-long-ve-y-tuong-va-cau-chu_b927bfcdefca4b94b2bd16901450f490_medium.png",
        name: "90-20-30 90 BÀI HỌC VỠ LÒNG VỀ Ý TƯỞNG VÀ CÂU CHỮ (BẢN ĐEN TRẮNG) - TÁI BẢN",
        price: "175.500",
        sale: "-10%"
    },
    {
        id: 7,
        img: "https://product.hstatic.net/1000363117/product/8936170870049_747025a69a7d47fdab20eadce5b42657_medium.jpg",
        name: "DIGITAL MARKETING - TỪ CHIẾN LƯỢC ĐẾN THỰC THI (TÁI BẢN 2020)",
        price: "198.000",
        sale: "-10%"
    },
    {
        id: 8,
        img: "https://product.hstatic.net/1000363117/product/cay-cam-ngot-cua-toi_1_d3689c94e8614673b72f6bcbee854219_medium.jpg",
        name: "CÂY CAM NGỌT CỦA TÔI",
        price: "97.200",
        sale: "-10%"
    },
    {
        id: 9,
        img: "https://product.hstatic.net/1000363117/product/3d_-_nhung_tran_chien_thay_doi_lich_su_13d64c69320940d9a6b7d274b7973f37_medium.jpg",
        name: "NHỮNG TRẬN CHIẾN THAY ĐÔI LỊCH SỬ",
        price: "400.000",
        sale: "-20%"
    },
    {
        id: 10,
        img: "https://product.hstatic.net/1000363117/product/ban_co_nam_cho_ngoi_636f2f4194b84b03bb77507bd05470da_medium.jpg",
        name: "BÀN CÓ NĂM CHỖ NGỒI (TÁI BẢN 2022)",
        price: "34.200",
        sale: "-10%"
    }
];

//banner1
function createBookElement(book) {
    var columnDiv = document.createElement('div');
    columnDiv.classList.add('grid__column-10-2');

    var productDiv = document.createElement('div');
    productDiv.classList.add('home-product-item');

    var link = document.createElement('a');
    link.href = "../ChiTietSP.html";

    var image = document.createElement('img');
    image.classList.add('home-product-item__img');
    image.src = book.img;
    image.alt = "";

    var title = document.createElement('h4');
    title.classList.add('home-product-item__name');
    title.textContent = book.name;

    var priceDiv = document.createElement('div');
    priceDiv.classList.add('home-product-item__price');

    var currentPrice = document.createElement('p');
    currentPrice.classList.add('home-product-item__current-price');
    currentPrice.innerHTML = '<span>' + book.price + '</span><sup>đ</sup>';

    var saleOffDiv = document.createElement('div');
    saleOffDiv.classList.add('home-product-item__sale-off');

    var saleOffPercent = document.createElement('span');
    saleOffPercent.classList.add('home-product-item__sale-off-percent');
    saleOffPercent.textContent = '-' + book.sale;

    var button = document.createElement('button');
    button.classList.add('btn', 'btn-addtocart');
    button.textContent = 'Thêm vào giỏ hàng';

    saleOffDiv.appendChild(saleOffPercent);
    priceDiv.appendChild(currentPrice);

    productDiv.appendChild(link);
    link.appendChild(image);
    link.appendChild(title);
    productDiv.appendChild(priceDiv);
    productDiv.appendChild(saleOffDiv);
    productDiv.appendChild(button);

    columnDiv.appendChild(productDiv);

    return columnDiv;
}

var container = document.getElementById('banner1');

books.forEach(function(book) {
    var bookElement = createBookElement(book);
    container.appendChild(bookElement);
});