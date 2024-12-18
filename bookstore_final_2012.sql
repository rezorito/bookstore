USE [master]
GO
/****** Object:  Database [QLBOOKSTORE]    Script Date: 11/27/2024 2:09:27 PM ******/
CREATE DATABASE [QLBOOKSTORE]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'QLBOOKSTORE', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.RITO\MSSQL\DATA\QLBOOKSTORE.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'QLBOOKSTORE_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.RITO\MSSQL\DATA\QLBOOKSTORE_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [QLBOOKSTORE].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [QLBOOKSTORE] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [QLBOOKSTORE] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [QLBOOKSTORE] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [QLBOOKSTORE] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [QLBOOKSTORE] SET ARITHABORT OFF 
GO
ALTER DATABASE [QLBOOKSTORE] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [QLBOOKSTORE] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [QLBOOKSTORE] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [QLBOOKSTORE] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [QLBOOKSTORE] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [QLBOOKSTORE] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [QLBOOKSTORE] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [QLBOOKSTORE] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [QLBOOKSTORE] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [QLBOOKSTORE] SET  DISABLE_BROKER 
GO
ALTER DATABASE [QLBOOKSTORE] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [QLBOOKSTORE] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [QLBOOKSTORE] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [QLBOOKSTORE] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [QLBOOKSTORE] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [QLBOOKSTORE] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [QLBOOKSTORE] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [QLBOOKSTORE] SET RECOVERY FULL 
GO
ALTER DATABASE [QLBOOKSTORE] SET  MULTI_USER 
GO
ALTER DATABASE [QLBOOKSTORE] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [QLBOOKSTORE] SET DB_CHAINING OFF 
GO
ALTER DATABASE [QLBOOKSTORE] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [QLBOOKSTORE] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
EXEC sys.sp_db_vardecimal_storage_format N'QLBOOKSTORE', N'ON'
GO
USE [QLBOOKSTORE]
GO
/****** Object:  Table [dbo].[Book]    Script Date: 11/27/2024 2:09:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Book](
	[ID] [char](10) NOT NULL,
	[Name] [nvarchar](max) NULL,
	[Price] [float] NULL,
	[Category_ID] [char](10) NULL,
	[Sale] [float] NULL,
	[Content] [nvarchar](max) NULL,
	[Image] [varchar](max) NULL,
	[Author] [nvarchar](max) NULL,
	[Count] [int] NULL,
 CONSTRAINT [PK_Book] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Cart]    Script Date: 11/27/2024 2:09:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cart](
	[UserName] [varchar](50) NULL,
	[Book_ID] [char](10) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Category]    Script Date: 11/27/2024 2:09:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Category](
	[ID] [char](10) NOT NULL,
	[Name] [nvarchar](50) NULL,
 CONSTRAINT [PK_Category] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Infor_user]    Script Date: 11/27/2024 2:09:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Infor_user](
	[User_ID] [varchar](50) NOT NULL,
	[Name] [nvarchar](50) NULL,
	[Email] [varchar](50) NULL,
	[SDT] [varchar](50) NULL,
	[Date] [date] NULL,
	[Gender] [nvarchar](50) NULL,
	[Address] [nvarchar](50) NULL,
	[Image] [varchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Login]    Script Date: 11/27/2024 2:09:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Login](
	[UserName] [varchar](50) NOT NULL,
	[PassWord] [varchar](50) NULL,
	[Permission] [int] NULL,
 CONSTRAINT [PK_Login] PRIMARY KEY CLUSTERED 
(
	[UserName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Order]    Script Date: 11/27/2024 2:09:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Order](
	[ID] [char](10) NOT NULL,
	[User_ID] [varchar](50) NULL,
	[Date] [date] NULL,
	[DatePay] [date] NULL,
	[Price] [float] NULL,
	[PthVC] [int] NULL,
	[PthTT] [int] NULL,
	[TT] [int] NULL,
	[Address] [nvarchar](50) NULL,
	[UserName] [nvarchar](50) NULL,
	[Email] [varchar](50) NULL,
	[SDT] [varchar](50) NULL,
 CONSTRAINT [PK_Order] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Order_detail]    Script Date: 11/27/2024 2:09:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Order_detail](
	[Order_ID] [char](10) NULL,
	[Book_ID] [char](10) NULL
) ON [PRIMARY]
GO
INSERT [dbo].[Book] ([ID], [Name], [Price], [Category_ID], [Sale], [Content], [Image], [Author], [Count]) VALUES (N'CK01      ', N'ĂN GÌ CHO KHÔNG ĐỘC HẠI - SÁCH CÓ CHỮ KÝ', 100, N'CK        ', 1, N' Câu chuyện thú vị và bổ ích về thực dưỡng, ăn chay, hay detox... nhìn từ góc độ khoa học và thực tiễn đời sống, môi trường, được thể hiện bằng giọng văn hài hước và sắc sảo. Tác giả vốn là cây viết chủ lực của trang soi.com, viết về ẩm thực và văn hóa', N'https://product.hstatic.net/1000363117/product/angikhongdochai_2adfaf44ccf74c70895f9b4d6aed4da5_master.jpg', NULL, 5)
INSERT [dbo].[Book] ([ID], [Name], [Price], [Category_ID], [Sale], [Content], [Image], [Author], [Count]) VALUES (N'CK02      ', N'ĂN UỐNG LÀ HẠNH PHÚC - SÁCH CÓ CHỮ KÝ', 105, N'CK        ', 0, N'Sau Chào con! Ba mẹ đã sẵn sàng & Bước đệm vững chắc vào đời, cuốn sách thứ ba trong bộ BÁC SĨ RIÊNG CỦA BÉ YÊU được bác sĩ Huyên Thảo chọn đề tài “ăn uống”, vì theo bác sĩ, “thật sự mình thấy đây là một đề tài rất cơ bản, quá cơ bản, nhưng lại gây ra quá nhiều đau thương, căng thẳng và cay đắng, cho con trẻ, cho ba mẹ ông bà chúng.” Vốn là bác sĩ nhi tốt nghiệp ở Đại học y khoa Úc, nổi tiếng mát tay khi chữa trị và tư vấn nhi khoa cho nhóm bệnh nhân nhỏ tuổi, bác sĩ gặp nhiều “nạn nhân” trong chính sự lo lắng thương yêu không đúng cách.', N'https://product.hstatic.net/1000363117/product/image_195509_1_44036_4c78a41a88dc4064a8f044a161268e28_master.jpg', NULL, 4)
INSERT [dbo].[Book] ([ID], [Name], [Price], [Category_ID], [Sale], [Content], [Image], [Author], [Count]) VALUES (N'CK03      ', N'BÁC SĨ RIÊNG CỦA BÉ YÊU - BƯỚC ĐỆM VỮNG CHẮC VÀO ĐỜI - SÁCH CÓ CHỮ KÝ', 92, N'CK        ', 0, N'Bước đệm vững chắc vào đời là cuốn tiếp theo Chào con! Ba mẹ đã sẵn sàng trong bộ BÁC SĨ RIÊNG CỦA BÉ YÊU. Trong cuốn sách này Bác sĩ – thạc sĩ nhi khoa Trần thị Huyên Thảo gửi tới các bậc phụ huynh những lời khuyên thực tế và khoa học dành cho việc chăm sóc trẻ.', N'https://product.hstatic.net/1000363117/product/3709495c77f6a7bfce764ad9a5214ade_d70f21fc11eb4978ab738b11b910578a_master.jpg', NULL, 3)
INSERT [dbo].[Book] ([ID], [Name], [Price], [Category_ID], [Sale], [Content], [Image], [Author], [Count]) VALUES (N'CK04      ', N'BỨC XÚC KHÔNG LÀM TA VÔ CAN - SÁCH CÓ CHỮ KÝ', 85, N'CK        ', 0, N'"Từ chỗ vô danh cách đây bảy, tám năm, bây giờ, nếu gõ "bức xúc" vào Google, ta sẽ được 29 triệu kết quả, gấp gần 10 lần "Ngọc Trinh" một con số ấn tượng cho một làn da xấu xí như vậy." 
 
Đây là một trong rất nhiều các quan sát thú vị, kèm theo các giải mãi hóm hỉnh, không kém phần chua xót song cũng rất giàu nhân văn trong tuyển tập BỨC XÚC KHÔNG LÀM TA VÔ CAN của tiến sĩ Đặng Hoàng Giang. 26 bài viết là 26 câu chuyện từ quen thuộc như thịt chó, ấn đền Trần, phẫu thuật thẩm mỹ, từ thiện câu like...đến ngỡ như vĩ mô xa xôi nhưng lại ảnh hưởng mật thiết đến cuộc sống từng cá nhân như sự tàn phá của kinh tế thị trường, lí do khiến quốc gia thất bại, du lịch đại trà, hay các vấn đề văn hóa không bao giờ hết nóng như sính ngoại, truyền hình thực tế...Không chỉ phân tích khách quan và bình luận sắc sảo, tác giả còn đề xuất nhiều giài pháp bất ngờ và đầy trách nhiệm, khiến các bài viết, trước khi được tập hợp lại trong tuyển tập này, đã nhận được hàng trăm nghìn lượt xem và rất nhiều chia sẻ từ đông đảo cư dân mạng. 
 
"Một góc nhìn thằng thắn và tỉnh táo, xoáy vào những vấn đề bằng những con dao mổ sắc cạnh của tri thức... Từ lâu, những cây viết của nước ta vẫn dùng dao gọt hoa quả có lưỡi lượn sóng để mổ xẻ các vấn đề. Chúng ta thiếu những con dao mổ lạnh, nằm trong những bàn tay ấm."', N'https://product.hstatic.net/1000363117/product/thumbnail_a8da0c51d58e4d96bc678c0914bd5206_master.png', NULL, 1)
INSERT [dbo].[Book] ([ID], [Name], [Price], [Category_ID], [Sale], [Content], [Image], [Author], [Count]) VALUES (N'CK05      ', N'CAN TRƯỜNG BƯỚC TIẾP (BÌA CŨ) - SÁCH CÓ CHỮ KÝ', 89, N'CK        ', 0, N'Mỗi người đều sẽ gặp nhau vào đúng thời điểm cần phải gặp, ra đi vào đúng thời điểm cần phải đi. Đừng sợ hãi mà cũng đừng mất lòng tin, những câu chuyện cổ tích ngọt ngào trên đời này vốn không thay đổi giá trị của nó, thứ duy nhất đổi thay là người cùng chúng ta viết nên cổ tích. Chương cũ không đóng lại làm sao có cơ hội cho chương mới mở ra. Cứ rực rỡ, vui vẻ lạc quan và dõng dạc: ”Người tiếp theo!!“ 

Gửi người đàn ông ra đi 11 năm về trước 

Hôm nay tròn 11 năm rồi đó ba ạ, đã đi lâu vậy rồi mà vẫn chưa thấy về, một lá thư gửi về cũng không, con thỉnh thoảng vẫn kiểm tra hòm thư của nhà mình, thế mà ở đó chỉ toàn là bụi. 

Con từng tình cờ xem một câu chuyện được kể trong đám cưới ở đâu đó, người cha đã nói với con rể rằng: 

“Tôi là người đầu tiên nắm tay con bé, không phải cậu. Người đầu tiên hôn con bé là tôi, không phải là cậu. Người đầu tiên bảo vệ con bé cũng là tôi. Nhưng mà… có thể đi cùng con bé suốt cuộc đời, đó là cậu chứ không phải tôi. 

Nếu có một ngày cậu không yêu con bé nữa… Đừng phản bội nó. Đừng đánh nó. Đừng nói với nó. Nói với tôi, tôi đưa nó về nhà…”. 

Vốn dĩ cuộc đời này không có gì là mãi mãi, ba mẹ càng không thể đi cùng con đến cuối cuộc đời. Nếu con bước sai đường, đi sai hướng, chọn sai người, con sẽ phải tự dò dẫm làm lại từ đầu. Con đã sai, ba ạ. Nhưng không có ai nói với anh ta rằng: “Nếu cậu không yêu con bé nữa, nói với tôi, tôi đưa nó về nhà…”. Có những ước mơ mà con phải tự bi ến thành hiện thực, có những vấp ngã mà con phải tự mình đứng dậy, cũ ng có nhữ ng chèn ép con phải tự chống chọi. Không một cánh tay, không một sự nâng đỡ, không một lời an ủi. Tất cả đều tự mình con. 

Nhiều người nói với con rằng làm phụ nữ phải biết yếu mềm, không hiền lành thì cũng phải tỏ ra ngây thơ dù chỉ là lừa dối, như thế thì ra xã hội mới có thể được chở che, nâng đỡ. Đàn bà đừng kiêu kỳ quá, cũng đừng mạnh mẽ quá, ông trời không ban bất hạnh cho cái đứa yếu đuối bao giờ, đứa nào cứng cỏi thì sẽ lãnh nhận hết mọi sầu bi trên thế gian, đó mới chính là lẽ đời. Thế nhưng con chưa từng làm được, con cục tính, không thể nói lời ngọt ngào như nhiều người, không biết lấy lòng ai, cũng chẳng thể tỏ ra mềm yếu bởi vì những lúc yếu mềm nhất con lại chọn ở một mình, chẳng muốn ai nhìn thấy, nước mắt có rớt xuống con cũng nhất định phải ngẩng cao đầu cho nó chảy ngược vào trong. 

Thế nhưng, cho dù đã khổ đau ra sao, bất hạnh thế nào, thì con vẫn sẽ giữ trái tim của mình trong trẻo, vẫn sẽ yêu chân thành đến khờ dại, vẫn nhận thiệt thòi về phía mình để dành cho người kia những gì tốt đẹp nhất, thế nhưng một khi quyết quay lưng thì sỏi đá cũng chẳng thể lạnh bằng. 

Ba à, đừ ng lo con sẽ buồn khi cuộc đời không như ý. Bởi vì con hiểu phận của con là cứ sống cho thật tử tế, vạn điều còn lại trời xanh đã tự có an bài. Ba cũng đừng sợ con sẽ khổ đau vì những lời hứa hứa quên quên trên thế gian, nếu không dũng cảm buông tay khỏi những điều chẳng còn lành lặ n, thì bi ết bao giờ mới có cơ hội đón nhận những thứ tốt đẹp hơn. 

Con sẽ sống một cuộc đời luôn tiến về phía trước, điều đó có nghĩa là đối với những người không còn phù h ợp với hành trình của mình, con sẽ nhẹ nhàng từ bỏ để họ có thể tìm kiếm một người bạn đồng hành mới phù hợp hơn con. Nơi con tuyệt đối không bao giờ có hận thù mặc dù chặng đường đã đi cùng nhau rất có thể vướng đôi ba điều chẳng hài lòng. 

Ba và mẹ đã đi cùng nhau trên chuyến tàu thanh xuân năm ấy, thế rồi số phận buộc ba phải xuống ga ở giữa đoạn đường. Con biết ba mẹ đã có nhiều điều bỏ lỡ trong quãng đời tuổi trẻ, chính vì thế mà con bây giờ không ch ỉ số ng cho riêng mình mà còn là sống cho những gì mẹ và ba chưa làm được. 

Con biết dù bây giờ ba không thể bước đi cùng con, chẳng thể chia vui với những thành công hay là đưa bờ vai cho con nương tự a trướ c những khổ đau mà cuộ c đời ai cũng phải đôi ba lần nếm trải. Nhưng con tin ba v ẫn luôn ngắm nhìn con Can trường bước tiếp, ngẩng cao đầu kiêu hãnh dưới ánh bình minh vào mỗi sớm mai thức dậy. Con luôn tin rằng cuộc sống của con có hạnh phúc hay không, giá trị của con có tă ng theo thờ i gian hay không là do chính con chọn lựa chứ không phụ thuộc vào số phận hay bất kỳ ai. 

Và con sẽ luôn chọn sống can trường như ba luôn mong đợi. Quyển sách này con gửi cho ba. Cảm ơn ba đã cho con hình hài, trái tim và lòng can đảm. Ba mãi sống ở nơi trang trọng nhất trong tim con. 

Con yêu ba nhiều, 

Con gái của ba 

Vạn sự trên cuộc đời này đều có lúc này lúc khác, chỉ cần học được cách mạnh mẽ đón nhận mọi điều tốt xấu và nhẹ nhàng buông bỏ những thứ không còn thuộc về mình, thì cả cuộc đời này đau khổ cũng chỉ là một dạng cảm nhận trong chốc lát. 

”Tôi viết cuốn sách này trong giai đoạn quan trọng nhất của những dự án ở công ty. Vì thế mà nếu có bất kỳ sai sót gì, tôi thật lòng mong các bạn sẽ thông cảm và vẫn tiếp tục yêu thương, ủng hộ tôi. 

Tới cuối cùng của cuốn sách, tôi muốn chúng ta đều phải tin rằng những uất ức mà bất kỳ ai phải nếm trải cũng đều là để có một tương lai tốt hơn. Khi bạn tin vào điều đó thì những điều không toại ý sẽ chẳng còn là trở ngại khiến bạn trượt dài trong tuyệt vọng nữa. 

Cơn mưa tầm tã chiều nay khiến tôi bất chợt nhớ lại cơn mưa của mười một năm về trước, khi tôi dầm mình trong đó cùng nỗi bất lực của sự nghèo khó, thất vọng, nhục nhã, đói và lạnh. Mười một năm sau, tôi đã có thể đứng ngắm mưa ở một vị trí khác, một địa vị khác. Để làm được như vậy, không có cách nào khác hơn đó là bạn nhất định phải ”Can trường bước tiếp“, dù cuộc đời có đưa đến cho bạn những thử thách éo le đến đâu đi chăng nữa. 

Không ai biết trước được cuộc sống sẽ thay đổi ra sao. Nếu nói cuộc đời như một cuốn phim, mỗi nhân vật đều sẽ có kết thúc riêng của mình, vậy thì người luôn can trường trong bất kỳ hoàn cảnh nào chính là người có thể ngẩng cao đầu mỉm cười ở tập cuối.“', N'https://product.hstatic.net/1000363117/product/fffffff_1_1_440f4eb6b0a7435990d23b42318939d0_master.jpg', NULL, 8)
INSERT [dbo].[Book] ([ID], [Name], [Price], [Category_ID], [Sale], [Content], [Image], [Author], [Count]) VALUES (N'CK06      ', N'CÁNH ĐỒNG BẤT TẬN (TÁI BẢN 2019) - SÁCH CÓ CHỮ KÝ ', 85, N'CK        ', 0, N'"Cánh đồng bất tận" bao gồm những truyện hay và mới nhất của nhà văn Nguyễn Ngọc Tư. Đây là tác phẩm đang gây xôn xao trong đời sống văn học, bởi ở đó người ta tìm thấy sự dữ dội, khốc liệt của đời sống thôn dã qua cái nhìn của một cô gái. Bi kịch về nỗi mất mát, sự cô đơn được đẩy lên đến tận cùng, khiến người đọc có lúc cảm thấy nhói tim... NXB Trẻ trân trọng giới thiệu cùng bạn đọc. ', N'https://product.hstatic.net/1000363117/product/2410e2b33f6a496f02587d9ebcff2a2f_287177aa9e094a9dbc770be5de634025_master.jpg', NULL, 10)
INSERT [dbo].[Book] ([ID], [Name], [Price], [Category_ID], [Sale], [Content], [Image], [Author], [Count]) VALUES (N'CK07      ', N'CHÀO CON BA MẸ ĐÃ SẴN SÀNG - SÁCH CÓ CHỮ KÝ ', 95, N'CK        ', 0, N'"Chào con! Ba mẹ đã sẵn sàng!" - Cuốn sách không chỉ được viết trên nền tảng khoa học của một bác sĩ mà còn chứa chan tình yêu của một người mẹ. 

Chắc chắn bạn cũng sẽ cảm nhận được những điểm hay và thực tế trong quyển sách này, từ nền tảng khoa học vững chắc cho đến kiến thức chăm sóc trẻ mới nhất, và nhất là phù hợp với hoàn cảnh của Việt Nam. ', N'https://product.hstatic.net/1000363117/product/chao-con-ba-me-da-san-sang_54cfffd51de0450aa76d2fac0910cb5f_master.jpg', NULL, 6)
INSERT [dbo].[Book] ([ID], [Name], [Price], [Category_ID], [Sale], [Content], [Image], [Author], [Count]) VALUES (N'CK08      ', N'CHUYỆN THỰC TẬP (TÁI BẢN 2020) - SÁCH CÓ CHỮ KÝ ', 90, N'CK        ', 0, N'"Chuyện Thực Tập" là cuốn nhật ký thực tập của cô sinh viên năm hai tại một công ty dược phẩm. Câu chuyện được Đặng Huỳnh Mai Anh kể với giọng văn hóm hỉnh, mộc mạc kèm những nét vẽ minh họa ngộ nghĩnh, đậm chất Mai Anh thời còn là cô sinh viên năm hai tại Đại học Ngoại Thương. 

Cuốn nhật ký ghi lại những câu chuyện dung dị, với rất nhiều tình tiết "dở khóc dở cười" nơi công sở, những khó khăn mà tác giả đã gặp phải và cách cô tự tìm ra phương hướng trong quãng thời gian ngắn ngủi là thực tập sinh. Tất cả những điều này, nếu Mai Anh không viết ra thì sẽ chẳng có ai hướng dẫn, đào tạo hay có mặt trong bất cứ một giáo trình nào trên giảng đường Đại học. 

Thông qua Chuyện Thực Tập, những quan sát, bài học và kiến thức mà Mai Anh chia sẻ sẽ giúp các bạn đang và sẽ đi thực tập sẽ có thêm nhiều kinh nghiệm quý báu, có một cái nhìn thực tế hơn về việc đi thực tập tại một công ty. Bạn đọc đã đi qua quãng đời thú vị này cũng sẽ bắt gặp lại hình ảnh của chính mình, trong những ngày đầu chập chững từ nhà trường đến công ty qua hình ảnh của cô thực tập sinh Mai Anh. ', N'https://product.hstatic.net/1000363117/product/chuyenthuctap1_c0b07ccc87e748c7839ec53a0056706b_master.jpg', NULL, 4)
INSERT [dbo].[Book] ([ID], [Name], [Price], [Category_ID], [Sale], [Content], [Image], [Author], [Count]) VALUES (N'CK09      ', N'CÓ NGƯỜI SỰC TỈNH CƠN MƠ - SÁCH CÓ CHỮ KÝ ', 79, N'CK        ', 0, N'Về tác phẩm: Ngày xưa, mỗi khi ngâm nga một câu chuyện, bài thơ, người thi sĩ sẽ bắt đầu bằng lời ơn đến các thi thần. Vì họ tin rằng cảm hứng là món quà được các thần ban tặng. Bây giờ thì chúng ta biết rằng, chính cuộc sống bình thường, nhỏ bé này đây mới là thơ trường cho những thi sĩ đến thu hoạch. Nguyễn Thiện Ngân là một nhà thơ của đời thường như vậy. 

Thơ của Ngân là thơ về cuộc sống của người trẻ. Một cuộc sống có buồn, vui, giận, ghét, yêu thương, suy tự... bình thường như mọi cuộc sống khác. Thế nhưng thơ của Ngân lại được đón nhận, như thể Ngân rót xuống công chúng đúng thứ nước người ta đang khát uống. Đó là vì chúng ta cần nỗi lòng của mình được cô đọng lại, thành câu thơ. Và Ngân đã làm điều đó thật tốt. Mỗi tập thơ của Ngân giống như một hộp kẹo chocolate, không phải vì ngọt ngào, mà vì khó đoán. Bạn đọc giở ra bất kỳ một trang nào đó, đọc chậm vài câu ngân viết, như chọn một viên kẹo đa-vị, rồi bỗng thấy nhớ, thấy buồn, thấy ấm áp hay tủi thân... và bỗng thấy tâm hồn mình mềm lại. Cây đời lúc nào cũng xanh tươi, và mỗi ngày luôn có những người trẻ mới. Có lẽ vậy mà thơ của Ngân luôn được đón nhận và tái bản nhiều lần. 

Có Người Sực Tỉnh Cơn Mơ với ý tưởng về một người thức giấc và trăn trở giữa vũ trụ bí ẩn của chính mình, được cặp đôi thiết kế Quân & Dương thể hiện. 

TỰ NHẮC (Có người sực tỉnh cơn mơ) 

Có những lúc 

Thấy đã đủ những chéo chồng rối rắm 

Chỉ muốn trở về, nằm im lặng bên nhau 

Mơ tiếp những giấc mơ bỏ dở đã lâu 

Đi tiếp những con đường, dòng sông, đỉnh núi. 

Chẳng sợ hãi những lần sau cuối 

Không cần nghĩ quá nhiều về mai sau 

Chả lưu tâm ai khác nghĩ gì 

Sau tất thảy những đoạn đường đã trải 

Chợt nhận ra 

Đời mình không dư chỗ 

Cho những điều đáng bị hoài nghi 

Sẽ có những điều tự động ra đi 

Để ta biết nâng niu điều ở lại. 

 5 lý do để mua thơ của Ngân:  

1. Thơ nhẹ, chữ thưa, nhưng vẫn đậm đặc khả năng khơi gợi cảm xúc từ người đọc. 

2. Không mất nhiều thời gian để đọc, rồi sẽ có thật nhiều thời gian để suy ngẫm. 

3. Cách dùng từ độc đáo, như sự giao du giữa ngôn từ hiện đại và vốn ca dao tục ngữ xưa xa. 

4. Bìa mới, thiết kế mới, tôn lên nội dung và mọi bức hình mà bạn sẽ chụp khoe lên trang cá nhân. 

5. Hãy tặng cho ai đó thơ của Ngân - nếu bạn thương quý người đó. Vì khi đọc, họ sẽ thấy mềm lòng. ', N'https://product.hstatic.net/1000363117/product/bia-cnstcm-2d_940681aeb2594e13ac41cb42349f3626_master.jpg', NULL, 2)
INSERT [dbo].[Book] ([ID], [Name], [Price], [Category_ID], [Sale], [Content], [Image], [Author], [Count]) VALUES (N'CK10      ', N'CÓ PHONG CÁCH RIÊNG - SÁCH CÓ CHỮ KÝ ', 169, N'CK        ', 0, N'“CÓ PHONG CÁCH RIÊNG” –  Giản và mộc như chính con người tác giả Đặng Trầm! 

Nếu bạn nghĩ, thời trang là xa xỉ và sang chảnh, hẳn sẽ phải ngạc nhiên trước những bức hình OOTD mà Đặng Trầm đăng lên facebook mỗi ngày. Một phong cách chẳng xa xôi cầu kỳ. Khi thì chiếc quần jean boyfriend bụi đời, đi cùng giày cao gót đỏ, và chiếc áo sơ mi cài nút lệch hững hờ. Khi thì một bộ đầm hết sức bình thường, tay chiếc giỏ mây như giỏ người ta lùa cá bống. Chính niềm đam mê thời trang là lý do khiến Đặng Trầm sáng lập và xây dựng thành công thương hiệu sách thời trang và phong cách sống STYLORY in sâu trong lòng rất nhiều độc giả. Bên cạnh đó, việc chia sẻ các bức ảnh OOTD mỗi ngày của nữ giám đốc thương hiệu 9x đã truyền cảm hứng cho rất nhiều người phụ nữ xung quanh. Họ không phải những tín đồ thời trang sành sỏi, càng không phải những cô nàng sành điệu. Nhưng hình ảnh Đặng Trầm đăng về outfit mỗi ngày cứ thấm dần trong họ từng ngày từng ngày một. Từ đó họ chẳng thể làm ngơ với những gì mình mặc mỗi ngày. Ồ, hóa ra “phong cách thời trang” chẳng phải được hình thành từ những cái tên thương hiệu. “Phong cách thời trang” chỉ đơn giản là cách mình mặc nó mỗi ngày. Những người phụ nữ nhớ nằm lòng những lưu ý về outfit của Đặng Trầm mà trước đây thường xuyên phạm phải: hễ hở trên thì nhớ kín dưới, hở sau nhớ kín trước một chút, quần jean không nhất thiết phải đi với giày thể thao và áo thun…. 

Đó chính là động lực để Đặng Trầm viết cuốn sách “CÓ PHONG CÁCH RIÊNG”, với mong muốn truyền cảm hứng và sự vui vẻ trong phong cách và thời trang cho thật nhiều phụ nữ hơn nữa. Hơn 200 trang sách, nếu không phải rất đam mê với thứ gọi là phong cách sống, phong cách thời trang, nếu không có tình yêu với cái đẹp, thì sao có thể sắp xếp được những chương sách gọn gàng chỉn chu như thế. Thoạt nhìn, có lẽ nhiều người sẽ tưởng đây là cuốn sách viết về áo quần, về cách phối áo quần cho hợp mốt. Không, thực sự không chỉ như vậy. Một nửa đầu cuốn sách chỉ dành để nói về nụ cười, về ánh mắt, về thần thái, về những điều tạo nên nét đẹp cuốn hút ở người phụ nữ. Hình ảnh, màu sắc, font chữ, mọi thứ vừa chỉn chu vừa tự do không khuôn khổ. Nửa sau cuốn sách chính là một Đặng Trầm qua những gì cô đã viết về outfit, kiên trì chăm chỉ học hỏi từ rất lâu. 

Nếu có một góc nào đó trong căn phòng được gọi tên “góc đẹp”, hy vọng bạn hãy đặt ngay ngắn cuốn sách này vào. Để rồi một ngày trời ẩm ương hay ngoài kia đường trơn ướt, tụi mình ngồi nhẩn nha đọc lại những trang viết của Đặng Trầm, pha cho mình một ly trà bỏ vào lát cam sấy, mặc một bộ outfit phá cách, cười thiệt tươi, rồi tung tăng xuống phố và nhủ thầm “Dù trời mưa gió em vẫn phải thật xinh”. “Find yourself before you find love”. ', N'https://product.hstatic.net/1000363117/product/ef31c45357bece7cddfa5a068931b176_b7015208d7ab4717b00fc17a46f2cfd3_master.jpg', NULL, 3)
INSERT [dbo].[Book] ([ID], [Name], [Price], [Category_ID], [Sale], [Content], [Image], [Author], [Count]) VALUES (N'CK11      ', N'CON CHIM XANH BIẾC BAY VỀ - SÁCH CÓ CHỮ KÝ ', 150, N'CK        ', 0, N'Không giống như những tác phẩm trước đây lấy bối cảnh vùng quê miền Trung đầy ắp những hoài niệm tuổi thơ dung dị, trong trẻo với các nhân vật ở độ tuổi dậy thì, trong quyển sách mới lần này nhà văn Nguyễn Nhật Ánh lấy bối cảnh chính là Sài Gòn – Thành phố Hồ Chí Minh nơi tác giả sinh sống (như là một sự đền đáp ân tình với mảnh đất miền Nam). Các nhân vật chính trong truyện cũng “lớn” hơn, với những câu chuyện mưu sinh lập nghiệp lắm gian nan thử thách của các sinh viên trẻ đầy hoài bão. Tất nhiên không thể thiếu những câu chuyện tình cảm động, kịch tính và bất ngờ khiến bạn đọc ngẩn ngơ, cười ra nước mắt. Và như trong mọi tác phẩm Nguyễn Nhật Ánh, sự tử tế và tinh thần hướng thượng vẫn là điểm nhấn quan trọng trong quyển sách mới này. 

Như một cuốn phim “trinh thám tình yêu”, Con chim xanh biếc bay về dẫn bạn đi hết từ bất ngờ này đến tò mò suy đoán khác, để kết thúc bằng một nỗi hân hoan vô bờ sau bao phen hồi hộp nghi kỵ đến khó thở. 

Bạn sẽ theo phe sinh viên-nhân viên với những câu thơ dịu dàng và đáo để, hay phe ông chủ với những kỹ năng kinh doanh khởi nghiệp? Và hãy đoán thử, điều gì khiến bạn có thể cảm động đến rưng rưng trong cuộc sống giữa Sài Gòn bộn bề? 

Lâu lắm mới có hình ảnh thành phố rộn ràng trong tác phẩm của Nguyễn Nhật Ánh - điều hấp dẫn khác thường của Con chim xanh biếc bay về. 

Chính vì thế mà cuốn sách chỉ có một cách đọc thôi: một mạch từ đầu đến cuối!', N'https://product.hstatic.net/1000363117/product/biamem_f9ebfe5741f34ca18344ae6cc54bfb1c_master.jpg', NULL, 6)
INSERT [dbo].[Book] ([ID], [Name], [Price], [Category_ID], [Sale], [Content], [Image], [Author], [Count]) VALUES (N'CK12      ', N'ĐIỂM ĐẾN CỦA CUỘC ĐỜI - SÁCH CÓ CHỮ KÝ ', 75, N'CK        ', 0, N'Điểm đến của cuộc đời kể lại một hành trình không thể nào quên cùng những người cận tử. Dấn thân vào “một thế giới của những bi kịch và tổn thất khổng lồ, của phẩm giá và lòng tự trọng trong hoàn cảnh khắc nghiệt, của sự phản bội và sợ hãi, của tình yêu mãnh liệt và hy vọng khôn nguôi, tóm lại, của tất cả những gì thuộc về con người, ở mức độ dữ dội nhất”, tác giả muốn đi tìm câu trả lời cho thôi thúc nội tâm: ta nên ứng xử thế nào trước cái chết, và sự chết có thể dạy ta điều gì cho cuộc sống? 
Kỳ lạ thay, những số phận được kể trong cuốn sách, dù đang ở tầng bậc tột cùng của nỗi đau đớn, lại cho thấy những điều đẹp đẽ đến mức khiến ta nghẹn ngào: bản lĩnh để đi qua bi kịch khó diễn đạt bằng lời, thái độ bình tĩnh của con người tự do trước cái chết, khao khát làm việc có ích, trỗi dậy vào những ngày tháng cuối cùng. Đồng hành với họ, ta thấy biết ơn, hạnh phúc và giàu có. Gấp lại cuốn sách, ta có thể được rất nhiều: một nhận thức thấm thía về sự hữu hạn của con người, một thái độ điềm tĩnh trước điểm kết, lòng trân trọng cuộc sống, để từ đó bắt đầu rời xa những phù phiếm ồn ào, sắp xếp lại các ưu tiên, tập trung vào những điều cốt lõi khiến cuộc sống có ý nghĩa. 
Một hành trình dũng cảm. Một cuốn sách tràn đầy tính nhân văn và và sức lay động tâm hồn. ', N'https://product.hstatic.net/1000363117/product/0ba349a0af272577cd7e6290c1c1b52e_b64c5468b3fe4a9bbafbe2993418f96b_master.jpg', NULL, 8)
INSERT [dbo].[Book] ([ID], [Name], [Price], [Category_ID], [Sale], [Content], [Image], [Author], [Count]) VALUES (N'CK13      ', N'HAI - MƯƠI - BẢY - SÁCH CÓ CHỮ KÝ ', 109, N'CK        ', 0, N'Hai-mươi-bảy là tập truyện ngắn đầu tay của Đặng Huỳnh Mai Anh – một tác giả vốn được biết đến và yêu thích bởi thể loại phi hư cấu, với hai cuốn sách trước theo thể loại nhật ký trải nghiệm và nhật ký hành trình, cùng những bài tản văn và chia sẻ cá nhân trên mạng xã hội. Lần này, với những câu chuyện hoàn toàn hư cấu, đây thật sự là một thể nghiệm mới, nơi Mai Anh muốn những độc giả đã từng yêu mến mình hãy… quên mình đi, quên đi phiên bản người kể chuyện chân thật dung dị mà cô đã xây dựng, để làm quen và chào đón một phiên bản mới – Một người trẻ muốn trở thành Nhà văn – người viết những câu chuyện sinh ra từ tưởng tượng, lãng mạn hơn và cũng phức tạp hơn. 
Các nhân vật trong Hai-mươi-bảy không xác định giới tính, không có tên riêng. Chỉ có tuổi (27) hoặc nghề nghiệp vì đó là bối cảnh cho những mâu thuẫn phát sinh. Có rất ít hội thoại giữa các nhân vật, đa số là nhân vật độc thoại, điều đó khiến những câu chuyện thêm phần kín kẽ khi luôn có nhiều hơn một lớp ý nghĩa trong đó. Cụ thể, có nhiều hình ảnh ẩn dụ, chi tiết ẩn, tình tiết hoặc câu chữ lặp lại giữa các câu chuyện. Mỗi truyện ngắn có thể đọc đơn lẻ, nhưng tồn tại kết nối ngầm giữa những câu chuyện, tạo thành những tuyến thông điệp liên-truyện. Các nhân vật có thể khác, nhưng về cơ bản họ khá giống nhau. Thoạt nhiên ta thấy có nhiều nhân vật nhưng đó hoàn toàn có thể là một nhân vật ở các giai đoạn và hành trình khác nhau. 

Cuốn sách này không mong bạn đọc sẽ học được bất kỳ điều gì, đây chỉ là những lát cắt, là phản chiếu của mỗi người đọc. Mà mỗi người khác nhau, ở những độ tuổi khác nhau, có những trải nghiệm khác nhau, sẽ nhìn nhận cuốn sách khác nhau. Giống như khi ta soi gương, mỗi người mỗi khác. Ở góc độ tác giả, Đặng Huỳnh Mai Anh mong cuốn sách này khiến mỗi người đọc vào lại thấy một lớp ý nghĩa khác nhau trong cả cuốn sách và từng truyện, mỗi người thấy những màu sắc và cảm giác khác nhau.', N'https://product.hstatic.net/1000363117/product/hai-muoi-bay-1_ca2bba9b3877474d950edf9e2bc2421b_master.jpg', NULL, 9)
INSERT [dbo].[Book] ([ID], [Name], [Price], [Category_ID], [Sale], [Content], [Image], [Author], [Count]) VALUES (N'CK14      ', N'HÁN SỞ DIỄN NGHĨA - SÁCH CÓ CHỮ KÝ ', 190, N'CK        ', 0, N'Hán Sở diễn nghĩa (tên gốc Tây Hán diễn nghĩa) là trước tác của Chung Sơn cư sỹ Chân Vĩ, vốn quen thuộc với độc giả Việt Nam qua cái tên Hán Sở tranh hùng. Lần này, qua bản dịch mới mẻ và đầy đủ 101 hồi của dịch giả Châu Hải Đường, một lần nữa quá khứ bi hùng về cuộc chiến giữa Lưu Bang và Hạng Vũ cách đây hơn hai nghìn năm lại như sống dậy trước mắt độc giả. Qua ngòi bút kiệt xuất của tác giả, ta thấy cái tài của người làm tướng quyết thắng ngoài nghìn dặm, cái trung của kẻ làm tôi hy sinh cứu chúa, cái dũng của tướng sỹ công thành hạ địch, cái mưu của kẻ sỹ quy phục chư hầu. Hòa mình vào Hán Sở diễn nghĩa, ta còn khắc khoải với những thành bại được mất tự nghìn xưa, hào hứng theo giấc mộng đồ vương định bá, và cũng xót xa cho thân phận chinh nhân trong những trận chiến một mất một còn. Bi và hùng đan xen hoà lẫn, Hán Sở diễn nghĩa đã tạo nên một thiên anh hùng ca rất riêng. 
 
“Tiết thu tháng chín chừ, bốn phía mờ sương. 
 
Trời cao nước khô chừ, cái nhạn bi thương. 
 
Lính thú khổ thay chừ, ngày đêm bàng hoàng. 
 
Mặc giáp cầm gươm chừ, xương trắng gò hoang.” 
 
Thông tin tác giả: 
 
Chân Vĩ là một văn nhân của đất Kim Lăng, Trung Quốc, sống dưới thời Vạn Lịch (1572 – 1620). Người đời sau chỉ biết đến ông qua trước tác Hán Sở diễn nghĩa, còn cuộc đời và hành trạng của ông đến nay vẫn còn là một ẩn số. 
 
Hán Sở diễn nghĩa thuật lại cuộc tranh hùng trục lộc giữa Hán và Sở – hai thế lực mạnh nhất sau khi nhà Tần sụp đổ. Không đơn thuần là kể lại lịch sử, tác phẩm đã đạt đến “trong văn có sử”, văn và sử tương hỗ nhau một cách nhuần nhuyễn; các nhân vật cũng được đắp thịt thổi hồn với những nét tính cách riêng hết sức sống động. Nhờ vậy, từ khi ra đời cho đến nay, Hán Sở diễn nghĩa luôn được độc giả yêu thích dòng văn “diễn nghĩa” đón nhận nồng nhiệt.', N'https://product.hstatic.net/1000363117/product/untitled-1_378b746a19504c25b1ac16ae3dbd7c1d_master_06550e5c93f9448f94277362d12061ad_master.jpg', NULL, 7)
INSERT [dbo].[Book] ([ID], [Name], [Price], [Category_ID], [Sale], [Content], [Image], [Author], [Count]) VALUES (N'CK15      ', N'HÁN SỞ DIỄN NGHĨA LIÊN HOÀN HỌA - SÁCH CÓ CHỮ KÝ ', 192, N'CK        ', 0, N'Tác phẩm Hán Sở diễn nghĩa của Chân Vĩ hẳn đã rất quen thuộc với nhiều thế hệ bạn đọc Việt Nam qua cái tên Hán Sở tranh hùng. Nay nhằm mang lại phong vị mới cho tác phẩm kinh điển này, Đông A ấn hành bộ Hán Sở diễn nghĩa liên hoàn họa. Với lời văn ngắn gọn, đúc kết những tinh túy từ nguyên tác, bộ truyện đưa độc giả trở về thời Tần mạt, chứng kiến cuộc tranh hùng trục lộc một mất một còn giữa Hạng Vũ và Lưu Bang. Qua những nét vẽ tỉ mỉ, sinh động trong 875 bức tranh của các họa sỹ danh tiếng Trung Quốc, độc giả không chỉ “đọc truyện” mà còn được “xem truyện”, “thưởng truyện”, gặp gỡ nhân vật có dáng có hình, dự khán tình tiết mười phần sống động. Hy vọng Hán Sở diễn nghĩa liên hoàn họa sẽ mang đến cho bạn đọc những trải nghiệm thú vị khi khám phá lịch sử qua ngôn ngữ hội họa.', N'https://product.hstatic.net/1000363117/product/ecacb12cf9021f5c4613_e101310b007641c2ac2d106953daab97_master_d43a86f161eb4a9480acaa1994b8d669_master.jpg', NULL, 4)
INSERT [dbo].[Book] ([ID], [Name], [Price], [Category_ID], [Sale], [Content], [Image], [Author], [Count]) VALUES (N'CK16      ', N'HÔM NAY MÌNH CHỈ VUI THÔI CÓ ĐƯỢC KHÔNG - SÁCH CÓ CHỮ KÝ ', 110, N'CK        ', 0, N'"Hôm nay mình chỉ vui thôi có được không" là quan sát, suy tư và chiêm nghiệm của một cô gái 23 tuổi lúc cô ấy viết sách, về thế giới không ngừng chuyển động xung quanh. Cô ấy cũng loay hoay với mớ tự do to đùng mình có. Và vì tự do đi kèm trách nhiệm, chúng ta không thể làm bất cứ điều gì mà không suy tư chút nào. Và cô ấy ở đây, để suy tư cùng bạn. Bất cứ đồ vật gì bạn mua hay được tặng cũng đi kèm hướng dẫn sử dụng. Vậy mà cuộc sống lại không có hướng dẫn sử dụng. Nhưng tại sao khi bạn được trao tặng cuộc sống, bạn lại dám sống? Không có hướng dẫn sử dụng chính xác tuyệt đối, đó là lí do luôn luôn ta phải dành một góc để suy tư về việc mình đang sử dụng nó. La bàn nằm trong tâm trí và trái tim bạn.', N'https://product.hstatic.net/1000363117/product/c75d4c1f22142438470f2d1adfa235d6_3d4ef9793a43498ab0f5a9979aa25011_master.jpg', NULL, 3)
INSERT [dbo].[Book] ([ID], [Name], [Price], [Category_ID], [Sale], [Content], [Image], [Author], [Count]) VALUES (N'CK17      ', N'HƯỚNG NÀO HÀ NỘI CŨNG SÔNG - SÁCH CÓ CHỮ KÝ ', 72, N'CK        ', 0, N'Cuốn tiểu luận của Hồ Anh Thái viết về đô thị và Hà Nội, ghi nhận lại những gì Hà Nội có và mới có, đã có, đang và đã mất, qua nhân vật trung tâm là con người - người ở Hà Nội. Những câu chuyển kể được nhìn bằng con mắt khe khắt, nhưng đầy lo lắng, cũng là cái tình của anh đối với một chốn mà mình yêu thương: cần phải thế nào để có thể yên tâm và tự hào. 

Tác giả cố gắng giải mã những sự kiện nghe như chuyện lạ, cũng như đưa ra cách hiểu về cuộc đời và con người. Tuy nhiên, cuộc sống hiện đại và tính cách người ở Hà Nội hiện diện như thế nào từ góc nhìn của nhà văn, đặc biệt là một nhà ngoại giao, nhà nghiên cứu văn hóa đã từng trải qua nhiều bối cảnh sống: chiến tranh, bao cấp, hòa bình, đổi mới, nông thôn và thành phố, trong nước và năm châu, đọc cuốn sách này sẽ thấy, một cách trào lộng nhưng thâm thúy, và hơn thế, là những phân tích một cách tỉ mỉ sau cái nhìn bao quát. Không như lời phê phán, xoi mói, mà thành là một bài học nhẹ nhàng nhanh nhớ khó quên. 

Tác giả đã chọn điểm nhìn so sánh giữa đất nước, con người, đô thị, người quản lý với những gì là chuẩn mực bấy lâu - được gọi là nền nã truyền thống, và cái tự do thực dụng trong khuôn khổ của một thế giới phẳng. Một so sánh tưởng chừng cũ kỹ, nhưng mở ra được rõ ràng, sắc nét đâu là nét văn hóa cần có của một con người, và rộng hơn, của một xã hội người. Tri thức, cách xử sự với nhau, đạo đức ở đời với nhau, và với công việc. 

Cuốn sách còn có thể coi như một ghi chép đặc biệt chuyện của một thời, vốn được viết từ năm 2008, in lần đầu 2009, nhưng cho đến nay vẫn còn nguyên cảnh báo, như mới. ', N'https://product.hstatic.net/1000363117/product/upload_696b3c2af8fd4353ba6f84df53a09b76_master.jpg', NULL, 5)
INSERT [dbo].[Book] ([ID], [Name], [Price], [Category_ID], [Sale], [Content], [Image], [Author], [Count]) VALUES (N'CK18      ', N'KHÔNG AI QUA SÔNG - SÁCH CÓ CHỮ KÝ ', 80, N'CK        ', 0, N'Không ai qua sông - Tập truyện ngắn mới nhất của Nguyễn Ngọc Tư gợi bạn đọc nhớ đến đến truyện dài Cánh đồng bất tận đã từng gây xôn xao trên văn đàn một thời gian dài. Cũng lấy cảm hứng từ cuộc sống của người dân nông thôn miền Tây, nhưng giờ đây nhân vật của NNT có cái trăn trở của một vùng đất đã dần bị đô thị hóa, con người phải thích ứng với những thứ nhân danh cuộc sống hiện đại nhưng có thể phá nát những rường mối gia đình. 

Đặc biệt, truyện vừa Đất dữ dội và khốc liệt, ngồn ngộn hiện thực cuộc sống, có mất mát, có phản bội, có đắng cay…', N'https://product.hstatic.net/1000363117/product/untitled-1_ea39a0424cdb4b3b8820882bbe197b05_master.png', NULL, 4)
INSERT [dbo].[Book] ([ID], [Name], [Price], [Category_ID], [Sale], [Content], [Image], [Author], [Count]) VALUES (N'CK19      ', N'LẠ LÙNG SAO, ĐỚN ĐAU NÀY - SÁCH CÓ CHỮ KÝ ', 79, N'CK        ', 0, N'Về tác phẩm: Ngày xưa, mỗi khi ngâm nga một câu chuyện, bài thơ, người thi sĩ sẽ bắt đầu bằng lời ơn đến các thi thần. Vì họ tin rằng cảm hứng là món quà được các thần ban tặng. Bây giờ thì chúng ta biết rằng, chính cuộc sống bình thường, nhỏ bé này đây mới là thơ trường cho những thi sĩ đến thu hoạch. Nguyễn Thiện Ngân là một nhà thơ của đời thường như vậy. 
Thơ của Ngân là thơ về cuộc sống của người trẻ. Một cuộc sống có buồn, vui, giận, ghét, yêu thương, suy tự... bình thường như mọi cuộc sống khác. Thế nhưng thơ của Ngân lại được đón nhận, như thể Ngân rót xuống công chúng đúng thứ nước người ta đang khát uống. Đó là vì chúng ta cần nỗi lòng của mình được cô đọng lại, thành câu thơ. Và Ngân đã làm điều đó thật tốt. Mỗi tập thơ của Ngân giống như một hộp kẹo chocolate, không phải vì ngọt ngào, mà vì khó đoán. Bạn đọc giở ra bất kỳ một trang nào đó, đọc chậm vài câu ngân viết, như chọn một viên kẹo đa-vị, rồi bỗng thấy nhớ, thấy buồn, thấy ấm áp hay tủi thân... và bỗng thấy tâm hồn mình mềm lại. Cây đời lúc nào cũng xanh tươi, và mỗi ngày luôn có những người trẻ mới. Có lẽ vậy mà thơ của Ngân luôn được đón nhận và tái bản nhiều lần. 
Lạ Lùng Sao, Đớn Đau Này sử dụng bìa là tranh vẽ của hoạ sĩ Ngô Thiên Hương, một khu rừng màu lam. Rừng lam tạo nên bằng thơ, chờ người đọc dạo bước vào, và tìm thấy những cái cây cảm xúc của chính mình trong đó. 

 
VẪN MUỐN CẦM BÀN TAY ẤY VÀ Mơ (Lạ lùng sao, đớn đau này) 
Trăng trên biển soi thấu lòng cát sỏi 
Mây đêm xa mài miệt cuộc giang hồ 
Dẫu biết chứ chuyện đời đầu tính được 
Vẫn muốn cầm bàn tay ấy và mơ 
Biết có cùng qua nọ núi kia sông 
Biết có thể nào chia hết mùa trăng ấy 
Biết có còn nhau khi sớm mai thức dậy 
Hay ta sẽ quên nhau như nhiều phen đã dặn lòng phải nhớ trong đời. 
Ta vẫn muốn nhớ người 
Sau muôn đệm sâu nữa 
Ta muốn nhớ người khi tơ tóc rồi phai 
Ta muốn nhớ người dẫu qua tháng năm dài 
Chúng ta đều chẳng còn là nhau của thời ước mơ nào cũng lung linh, khoảng trời nào cũng chật chội 
Mắt xa vắng kể nhau nghe chuyện mới. 
Ta vẫn muốn nhớ người dẫu tan nát rồi đây. 

 
 5 lý do để mua thơ của Ngân: 
1. Thơ nhẹ, chữ thưa, nhưng vẫn đậm đặc khả năng khơi gợi cảm xúc từ người đọc. 
2. Không mất nhiều thời gian để đọc, rồi sẽ có thật nhiều thời gian để suy ngẫm. 
3. Cách dùng từ độc đáo, như sự giao du giữa ngôn từ hiện đại và vốn ca dao tục ngữ xưa xa. 
4. Bìa mới, thiết kế mới, tôn lên nội dung và mọi bức hình mà bạn sẽ chụp khoe lên trang cá nhân. 
5. Hãy tặng cho ai đó thơ của Ngân - nếu bạn thương quý người đó. Vì khi đọc, họ sẽ thấy mềm lòng. ', N'https://product.hstatic.net/1000363117/product/bia-lls-2d_28492b91f34e4a218bb89c60676505d9_master.jpg', NULL, 6)
INSERT [dbo].[Book] ([ID], [Name], [Price], [Category_ID], [Sale], [Content], [Image], [Author], [Count]) VALUES (N'CK20      ', N'MÙA HÈ NĂM ẤY - SÁCH CÓ CHỮ KÝ ', 90, N'CK        ', 0, N'“Mỗi chúng ta đều có những mùa hè, mà sau đó, mình thay đổi” 

Câu chuyện xuyên suốt trong quyển sách là hành trình nói về những trải nghiệm khám phá bản thân của tác giả Mai Anh qua chương trình trao đổi văn hóa diễn ra trong năm tuần ở Mỹ. Chuyến đi trong “Mùa Hè Năm Ấy” cũng chính là bối cảnh để Mai Anh kể về những câu chuyện bình dị như: về tình bạn, về gia đình, về những đố kỵ nho nhỏ, về chút tủi thân khi thấy mình kém cỏi, về sự ngần ngừ phải bước khỏi “vòng an toàn”, cả một chút trẻ con và sự ích kỷ...Để cuối cùng, bài học lớn nhất chính là: biết mình thật nhỏ bé, biết mình cần thôi tỏ ra “tôi là người đặc biệt”, chịu lắng nghe và học hỏi nhiều hơn. Cái tên "Mùa hè năm ấy" sẽ khiến nhiều người chờ đợi những cuộc phiêu lưu sôi nổi kịch tính, thế nhưng, không khí chủ đạo lại là sự bình yên từ tình bạn, từ một cuộc điện thoại đường dài, từ những lúc đạp xe một mình, từ những lần hội ngộ. Những điều nhỏ bé âm thầm xoa dịu Mai Anh sau những phút lạc lõng đi tìm mình mà vẫn đó những hoài nghi khi chưa biết mình muốn trở thành ai, mang giá trị gì và sẽ thuộc về đâu? 

Người trẻ nào cũng có những phút chông chênh khi họ đứng trước bước ngoặt phải lớn lên, khi họ không thể cứ mãi là đứa trẻ nữa, khi họ phải chọn một "kiểu người lớn" họ sẽ trở thành. Được viết năm 2013, cuốn sách là câu chuyện kể về chuyến hành trình của tác giả khi tham gia chương trình Sáng kiến Thủ lĩnh trẻ Đông Nam Á - Young Southeast Asian Leaders Initiative (YSEALI) do chính phủ Mỹ tài trợ. Đây là hoạt động thường niên được tổng thống Barack Obama khởi xướng nhằm tăng cường phát triển năng lực lãnh đạo và kết nối trong khu vực Đông Nam Á. Đặng Huỳnh Mai Anh là một trong những đại diện đầu tiên của Việt Nam tham gia chương trình. Với giọng văn rất mực đời thường, Mai Anh viết về cuộc sống,như nó vốn vậy, mà ở đó chúng ta chẳng thể tùy ý sáng tạo nên những cao trào và không ngừng học cách yêu quý những điều đơn sơ đầy kỳ diệu. 

Thông tin tác giả 

Đặng Huỳnh Mai Anh, 1992 - Đại sứ môi trường toàn cầu năm 2012. 

Đại diện của Việt Nam tham gia Hội nghị thượng đỉnh thanh niên thế giới tại Anh. 

Giám đốc Give2give - dự án đào tạo tiếng Anh cho các tình nguyện viên công tác xã hội do Chính phủ Mỹ cấp vốn. 

Tốt nghiệp thủ khoa cả hai chương trình đào tạo Thạc sĩ:Chương trình Chính sách kinh tế tại Trường ĐH Westminster, London (học bổng toàn phần của nhà trường) và chương trình Kinh tế học tại Toulouse School of Economics (Học bổng Eiffel của chính phủ Pháp). 

Công việc hiện tại: Nhà khoa học dữ liệu (Data Scientist). ', N'https://product.hstatic.net/1000363117/product/muahenamnay1_2a35e7cb016348769746a5c0c40e57eb_master.jpg', NULL, 3)
INSERT [dbo].[Book] ([ID], [Name], [Price], [Category_ID], [Sale], [Content], [Image], [Author], [Count]) VALUES (N'CK21      ', N'NHẮM MẮT THẤY PARIS - SÁCH CÓ CHỮ KÝ ', 90, N'CK        ', 0, N'Tiểu thuyết "Nhắm mắt thấy Paris" của nhà văn Dương Thụy là "một thiên tình ái" vừa lãng đãng mơ màng với những nhân vật đẹp như trong mộng, vừa mang hơi thở rạo rực của cuộc sống đô thị hiện đại. Độc giả sẽ được du ngoạn qua nhiều thành phố châu Á và châu Âu, mà tâm điểm sẽ là một " Paris của rạng đông" đầy đủ các cung bậc cảm xúc.', N'https://product.hstatic.net/1000363117/product/copy_5_nxbtre_full_05492017_084907.u4939.d20171017.t152915.860981_29aa9e9a8fc34bbb8007b5c752a5660d_master.jpg', NULL, 1)
INSERT [dbo].[Book] ([ID], [Name], [Price], [Category_ID], [Sale], [Content], [Image], [Author], [Count]) VALUES (N'CK22      ', N'RĂNG SƯ TỬ (BÌA XANH) - SÁCH CÓ CHỮ KÝ ', 250, N'CK        ', 0, N'Cuộc chiến điệp báo – “nhân vật chính” xuyên suốt Răng sư tử – là cuộc đọ sức thầm lặng không tiếng súng giữa những cơ quan đặc biệt của các cường quốc Mỹ, Anh, Liên Xô cả trước, trong và sau Chiến tranh Lạnh – cuộc chiến kéo dài suốt sáu thập kỉ của thế kỉ 20. Chân dung cuộc chiến điệp báo sinh tử này được phác họa thông qua những con người cụ thể, những sự kiện có thật. Nhiều người trong số đó tham gia cuộc chiến vì lí tưởng, số khác vì tiền bạc hay danh vọng của những chiến binh đủ sức một mình làm xoay chuyển thế giới. Nhiều người thoát chết trong đường tơ kẽ tóc và cũng có kẻ mãi mãi bị chôn vùi dưới lớp bụi dày của những bí mật thế kỉ. Dù thế nào thì tất cả họ đều cùng tạo nên những mảnh ghép then chốt góp phần làm thay đổi cả dòng chảy lịch sử, định hình diện mạo mới của thế giới trong một thời kì lịch sử biến động dữ dội. 
Thông tin tác giả: Nhà báo Yên Ba sinh năm 1962, làm báo từ năm 1990, chuyên theo dõi mảng thể thao và đời sống quốc tế. 
Các tác phẩm đã xuất bản: 
- Từ Espana 82 đến France 98: Nhìn lại và chờ đợi (sách thể thao) 
- Từ Pele đến Maradona (sách thể thao) 
- Vụ đánh cắp thế kỷ (tập truyện trinh thám chính trị quốc tế, biên soạn) 
- Thoát khỏi CIA (tiểu thuyết trinh thám chính trị, dịch) 
- Điệp viên ở Washington (tiểu thuyết trinh thám chính trị, dịch) 
- Những mảnh ký ức (tập bút ký) ', N'https://product.hstatic.net/1000363117/product/xanh_duong_cc_c1e0ff5fd70c4b4689aa80fd8e34ce06_master.jpg', NULL, 4)
INSERT [dbo].[Book] ([ID], [Name], [Price], [Category_ID], [Sale], [Content], [Image], [Author], [Count]) VALUES (N'CK23      ', N'TẨY ĐỘC BẾP - VÌ KHÔNG THỂ SỐNG MÀ KHÔNG ĂN GÌ - SÁCH CÓ CHỮ KÝ ', 180, N'CK        ', 0, N'Cùng tác giả của cuốn sách bán chạy "Ăn gì cho không độc hại". 

Mỗi món ngon ra đời là kết quả của cả quá trình đằng sau - không đơn thuần là kỹ thuật nấu nướng mà là chuyện về muối đường tương mắm, các dụng cụ, nồi niêu, bếp nấu… Một khi nắm rõ các vấn đề, các khía cạnh của bếp, chúng ta sẽ biết lý do đằng sau mỗi món ngon và món chưa ngon. Chúng ta sẽ hiểu sức mình làm việc bếp núc tới đâu là vừa. Chúng ta cũng sẽ biết, trong ma trận những nội dung quảng cáo, chia sẻ về những thứ “cần có trong gian bếp của bạn”, cái gì thực sự cần thiết, phù hợp với điều kiện, hoàn cảnh mỗi người và tốt cho sức khỏe, cái gì đã bị thổi phồng về công năng, tác dụng. Từ đó, mỗi người có thể bắt đầu quá trình detox (tẩy độc) cho gian bếp, từ nồi niêu, dụng cụ đến gia vị, để có một gian bếp sạch theo cả nghĩa đen lẫn nghĩa bóng. 
  
Nếu "Ăn gì cho không độc hại" là hành trình “học ăn”, "Tẩy độc bếp: Vì không thể sống mà không ăn gì" là bước đầu của hành trình “học nấu” một các tường tận, nghiêm túc, bắt đầu từ việc hiểu về bếp. 

Tác giả Pha Lê tốt nghiệp trường ẩm thực danh tiếng Le Cordon Bleu (Vương quốc Anh), hiện là cây bút ẩm thực - văn hóa chủ lực của soi.today và Tuổi Trẻ Cuối Tuần. ', N'https://product.hstatic.net/1000363117/product/image_195509_1_33774_15cf13a9305849cb8eb3ff0653d45815_master.jpg', NULL, 8)
INSERT [dbo].[Book] ([ID], [Name], [Price], [Category_ID], [Sale], [Content], [Image], [Author], [Count]) VALUES (N'CK24      ', N'THIỆN, ÁC VÀ SMARTPHONE - SÁCH CÓ CHỮ KÝ ', 105, N'CK        ', 0, N'Có lẽ chúng ta đang chứng kiến sự phục sinh đáng kinh ngạc của hiện tượng làm nhục công cộng, khi trong thời đại của Internet, chưa bao giờ con người lại bị lăng nhục nhanh, nhiều và dễ dàng đến thế! Những câu chuyện thời sự nóng bỏng trong Thiện, Ác và Smartphone của Đặng Hoàng Giang đã phác họa sắc nét bức chân dung của văn hóa làm nhục thời mạng xã hội, với toàn bộ sự xấu xí và sức phá hủy của nó. Cùng những phân tích thấu đáo buộc chúng ta phải đối diện chính bản thân mình, và giật mình nhận ra đôi khi bản thân cũng đang góp phần tạo ra bức tranh chung đó… 
 
Không dừng lại ở đó, tác giả tìm ra con đường thoát bằng sức mạnh của sự điềm tĩnh, vững vàng và trắc ẩn. Để ý thức rằng đằng sau những avatar ảo là con người thật, rằng mỗi nút like có thể là một ngọn roi góp vào cuộc hành hình tập thể. Để phê bình mà không mạt sát, lên án nhưng không lăng nhục. Để trong khi thượng tôn pháp luật vẫn trân trọng nhân phẩm con người. Để thấu cảm, khoan dung và tha thứ. Để hướng tới một xã hội của công lý, phục hồi và hàn gắn, thay vì của trừng phạt tàn khốc. 
 
Giàu chất thời sự nhưng mang ý nghĩa vững bền, chạm tới từng góc khuất trong tâm can mỗi người nhưng đồng thời bao quát cả xã hội, cuốn sách mang tính xây dựng và tinh thần nhân văn sâu sắc. 
 
Hãy đặt smartphone  xuống và đọc cuốn sách này! ', N'https://product.hstatic.net/1000363117/product/upload_32880287e5464531b9e2864dc505266d_master.jpg', NULL, 4)
INSERT [dbo].[Book] ([ID], [Name], [Price], [Category_ID], [Sale], [Content], [Image], [Author], [Count]) VALUES (N'CK25      ', N'TIẾNG KIỀU ĐỒNG VỌNG - SÁCH CÓ CHỮ KÝ ', 98, N'CK        ', 0, N'TIẾNG KIỀU ĐỒNG VỌNG là hành trình tìm lại bản ngã của một cô gái trẻ luôn bị mắc kẹt trong những câu hỏi thuộc về quá khứ. Có lẽ, khi người ta bắt đầu học cách đưa ra câu trả lời cho những nghi vấn trớ trêu mà số phận đặt ra, dù tiếng vọng cuối cùng chưa hẳn là một đáp án tiệm cận nhất với sự thật thì rốt cuộc, ta cũng dần tiến đến sự trưởng thành bản ngã - thời khắc cái tôi cá nhân phải tự phá vỡ vỏ trứng bảo bọc an toàn tưởng chừng vững chắc như một thành trì nhưng hóa ra lại chỉ mong manh như một làn sương dệt từ những mơ hồ bất quyết. Chỉ khi thành trì ấy sụp đổ, làn sương ấy lùi lại phía sau con người vừa bước ra từ sự tổn thương, chính khi ấy ta mới có thể nhìn rõ hơn thế giới với trọn vẹn hương sắc của nó. ', N'https://product.hstatic.net/1000363117/product/tai_xuong.jpg_2a761d6f07a5402a9d8cf0bc75a33b5f_master.png', NULL, 2)
INSERT [dbo].[Book] ([ID], [Name], [Price], [Category_ID], [Sale], [Content], [Image], [Author], [Count]) VALUES (N'CK26      ', N'TIỂU THUYẾT SÔNG (NGUYỄN NGỌC TƯ) - SÁCH CÓ CHỮ KÝ ', 99, N'CK        ', 0, N'Đây là tiểu thuyết đầu tay của nhà văn Nguyễn Ngọc Tư với sự đổi mới toàn diện của chính cô. Đẹp. Đáo để. Trần tục và hư ảo. Truyện kết thúc bằng dấu chấm hỏi về số phận một con người - Không hề do dự, cô đã đẩy mầm ý tưởng vừa nhú lên sang tay người đọc, để họ nuôi dưỡng chúng, bằng trải nghiệm qua việc đọc cuốn sách này. 

" Sài Gòn. Sáng nay ở đó Tú dậy, đánh răng rồi chở vợ ra đường, họ có thể cùng ăn sáng trước khi đến cơ quan. Sáng nay ở đó Hậu, Bách, Cường tiểu thơ vẫn còn nằm ngầy ngật trong hơi men vì nhậu nhẹt khuya. Sáng nay mẹ cậu mặc quần lửng, giày thể thao, đá cầu ở công viên xong thì xõa tóc ngồi quán cà phê với một trong những người đàn ông của bà, cũng có thể là cha cậu. 

Sáng nay cậu cùng một người không thể gọi là lạ, cũng không thể nói đã quá biết nhau, đi xuyên qua những cánh rừng tinh linh đi tìm những khe suối nằm đâu đó giữa những vách đá. Hai thằng người bụi bặm và trông hơi tàn tạ… 

Khi mặt trời biến hai cái bóng thành vũng tối dưới chân, bọn cậu đã tận mắt nhìn thấy một vài cái khe nhỏ nước chảy cùng một thứ rêu óng biếc. Hứng mãi nước mới đầy một vốc tay, cậu không thể hình dung có bao nhiêu dòng chảy re rắt như vầy để làm tràn đầy hồ Thiên, khiến nó không khô cạn dù bất cứ mùa nắng hạn nào. Cậu xòe những ngón tay chắn giữa khe, thấy nước ẩn nhẩn lách qua, nhỏ nhắn và xanh xao như một hồn ma sầu muộn. Không thể tin được những nhánh nước rủ rỉ này lại làm nên dòng chảy hàng ngàn dặm của sông D"', N'https://product.hstatic.net/1000363117/product/f728e9656cadba38713628f51804a425_e886d1bb580044f4a4e55ff86b4533c9_master.jpg', NULL, 3)
INSERT [dbo].[Book] ([ID], [Name], [Price], [Category_ID], [Sale], [Content], [Image], [Author], [Count]) VALUES (N'CK27      ', N'TÌM MÌNH TRONG THẾ GIỚI HẬU TUỔI THƠ - SÁCH CÓ CHỮ KÝ ', 142, N'CK        ', 0, N'Tìm mình trong thế giới hậu tuổi thơ dẫn người đọc vào thế giới của người trẻ trên dưới hai mươi tuổi, lứa tuổi không còn trẻ con, nhưng cũng chưa thực sự là người lớn. Trong thế giới đó có những run rẩy của va chạm thân thể lần đầu, có lấp lánh của tình yêu, có những đêm dài, những chuyến đi xa, những hoang mang và băn khoăn hiện sinh. Nhưng bao trùm lên tất cả, như một tấm màn lớn, là nỗi đau. Nỗi đau từ sự cô đơn của đứa con vẫn được xã hội khen là “trưởng thành” và “ngoan,” từ sự trống rỗng nội tâm của đứa trẻ lớn lên trong một gia đình lạnh lẽo, từ sự tuyệt vọng của người trẻ bị giam cầm trong nhà tù mang tên tình yêu cha mẹ. 
 Vang lên như những bài hát khi buồn đau khi dữ dội, những chân dung trong cuốn sách cùng các phân tích tâm lý học của tác giả sẽ khiến cha mẹ, thầy cô và tất cả những ai có người trẻ trong cuộc sống của mình phải thức tỉnh, phải ngồi xuống lắng nghe con em mình và suy ngẫm về bản thân, để học cách chữa lành và yêu thương đích thực. ', N'https://product.hstatic.net/1000363117/product/tim-minh-trong-the-gioi-hau-tuoi-tho-01_2cc876fbcf2d4a78bd6b725a40899a9d_master.jpg', NULL, 5)
INSERT [dbo].[Book] ([ID], [Name], [Price], [Category_ID], [Sale], [Content], [Image], [Author], [Count]) VALUES (N'CK28      ', N'TUỔI 20 TÔI ĐÃ SỐNG NHƯ MỘT BÔNG HOA DẠI - SÁCH CÓ CHỮ KÝ ', 82, N'CK        ', 0, N'Tác giả, một cô gái đang trong độ tuổi 20, đang nói hộ chúng ta rất nhiều điều ta không diễn đạt được bằng lời. 

"Bố mẹ không hỏi các con đi học vui không, chỉ hỏi điểm cao Bố mẹ không hỏi đi làm vui không, mệt không, chỉ hỏi lương cao không, công ty to không. Kết hôn không hỏi có yêu nhau không, mà hỏi có hợp năm tuổi không, chúc mừng sale-off tuổi xuân thành công. Ly dị không ai hỏi vì sao không sống cùng nhau nữa, chỉ hỏi định nhìn mặt mẹ cha xóm giềng thế nào. Đâu phải đến lúc đi làm bạn mới sợ thứ Hai, bạn sợ thứ hai từ lúc đi học cơ mà. Hóa ra chúng ta vẫn là những đứa trẻ đi dưới sân trường, chỉ vì tiếng trống mà chạy đua náo loạn trong sợ hãi. Tiếng trống tuổi 25, tiếng trống tuổi 30, chưa gióng lên mà ta đã sợ hãi lao đi rồi. Người ta nói kẻ dùng trái tim là yếu đuối, thực ra chỉ kẻ mạnh mới dám dùng thôi.', N'https://product.hstatic.net/1000363117/product/tuoi-20-toi-da-song-nhu-mot-bong-hoa-dai_631efc4dab944670b1d4b1bbb6ce0994_master.jpeg', NULL, 1)
INSERT [dbo].[Book] ([ID], [Name], [Price], [Category_ID], [Sale], [Content], [Image], [Author], [Count]) VALUES (N'CK29      ', N'VENISE VÀ NHỮNG CUỘC TÌNH GONDOLA - SÁCH CÓ CHỮ KÝ ', 118, N'CK        ', 0, N'Với tinh thần truyền cho những bạn trẻ niềm đam mê học hỏi, tính xốc vác, thú chu du qua những “ghi chép ngoài truyện”, Venise và những cuộc tình Gondola sẽ mang đến cho độc giả câu chuyện rất thật và cũng rất lý thú của chính tác giả. Từ những hiểu biết về Paris qua những trang sách báo đến khao khát cháy bỏng được một lần đặt chân đến Paris… đến những nỗ lực phấn đấu không ngừng để trở thành “dân Paris”, những cảm xúc vui buồn về cuộc sống ở kinh thành ánh sáng… Tất cả đều được Dương Thụy kể lại qua những dòng ký sự mượt mà sâu lắng và tràn đầy nhiệt huyết của một người trẻ dấn thân ở xứ người. ', N'https://product.hstatic.net/1000363117/product/image_186045_bdafd77ca4f247ceae6e2e52c1c5c4cb_master.jpg', NULL, 3)
INSERT [dbo].[Book] ([ID], [Name], [Price], [Category_ID], [Sale], [Content], [Image], [Author], [Count]) VALUES (N'TN01      ', N'THƠ HAY VIẾT CHO THIẾU NHI - CÁC NHÀ TOÁN HỌC CỦA MÙA XUÂN', 60, N'TN        ', 10, N'Học toán xong rồi nghiên cứu toán 

Rồi đi dạy toán chục năm ròng 

Năm mươi tuổi bỗng thành nhà-thơ-trẻ 

Chuyên làm thơ cho lứa tuổi nhi đồng 

Đó là những lời thơ vui mà nhà thơ Đặng Hấn viết rất chính xác về mình. Làm thơ bằng tư duy của một phó giáo sư toán học, nên thơ ông luôn có niêm luật chặt chẽ, cấu tứ hoàn chỉnh, hóm hỉnh tươi vui, những phép cộng trừ nhân chia cũng làm thành mùa xuân. ', N'https://product.hstatic.net/1000363117/product/tho-hay-viet-cho-thieu-nhi_cac-nha-toan-hoc-mua-xuan_bia_bfd47335fa3f47fb933444a016af777a_master.jpg', NULL, 2)
INSERT [dbo].[Book] ([ID], [Name], [Price], [Category_ID], [Sale], [Content], [Image], [Author], [Count]) VALUES (N'TN02      ', N'TRẢ LẠI NỤ CƯỜI', 45, N'TN        ', 10, N'Thế kỉ 19, ở vùng đất của rất nhiều truyền thuyết Arizona, cô bé mười tuổi Oklahoma đã gặp phải một phù thủy da đỏ. Người ta gọi ông là “kẻ cắp niềm vui”, chuyên lấy đi nụ cười của trẻ em. Ông ta hứa rằng sẽ trả lại cho cô bé khi cô đã lớn, và Oklahoma đồng ý. 

Liệu nụ cười có trở lại với Oklahoma bé bỏng, hay cô đã bị vị phù thủy bí ẩn lừa dối và mất chúng vĩnh viễn?', N'https://product.hstatic.net/1000363117/product/tra-lai-nu-cuoi_bia_505173b221ea428fadd95a9c1ae23744_master.jpg', NULL, 5)
INSERT [dbo].[Book] ([ID], [Name], [Price], [Category_ID], [Sale], [Content], [Image], [Author], [Count]) VALUES (N'TN03      ', N'KỊCH! KỊCH! KỊCH!', 55, N'TN        ', 10, N'Khu trọ vừa có thêm hàng xóm mới là Chị Gà Mái. Nhà chị ở ngay sát vách nhà anh Vịt Bầu. Ấy thế mà Chị Gà Mái lại suốt ngày đục tường: “Kịch! Kịch! Kịch!” ồn ào quá đi! Phải làm thế nào để nói với Chị Gà Mái ngừng đục tường mà không làm mất lòng chị bây giờ? 

Cuốn sách có nội dung độc đáo, mới lạ với phần minh hoạ rực rỡ, tác động tới thị giác. 

“Kịch! Kịch! Kịch!” dành giải thường cho Sách hư cấu trong Hội sách thiếu nhi Bologna 2023.', N'https://product.hstatic.net/1000363117/product/kich-kich-kich_bia_4be316be7dac49668297ecf71b79ce8d_master.jpg', NULL, 1)
INSERT [dbo].[Book] ([ID], [Name], [Price], [Category_ID], [Sale], [Content], [Image], [Author], [Count]) VALUES (N'TN04      ', N'CHIẾC HỘP BÁU VẬT', 50, N'TN        ', 10, N'Cô bé trong truyện vô cùng yêu thích việc tìm kiếm kho báu cùng ông ngoại. Chiếc hộp kho báu ấy chính là bí mật giữa cô và ông… Kể từ khi ông mất, chiếc hộp ấy đã không còn được mở ra. Cho đến một ngày nọ, bà ngoại đã mang đến cho cô bé một số báu vật mà ông ngoại để lại cho cô… 
Câu chuyện sâu sắc với minh họa tuyệt đẹp này tôn vinh mối liên kết đặc biệt giữa mỗi đứa trẻ với ông bà, ngay cả sau khi họ đã qua đời. 
Tranh minh họa cho cuốn sách “Chiếc hộp báu vật” của họa sĩ Rahele Jomepour Bell được chọn trưng bày trong Triển lãm Họa sĩ Minh họa lần thứ 57 tại Hội chợ Sách Thiếu nhi Quốc tế Bologna.', N'https://product.hstatic.net/1000363117/product/thiet_ke_chua_co_ten__80__a79c2deb945e45009d91002068916ad9_master.jpg', NULL, 2)
INSERT [dbo].[Book] ([ID], [Name], [Price], [Category_ID], [Sale], [Content], [Image], [Author], [Count]) VALUES (N'TN05      ', N'TRÍ TUỆ CỔ XƯA - TRƯỞNG THÀNH CÙNG BẠN - ĐẠO LÝ CỦA NGƯỜI XƯA', 58, N'TN        ', 10, N'Bộ sách "Trí tuệ cổ xưa cùng bạn trưởng thành" hướng đến Chân - Thiện - Mỹ của con người mà chúng tôi muốn giới thiệu cho bạn đọc, với mong muốn là kim chỉ nam cho bạn đọc nhỏ tuổi trên con đường hoàn thiện nhân cách của bản thân.', N'https://product.hstatic.net/1000363117/product/9786044727578_4f1eabd10faf403e80aa4f42b559e8dd_master.jpg', NULL, 3)
INSERT [dbo].[Book] ([ID], [Name], [Price], [Category_ID], [Sale], [Content], [Image], [Author], [Count]) VALUES (N'TN06      ', N'NHẬT KÝ CỦA PINK ', 69, N'TN        ', 10, N'“Nhật ký của Pink” là tập truyện tranh gồm những mẩu chuyện hồn nhiên, với cách nhìn vừa đáng yêu, vừa mới lạ về tuổi thơ, về xe cộ, về mùa thu Hà Nội… Những điều tưởng chừng rất đời thường, hiển nhiên mà ai trong mỗi chúng ta đều đã từng trải qua, chỉ đến khi được tái hiện trên trang giấy với nét vẽ ngộ nghĩnh, đáng yêu của Pink – chúng ta mới chợt nhận ra rằng “Ồ thì ra những điều ngớ ngẩn vô cùng ấy chính là hạnh phúc!” 

“Tuổi thơ – quãng thời gian mà những người hơn ta chục tuổi tự cho mình cái quyền gọi ta là “trẻ con”… là những ngày lê la chơi ô ăn quan, đánh chắt đánh chuyền hay những chiều rong ruổi ngoài đồng…” 

Ôi những ngày tháng “ngớ ngẩn” và hạnh phúc!', N'https://product.hstatic.net/1000363117/product/nhat-ki-cua-pink_1_a146874d071c4a1ba2c5ea4bf700176e_master.jpg', NULL, 5)
INSERT [dbo].[Book] ([ID], [Name], [Price], [Category_ID], [Sale], [Content], [Image], [Author], [Count]) VALUES (N'TN07      ', N'MẶC GÌ HÔM NAY? - PHÙ HỢP VỚI HOẠT ĐỘNG ', 35, N'TN        ', 10, N'Bác đầu bếp nấu nướng thế nào nếu mặc váy múa ba-lê? 

Nghệ sĩ múa biểu diễn ra sao nếu đi giày leo núi? 

Thủy thủ mặc áo màu gì? 

Hãy đọc bộ sách Mặc gì hôm nay? để biết nên ăn mặc thế nào cho phù hợp với từng nghề nghiệp và các hoạt động thường ngày nhé! 

--- 

Một bộ sách nhỏ giới thiệu tới các em một đề tài đơn giản nhưng rất quan trọng: trang phục. Đó là những thứ ta mặc lên hàng ngày, nhưng em có chắc trang phục của mình đã phù hợp với bối cảnh hay chưa? Hãy cùng tìm hiểu về chủ đề mới lạ này trong hai cuốn sách vô cùng hấp dẫn nhé! 

Mời các em tìm đọc trọn bộ: 

Mặc gì hôm nay? - Phù hợp với nghề nghiệp 

Mặc gì hôm nay? - Phù hợp với hoạt động ', N'https://product.hstatic.net/1000363117/product/mac-gi-hom-nay_phu-hop-voi-hoat-dong_bia_e28bcddcd9e4442db897aa9e93ae88fa_master.jpg', NULL, 4)
INSERT [dbo].[Book] ([ID], [Name], [Price], [Category_ID], [Sale], [Content], [Image], [Author], [Count]) VALUES (N'TN08      ', N'MẶC GÌ HÔM NAY? - PHÙ HỢP VỚI NGHỀ NGHIỆP ', 35, N'TN        ', 10, N'Bác đầu bếp nấu nướng thế nào nếu mặc váy múa ba-lê? 

Nghệ sĩ múa biểu diễn ra sao nếu đi giày leo núi? 

Thủy thủ mặc áo màu gì? 

Hãy đọc bộ sách Mặc gì hôm nay? để biết nên ăn mặc thế nào cho phù hợp với từng nghề nghiệp và các hoạt động thường ngày nhé! 

--- 

Một bộ sách nhỏ giới thiệu tới các em một đề tài đơn giản nhưng rất quan trọng: trang phục. Đó là những thứ ta mặc lên hàng ngày, nhưng em có chắc trang phục của mình đã phù hợp với bối cảnh hay chưa? Hãy cùng tìm hiểu về chủ đề mới lạ này trong hai cuốn sách vô cùng hấp dẫn nhé! 

Mời các em tìm đọc trọn bộ: 

Mặc gì hôm nay? - Phù hợp với nghề nghiệp 

Mặc gì hôm nay? - Phù hợp với hoạt động ', N'https://product.hstatic.net/1000363117/product/mac-gi-hom-nay_phu-hop-voi-nghe-nghiep_bia_d82e2615be60450bbe12b7e36286dba8_master.jpg', NULL, 1)
INSERT [dbo].[Book] ([ID], [Name], [Price], [Category_ID], [Sale], [Content], [Image], [Author], [Count]) VALUES (N'TN09      ', N'PHÁT MINH PHI THƯỜNG - PHƯƠNG TIỆN DI CHUYỂN: TỪ BÁNH XE ĐẾN PHI THUYỀN ', 40, N'TN        ', 10, N' Tập sách Thế giới  hiện đại giới thiệu những phát minh thú vị từ lúc con người phải dùng sức người và gia súc để lao động tạo ra thực phẩm đến khi khám ra những cách thức hiện đại hơn ứng dụng vào cuộc sống, sáng tạo ra những thiết bị máy móc hiện đại giúp cuộc sống càng ngày càng đơn giản, tiện nghi hơn. Tập sách nằm trong bộ Phát minh phi thường gồm 4 tựa: Ánh sáng, Thế giới hiện đại, Phương tiện giao tiếp, Phương tiện di chuyển, giới thiệu những phát minh không ngừng nghỉ của các nhà khoa học, nhờ sự bền bỉ tìm tòi sáng tạo của họ mà cuộc sống của chúng ta đầy tiện ích và dễ dàng kết nối với thế giới.', N'https://product.hstatic.net/1000363117/product/image_195509_1_31038_e49fe366b18d4a9caea52c1393e2dbfa_master.jpg', NULL, 2)
INSERT [dbo].[Book] ([ID], [Name], [Price], [Category_ID], [Sale], [Content], [Image], [Author], [Count]) VALUES (N'TN10      ', N'BÍ MẬT CỦA MILTON ', 89, N'TN        ', 10, N'Bí mật của Milton sẽ truyền cảm hứng và giúp đỡ những trẻ em đang gặp phải những khó khăn ở trường học, ở nhà cũng như ở bất cứ nơi đâu. 

"Bí Mật Của Milton" là một cuốn truyện tranh truyền tải toàn bộ cuốn sách của tác giả Eckhart Tolle - SỨC MẠNH CỦA HIỆN TẠI giúp trẻ em có thể nhận ra thông điệp mà người lớn không dễ nhận ra. Gieo hạt giống thức tỉnh tâm linh trong trẻ. 

Dành cho phụ huynh: 

Là phụ huynh ai cũng mong muốn những điều tốt đẹp nhất cho con em mình, nhưng điều tốt đẹp nhất đứa trẻ có thể có thì không ai - không phụ huynh nào có thể trao tặng. Thứ có giá trị nhất với đứa trẻ phải do chúng khám phá ở trong chính mình. Đó chính là sự tỉnh thức. 

Eckhart Tolle vị thầy tâm linh có ảnh hưởng bậc nhất thế giới đã lan toả sự tỉnh thức đến với nhân loại thông qua các tác phẩm như: Sức Mạnh Của Hiện Tại, Đi Vào Thực Tại, Thức Tỉnh Mục Đích Sống, Những tác phẩm đó đã làm rung chuyển tâm thức nhân loại, tuy nhiên hầu hết đều là sách dành cho người lớn. Bí Mật Của Milton là một cuốn truyện tranh dành cho thiếu niên nhưng có năng lực đánh thức, năng lượng chuyển hoá tâm hồn. Cuốn sách truyền tải bí mật lớn nhất của nhân loại - bí mật về Sức mạnh của Hiện tại để trẻ có thể tiếp cận và nhận ra giá trị tâm linh tối hậu ngay trong chính mình. Đây là một điều quá đỗi diệu kỳ! 

Nếu bố mẹ là người quan tâm tới sự thức tỉnh tâm linh thì cuốn sách có thể là món quà vô giá dành cho con em mình. ', N'https://product.hstatic.net/1000363117/product/8938539539253_716b38fce50a4d2c8f5b2184ab757f8c_master.jpg', NULL, 3)
INSERT [dbo].[Book] ([ID], [Name], [Price], [Category_ID], [Sale], [Content], [Image], [Author], [Count]) VALUES (N'TN11      ', N'PHÁT MINH PHI THƯỜNG - PHƯƠNG TIỆN GIAO TIẾP: TỪ CHỮ VIẾT ĐẦU TIÊN ĐẾN INTERNET ', 40, N'TN        ', 10, N'Tập sách Thế giới hiện đại giới thiệu những phát minh thú vị từ lúc con người phải dùng sức người và gia súc để lao động tạo ra thực phẩm đến khi khám ra những cách thức hiện đại hơn ứng dụng vào cuộc sống, sáng tạo ra những thiết bị máy móc hiện đại giúp cuộc sống càng ngày càng đơn giản, tiện nghi hơn. Tập sách nằm trong bộ Phát minh phi thường gồm 4 tựa: Ánh sáng, Thế giới hiện đại, Phương tiện giao tiếp, Phương tiện di chuyển, giới thiệu những phát minh không ngừng nghỉ của các nhà khoa học, nhờ sự bền bỉ tìm tòi sáng tạo của họ mà cuộc sống của chúng ta đầy tiện ích và dễ dàng kết nối với thế giới', N'https://product.hstatic.net/1000363117/product/image_195509_1_31039_74e1d0b50262412884b9b00f4f3434a5_master.jpg', NULL, 5)
INSERT [dbo].[Book] ([ID], [Name], [Price], [Category_ID], [Sale], [Content], [Image], [Author], [Count]) VALUES (N'TN12      ', N'PHÁT MINH PHI THƯỜNG - THẾ GIỚI HIỆN ĐẠI: TỪ LƯỠI CÀY ĐẾN NGƯỜI MÁY ', 40, N'TN        ', 10, N'Tập sách Thế giới hiện đại giới thiệu những phát minh thú vị từ lúc con người phải dùng sức người và gia súc để lao động tạo ra thực phẩm đến khi khám ra những cách thức hiện đại hơn ứng dụng vào cuộc sống, sáng tạo ra những thiết bị máy móc hiện đại giúp cuộc sống càng ngày càng đơn giản, tiện nghi hơn. Tập sách nằm trong bộ Phát minh phi thường gồm 4 tựa: Ánh sáng, Thế giới hiện đại, Phương tiện giao tiếp, Phương tiện di chuyển, giới thiệu những phát minh không ngừng nghỉ của các nhà khoa học, nhờ sự bền bỉ tìm tòi sáng tạo của họ mà cuộc sống của chúng ta đầy tiện ích và dễ dàng kết nối với thế giới.', N'https://product.hstatic.net/1000363117/product/image_195509_1_31040_c245eee490e04698b2f4cac6c3d7c063_master.jpg', NULL, 4)
INSERT [dbo].[Book] ([ID], [Name], [Price], [Category_ID], [Sale], [Content], [Image], [Author], [Count]) VALUES (N'TN13      ', N'PHÁT MINH PHI THƯỜNG - ÁNH SÁNG: TỪ THẤU KINH TỚI TIA LASER ', 40, N'TN        ', 10, N'Tập sách Thế giới hiện đại giới thiệu những phát minh thú vị từ lúc con người phải dùng sức người và gia súc để lao động tạo ra thực phẩm đến khi khám ra những cách thức hiện đại hơn ứng dụng vào cuộc sống, sáng tạo ra những thiết bị máy móc hiện đại giúp cuộc sống càng ngày càng đơn giản, tiện nghi hơn. Tập sách nằm trong bộ Phát minh phi thường gồm 4 tựa: Ánh sáng, Thế giới hiện đại, Phương tiện giao tiếp, Phương tiện di chuyển, giới thiệu những phát minh không ngừng nghỉ của các nhà khoa học, nhờ sự bền bỉ tìm tòi sáng tạo của họ mà cuộc sống của chúng ta đầy tiện ích và dễ dàng kết nối với thế giới.', N'https://product.hstatic.net/1000363117/product/image_195509_1_31037_a9ed593db17641aea68ca3e8557f0c85_master.jpg', NULL, 1)
INSERT [dbo].[Book] ([ID], [Name], [Price], [Category_ID], [Sale], [Content], [Image], [Author], [Count]) VALUES (N'TN14      ', N'BÀ NGOẠI TRÊN CÂY TÁO ', 50, N'TN        ', 10, N'Cậu bé Andi buồn chán vì mình là đứa nhóc duy nhất trong khu phố không có bà, trong khi các bạn khác đều có bà. 

Thế rồi bỗng vào buổi chiều nọ, một bà ngoại bất ngờ xuất hiện trên cây táo – nơi ẩn nấp bí mật của riêng cậu bé. 

Bà ngoại dẫn Andi chu du khắp các miền đất mới lạ, từ rừng núi đến đại dương, chơi đủ các trò chơi kì thú, để Andi lái một chiếc ô tô xanh siêu “ngầu” và thậm chí là đi săn hổ ở Ấn Độ! 

Cùng lúc ấy, Andi cũng làm quen với bà Fink – người hàng xóm già mới chuyển đến và đỡ đần, chăm lo cho bà trong những công việc thường ngày. 

Một câu chuyện trong trẻo, dễ thương về ước mong, khát khao chinh phục những điều lớn lao của trẻ nhỏ cũng như tình thân và sự thấu hiểu giữa các thành viên trong gia đình. 

TÁC PHẨM ĐOẠT GIẢI THƯỞNG SÁCH DÀNH CHO THIẾU NHI VÀ THANH THIẾU NIÊN ÁO NĂM 1965. ', N'https://product.hstatic.net/1000363117/product/ba-ngoai-tren-cay-tao_bia_781c018bc588485c862022c9c2535959_master.jpg', NULL, 2)
INSERT [dbo].[Book] ([ID], [Name], [Price], [Category_ID], [Sale], [Content], [Image], [Author], [Count]) VALUES (N'TN15      ', N'THÀNH PHỐ QUANH VÒNG QUANH ', 65, N'TN        ', 10, N'Ngài Thị trưởng đáng kính muốn chặt phá cánh rừng, lấp ao hồ để mở rộng thị trấn bé nhỏ thành một đô thị to lớn hiện đại như ý tưởng ngài ấp ủ từ lâu. 

Vậy nhưng muôn loài động vật than khóc, trẻ nhỏ bực dọc và người già rầu rĩ. Bà tiên rừng Hullewulle cũng bất bình thay. Bà đã gieo những giấc mơ kì quái khiến ngài Thị trưởng sợ hãi, từ đó giúp ngài ngộ ra cách xây dựng thành phố mà không tổn hại đến rừng xanh. ', N'https://product.hstatic.net/1000363117/product/thanh-pho-quanh-vong-quanh_bia_0f010646cc5c408aa9632b17e9bfcd08_master.jpg', NULL, 3)
INSERT [dbo].[Book] ([ID], [Name], [Price], [Category_ID], [Sale], [Content], [Image], [Author], [Count]) VALUES (N'TN16      ', N'TÔI LÀ TÔI BÉ NHỎ ', 50, N'TN        ', 10, N'“Tôi là tôi bé nhỏ cũng là cuốn sách được yêu thích nhất của Mira Lobe. Câu chuyện xoay quanh một con vật tác giả tưởng tượng, toàn thân đủ các sắc màu sặc sỡ, mà độc giả có thể cắt dán thủ công theo hướng dẫn kèm theo trong sách. Một chú ếch tò mò hỏi con vật vui vẻ ấy nó là con gì, và con vật đó không thể trả lời nổi câu hỏi này. Cảm thấy hoang mang, nó lên đường tìm hiểu xem mình là giống loài gì, nhưng vẫn bế tắc như trước. Mãi cho đến khi nó tự chấp nhận bản thân “Tôi là tôi”, nó mới nhận được sự tôn trọng của các loài vật khác. Trẻ em học được từ câu chuyện này việc cần phải chấp nhận bản thân mình như vốn có, chỉ khi ấy chúng mới có được sự tự tin trong cuộc sống. Họa sĩ minh họa Susi Weigel đã sáng tạo ra những bức tranh thật sinh động và ấm lòng. Nhờ đó, cuốn sách trở thành tác phẩm giàu nghệ thuật thị giác cho trẻ em.” 

- PATRICK HORVATH 

Tổng thư kí nhóm chuyên gia cố vấn WIWIPOL — Nhóm làm việc về chính sách kinh tế khoa học có trụ sở tại thành phố Viên, Áo', N'https://product.hstatic.net/1000363117/product/toi-la-toi-be-nho_bia_1b1672d90be84ae4838bbdc8cc301cde_master.jpg', NULL, 5)
INSERT [dbo].[Book] ([ID], [Name], [Price], [Category_ID], [Sale], [Content], [Image], [Author], [Count]) VALUES (N'TN17      ', N'"LẠI ĐÂY NÀO!" MÈO BẢO ', 50, N'TN        ', 10, N'Mèo trèo lên cây và thoát khỏi dòng lũ. Cái cây đổ xuống trôi theo dòng lũ cùng với Mèo. 

Cùng với những con sóng, các bạn động vật bị nạn khác lần lượt trôi tới. 

“Lại đây nào!” Mèo bảo. Và thế là Mèo mời từng con vật cùng lên thân cây lánh nạn. 

Kể cả Cáo, loài thú mà nhiều con vật khiếp sợ, cũng được phép “lên thuyền”. 

Một câu chuyện cảm động giúp các bạn nhỏ hiểu rằng sống ở đời đừng quên “lá lành đùm lá rách”, giúp đỡ nhau lúc gian khó thật cần thiết vô cùng, và ai cũng xứng đáng có được một chốn nương thân. ', N'https://product.hstatic.net/1000363117/product/lai-day-meo-bao_bia_b88d1c75508044c6a38be874eee6d094_master.jpg', NULL, 4)
INSERT [dbo].[Book] ([ID], [Name], [Price], [Category_ID], [Sale], [Content], [Image], [Author], [Count]) VALUES (N'TN18      ', N'THƠ HAY VIẾT CHO THIẾU NHI - HOA VỪA ĐI VỪA NỞ ', 55, N'TN        ', 10, N'Thơ Trần Mạnh Hảo rất lạ, rất đặc biệt, như những hạt sương nhỏ nhoi đứng trước mặt trời vĩ đại. Mặt trời không mang nổi dù một hạt sương rơi, nhưng hạt sương lại có thể phản chiếu, mang bao nhiêu mặt trời thu trong ảnh trong hình của mình.', N'https://product.hstatic.net/1000363117/product/tho-hay-viet-cho-thieu-nhi_hoa-vua-di-vua-no_bia_5dc66b9069724a0dbe06abcd87492397_master.jpg', NULL, 2)
INSERT [dbo].[Book] ([ID], [Name], [Price], [Category_ID], [Sale], [Content], [Image], [Author], [Count]) VALUES (N'TN19      ', N'WHO? CHUYỆN KỂ VỀ DANH NHÂN THẾ GIỚI - ANTONI GAUDI ', 60, N'TN        ', 10, N'Antoni Gaudi chỉ có một người bạn duy nhất, đó chính là thiên nhiên. Ngay từ nhỏ, Gaudi đã có khả năng quan sát tự nhiên vô cùng tinh tế, từ đó cậu bé ấp ủ ước mơ sau này sẽ xây nên những công trình kiến trúc độc đáo giống với thiên nhiên.', N'https://product.hstatic.net/1000363117/product/danh-nhan-who_antoni-gaudi_bia_b28f320eb17449789e1bf3de4116092d_master.jpg', NULL, 3)
INSERT [dbo].[Book] ([ID], [Name], [Price], [Category_ID], [Sale], [Content], [Image], [Author], [Count]) VALUES (N'TN20      ', N'WHO? CHUYỆN KỂ VỀ DANH NHÂN THẾ GIỚI - MARK TWAIN ', 60, N'TN        ', 10, N'Thuở bé, do hoàn cảnh khó khăn nên Mark Twain không được học hành tới nơi tới chốn. Ông luôn ấp ủ ước mơ thực hiện những chuyến phiêu lưu mạo hiểm và dùng tài viết lách của mình để giúp đỡ mọi người. 

Cuối cùng, nhờ những tác phẩm hài hước nhưng mang tính phê phán hiện thực xã hội sâu sắc, Mark Twain đã chiếm được tình cảm của đông đảo bạn đọc và trở thành đại văn hào nước Mĩ!', N'https://product.hstatic.net/1000363117/product/danh-nhan-who_mark-twain_bia_ed3e81f3531b405a81aec04a0526dda4_master.jpg', NULL, 4)
INSERT [dbo].[Book] ([ID], [Name], [Price], [Category_ID], [Sale], [Content], [Image], [Author], [Count]) VALUES (N'TN21      ', N'WHO? CHUYỆN KỂ VỀ DANH NHÂN THẾ GIỚI - SIMONE DE BEAUVOIR ', 60, N'TN        ', 10, N'Simone de Beauvoir từ nhỏ đã là một cô bé độc lập, không chịu sự ràng buộc bởi hôn nhân hay những quan niệm cổ hủ thời bấy giờ! Thông qua các tác phẩm, bà cho cả thế giới biết rằng phụ nữ đang bị đối xử bất công như thế nào. Simone de Beauvoir đã cống hiến hết mình nhằm cải thiện cuộc sống và vị thế của phụ nữ trong xã hội và luôn tích cực đi đầu trong các phong trào giải phóng phụ nữ trên toàn thế giới! ', N'https://product.hstatic.net/1000363117/product/danh-nhan-who_simone-de-beauvoir_bia_5bd782199bbf4fcf9e035f92b4cb2d61_master.jpg', NULL, 1)
INSERT [dbo].[Book] ([ID], [Name], [Price], [Category_ID], [Sale], [Content], [Image], [Author], [Count]) VALUES (N'TN22      ', N'WHO? CHUYỆN KỂ VỀ DANH NHÂN THẾ GIỚI - JEFF BEZOS ', 60, N'TN        ', 10, N'Jeff Bezos được coi là một thiên tài lập dị, một vị CEO lạnh lùng nhưng ông đang góp phần thay đổi thế giới bằng những nỗ lực khó có ai có thể tưởng tượng! Ước mơ xây dựng nên một tương lai tốt đẹp hơn, ông đã tạo ra một trung tâm mua sắm khổng lồ bán mọi mặt hàng trên thế giới, phát triển máy đọc sách điện tử có thể chứa hàng chục nghìn cuốn sách và tạo ra con tàu vũ trụ giúp những người bình thường có cơ hội thực hiện ước mơ bay vào không gian. 

Khởi đầu từ một cửa hàng sách online trở thành tỉ phú thế giới, ông chủ của Amazon - sàn thương mại điện tử số 1 thế giới! ', N'https://product.hstatic.net/1000363117/product/danh-nhan-who_jeff-bezos_bia_14fb10821c3644fdbf5a488a1fa8d7cc_master.jpg', NULL, 2)
INSERT [dbo].[Book] ([ID], [Name], [Price], [Category_ID], [Sale], [Content], [Image], [Author], [Count]) VALUES (N'TN23      ', N'WHO? CHUYỆN KỂ VỀ DANH NHÂN THẾ GIỚI - ELON MUSK ', 60, N'TN        ', 10, N'Thời niên thiếu, Elon Musk từng đọc sách 10 tiếng mỗi ngày và tự đặt câu hỏi rằng đâu là vấn đề quan trọng nhất đối với loài người. 

“SpaceX” thành công trong việc tái sử dụng tên lửa. 

“Tesla Motors” phân phối ô tô điện khắp thế giới. 

“Solar City” cung cấp năng lượng sạch, bảo vệ môi trường Trái Đất. 

Đó là những thành tựu đạt được nhưng Elon Musk vẫn chưa dừng lại mà sẽ tiếp tục dấn thân vào thử thách vì tương lai của nhân loại. 

Một kĩ sư thiên tài đã biến điều không tưởng thành hiện thực! Liệu ước mơ đưa con người lên Sao Hoả của ông sẽ trở thành hiện thực? ', N'https://product.hstatic.net/1000363117/product/danh-nhan-who_elon-musk_bia_8df11622125a4ea592dee1bf738d6161_master.jpg', NULL, 3)
INSERT [dbo].[Book] ([ID], [Name], [Price], [Category_ID], [Sale], [Content], [Image], [Author], [Count]) VALUES (N'TN24      ', N'TUYỂN TẬP CA DAO - ĐỒNG DAO - CÂU ĐỐ - NGỤ NGÔN (DÀNH CHO BÉ TẬP NÓI, TẬP ĐỌC) ', 118, N'TN        ', 10, N'- Những câu đố, ca dao và ngụ ngôn thường là một phần quan trọng của văn hóa dân gian, chúng không chỉ giúp trẻ phát triển kỹ năng đọc mà còn giúp trẻ học được những bài học quý báu về đạo đức và cuộc sống 

- Sách TUYỂN TẬP CA DAO, ĐỒNG DAO, CÂU ĐỐ, NGỤ NGÔN CHO BÉ HỌC NÓI, TẬP ĐỌC giúp trẻ luyện tập kỹ năng đọc, nâng cao từ vựng và hiểu biết về những giá trị đạo đức thông qua các câu đố, ca dao và ngụ ngôn dân gian. Bạn có thể sử dụng chúng để tạo ra một môi trường học tập thú vị cho trẻ, giúp trẻ phát triển cả về mặt trí tuệ và đạo đức.', N'https://product.hstatic.net/1000363117/product/9786044723440_2b99246220654387bdd637a6620611c8_master.jpg', NULL, 5)
INSERT [dbo].[Book] ([ID], [Name], [Price], [Category_ID], [Sale], [Content], [Image], [Author], [Count]) VALUES (N'TN25      ', N'NHỮNG TRUYỆN HAY KỂ CHO BÉ NGHE - ĐI LẤY MẶT TRĂNG ', 99, N'TN        ', 10, N'Trong cuốn sách này, bạn sẽ không chỉ được đọc những truyện ngắn xinh xắn, đặc sắc viết cho tuổi thơ mà còn được xem những bức tranh sinh động, gợi mở cảm xúc thuần khiết về tuổi thơ. 

Được tuyển chọn từ hàng ngàn sáng tác đã đăng tải trên “Người bạn nhỏ”, một tạp chí uy tín, nổi tiếng, có truyền thống lâu đời đồng hành cùng văn học thiếu nhi của Trung Quốc, “Những truyện hay kể cho bé nghe” sẽ đưa bạn tới khu vườn của những đóa hoa nhiều sắc màu, hồn hậu và tinh tế. 

Bạn sẽ gặp ở đây những Chuột Trắng, Sói lông đỏ, Cây hoa hồng, Chuột Chũi… dễ thương, có những Cuốn truyện tranh kì diệu, Điện thoại chuyển phát nhanh, Đi lấy mặt trăng, Món quà của cô gái Mùa Đông… cũng đang đợi chờ để thủ thỉ cho bạn nghe câu chuyện của mình, câu chuyện cổ tích hiện đại lung linh ánh bình minh… ', N'https://product.hstatic.net/1000363117/product/nhung-truyen-hay-me-ke-be-nghe_di-lay-mat-trang_bia_227bbe3708b149fcaf3686d188bc9ff8_master.jpg', NULL, 3)
INSERT [dbo].[Book] ([ID], [Name], [Price], [Category_ID], [Sale], [Content], [Image], [Author], [Count]) VALUES (N'TN26      ', N'CÁNH DIỀU HÌNH NỐT NHẠC ', 58, N'TN        ', 10, N'Mỗi chúng ta đều có một khoảng thời gian được sống với cảm xúc tươi tắn, tự do chạy nhảy đùa nghịch, vui thích với các khám phá. Đó chính là tuổi thơ. Cậu bé Đèn Pha có một tuổi thơ như thế trên miền cao nguyên. Cậu nhóc sống trong gia đình yêu thương, chơi cùng bạn bè ngộ nghĩnh, có các chuyến đi thăm ba là bộ đội ở tận đồn biên phòng. Trái tim trong sáng của cậu nhóc không ngừng được đắp bồi và mở rộng bởi những câu chuyện nhỏ xinh diễn ra mỗi ngày. 

Bạn đã từng kéo một chiếc diều chạy trong gió, vui thích nhìn nó bay lên, nhẹ nhàng chao liệng trên bầu trời? Bạn sẽ gặp cảm giác ấy với Cánh diều hình nốt nhạc. Hãy mở quyển sách này và bay bổng cùng cậu bé Đèn Pha, bạn nhé! 

“Con diều được làm từ thứ vải dù đặc biệt của các chú bộ đội. Nó vốn là một chiếc dù bị rách vì được sử dụng trong tập luyện rất lâu rồi. Đèn Pha thầm ước một ngày nào đó, mình cũng sẽ sở hữu một con diều màu xanh lá cây xinh đẹp và bay cao như thế.” 

TÁC PHẨM DỰ GIẢI THƯỞNG VĂN HỌC KIM ĐỒNG LẦN THỨ NHẤT 2023-2024 ', N'https://product.hstatic.net/1000363117/product/canh-dieu-hinh-not-nhac-3_eca16214a7604d498fce92e311ba15cb_master.jpg', NULL, 2)
INSERT [dbo].[Book] ([ID], [Name], [Price], [Category_ID], [Sale], [Content], [Image], [Author], [Count]) VALUES (N'TN27      ', N'TỚ KHÔNG BIẾT BAY - I CAN FLY (SONG NGỮ DÀNH CHO LỨA TUỔI 2-7) ', 110, N'TN        ', 10, N'Cánh Cụt Nhỏ bối rối quá: cậu có cánh, biết đập cánh, biết chạy, biết nhảy, vậy mà không thể bay! Bố bảo cậu rằng cánh cụt chỉ bơi thôi, nhưng Cánh Cụt Nhỏ tin chắc rằng mình bay được. Rốt cuộc cậu có tìm được cách gì hay không?! 

Tác giả Fifi Kuo đến từ Đài Loan. Cô đã có bằng Cử nhân về Thiết kế Kiến trúc Cảnh quan và bằng Thạc sĩ Nghệ thuật tại Trường Nghệ thuật Cambridge. Ngoài ra cô đã giành được một số giải thưởng uy tín, bao gồm Giải thưởng Macmillan và Giải thưởng Minh họa iJungle. ', N'https://product.hstatic.net/1000363117/product/8935333710093_3b7b13cd7ed4489aa7624347e9f693fd_master.jpg', NULL, 3)
INSERT [dbo].[Book] ([ID], [Name], [Price], [Category_ID], [Sale], [Content], [Image], [Author], [Count]) VALUES (N'TN28      ', N'GERDA - CÂU CHUYỆN CÁ VOI ', 139, N'TN        ', 10, N'CÂU CHUYỆN ĐẦY CẢM ĐỘNG VỀ ƯỚC MƠ, NIỀM TIN VÀ KHÁT VỌNG 

Tuổi thơ hạnh phúc của cá voi nhỏ Gerda đột nhiên kết thúc bởi một biến cố bất ngờ. Bị bỏ lại một mình, không gia đình ở bên, cô lang thang khắp đại dương và trải qua nhiều ngọt bùi cay đắng, để rồi đến cuối hành trình cô tìm được một chốn đầy yêu thương gọi là nhà. 

Minh hoạ bởi Adrián Macho – tác giả sách thiếu nhi bán chạy hang đầu ở Slovakia (Đông Âu), Gerda – Câu chuyện Cá voi không chỉ mang bài học về sức mạnh niềm tin và khát vọng mà còn gửi gắm thông điệp bảo vệ môi trường. 

Từng trang sách mở ra thế giới đại dương kì thú, tranh minh hoạ trau chuốt chi tiết, phối màu ấn tượng khiến bạn đọc khó lòng rời mắt. Từ 2018 đến nay, Gerda – Câu chuyện Cá voi đã được dịch ra 16 thứ tiếng, được trẻ em trên toàn thế giới yêu thích. Năm 2019, tác phẩm được giải KNIHA ROKU ở hạng mục Sách Thiếu nhi. ', N'https://product.hstatic.net/1000363117/product/8935333710130_747d767974b547d598ff1fdcb7b74f9a_master.jpg', NULL, 5)
INSERT [dbo].[Book] ([ID], [Name], [Price], [Category_ID], [Sale], [Content], [Image], [Author], [Count]) VALUES (N'TN29      ', N'GERDA - CÂU CHUYỆN VỀ LÒNG DŨNG CẢM ', 139, N'TN        ', 10, N'HÀNH TRÌNH ĐƯƠNG ĐẦU VÀ VƯỢT QUA NỖI SỢ 

Kể từ khi đoàn tụ, hai anh em cá voi Gerda và Lars đã cùng ngân nga khúc hát mẹ ru thuở bé. Một ngày nọ, tình cờ phát hiện ra bài ca chưa trọn vẹn, hai anh em quyết tâm lên đường đi tìm phần còn lại. Hành trình mới đầy gian nan này sẽ dạy Gerda và Lars một bài học đường đời quan trọng: bài học về lòng dũng cảm. 

Adrián Macho là tác giả sách thiếu nhi bán chạy hàng đầu ở Slovakia (Đông Âu). Gerda – Câu chuyện về lòng dũng cảm sẽ đưa các độc giả nhí “theo vây” hai anh em cá voi bơi vòng quanh thế giới, rèn luyện bản lĩnh, sự tự tin và tinh thần cởi mở. 

“Ai trong đời cũng đôi lần hoảng sợ 
Cá, hải mã, cá voi hay con người 
Nhưng sợ hãi nếu con dám đối mặt 
Phiêu lưu nào cũng mãi của con thôi.” 

Từng trang sách mở ra thế giới đại dương kì thú, tranh minh hoạ trau chuốt chi tiết, phối màu ấn tượng khiến bạn đọc khó lòng rời mắt. Từ 2019 đến nay, Gerda – Câu chuyện về lòng dũng cảm đã được dịch ra 12 thứ tiếng, được trẻ em trên toàn thế giới yêu thích. ', N'https://product.hstatic.net/1000363117/product/647397a632a7e9dc8d837e7ef5401bc8_3b022a931254411f8e925ff931630ad6_master.jpg', NULL, 1)
INSERT [dbo].[Book] ([ID], [Name], [Price], [Category_ID], [Sale], [Content], [Image], [Author], [Count]) VALUES (N'TN30      ', N'PIPPIN HỌC VỄ CHÂN DUNG ', 100, N'TN        ', 10, N'Pippin vẽ một bức chân dung tự hoạ, mà bạn bè cứ bảo cậu vẽ SAI rồi! Cùng Pippin chu du trong thế giới hội hoạ, mở mang về kĩ thuật lẫn ý tưởng nghệ thuật, và khám phá tài nghệ sĩ bên trong bé nhé. 

Charlotte Mei là một họa sĩ nổi tiếng. Làm việc trên các lĩnh vực hội họa, minh họa, gốm sứ và hoạt hình, cô có cách tiếp cận đặc biệt, vui tươi về hình thức và màu sắc. Ngoài ra, cô còn hợp tác với những tên tuổi nổi tiếng như Nike, Hermes, Lazy Oaf và Converse và biên tập cho New York Times và Vice. ', N'https://product.hstatic.net/1000363117/product/8935333710086_5bfd06bff969407ea3c5b26ed2cf1c22_master.jpg', NULL, 2)
INSERT [dbo].[Book] ([ID], [Name], [Price], [Category_ID], [Sale], [Content], [Image], [Author], [Count]) VALUES (N'TN31      ', N'WILLOW NHÚT NHÁT ', 130, N'TN        ', 10, N'Willow rất nhát. CỰC KÌ nhát. Cô sống trong một hòm thư bỏ hoang, và cô không thích ra ngoài cho lắm. Nhưng rồi một ngày nọ có phong thư đáp xuống nhà cô, trong thư là lời thỉnh cầu của cậu bé gửi tới mặt trăng trong ngày sinh nhật mẹ. Willow biết rằng nếu mình không dũng cảm bước ra ngoài, bức thư sẽ không bao giờ được gửi và cậu bé sẽ buồn vô cùng. Vậy thì, cô có nên thử không? Cô có làm được không? 

Tác giả Cat Min là một họa sĩ vẽ tranh minh họa, hoạt họa và nhà văn. Cat lớn lên là một đứa trẻ nhút nhát ở Hồng Kông, nơi cô dành phần lớn thời thơ để vẽ và làm truyện tranh từ giấy in và kim bấm cùng người bạn thân nhất của mình. Cô theo học hoạt hình và điện ảnh tại Đại học New York, Trường Nghệ thuật Tisch, và hoàn thành Chương trình Cư trú mùa hè Minh họa & Kể chuyện bằng Hình ảnh tại Trường Nghệ thuật Thị giác ở New York. Cô cũng là thành viên của SCBWI.', N'https://product.hstatic.net/1000363117/product/8935333710123_885e39c551c944839fed667962ef1452_master.jpg', NULL, 3)
INSERT [dbo].[Book] ([ID], [Name], [Price], [Category_ID], [Sale], [Content], [Image], [Author], [Count]) VALUES (N'TN32      ', N'MỘT CUỐN SÁCH KHÔNG VỀ CÔ VY ', 109, N'TN        ', 10, N'Để không bỏ lỡ những ký ức có đắng cay, ngọt bùi, xen lẫn dí dỏm, ngộ nghĩnh trong giai đoạn dịch Covid-19 hoành hành, Ban Biên tập Sống phối hợp cùng Tác giả Trang CHO và nhóm Họa sĩ Tăng Quang – Tien Buj – Phạm Lâm – Lượn xuất bản cuốn sách tranh “Một cuốn sách không về Cô Vy” với mong muốn ghi lại những thay đổi trước và sau mùa dịch trong đời sống sinh hoạt, học tập, làm việc, các hoạt động vui chơi, giải trí của người dân Việt Nam. Bạn sẽ nhìn thấy đâu đó hình ảnh của mình qua từng trang sách, để rồi bất giác bật lên tiếng cười, khóc ra nước mắt, hay ngậm ngùi nhìn lại một chặng đường đã qua. ', N'https://product.hstatic.net/1000363117/product/mot-cuon-sach-khong-ve-co-vy-01_01d51cec48db496aa2fb1788a88cc681_master.jpg', NULL, 5)
INSERT [dbo].[Book] ([ID], [Name], [Price], [Category_ID], [Sale], [Content], [Image], [Author], [Count]) VALUES (N'TN33      ', N'ANH THẢO VÀ CỎ DẠI (NHỮNG BÀI HỌC TỪ THIÊN NHIÊN) ', 85, N'TN        ', 10, N'Truyện dài thiếu nhi Anh Thảo và Cỏ Dại sẽ đưa các bé cùng phiêu lưu trên những miền đất của mẹ thiên nhiên. Câu chuyện được bắt đầu trong một vùng đất tưởng tượng: “Từ thuở xa xưa, xưa ơi là xưa, có một vùng đất thuộc phía Bắc Đông Nam Á, nằm gần eo biển Malacca tiếp giáp với bán  đảo Mã Lai và đảo Sumatra được gọi là xứ sở Thiên Đường Xanh Thiên Đường Xanh như một chiếc khiên khổng lồ, nằm lọt thỏm giữa vùng rừng núi trùng điệp, phần giữa trũng xuống, hai bên cong lên tạo thành hình vòng cung, nhìn từ trên cao sẽ thấy nơi này giống một cái phễu. Hai nhân vật chính là hai cô bé Anh Thảo và Cỏ Dại với những năng khiếu cá nhân thiên bẩm sẽ cùng nhau khám phá những điều mới lạ bên ngoài ngôi nhà của mình. 
 
Như một điều hiển nhiên, thiên nhiên đã mang đến cho con người những gì thì cũng có thể lấy đi tất cả. Nhà sinh vật học Sylvia Earle có nói: “Phần còn lại của thế giới (thiên nhiên) có thể tiếp tục sống mà không có chúng ta, nhưng chúng ta không thể tồn tại nếu thiếu đi chúng”. Chúng ta hãy đối xử với thiên nhiên một cách có trách nhiệm vì một tương lai tốt đẹp hơn, các bạn nhé!', N'https://product.hstatic.net/1000363117/product/image_195509_1_26627_9b78f916167d4c74bb1637931b810ded_master.jpg', NULL, 4)
INSERT [dbo].[Book] ([ID], [Name], [Price], [Category_ID], [Sale], [Content], [Image], [Author], [Count]) VALUES (N'TN34      ', N'BÀI HÁT THẦN TIÊN ', 79, N'TN        ', 10, N'"Bài hát thần tiên" là truyện dài viết về loài vật.  Một căn phòng học trong ngôi nhà của cậu bé vào mùa hè, mọi thứ đồ vật trong căn phòng ấy đều chộn rộn suốt ngày, cãi nhau về sự có mặt của mình khi cậu chủ vắng nhà. Rồi bỗng một hôm xuất hiện một chú dế mèn, chàng lãng tử thời đại chu du khắp nơi đến nỗi chàng không nhớ mình từ đâu tới, chỉ biết khi tình cờ lạc bước vào căn phòng này mọi thứ khiến chàng ngạc nhiên, cao hứng cất tiếng gáy. Không phải là tiếng gáy mà giọng của chàng lãng tử cất lên để hát. Giọng hát của chú dế mèn lãng tử làm cụ sách thông thái giật mình ngẩn ngơ, bác dép già khó tính hay càu nhàu bà vợ lãng tai im phắt. Cô cửa sổ suốt ngày kể chuyện vườn cây, bầu trời, mùa màng, thời tiết, bỗng "say nắng" tiếng hát của anh dế mèn. Và chuyện gì xảy ra khi cậu chủ nghỉ hè trở về chuẩn bị cho niên học mới? Chắc chắn là rất nhiều "kịch tính" trong căn phòng mà mọi thứ đồ vật đều được "nhân cách hóa" với đủ trạng thái vui, buồn.', N'https://product.hstatic.net/1000363117/product/image_175796_31fb0de82e75409d90903cd1340710e4_master.jpg', NULL, 1)
INSERT [dbo].[Book] ([ID], [Name], [Price], [Category_ID], [Sale], [Content], [Image], [Author], [Count]) VALUES (N'TN35      ', N'SUỐI MÂY HỒNG ', 79, N'TN        ', 10, N'Với “Suối mây hồng”, nhà văn Từ Kế Tường bắt đầu với giọng văn thơ mộng để khơi gợi cho các cháu những ước mơ: “Dòng suối đẹp tuyệt vời. Dư Hương sẽ trải tấm chăn trên thảm cỏ này, bên cạnh bờ suối để ngủ cùng Mai Mai. Để đến khi thức giấc nghe sương rơi rớt trên từng phiến lá, và nghe tiếng quậy nước của bầy thiên nga vừa về tới từ trên ngàn…”. Xuyên suốt tác phẩm là những thông điệp vô cùng nhân văn. Đọc truyện Suối mây hồng các bạn nhỏ sẽ biết yêu thiên nhiên là giúp cho tâm hồn mình được rộng mở. Khi lớn lên mình sẽ tích cực bảo vệ môi trường sống. Những rừng cây cổ thụ đã bị đốn chặt để trồng cây cà phê, cây tiêu nên gà rừng và chim chơrao rất hiếm hoi. Và dĩ nhiên bầy thiên nga trong truyện của Từ Kế Tường cũng đã bay đi… Nhưng Suối mây hồng vẫn còn đó, nổi bật trên nền trời cao nguyên trong xanh.', N'https://product.hstatic.net/1000363117/product/image_175797_47bf41320edf4a8e97fbf02ba9f503bb_master.jpg', NULL, 2)
INSERT [dbo].[Book] ([ID], [Name], [Price], [Category_ID], [Sale], [Content], [Image], [Author], [Count]) VALUES (N'TN36      ', N'EHON KỸ NĂNG SỐNG - ĐỂ CON YÊU TỰ LẬP - CÙNG ĐI VỆ SINH NÀO (TỪ 1.5 TUỔI) ', 39, N'TN        ', 10, N'Nhiều trẻ 5 – 6 tuổi vẫn chưa có kỹ năng tự làm việc cá nhân: mặc quần áo, tự xúc cơm… Đó là kết quả của việc cha mẹ làm thay con mọi việc. Điều này vô tình cướp mất đi cơ hội tự lập ở trẻ. Những đứa trẻ được bao bọc kĩ càng sẽ ỉ lại, thích dựa dẫm và không có chí tiến thủ trong công việc sau này. Thay vào đó, ba mẹ nên giúp con thoát khỏi vỏ bọc của mình bằng việc lựa chọn đúng thời điểm cũng như giải pháp để dạy trẻ các kỹ năng sống tự lập ngay từ thuở còn nhỏ. 

Cùng đi vệ sinh nào: 

Cún con ăn nhiều kẹo nên bị đau bụng. Mẹ bảo Cún con nên đi tìm bạn Bồn Cầu. Cún con đi tìm bạn Bồn Cầu nhưng mỗi lần mở cửa lúc thì là phòng đọc sách, lúc thì là tủ quần áo, có khi là tủ lạnh,… Liệu Cún con có nhớ lời mẹ là tìm bằng được bạn Bồn Cầu để đi vệ sinh không nhỉ? Ba mẹ và các bé cùng đón đọc cuốn Cùng đi vệ sinh nào nhé! ', N'https://product.hstatic.net/1000363117/product/image_244718_1_5191_2a22f1d592e44789adc6f181f242343a_master.jpg', NULL, 3)
INSERT [dbo].[Book] ([ID], [Name], [Price], [Category_ID], [Sale], [Content], [Image], [Author], [Count]) VALUES (N'TN37      ', N'EHON KỸ NĂNG SỐNG - ĐỂ CON YÊU TỰ LẬP - CÙNG GỘI ĐẦU NÀO (TỪ 1.5 TUỔI) ', 39, N'TN        ', 10, N'Nhiều trẻ 5 – 6 tuổi vẫn chưa có kỹ năng tự làm việc cá nhân: mặc quần áo, tự xúc cơm… Đó là kết quả của việc cha mẹ làm thay con mọi việc. Điều này vô tình cướp mất đi cơ hội tự lập ở trẻ. Những đứa trẻ được bao bọc kĩ càng sẽ ỉ lại, thích dựa dẫm và không có chí tiến thủ trong công việc sau này. Thay vào đó, ba mẹ nên giúp con thoát khỏi vỏ bọc của mình bằng việc lựa chọn đúng thời điểm cũng như giải pháp để dạy trẻ các kỹ năng sống tự lập ngay từ thuở còn nhỏ. 

Cùng gội đầu nào: 

Cừu nhỏ bị bẩn và ngứa nên nhờ bố hướng dẫn gội đầu. Thấy Cừu nhỏ gội đầu, bạn Gàu sợ lắm nên xin Cừu nhỏ đừng gội đầu nữa. Nhưng Cừu nhỏ không muốn bạn Gàu sống trên đầu của mình chút nào cả. Với cuốn sách này, dõi theo câu chuyện của Cừu nhỏ, bé sẽ biết được các bước để có thể gội đầu là như thế nào đấy nhé! Từ nay, bé sẽ luôn là một em bé thơm tho sạch sẽ vì đã biết vệ sinh cá nhân như Cừu nhỏ rồi đấy! 

Trong quá trình rèn kỹ năng sống cho trẻ, sẽ có lúc ba mẹ cảm thấy phiền muộn vì có thể trẻ sẽ không làm tốt như những gì ba mẹ mong đợi. Tuy nhiên, quá trình này chỉ phản ánh sự đa dạng trong tốc độ phát triển của bé. Do quá trình này cần diễn ra trong một khoảng thời gian dài để bé có thể thích nghi với việc: chuyển từ được nâng niu, bao bọc, thụ động sang việc tự mình thực hiện các công việc chăm sóc bản thân. Vậy nên, ba mẹ đừng quá căng thẳng thúc ép con mình phát triển các kỹ năng sống. Hãy để con tự mình khám phá và “lớn lên” một cách tự nhiên ba mẹ nhé! ', N'https://product.hstatic.net/1000363117/product/image_244718_1_5189_eb1acc55509742f99aacd1d6bbe6b79d_master.jpg', NULL, 5)
INSERT [dbo].[Book] ([ID], [Name], [Price], [Category_ID], [Sale], [Content], [Image], [Author], [Count]) VALUES (N'TN38      ', N'100 TRUYỆN NGỤ NGÔN CÙNG BÉ LỚN KHÔN ', 100, N'TN        ', 10, N'Từ xưa tới giờ, truyện ngụ ngôn thường được cha mẹ chọn để ân cần đọc cho em bé ở nhà mỗi tối, bởi cốt truyện đơn giản, tính cách nhân vật giản dị và truyền tải những kinh nghiệm sống cùng triết lý có giá trị lâu dài. 

Cuốn sách lọt vào vòng bình chọn giải Văn học thiếu nhi Dế mèn năm 2022 này đem đến nhiều câu chuyện mới cùng góc nhìn mới lạ, khiến cho ngụ ngôn ngày càng gần gũi và thiết thực với mọi nhà. Có những truyện có kết thúc dễ hiểu, có những truyện gợi ra hướng để gia đình thảo luận. Đúng và sai, hay và dở sẽ dần dần hiện rõ sau nhưng giây phút bố mẹ tâm sự cùng con. 

Mỗi ngày mươi phút thủ thỉ tâm sự sẽ giúp con thấm dần bài học cuộc sống. Việc học diễn ra êm ái trong bầu không khí gia đình ấm cúng là một nền tảng tuyệt vời cho con lớn khôn. 

ĐÀO TRUNG UYÊN tốt nghiệp cử nhân Báo chí tại Việt Nam và M.A.Media and Communication Science, Ilmenau University of Technology tại CHLB Đức. Cô từng đoạt giải xuất sắc cuộc thi sáng tác truyện đồng thoại Đóa hoa đồng thoại năm 2022 và xuất bản nhiều sách cho trẻ em. Ước mơ của cô là làm trẻ em bật cười và ngủ ngon khi đọc các tác phẩm của mình. 

Tác phẩm này đã lọt vào vòng bình chọn giải Thiếu nhi Dế mèn năm 2022 và được hội đồng chuyên môn đánh giá cao. ', N'https://product.hstatic.net/1000363117/product/8935235237643_8ac1afeb652e4ead940341fac877250b_master.jpg', NULL, 4)
INSERT [dbo].[Book] ([ID], [Name], [Price], [Category_ID], [Sale], [Content], [Image], [Author], [Count]) VALUES (N'TN39      ', N'HANS CHRISTIAN ANDERSEN - NGƯỜI KỂ CHUYỆN CỔ TÍCH ', 179, N'TN        ', 10, N'Nhà vật lý người Đức Albert Einstein từng nói: “Nếu bạn muốn những đứa con của mình trở nên thông minh, hãy kể cho chúng nghe truyện cổ tích. Nếu bạn muốn chúng thông minh hơn nữa, hãy kể nhiều truyện cổ tích hơn nữa”. Và nói đến truyện cổ tích, chúng ta không thể không nhắc đến nhà văn Andersen - ông vua kể chuyện cổ tích nổi tiếng của Đan Mạch với hàng loạt tác phẩm quen thuộc với độc giả nhí trên toàn thế giới. Trên tay các bạn là tập truyện cổ tích hay nhất của Andersen do nhà văn kiêm dịch giả người Đức và hà Lan, Arnica Esterl tuyển chọn và kể lại. 

Qua giọng kể cô đọng, giàu hình ảnh của bà, cùng những bức tranh minh họa tuyệt đẹp của họa sĩ Anastassija Archipowa, những câu chuyện của Andersen vốn đã vô cùng thú vị nay lại càng trở nên hấp dẫn lôi cuốn như những chuyến phiêu lưu đầy màu sắc. Đây hẳn sẽ là một món quà ý nghĩa dành cho các em nhỏ, để các em thỏa sức tung bay với trí tưởng tượng của mình. Tập truyện bao gồm những tác phẩm nổi tiếng và rất được yêu thích của Andersen như: Nàng tiên Cá bé nhỏ, Bộ quần áo của Hoàng đế, Chú lính thiếc kiên cường, Bà Chúa tuyết, Cô bé bán diêm,… 

Đến với từng câu chuyện trong tuyển tập, các em nhỏ không chỉ được bước vào miền đất cổ tích thần tiên ngọt ngào mà còn thu được những bài học sâu sắc về tình yêu thương, tình bạn, lòng nhân hậu và tinh thần dũng cảm... Những câu chuyện giản dị, những nhân vật sống động trong truyện giúp gợi mở trí tưởng tượng, óc sáng tạo, sự hiểu biết của các em nhỏ về thế giới xung quanh. 

Với một bạn đọc lớn tuổi hơn, tập truyện thấm đẫm những rung cảm sâu sắc không thể nói thành lời và chắc hẳn sẽ mang đến cho bạn những trải nghiệm khó quên. Trong quá trình chuyển ngữ, chúng tôi đã vô cùng xúc động và cố gắng để có thể truyền tải nội dung truyện một cách chân thực nhất. Chúng tôi hi vọng rằng bạn đọc sẽ có nhiều trải nghiệm đẹp khi đọc truyện. Chúng tôi cũng sẽ rất hạnh phúc nếu nhận được những chia sẻ về cảm xúc của quý độc giả khi đọc truyện cùng những góp ý để bản dịch được hoàn thiện hơn. 

Chúc các bạn có những giờ phút thư giãn vui vẻ qua từng trang sách! ', N'https://product.hstatic.net/1000363117/product/hans-christian-andersen---ng_i-k_-chuy_n-c_-t_ch-full-01_f6ddc316ab3347e2844eadfce7812b35_master.jpg', NULL, 1)
INSERT [dbo].[Book] ([ID], [Name], [Price], [Category_ID], [Sale], [Content], [Image], [Author], [Count]) VALUES (N'TT01      ', N'VỤ ÁN ĐẦU TIÊN CỦA SHERLOCK HOLMES: CUỘC ĐIỀU TRA MÀU ĐỎ', 199, N'TT        ', 10, N'“Vụ án đầu tiên của Sherlock Holmes: Cuộc điều tra màu đỏ” Xuất bản lần đầu vào năm 1887, tác giả Arthur Conan Doyle đã phát hành cuốn tiểu thuyết đầu tiên giới thiệu thế giới về Sherlock Holmes tài giỏi. Nhân vật này trở nên vô cùng nổi tiếng, tiếp tục góp mặt trong 4 tiểu thuyết và 56 truyện ngắn trước khi lấn sân sang hầu hết các phương tiện khác được biết đến, từ sân khấu, màn ảnh cho đến trò chơi điện tử. 

Câu chuyện mà bạn đọc đang cầm trên tay chính là chuyến phiêu lưu đầu tiên của nhân vật thám tử tài năng này. 

Câu chuyện bắt đầu ở London năm 1878, khi bác sĩ Watson tội nghiệp trở về từ Ấn Độ, trên người không một xu dính túi. Trên bờ vực tuyệt vọng, anh gặp Sherlock Holmes, một anh chàng hay thay đổi, cũng đang tìm bạn cùng phòng. Hai người đàn ông vừa chuyển đến số nhà 221 Phố Baker thì một trong những thám tử hàng đầu của Scotland Yard đã tới và kêu gọi tài năng của Sherlock Holmes giúp anh ta giải quyết một vụ án giết người đen tối. Tiến sĩ Watson và Sherlock Holmes sẽ cùng nhau dẫn dắt cuộc điều tra bi thảm này như thế nào và kết quả sẽ ra sao? 

Cuốn sách này đem đến một phiên bản rất khác với những cuốn sách bạn đã từng xem. Ngoài nội dung tuyệt vời của nó, những hình minh họa với tông màu ấm áp và cổ kính của Vincent Mallié sẽ đưa bạn chìm đắm vào làn sương mù mờ ảo của Luân Đôn cuối thế kỷ 19. ', N'https://product.hstatic.net/1000363117/product/8935280914018_440a810d93474d7d90b44806e540a487_master.jpg', NULL, 2)
INSERT [dbo].[Book] ([ID], [Name], [Price], [Category_ID], [Sale], [Content], [Image], [Author], [Count]) VALUES (N'TT02      ', N'THỢ SĂN BÓNG TỐI', 182, N'TT        ', 10, N'Sau Tòa án linh hồn, Thợ săn bóng tối là phần tiếp theo trong xê ri trinh thám mang đậm chất tôn giáo của nhà văn người Italia Donato Carrisi. 

Marcus, một linh mục ân giải, tỉnh dậy sau cơn hôn mê ở Prague và hoàn toàn mất trí nhớ. Bên giường bệnh, anh tìm thấy hai phong bì dán kín: một chiếc chứa vé tàu tới Roma cùng với lời cam kết ở đó, anh sẽ tìm lại được quá khứ của mình; trong phong bì còn lại chứa 20.000 euro cùng một hộ chiếu mang danh tính giả để Marcus làm lại cuộc đời. Vị linh mục sẽ lựa chọn cái nào? 

Marcus quyết định vò nát chiếc phong bì chứa tiền và hộ chiếu giả để anh không có cơ hội đổi ý, và lựa chọn trở về Rome. Ở đó, anh được dẫn đến Vatican, và lần đầu tiên nhận ra khả năng nhìn thấu cái ác như đang diễn ra ngay trước mắt của bản thân mình. Sau khi được huấn luyện, Marcus sẵn sàng thực hiện nhiệm vụ của mình đúng vào lúc cả thành phố Rome đang lâm vào trạng thái hoảng loạn bởi một tên sát nhân hàng loạt. Hắn lựa chọn nạn nhân là các cặp đôi đang thân mật với nhau ở ngoại ô thành phố với cùng một cách thức gây án: nạn nhân nam nhận cái chết êm ái với một phát đạn vào gáy trong khi nạn nhân nữ phải chứng kiến cái chết của người tình, sau đó bị tra tấn dã man trước khi những nhát dao chí tử cướp đi mạng sống của họ. 

Trong lúc Marcus thâm nhập các hiện trường án mạng để tìm kiếm manh mối, anh gặp lại Sandra - nữ cảnh sát chụp ảnh hiện trường. Cả hai nhanh chóng phát hiện ra kết quả khám nghiệm tử thi đã bị làm cho sai lệch bởi chính vị chuyên gia pháp y -   kẻ đứng đầu một giáo phái bí truyền và từng điều hành một bệnh viện dành cho tội phạm vị thành niên trong quá khứ. 

Tuyến nhân vật đa dạng, các vụ án kép diễn ra liên tục với nhịp điệu điên cuồng cùng tình tiết truyện phức tạp tạo nên một tác phẩm cuốn hút và thể hiện tài năng phi thường của Donato Carrisi. ', N'https://product.hstatic.net/1000363117/product/image_195509_1_46501_a043d177c9d24a63b2486b29ce52770e_master.jpg', NULL, 3)
INSERT [dbo].[Book] ([ID], [Name], [Price], [Category_ID], [Sale], [Content], [Image], [Author], [Count]) VALUES (N'TT03      ', N'RỒNG ĐỎ', 135, N'TT        ', 10, N'Những vụ giết người khủng khiếp vào những đêm trăng tròn. Những hiện trường được sắp đặt với rất nhiều ý đồ nhưng rất ít dấu vết. Một sát thủ thích phô trương, thách thức cảnh sát bằng những lời nhắn trêu ngươi. Một con quái vật khốn khổ chỉ tìm thấy niềm vui trong việc sát hại các gia đình hạnh phúc. Một kẻ thái nhân cách chìm trong những logic quái gở và những hoang tưởng bất khả hình dung. Hắn tự gọi mình là Rồng Đỏ. 

Trước khi có Hannibal Lecter đã có Rồng Đỏ. Rồng Đỏ không có được vẻ sắc lạnh rợn người mà thu hút khó cưỡng của Hannibal, nhưng ở hắn có thứ nhân tính méo mó vừa gây sợ hãi vừa gợi nên những trắc ẩn đau lòng. Là một sự pha trộn khôn ngoan của thuật loại suy, tính hồi hộp, của hành động và nỗi kinh hoàng. lại được viết chặt chẽ hơn nhiều tiểu thuyết ly kỳ khác, Rồng Đỏ hoàn toàn xứng đáng với lời khen tặng của Stephen King:'' Tiểu thuyết đại chúng xuất sắc nhất kể từ sau Bố Già " ', N'https://product.hstatic.net/1000363117/product/8935235234130_a32f5d190022481da747071f8bb838d4_master.jpg', NULL, 5)
INSERT [dbo].[Book] ([ID], [Name], [Price], [Category_ID], [Sale], [Content], [Image], [Author], [Count]) VALUES (N'TT04      ', N'VE SẦU MƯỜI BẢY NĂM', 109, N'TT        ', 10, N'Một nhà nghiên cứu lịch sử chết trong thư phòng bên bài thơ kỳ lạ. 

Một cô gái khao khát “kết án đàn ông” gục trên biển giấy với vô số dòng chữ “Chết đi!”. 

Một cựu nữ cảnh sát tử vong vì khí thải trong ô tô bị bịt kín. 

“Tự sát” hay “bị giết”. 

Điều tra viên Kuraishi Yoshio thuộc đội điều tra số 1 chuyên phụ trách những cái chết bất thường, là người sẽ nhìn ra. 

Vì từ hoa trong chậu hay tiếng hót của chim trong lồng, ông có thể đọc được thông tin liên quan đến tử thi. 

Tác phẩm được đề cử Giải Honkaku Mystery lần thứ 5 và được chuyển thể thành các phiên bản phim truyền hình, phim điện ảnh và manga.', N'https://product.hstatic.net/1000363117/product/b_a-ve-s_u_f63ec88240684ebeae9a3721fbc5fdb1_master.jpg', NULL, 2)
INSERT [dbo].[Book] ([ID], [Name], [Price], [Category_ID], [Sale], [Content], [Image], [Author], [Count]) VALUES (N'TT05      ', N'TẤN BI KỊCH Z', 96, N'TT        ', 10, N'10 năm sau thành công rực rỡ của Tấn bi kịch X và Tấn bi kịch Y, Tấn bi kịch Z ra đời! Thanh tra Thumm đã trở lại với cô con gái thông minh, có khả năng quan sát và liên kết các sự việc. 

  Thượng Nghị sĩ tham nhũng Joel Fawcett – một người có vô vàn kẻ thù, bị sát hại! Bác sĩ Ira Fawcett, cũng bị sát hại! Hung thủ là một! Aaron Dow – tên tù nhân mới phóng thích vô tình trở thành kẻ tình nghi. 

   Với quyết tâm tìm kiếm bằng chứng để minh oan cho Aaron Dow, bố con thanh tra Thumm đã đạt mình vàomột cuộc chiến công lý với tia hy vọng chỉ bằng 1%. Một lần nữa, Thumm lại phải nhờ đến sự minh mẫn của người bạn già Drury Lane 

   Câu hỏi cuối cùng sẽ được giải quyết ra sao mang tên Z? ', N'https://product.hstatic.net/1000363117/product/image_229221_9841dbe411ad4f6889c96be039c3e4db_master.jpg', NULL, 1)
INSERT [dbo].[Book] ([ID], [Name], [Price], [Category_ID], [Sale], [Content], [Image], [Author], [Count]) VALUES (N'TT06      ', N'AGATHA CHRISTIE - NHỮNG QUÂN BÀI TRÊN MẶT BÀN ', 130, N'TT        ', 10, N'Ông Shaitana nổi tiếng là người chủ trì các bữa tiệc xa hoa. Tuy nhiên, hầu hết mọi người đều kiêng dè ông – họ vừa thích vừa sợ khi nghe ông hé lộ những bí mật đen tối của người khác. 

Vì vậy, thám tử Hercule Poirot có hơi dè dặt khi đến tham dự bữa tiệc tại nhà riêng và xem “bộ sưu tập tội phạm” của ông Shaitana. Như ông Poirot đã lo sợ, sau phần tiệc tùng và những ván bài bridge, các khách mời đã đối mặt với một mối nguy khôn lường… 

-- 

Những quân bài trên mặt bàn một lần nữa cho thấy óc quan sát tinh tế, sự hiểu biết sâu sắc tâm lý tội phạm của Agatha Christie. Như nhận định của nhiều nhà phê bình, cuốn sách đã góp phần khẳng định vị trí “Nữ hoàng của tiểu thuyết trinh thám” mà thế giới đã dành cho bà. ', N'https://product.hstatic.net/1000363117/product/nhung-quan-bai-tren-mat-ban-3_9d86ea6d5f2845fcae5a4eaa75ecfce7_master.jpg', NULL, 4)
INSERT [dbo].[Book] ([ID], [Name], [Price], [Category_ID], [Sale], [Content], [Image], [Author], [Count]) VALUES (N'TT07      ', N'MỘT HỌA SĨ CHẾT RỒI THÀNH DANH ĐÃ TRỞ LẠI ', 165, N'TT        ', 10, N'MỘT KẾ HOẠCH ĐẦY TINH VI ĐƯỢC VẠCH RA TỪ ĐẦU TỚI CUỐI CUỐN SÁCH NÀY! 

Họa sĩ lỡ vận đột ngột tử vong, để rồi nổi tiếng khắp cả nước chỉ trong một đêm. 

Có người chấp nhận quá khứ của hắn, có người cảm thông với cảnh ngộ của hắn, cũng có người điên cuồng dành lời có cánh cho các tác phẩm của hắn. 

Mọi thứ mà hắn khổ sở kiếm tìm “lúc còn sống” ồ ạt ùa đến với hắn “sau khi chết”. 

Nhưng đằng sau danh lợi vẻ vang là nguy cơ tiềm phục bốn bề. 

Trong tầng hầm khép kín đang triển lãm các tác phẩm hắn để lại cũng vọng ra tiếng thét gào tuyệt vọng. 

Hắn làm thế nào để thao túng tất cả những chuyện này, còn sống mà lại có thể “chết rồi thành danh”? 

Và hắn làm thế nào để chống lại thế lực nhiều phía, điên cuồng đánh trả? 

Ván cờ trí mạng đã vén màn, cái chết thật sự đang từng bước áp sát! 

Hãy mở quyển sách ra và chứng kiến kế hoạch nổi danh sau khi chết được dày công sắp đặt! ', N'https://product.hstatic.net/1000363117/product/e49038daf8bcb096d285d2eab8d74d29_d19b1b647d1e4cdb890171db7202a7b0_master.jpg', NULL, 3)
INSERT [dbo].[Book] ([ID], [Name], [Price], [Category_ID], [Sale], [Content], [Image], [Author], [Count]) VALUES (N'TT08      ', N'NHẬT KÝ PHÁP Y ', 198, N'TT        ', 10, N'Nhật Ký Pháp Y - Da Người, Đuốc Sống Và “Đá Hồng” 

- Cuốn sách được giới thiệu bởi Tử Kim Trần và bác sĩ pháp y Lưu Hiểu Huy. 

- Tuyển tập hàng loạt tình tiết rùng rợn, hấp dẫn: vứt xác ở trung tâm thành phố, album da người, giao dịch web đen, trừng phạt phi pháp. 

- Tái hiện cuộc đối đầu giữa bác sĩ pháp y thiên tài và nghi phạm biến thái với chỉ số IQ cao. 

- Tại thị trường nội địa, phiên bản điện tử của "Nhật Ký Pháp Y" đã vượt qua 1 triệu lượt đọc, phiên bản sách audio vượt 10 triệu lượt nghe. 

- Là tác phẩm mới nhất nằm trong truyển tập dựa trên những vụ án có thật "Ghi chép pháp y", được Hồng Mâu viết nên bởi chính kinh nghiệm nghề nghiệp của ông. 

______________________ 

Giới thiệu cốt truyện 

Vụ án đầu tiên bắt đầu vào ngày 12/7/2018, thi thể phụ nữ lần lượt xuất hiện ở thành phố A. Những người thiệt mạng đều bị tấn công tình dục và bị lột một phần da ở cùng một vị trí trên cơ thể. Bác sĩ pháp y thiên tài Trương Chiêu được chỉ định trực tiếp tham gia vụ án. 

Trương Chiêu có chỉ số IQ 152 và có bằng tiến sĩ kép về pháp y và tâm lý tội phạm. Vì mắc chứng rối loạn nhân cách chống đối xã hội, Trương Chiêu bị coi là quái vật của đội cảnh sát hình sự. Khi nghiên cứu sâu vào vụ án, anh phát hiện một nhân vật ẩn lấp suốt 10 năm đang dần lộ diện, và mỗi bước đi của Trương Chiêu dường như đều nằm trong kế hoạch của hắn. ', N'https://product.hstatic.net/1000363117/product/2d-nhat-ky-phap-y_-duoc-song-va-da-hong_1435a92b46a3489993b99109f1301e0b_master.jpg', NULL, 2)
INSERT [dbo].[Book] ([ID], [Name], [Price], [Category_ID], [Sale], [Content], [Image], [Author], [Count]) VALUES (N'TT09      ', N'TRÒ CHƠI ĐOẠT MẠNG - THE KILLING GAME - HE DIES, YOU DIE ', 185, N'TT        ', 10, N'Một tay súng đột nhập vào nhà hàng Hollywood nơi người nổi tiếng tụ tập, một dạo diễn bị bắt quay trực tiếp hiện trường đưa lên MXH khiến giới truyền thông bên ngoài náo loạn. Tội phạm sử dụng trò chơi để chọn ra nạn nhân, mỗi vòng 30 phút chỉ có 7 cơ hội sống sót. Nhìn những người xung quanh lần lượt bị bắn chết, những người sống sót phải làm thế nào để thuyết phục bọn côn đồ : Tôi không nên là người chết tiếp theo? Nhà báo JJ có mặt tại dó dóng vai trò tìm ra mục đích của tay súng và giải cứu mọi người.', N'https://product.hstatic.net/1000363117/product/5aa8bd046481b8d98e9a358225cedcb8_e4bfb03d8e3f4b328c5ce52224572d9b_master.jpg', NULL, 5)
INSERT [dbo].[Book] ([ID], [Name], [Price], [Category_ID], [Sale], [Content], [Image], [Author], [Count]) VALUES (N'TT10      ', N'BẢNG DANH SÁCH TỬ HÌNH - MÊ CUNG KÝ ỨC ', 165, N'TT        ', 10, N'“Trong tim mỗi người đều có một nơi không thể chạm vào, trong mênh mông ký ức là tòa mê cung không tìm thấy lối ra.” 

Lấy cảm hứng từ một trong thập đại huyền án Nhật Bản và án mạng liên hoàn Hwaseong Hàn Quốc, Bảng danh sách tử hình - Mê Cung Ký Ức là một bản phác họa hồ sơ tâm lý tội phạm với những cái chết bất thường, những hiện trường án mạng rùng rợn và vô số thủ đoạn phạm tội tàn ác. 

23 năm, khi mọi manh mối về tên sát nhân hàng loạt tưởng như đã bị vùi lấp theo dòng thời gian, chiếc móc chìa khóa năm xưa lại bất ngờ trở về, bất động trong những bàn tay lạnh ngắt. Thành phố An Bình một lần nữa rơi vào cơn ác mộng. Xác những cô gái tuổi đôi mươi vỡ nát hình hài nằm gục trước mặt gương máu. Thanh tra cảnh sát trẻ tuổi, chuyên gia tâm lý tội phạm Lý Chấn Phong tiếp nhận vụ án năm xưa bố mình còn dang dở. Cùng thủ pháp gây án, cùng một kiểu nạn nhân, cùng mảnh nhựa hình chuột Mickey như trêu đùa, bỡn cợt lòng người. Và cũng như 23 năm trước, khi sự thật tưởng như sắp được phơi bày, mọi suy luận một lần nữa đi vào ngõ cụt. Nhân chứng, vật chứng, hồ sơ pháp y và những phác họa tâm lý tội phạm phủ định lẫn nhau, không tìm ra giao điểm. Giữa mênh mông ký ức, đâu mới là điểm khởi đầu? ', N'https://product.hstatic.net/1000363117/product/e6570b29618216c64d8c2d59558d96e4-removebg-preview_2d3ae9174a5d4ca2936865011c4093ef_master.png', NULL, 2)
INSERT [dbo].[Book] ([ID], [Name], [Price], [Category_ID], [Sale], [Content], [Image], [Author], [Count]) VALUES (N'TT11      ', N'TRỞ LẠI HIỆN TRƯỜNG VỤ ÁN ', 165, N'TT        ', 10, N'"Trở lại hiện trường vụ án" của tác giả Mã Đinh Hàn Trang là 14 câu chuyện về 14 tội ác trong các vụ án điển hình trên thế giới. Mỗi một câu chuyện đều có nguyên nhân và kết quả của riêng nó, thứ chúng ta đọc được không chỉ là bản thân câu chuyện mà còn là những suy tư về nhân tính và chân tướng, về công lý và chính nghĩa. Những suy nghĩ ấy có thể khiến bạn phẫn nộ, cũng có thể khiến bạn thở dài. 

Nếu pháp luật chưa hoàn thiện sẽ có hậu quả ra sao? Chúng ta phải dựa dẫm hoặc tin tưởng vào pháp luật như thế nào? Chúng ta nên nhìn nhận những vấn đề trong cuộc sống như thế nào để giữ được sự công chính và sáng suốt? Làm thế nào để tránh cho cảm xúc ảnh hưởng đến phán đoán của chúng ta v.v... 

Hiểu được ý nghĩa của những điều ấy sẽ giúp ta nhẹ lòng và thêm thấu hiểu về thế giới xung quanh mình, về giá trị tồn tại của bản thân, đón nhận và kiên trì với nó. ', N'https://product.hstatic.net/1000363117/product/tro-lai-hien-truong-vu-an-3_592dcf3e5a674a4285b8e57f8558054a_master.jpg', NULL, 2)
INSERT [dbo].[Book] ([ID], [Name], [Price], [Category_ID], [Sale], [Content], [Image], [Author], [Count]) VALUES (N'TT12      ', N'MÃ GIEN TỘI ÁC (PHẦN TIẾP THEO CỦA HỘI CHỨNG E) ', 269, N'TT        ', 10, N'PHẦN TIẾP THEO CỦA TÁC PHẨM ĐÌNH ĐÁM "HỘI CHỨNG E"!!! 

Có mối liên hệ nào giữa những kẻ giết người vô cùng hung hãn thuận tay trái và người Cro-Magnon, giữa những người không dung nạp lactose và một bộ tộc sống tách biệt mãi sâu trong rừng già Amazon? 

Trong khi Lucie Henebelle chật vật quay trở lại với cuộc sống sau biến cố khủng khiếp xảy ra với cô, cựu thanh tra trưởng Sharko bị đẩy cho những vụ điều tra “hạng hai” như vụ phát hiện ra xác một nhà nghiên cứu trẻ bị một con tinh tinh đánh chết. 

Tái hợp trong hoàn cảnh tệ hại nhất, lần này cặp đôi cảnh sát lặn ngụp tìm kiếm nguồn gốc của bạo lực mà ở đó, bộ gien của con người sẽ quyết định tương lai của nhân loại: diệt chủng. PHẦN TIẾP THEO CỦA TÁC PHẨM ĐÌNH ĐÁM "HỘI CHỨNG E"!!! 

Có mối liên hệ nào giữa những kẻ giết người vô cùng hung hãn thuận tay trái và người Cro-Magnon, giữa những người không dung nạp lactose và một bộ tộc sống tách biệt mãi sâu trong rừng già Amazon? 

Trong khi Lucie Henebelle chật vật quay trở lại với cuộc sống sau biến cố khủng khiếp xảy ra với cô, cựu thanh tra trưởng Sharko bị đẩy cho những vụ điều tra “hạng hai” như vụ phát hiện ra xác một nhà nghiên cứu trẻ bị một con tinh tinh đánh chết. 

Tái hợp trong hoàn cảnh tệ hại nhất, lần này cặp đôi cảnh sát lặn ngụp tìm kiếm nguồn gốc của bạo lực mà ở đó, bộ gien của con người sẽ quyết định tương lai của nhân loại: diệt chủng. ', N'https://product.hstatic.net/1000363117/product/57bfdd8cf93c3adfeee5039a52c9df0d_5ecee5b6f2304342a09dc5babf406cfc_master.jpg', NULL, 3)
INSERT [dbo].[Book] ([ID], [Name], [Price], [Category_ID], [Sale], [Content], [Image], [Author], [Count]) VALUES (N'TT13      ', N'CHIẾN BINH ZULU ', 216, N'TT        ', 10, N'MỘT TRONG NHỮNG TÁC PHẨM VĂN CHƯƠNG ẤN TƯỢNG NHẤT CỦA NHÀ VĂN PHÁP CARYL FÉREY!! 

Cuối thế kỷ 20, cuộc chiến khốc liệt giữa các đảng phái ở Nam Phi đã gây bao đau thương cho người dân, trong đó có gia đình của Ali Neuman. Mất cha và anh trai trong cuộc thanh trừng tộc người Zulu, Ali trở thành đội trưởng đội cảnh sát hình sự Cape Town với nhiệm vụ giải quyết hai vấn nạn lớn của đất nước là bạo lực và bệnh AIDS. 

Một loạt án mạng đột nhiên diễn ra, khởi đầu là vụ giết hại con gái cựu thành viên đội bóng bầu dục danh tiếng, làm dấy lên làn sóng kích động từ phía người dân và báo chí. Điểm chung của các vụ án là nạn nhân đã sử dụng một loại ma túy trôi nổi có nguồn gốc bí ẩn. Cùng hai cộng sự Brian Epkeen và Dan Fletcher, Ali Neuman lên đường truy tìm thủ phạm mà không hề biêts mình đang lần theo những manh mối tử thần. 

Tác phẩm đã mang về cho Caryl Férey giải Grand Prix dành cho văn học trinh thám 2008, giải thưởng tạp chí Elle hạng mục trinh thám 2009, Quais du Polar 2009 và giải Jean Amila-Meckert 2009! ', N'https://product.hstatic.net/1000363117/product/chien-binh-zulu-3_196a2fc8cfe54bbb8e63dd2b15065432_master.jpg', NULL, 5)
INSERT [dbo].[Book] ([ID], [Name], [Price], [Category_ID], [Sale], [Content], [Image], [Author], [Count]) VALUES (N'TT14      ', N'NOA - MÙA XUÂN THỨC GIẤC ', 169, N'TT        ', 10, N'TÁC PHẨM TRINH THÁM NGHẸT THỞ, NẰM TRONG SERIES "9" CỦA NHÀ VĂN MARC LEVY! 

Biết bao mạng sống đang gặp nguy hiểm. Để thực hiện nhiệm vụ, lần này một thành viên của Hội 9 phải xâm nhập hang ổ địch. Thời gian vô cùng gấp gáp. Tương lai của cả một dân tộc đang bị thách thức. Ai sẽ đóng vai trò chủ chốt trong cuộc chiến chống lại một âm mưu toàn cầu: phá hủy các nền dân chủ? 

Từ London đến Kyiv, từ Vilnius đến Rome, từ Israel nóng rực đến một nhà tù khủng khiếp băng giá, Hội 9 lại tiếp tục đồng hành cùng nhau trong một cuộc phiêu lưu nghẹt thở với những công nghệ đỉnh cao, những màn rối trí trước các thông điệp được mã hóa. Dù hiểm nguy luôn rình rập các hacker Mũ Xám, tình yêu vẫn luôn tìm ra lý lẽ cho mình. Và cuối cùng, mùa xuân cũng đến. ', N'https://product.hstatic.net/1000363117/product/noa-mua-xuan-thuc-giac_80d031163dfe42f1a448718454e5a0b7_master.jpg', NULL, 4)
INSERT [dbo].[Book] ([ID], [Name], [Price], [Category_ID], [Sale], [Content], [Image], [Author], [Count]) VALUES (N'TT15      ', N'KẺ TIỄN BIỆT ', 185, N'TT        ', 10, N'“Kẻ tiễn biệt” là tập thứ 2 trong series về Colter Shaw. Colter Shaw, gã thợ săn tiền thưởng luôn đề cao phương châm “tìm người, cứu mạng”. Nhưng khi nhiệm vụ mới nhất của anh kết thúc trong bi kịch, Shaw cảm thấy mình cần tìm hiểu nguồn cơn của mọi việc. Những manh mối dẫn anh đến với tổ chức bí ẩn nằm giữa vùng hoang dã của Bang Washington. Một cộng đồng vô hại với sứ mệnh an ủi những người đau buồn? Hay là một giáo phái nguy hiểm nằm dưới sự thống trị của một nhà lãnh đạo quyết rũ? 

Cùng lúc đó, Colter Shaw phải định vị và giải mã một thông điệp được cất giấu nhiều năm trước: Một thông điệp từng đẩy cha anh đến chỗ chết, giờ tiếp tục đe dọa mạng sống của Shaw và gia đình. 

Có những sự thật chết người. Có những kẻ sẵn sàng nhúng chàm chỉ với mục đích là giữ kín chúng. Có những người sẵn sàng liều mạng để tìm ra. ', N'https://product.hstatic.net/1000363117/product/ke-tien-biet-3_f2cf124d98ba4e96a224d007519dffb8_master.jpg', NULL, 1)
INSERT [dbo].[Book] ([ID], [Name], [Price], [Category_ID], [Sale], [Content], [Image], [Author], [Count]) VALUES (N'TT16      ', N'NHỮNG CÔ GÁI CUỐI CÙNG ', 185, N'TT        ', 10, N'10 năm trước, sáu người bạn cùng nhau đi nghỉ. Chỉ một người trong đó còn sống… 

Vào thời khắc đó, cô sinh viên Quincy Carpenter đã gia nhập vào một nhóm cá biệt mà cánh báo chí đặt tên là “Những Cô Gái Cuối Cùng” (The Final Girls), bao gồm: Lisa, người đã mất đi chín người bạn học nữ dưới lưỡi dao của một kẻ bỏ học đại học; Sam, người từng bị bắt cóc trong ca làm việc của mình tại khách sạn Nightlight; và giờ đây là Quincy, máu me đầy người chạy qua cánh rừng để đào thoát khỏi vụ thảm sát tại nhà Pine. Mặc cho nhiều nỗ lực của giới truyền thông, cả ba cô gái chưa từng gặp nhau. 

Hiện tại, cuộc sống của Quincy đã ổn định, thậm chí rất tuyệt, nhờ vào liều thuốc an thần mà cô được kê. Cô có một vị hôn thê luôn quan tâm săn sóc cho mình; một trang blog nổi tiếng đình đám; một căn hộ đẹp đẽ; và sự kề bên thường trực đầy an tâm của Coop, người cảnh sát đã cứu sống cô. Cô không còn bị ám ảnh về những gì diễn ra vào tối hôm ấy; dĩ vãng đã là dĩ vãng… cho đến khi cô gái đầu tiên trong nhóm “Sống Sót” được phát hiện đã chết trong bồn tắm và cô gái thứ hai xuất hiện ngay trước cửa nhà Quincy. 

Như một cơn bão quét qua cuộc đời của Quincy, Sam dường như chủ ý muốn cô sống lại cảm giác đau đớn tột cùng đã trải qua. Khi những chi tiết kinh hoàng về cái chết của Lisa trở nên rõ ràng, Quincy nỗ lực hết sức để lật tẩy những lời nói dối của Sam đồng thời tránh né cảnh sát và đám phóng viên khát máu. Quincy hiểu rằng để sống sót, cô phải nhớ lại những gì đã thực sự diễn ra ở nhà Pine. 

Bởi lẽ, điều duy nhất tồi tệ hơn việc trở thành một cô gái “Sống Sót” là cái chết.', N'https://product.hstatic.net/1000363117/product/nhung-co-gai-cuoi-cung_12272f30129946f0a43c101ecf075926_master.jpg', NULL, 2)
INSERT [dbo].[Book] ([ID], [Name], [Price], [Category_ID], [Sale], [Content], [Image], [Author], [Count]) VALUES (N'TT17      ', N'XOẮN ỐC VÔ HÌNH ', 140, N'TT        ', 10, N'CÂU CHUYỆN HÉ LỘ BÍ MẬT CỦA VỊ "THÁM TỬ GALILEO" YUKAWA MANABU! 

Xác của Uetsuji Ryota, một kẻ vô công rồi nghề được tìm thấy ngoài khơi Minamiboso. Shimauchi Sonoka, cô người yêu sống cùng Uetsuji đã bỏ trốn sau khi nộp đơn trình báo người yêu mất tích. Kỳ lạ thay, manh mối mỏng manh duy nhất để cảnh sát có thể lần ra tung tích của Sonoka lại nằm ở chỗ Yukawa Manabu, vị giáo sư thiên tài từng không ít lần giúp cảnh sát phá án. Yukawa liên quan thế nào tới vụ án? Và bí mật nào đang ẩn đằng sau đó? 

Xoắn ốc vô hình lần đầu tiên hé lộ những bí mật riêng tư, những khía cạnh vô cùng “con người” của vị giáo sư nổi tiếng lạnh lùng Yukawa Manabu. ', N'https://product.hstatic.net/1000363117/product/xoan-oc-vo-hinh-3_c9ca90e214784aafbea6c311e4f1c039_master.jpg', NULL, 3)
INSERT [dbo].[Book] ([ID], [Name], [Price], [Category_ID], [Sale], [Content], [Image], [Author], [Count]) VALUES (N'TT18      ', N'AGATHA CHRISTIE - BI KỊCH BA HỒI ', 125, N'TT        ', 10, N'Hercule Poirot là một trong mười ba vị khách được mời đến dự tiệc tối tại nhà ngài Charles Cartwright, một diễn viên kịch nổi tiếng. Buổi tiệc kết thúc không mấy vui vẻ khi vị mục sư hiền hòa, Stephen Babbington nhấp một ngụm cocktail rồi bất ngờ lên cơn co giật và chết. Khi ly rượu của ông được đi xét nghiệm, kết quả cho thấy không có dấu vết của chất độc, đúng như dự đoán của Poirot. Rắc rối hơn nữa, dường như chẳng có động cơ nào cho vụ án mạng này. 

Sau lễ tang, Poirot rời đi để rồi được tin bác sĩ Strange, một vị khách khác của bữa tiệc, cũng đã mất mạng sau khi uống rượu trong một bữa tiệc khác. Không có gì ngạc nhiên, những vị khách từng có mặt tại nhà Cartwright cũng hiện diện ở nhà Strange. Một lần nữa, Hercule Poirot phải tìm ra sự thật. ', N'https://product.hstatic.net/1000363117/product/bi-kich-ba-hoi-3_1b53dc62a4864ae5afb7333c4e5b29ec_master.jpg', NULL, 5)
INSERT [dbo].[Book] ([ID], [Name], [Price], [Category_ID], [Sale], [Content], [Image], [Author], [Count]) VALUES (N'TT19      ', N'NHẬT KÝ MẤT TÍCH CỦA TÔI ', 178, N'TT        ', 10, N'Tám năm trước, Malin khi đó là thiếu nữ 17 tuổi vô tình phát hiện một đầu người với mái tóc dài màu nâu bị chôn vùi trong khu rừng Ormberg, một thị trấn xa xôi của Thụy Điển. Danh tính của bé gái vẫn còn là một bí ẩn chưa có lời giải. Malin hiện giờ là cảnh sát. Vì là người trong vùng nên cô được gọi đến hỗ trợ điều tra vụ án tám năm trước. Nhưng cảnh sát chỉ vừa mới vào cuộc thì thanh tra Peter biến mất chỉ sau một đêm, còn Hanne thì được tìm thấy trong rừng với thương tích và hoàn toàn mất trí. 

Jake, một nam sinh 15 tuổi thích cải trang thành con gái đã bắt gặp Hanne và được bà đưa cho cuốn nhật ký của mình trong đó là toàn bộ những ghi chép của Hanne liên quan đến cuộc điều tra. Jake đã chìm đắm trong những dòng ghi chép đó, và cậu bé đã góp công rất lớn giúp cảnh sát tìm được thi thể của Peter, cứu mạng Hanne và vén bức màn bí ẩn về những bí mật được chôn vùi suốt 25 năm. 

Nhật Ký Mất Tích Của Tôi là phần tiếp theo, độc lập của câu chuyện của Hanne và Peter, sau thành công của Tiếng thét dưới băng. 

Tác phẩm nhận giải thưởng dành cho tiểu thuyết tội phạm Thụy Điển xuất sắc nhất của Hội tác giả trinh thám Thụy Điển (2017) và giải thưởng thường niên dành cho hạng mục tiểu thuyết trinh thám hay nhất (2018). Tác phẩm đã được hơn 20 quốc gia mua bản quyền chuyển ngữ và nhượng quyền chuyển thể điện ảnh cho một công ty truyền hình Mỹ. ', N'https://product.hstatic.net/1000363117/product/8935069923101_9cc998ed4b304fa885812aae44020cc8_master.jpg', NULL, 4)
INSERT [dbo].[Book] ([ID], [Name], [Price], [Category_ID], [Sale], [Content], [Image], [Author], [Count]) VALUES (N'TT20      ', N'SONG NGUY THUYỀN ', 340, N'TT        ', 10, N'Sau cái chết của nhà thám hiểm nổi tiếng William, Tô Ngữ, một du học sinh người Trung Quốc tại Đại học Oxford, bắt đầu dấn thân vào hành trình tìm kiếm cuốn sách bí ẩn mà William đã từng xuất bản. Cũng từ ngày ấy, một mê cung kỳ bí bắt đầu cuốn lấy cô cùng người bạn trai Andre của mình. Những nhân vật bí ẩn dần xuất hiện, liệu những người đó đóng vai trò gì trong câu chuyện của William? Ai là Hercules, ai là Atlas và ai là Trái Táo Vàng? Con thuyền cổ hai cột buồm là một ẩn ức như thế nào trong nỗi day dứt khôn nguôi của William? Bên cạnh cuốn sách của William, cuốn nhật ký của Asia, người vợ của ông, cũng gợi mở nhiều chi tiết. Những trang nhật ký nhuốm màu thời gian ấy ẩn chứa cả một khoảng ký ức tăm tối của lịch sử châu Âu dưới sự thống trị của Đức quốc xã và những số phận bi thương bị đặt trong bối cảnh lịch sử của dân tộc mình. Trên con đường tìm kiếm cuốn sách đầy gian nan ấy, cảm xúc trong Tô Ngữ đã vỡ ào khi cô khám phá ra câu chuyện về tình thân, tình bạn, tình yêu của William và những người thân yêu của ông, đồng thời, cuộc hành trình này cũng giúp cô tìm thấy chính bản thân mình.', N'https://product.hstatic.net/1000363117/product/3-4__19__988d76b0e648422e88a7b71ec2fb8922_master.jpg', NULL, 1)
INSERT [dbo].[Book] ([ID], [Name], [Price], [Category_ID], [Sale], [Content], [Image], [Author], [Count]) VALUES (N'TT21      ', N'THỜI KHẮC SINH TỬ ', 199, N'TT        ', 10, N'"Một doanh nhân sang Mỹ du lịch bị bắt cóc ngay trên con phố ở khu Upper East Side giữa ban ngày ban mặt. Đó là lời kể của nhân chứng duy nhất, một cô bé tám tuổi. Hung thủ đã để lại hiện trường một biểu tượng – một cái thòng lọng thu nhỏ đầy ẩn ý. Hiện trường tội ác khó hiểu này đòi hỏi chuyên môn của Lincoln Rhyme và Amelia Sachs. 

Cuộc điều tra của Rhyme và Sachs có bước ngoặt bất ngờ khi một vụ bắt cóc tuơng tự cũng xảy ra bên kia bờ biển Atlantic, tại một thị trấn nhỏ ngoại ô Naples, nước Ý. Phương thức gây án của hung thủ rất đáng sợ và kỳ dị. 

Bị ám ảnh bởi âm nhạc, nên hung thủ đã ghi âm lại những hơi thở cuối cùng của các n.ạn nh.ân, sau đó dùng phầm mềm tạo bản nhạc thu sẵn để sáng tác một giai điệu kỳ dị rồi đăng tải lên mạng. Cuộc tìm kiếm kẻ sát nhân trở thành một vụ án phức tạp cần sự hợp tác trên toàn thế giới – không lâu sau đó Rhyme và Sachs nhận ra mình đang chơi một trò chơi nguy hiểm liên quan các tổ chức đen tối phía bên kia địa cầu. 

"Thời khắc sinh tử" của Deaver khiến cho người đọc nhờiư bước vào một mê cung rối rắm, những vén màn bí mật gây bất ngờ, và không thiếu những pha gay cấn, nghẹt thở." ', N'https://product.hstatic.net/1000363117/product/b_a_tr_c_th_i_kh_c_sinh_t_file_in-1_30c36930f2a14ab599089f037763bc41_master.jpg', NULL, 2)
INSERT [dbo].[Book] ([ID], [Name], [Price], [Category_ID], [Sale], [Content], [Image], [Author], [Count]) VALUES (N'TT22      ', N'SÁT THI NHÂN ', 175, N'TT        ', 10, N'"Năm 1996, người ta phát hiện ra thi thể của một cậu bé 13 tuổi dưới một con suối tại Georgetown, bang Texas, Hoa Kỳ. Ai cũng cho rằng đó chỉ là một tai nạn đuối nước thương tâm, cả cô bé học cùng lớp với nạn nhân xấu số cũng cho là vậy, và vụ việc cứ thế khép lại. 

Cho đến nhiều năm sau, khi cô bé ấy, nay đã trở thành Thám tử Samantha Jazz, đang chìm trong những ám ảnh về cái chết của cha mình, thì bỗng một vụ án bí ẩn xảy ra. Nạn nhân bị đầu độc, trói vào ghế trong tình trạng khỏa thân và trong miệng bị nhét một đoạn thơ ngắn. Hơn thế nữa, thám tử đang xử lý vụ án này đột nhiên mất tích, và Samantha được chỉ định tiếp quản nó nhờ vào khả năng cùng những hiểu biết của cô về thơ. 

Cùng với người đồng sự Ethan Langsford và anh bạn trai cũ – đặc vụ FBI Wade Miller, Samantha từng bước tới gần với chân tướng vụ án mạng và tên hung thủ mà cô gọi là “Thi Sĩ”, mà không ngờ rằng đây chính là phần tiếp theo của cái sự mệnh tăm tối đã được châm ngòi từ vụ “tai nạn” nhiều năm về trước." ', N'https://product.hstatic.net/1000363117/product/b_a-tr_c-s_t-thi-nh_n-file-in-fahasa-1_be57b8725e8e4ef2bc0874276a1eb3fb_master.jpg', NULL, 3)
INSERT [dbo].[Book] ([ID], [Name], [Price], [Category_ID], [Sale], [Content], [Image], [Author], [Count]) VALUES (N'TT23      ', N'SÁT NHÂN MẠNG (TÁI BẢN) ', 159, N'TT        ', 10, N'Tiểu thuyết “Sát nhân mạng” của Jeffery Deaver khai thác một chủ đề mới về hacker và thế giới máy tính, những thứ vô cùng gắn bó với cuộc sống hiện đại. Câu chuyện xuất phát từ ý niệm rất giản đơn: Sẽ đáng sợ thế nào nếu ai đó có thể biết mọi điều về cuộc sống của chúng ta - những điều chúng ta nghĩ là bí mật của riêng mình, và sử dụng chính những thông tin ấy để sát hại chúng ta. Nỗi cô đơn và sự ruồng bỏ suốt thuở thiếu thời đã biến Phate thành một hacker máu lạnh. Hắn chui vào vỏ bọc của mình trong thế giới máy tính, và tin rằng thế giới thực chỉ là một trò chơi nhập vai, nơi hắn giết người như một nhân vật trong trò chơi để giành điểm số. 

Mỗi trang sách là một cuộc rượt đuổi đầy cam go trên thế giới máy tính và cả ngoài đời thực. Cứ mỗi lần tưởng chừng đã tóm được tay sát nhân hàng loạt, thì hắn lại vụt khỏi tầm tay. Những tình huống bất ngờ đan xen trên từng trang sách khi không biết ai là gián điệp tiếp tay cho kẻ giết người, và nhân dạng thực sự của tên sát nhân Phate ra sao…người tốt và kẻ xấu đều muốn giành chiến thắng trong trò chơi chiến thuật máy tính ngoài đời thực. ', N'https://product.hstatic.net/1000363117/product/b_a-tr_c-sat-nhan-mang-file-in-tb-2022-2_de72df387d8c47de836b45b507434261_master.jpg', NULL, 5)
INSERT [dbo].[Book] ([ID], [Name], [Price], [Category_ID], [Sale], [Content], [Image], [Author], [Count]) VALUES (N'TT24      ', N'LẠC VÀO TAY TỬ THẦN ', 159, N'TT        ', 10, N'Long Island, New York vào một ngày cuối mùa xuân năm 2010, Shanan Gilbert hoảng loạn kêu cứu trong khi đang trốn chạy, rồi cô gái ấy biến mất không ai hay. Bảy tháng sau, giới chức trách đã tìm thấy bốn thi thể phụ nữ bị chon giấu gần đó, nhưng không ai trong số đó là Shannan cả. 

Cảnh sát đã chính thức phát động cuộc điều tra tìm kiếm tên sát nhân hàng loạt vùng Long Island. Vụ án nhanh chóng thu hút giới truyền thông, nhưng việc phá án dần rơi vào bế tắc. Trong khi đó, người thân và bạn bè của các cô gái không ngừng lên tiếng đòi công lý và học cách đối mặt với mất mát. ', N'https://product.hstatic.net/1000363117/product/9786043879636_ee0ff9deecaf4cf1a303d85d113553fb_master.jpg', NULL, 4)
INSERT [dbo].[Book] ([ID], [Name], [Price], [Category_ID], [Sale], [Content], [Image], [Author], [Count]) VALUES (N'TT25      ', N'LÁ BÀI CHỦ ', 189, N'TT        ', 10, N'"Henry Loving là một kẻ được thuê để đánh cắp thông tin của người khác. Hắn cực kỳ thành thạo việc đó. 

Ryan Kessler một cảnh sát ở Washington DC trở thành “con mồi” tiếp theo của Loving. Một nhân viên bảo vệ cấp cao liên bang tên là Corte được giao nhiệm vụ để giữ mạng sống cho Kessler và gia đình ông. Corte có biệt danh “người chăn cừu”, anh là người không khoan nhượng, luôn nỗ lực không ngừng để bảo vệ những người anh quan tâm. Ngoài ra, Corte còn là một chuyên gia trong lĩnh vực game nhập vai, chính những am hiểu trong lĩnh vực game đã giúp anh hoàn thành rất nhiều nhiệm vụ. 

Nhưng tất cả những điều đó đều không có ý nghĩa gì cho tới khi Loving một lần nữa xuất hiện trong cuộc đời của Corte. Loving – chính hắn đã tra tấn dã man một người thân cận của Corte 6 năm về trước. Corte nghĩ đây chính là dịp để anh trả lại tất cả những gì mà Loving đã gây ra. 

Câu chuyện của Deaver được đẩy lên cao trào bởi màn đấu trí “thiên tài” giữa Loving và Corte. Một cốt truyện hấp dẫn, ly kỳ, tiết tấu nhanh với những màn rượt đuổi căng thẳng."', N'https://product.hstatic.net/1000363117/product/9786043605976_1579ed3f5c924af2b2f89db50efbc0d8_master.jpg', NULL, 1)
INSERT [dbo].[Book] ([ID], [Name], [Price], [Category_ID], [Sale], [Content], [Image], [Author], [Count]) VALUES (N'TT26      ', N'KẺ TẦM XƯƠNG ', 162, N'TT        ', 10, N'Một trong những cuốn được coi là nổi bật nhất của Jeffery Deaver chính là Kẻ tầm xương. Câu chuyện này cũng đã được chuyển thể thành bộ phim điện ảnh cùng tên ra mắt năm 1999 với sự tham gia của tài tử điện ảnh Denzel Washington và nữ minh tinh Angelina Jolie. 

Câu chuyện xoay quanh nhân vật thám tử Lincoln Rhyme và nữ cảnh sát tuần tra Amelia Sachs. Cuốn tiểu thuyết không tập trung miêu tả những cảnh rùng rợn, máu me mà thay vào đó bằng cách dựng lên những tình huống căng thẳng, cuộc đấu trí với tên tội phạm có sở thích bệnh hoạn là sưu tầm xương. 

Kẻ Tầm Xương là tập đầu tiên trong series về thanh tra Lincoln Ryhme của Jeffery Deaver.', N'https://product.hstatic.net/1000363117/product/9786043498813_4e2a90a274f44d1f84f04f1c2285b6d9_master.jpg', NULL, 2)
INSERT [dbo].[Book] ([ID], [Name], [Price], [Category_ID], [Sale], [Content], [Image], [Author], [Count]) VALUES (N'TT27      ', N'KẺ PHÁ KHÓA ', 189, N'TT        ', 10, N' Một người phụ nữ thức dậy vào buổi sáng và phát hiện ra ai đó đã đột nhập căn hộ vốn bất khả xâm phạm của mình. Hắn ta thậm chí đã tự ý sắp xếp lại các vật dụng trong nhà và đã ngồi cạnh khi cô đang ngủ. Theo sở cảnh sát, vụ đột nhập dường như mang theo một thông điệp ghê rợn nào đó, mở màn cho những vụ tàn sát. 

Rất nhanh, Lincoln Rhyme và Amelia Sachs đã được đưa đến để điều tra vụ việc. Họ sớm biết được rằng, kẻ đột nhập ấy – tự xưng là “Thợ khóa”. Hắn ta có khả năng phá được bất kỳ ổ khóa nào, dễ dàng qua mắt được hệ thông an ninh nào dù phức tạp đến đâu. Số lượng các nạn nhân ngày càng tăng lên, Lincoln Rhyme và Amelia Sachs cùng các cộng sự của mình lần theo dấu vết tới được hang ổ của Thợ khóa… và khám phá ra những bí mật của hắn ta. 

Tuy nhiên, vụ việc bị gián đoạn bởi một cuộc điều tra khác nhắm vào Rhyme vì những khúc mắc liên quan tới các vụ án trước. Kết quả là Rhyme bị sa thải, nếu như anh tiếp tục điều tra vụ việc liên quan tới Thợ khóa, thì có khả năng anh sẽ bị ngồi tù. Kẻ thủ ác vẫn nhởn nhơ ngoài vòng pháp luật trong khi Rhyme lại không thể tiến hành điều tra vụ việc một cách đường hoàng. Dường như Deaver đã ném nhân vật chính của mình vào một tình cảnh không thể ngặt nghèo hơn. 

The Midnight Lock như một chuyến tàu lượn cao tốc, đưa bạn đi từ bất ngờ này tới bất ngờ khác. Deaver vẫn vậy, chưa bao giờ khiến người hâm mộ ngừng mê mẩn những chuyến phiêu lưu kỳ lạ đầy hồi hộp của mình. ', N'https://product.hstatic.net/1000363117/product/b_a-tr_c-k_-ph_-kh_a-file-in-1_f7246c24ed2a4175867e5e0575b0de21_master.jpg', NULL, 3)
INSERT [dbo].[Book] ([ID], [Name], [Price], [Category_ID], [Sale], [Content], [Image], [Author], [Count]) VALUES (N'TT28      ', N'ĐỨA TRẺ ÁNH TRĂNG ', 145, N'TT        ', 10, N'Đêm tháng Một lạnh giá, khi Sharon Lemke ngắm nguyệt thực ở sân sau thì phát hiện điều gì đó kì lạ ở nhà hàng xóm. Bà nhìn thấy một bé gái đang rửa bát vào lúc nửa đêm. Gia đình Fleming không có con ở độ tuổi đó nếu bà nhớ không lầm, và ngay cả khi họ có con ở độ tuổi đó thì sao cô bé lại làm việc nhà vào giờ này? 

Sharon định cho qua vụ việc này. Nhưng khi Niki - cô gái đã phải trải qua một tuổi thơ đầy bất hạnh - đến và sống cùng bà, Sharon quyết định kể cho Niki vụ việc mà bà đã chứng kiến vào tối hôm đó và Niki cũng cảm thấy có điều gì đó đáng ngờ ở gia đình Fleming. 

Hai người gọi đến Trung tâm Dịch vụ xã hội báo cáo sự việc nhưng lại không nhận được sự trợ giúp rõ ràng nào. Cuối cùng, Sharon và Niki quyết định tự mình điều tra và làm rõ sự việc bí ẩn này. ', N'https://product.hstatic.net/1000363117/product/9786043870022_4bfebeead592486aa4c133912bae1853_master.jpg', NULL, 5)
INSERT [dbo].[Book] ([ID], [Name], [Price], [Category_ID], [Sale], [Content], [Image], [Author], [Count]) VALUES (N'TT29      ', N'ĐỨA BÉ MẤT TÍCH ', 165, N'TT        ', 10, N'Sau khi cậu con trai nhỏ mất tích, viên cảnh sát Jonah Colley chìm sâu trong nỗi đau và sự ám ảnh khuôn nguôi. Mười năm sau đó, một cuộc điện thoại cầu cứu từ một số điện thoại xa lạ đã dẫn lối anh tới thị trấn nhỏ tên là Bến Lò – một thị trấn hẻo lánh xa xôi. Tại đây, anh tìm thấy bốn xác chết trước khi bị một kẻ lạ mặt đánh cho bất tỉnh nhân sự. 

Khi Jonah tỉnh lại trong bệnh viện, anh bống chốc trở thành nghi phạm chính của vụ án. Trong hành trình minh oan cho bản thân mình, Jonah phaiủ tự mình điều tra và dần dần phát hiện được nhiều bí mật cùng những lời nói dối về những người mà anh đã từng quen biết. Anh buộc lòng phải đặt ra những câu hỏi, điều gì đã thực sự xảy ra từ nhiều năm về trước? 

“Đứa bé mất tích” có nhịp độ nhanh cùng với những khoảnh khắc rùng rợn và những bí mật đen tối khiến người đọc phải ớn lạnh, rùng mình. Cuốn tiều thuyết tàn bạo và nhiều bước ngoặt đẩy tình huống lên cao trào. Jonah là một người cha sẵn sang liều mạng vì con trai mình, một hình mẫu lý tưởng cho sự tranh đấu về công lý.”', N'https://product.hstatic.net/1000363117/product/b_a-tr_c-_a-b_-m_t-t_ch--file-in-1_ae4338e86aaa4b42b26d0626ad6c9c4e_master.jpg', NULL, 2)
INSERT [dbo].[Book] ([ID], [Name], [Price], [Category_ID], [Sale], [Content], [Image], [Author], [Count]) VALUES (N'TT30      ', N'ĐIỂM DỐI LỪA ', 205, N'TT        ', 10, N'Khi vệ tinh phát hiện ra một vật thể lạ bị chôn vùi dưới lòng sông băng ở Bắc Cực, NASA lập tức tận dụng cơ hội này để đưa ra tuyên bố về một kì tích chắc chắn sẽ ảnh hưởng mạnh mẽ đến kì bầu cử Tổng thống đang đến gần. Tổng thống Zachary Herney đã đích thân mời chuyên gia phân tích tình báo, đồng thời cũng là con gái của ứng cử viên Đảng đối thủ - Rachel Sexton - đến tận nơi để xác minh phát kiến đó. Cùng một nhóm những nhà khoa học nổi tiếng, trong đó có nhà hải dương học Michael Tolland, Rachel đặt chân đến Bắc Cực. 

Nhưng ở đây, cô lại phát hiện ra một âm mưu dối trá, có thể ảnh hưởng đến cả thế giới. Chưa kịp báo cho Tổng thống Herney biết thì cô cùng các nhà khoa học đã bị một đội sát thủ chuyên nghiệp tấn công. Trên đại dương tăm tối, chết chóc, Rachel cùng nhóm của mình đã phải tìm mọi cách để vạch mặt kẻ chủ mưu, đồng thời cố gắng để bảo toàn mạng sống. 

Một cuộc đấu trí khốc liệt diễn ra ngay trên biển cả bao la. Thời gian chỉ còn được tính bằng phút. Kẻ đứng sau tất cả những âm mưu đen tối này là ai? Liệu sự thật cuối cùng có được tiết lộ hay sẽ bị chôn vùi mãi mãi?', N'https://product.hstatic.net/1000363117/product/z3321916667332_020c2534a681bf6955344738d2c90492_1_e9d9d7f5b67344218a12f5d9c8b5fdc8_master.jpg', NULL, 3)
INSERT [dbo].[Book] ([ID], [Name], [Price], [Category_ID], [Sale], [Content], [Image], [Author], [Count]) VALUES (N'TT31      ', N'DAO CẠO ', 165, N'TT        ', 10, N'Ike Randolph ra tù được mười lăm năm và anh cố gắng để bản thân mình không mắc phải lỗi nhỏ nhất, dù cho đó là vé phạt tốc độ. Nhưng người đàn ông da đen ấy vẫn cảm thấy lo lắng mỗi khi cảnh sát đến gõ cửa nhà mình. 

Điều cuối cùng mà anh được thông báo từ cảnh sát chính là cái chết của đứa con trai, Isiah cùng với người chồng cậu, Derek. Ike không hoàn toàn chấp nhận về xu hướng tình dục của cậu con trai nhưng đây là một sự mất mát vô cùng đau thương. 

Cha của Derek, Buddy Lee vô cùng xấu hổ khi biết biết con mình là người đồng tính còn Derek cảm thấy xấu hổ vì cha là tội phạm. Nhưng Buddy Lee đã kết nối lại với thế giới ngầm vì anh muốn tìm ra kẻ đã giết con trai mình. 

Ike và Buddy Lee, hai cựu tù nhân không có điểm chung nào khác ngoài quá khứ phạm tội và tình yêu vô bờ bến với những đứa con trai đã chết của họ, cùng bắt tay hợp tác hợp tác với nhau để tìm ra và trả thù những kẻ đã giết con trai của mình. Trong hành trình tìm kiếm sự thật, những người đàn ông cứng cỏi như Ike và Buddy Lee đã phải đối mặt với những định kiến về con trai của họ và về chính bản thân họ… ', N'https://product.hstatic.net/1000363117/product/b_a-tr_c-dao-c_o-file-in-1_200f81b23dce4b62b2d8e1ba6f429423_master.jpg', NULL, 1)
INSERT [dbo].[Book] ([ID], [Name], [Price], [Category_ID], [Sale], [Content], [Image], [Author], [Count]) VALUES (N'TT32      ', N'BIỂU TƯỢNG THẤT TRUYỀN (TÁI BẢN 2023) ', 239, N'TT        ', 10, N'Biểu tượng thất truyền là cuốn sách đưa người đọc song hành cùng nhà biểu tượng học lừng danh Robert Langdon trong cuộc hành trình tới thủ đô nước Mỹ và khám phá bức màn bí mật về Hội Tam Điểm – một hội kín có lịch sử lâu đời, cuốn quanh mình vô vàng biểu tượng và truyền thuyết kỳ bí. Trên thực tế, toàn bộ câu chuyện chỉ diễn ra trong vỏn vẹn mười hai tiếng, địa điểm chỉ khoanh vùng ở thủ đô Washington, nhưng không gian và thời gian xây dựng trên ký ức nhân vật lại bao trùm suốt chiều dài lịch sử, tôn giáo, triết học, lý luận, giả kim, và nghệ thuật của cả đất nước. 

Trên tất cả, Biểu tượng thất truyền chính là một hành trình hồi tưởng và truy nguyên, là lời nhắc nhở thế nhân về những điều họ đã bỏ quên trong quá khứ. Hơn lúc nào hết, đồng hành với những phát minh tương lai, con người cũng cần chấn hưng hiểu biết về bước tiếp những thành tựu của tiền nhân trước khi chúng thất truyền mãi mãi. ', N'https://product.hstatic.net/1000363117/product/image_195509_1_31873_1_eafdd88de63846febdeb1ec43842b088_master.jpg', NULL, 5)
GO
INSERT [dbo].[Book] ([ID], [Name], [Price], [Category_ID], [Sale], [Content], [Image], [Author], [Count]) VALUES (N'TT33      ', N'NỖI NIỀM CỦA THÁM TỬ GALILEO ', 146, N'TT        ', 10, N'Tôi không tha thứ cho kẻ lấy khoa học làm công cụ giết người. Tuyệt đối không! 

Một lá thư kỳ quái được gửi đến Sở cảnh sát Tokyo từ kẻ tự xưng "Bàn tay của ác ma" cảnh báo về một vụ giết người hàng loạt, đồng thời khiêu khích đích danh phó giáo sư Yukawa Manabu của đại học Teito. Mục đích nhắm đến Yukawa của tên tội phạm là gì, cách thức giết người đáng sợ vượt qua hiểu biết thông thường là gì? Yukawa từng tuyên bố sẽ không hợp tác với cảnh sát nay lại phải đương đầu với một vụ án cận kề. Cuốn thứ tư trong series Thám tử Galileo khắc họa cuộc quyết đấu giữa tên tội phạm quỷ quyệt và nhà vật lý thiên tài ở một quy mô vượt mọi hình dung. ', N'https://product.hstatic.net/1000363117/product/noi-niem-cua-tham-tu-galileo-3_cb29caacb21a47e39994dd6397899699_master.jpg', NULL, 2)
INSERT [dbo].[Book] ([ID], [Name], [Price], [Category_ID], [Sale], [Content], [Image], [Author], [Count]) VALUES (N'TT34      ', N'MÀN CHƠI TỬ THẦN ', 185, N'TT        ', 10, N'"Màn chơi tử thần" là tập đầu tiên trong series về nhân vật đặc biệt Colter Shaw của tác giả Jeffery Deaver. 

Colter Shaw là một thợ săn thưởng. Anh đến Thung lũng Silicon để nhận lời tìm kiếm một cô gái trẻ mất tích. 

Lần theo dấu vết, anh phát hiện ra cô gái đã bị bắt cóc và bị bỏ lại ở một nhà máy bỏ hoang. Hung thủ - có biệt danh là “Game Thủ” - dường như bị ám ảnh với một trò chơi điện tử sinh tồn mang tên Kẻ Thì Thầm. Vậy nên hắn ta - Game Thủ đã thực hiện bí mật bắt cóc 3 nạn nhân và ép họ chơi trò chơi ấy ngoài đời thật. Cuốn họ vào một mê cung rối rắm, bạo lực, đe dọa tính mạng, dùng họ như những con chuột thí nghiệm và mục đích cuối cùng của hắn có thực sự đơn giản chỉ là việc giải trí. Hay ẩn sâu bên trong đó là những uẩn khúc, bí mật gì? 

Gay cấn, nghẹt thở và bất ngờ là những gì có trong Màn chơi tử thần.', N'https://product.hstatic.net/1000363117/product/man-choi-tu-than-3_c666d98a8fee40d5b3832e545a5df07f_master.jpg', NULL, 5)
INSERT [dbo].[Book] ([ID], [Name], [Price], [Category_ID], [Sale], [Content], [Image], [Author], [Count]) VALUES (N'VH01      ', N'CHÂN DUNG - TUYỂN TẬP TRUYỆN NGẮN SONG NGỮ VIÊT-ANH NGUYỄN QUANG THÂN', 144, N'VH        ', 10, N'TRÀO LỘNG - TRỮ TÌNH - LẮNG SÂU 

Nhà văn Mỹ Steven Millhauser trong bài báo “Tham vọng của truyện ngắn” (The Ambition of the Short Story) đã ví truyện ngắn như hạt cát mà tham vọng của hạt cát ấy là chứa đựng một phần của thế giới, hơn thế, nó muốn tạo ra hình hài cho cả thế giới này! 

Từ truyện đầu tiên in năm 1957 đến nay, ngoài thế mạnh chính là tiểu thuyết và truyện dài, Nguyễn Quang Thân đã có hàng trăm truyện ngắn, phần nhiều trong số đó chưa bị bụi thời gian che mờ mà năm truyện trong tuyển tập này là một minh chứng. Năm hạt cát tiềm ẩn long lanh! 

Năm truyện, năm cảnh huống và lát cắt nhưng hiện thực dữ dội đã được phơi bày bởi ngòi bút tài hoa, nhân ái và uy-mua hiếm quý. Dù với giọng điệu nào, trữ tình, cay đắng hay giễu nhại, nhà văn đều đi đến tận cùng của tâm trạng mà không sống trong chăn, không trải nghiệm bi kịch xã hội đương thời, người ta không viết nổi những trang văn này. 

Cảm ơn Nguyễn Quang Thân, Rosemary Nguyễn, Mạnh Chương. Rằng, dòng văn chương Việt đích thực vẫn đang chảy, nhất là những dòng chảy ngầm! ', N'https://product.hstatic.net/1000363117/product/chan-dung-mockup_e7dedc1919a14b58a380d6ee39b18dca_master.jpg', NULL, 1)
INSERT [dbo].[Book] ([ID], [Name], [Price], [Category_ID], [Sale], [Content], [Image], [Author], [Count]) VALUES (N'VH02      ', N'BÌNH NGUYÊN LỘC - ĐÒ DỌC', 115, N'VH        ', 10, N'Tình yêu là thứ gì vừa dữ dội, vừa mong manh. Bao đời nay người ta đã đúc kết như vậy. Cái khác thường trong tình yêu ở tiểu thuyết Đò Dọc là nhà văn Bình Nguyên Lộc đã đặt các nhân vật của mình trong hoàn cảnh hết sức trớ trêu: Cả mấy chị em gái của gia đình nọ đều đem lòng yêu một người. Chỉ vì họ không còn có ai để yêu, khi phải sống ở một chốn quê quạnh quẽ mà họ là dân thành thị mới chuyển về. Bao nhiêu chuyện từ vui vẻ, đến khôi hài, rồi buồn giận cứ diễn ra, một cách tự nhiên, để rồi cuối cùng nỗi éo le lên đến đỉnh điểm khi lý trí không thể cầm cương mà thắng được. Bi kịch xảy đến khi các chị em gái vốn là con nhà gia giáo và rất mực thương yêu nhau lại phải đối đầu nhau. 

Bình Nguyên Lộc đã lột tả hết cái không khí miền quê phảng lì buồn tẻ là nỗi ám ảnh của các cô gái, và nỗi chông chênh trong tâm hồn của chính họ. Nhưng ta vẫn thấy lấp lánh những điều đẹp đẽ trong các trang văn của nhà văn bậc thầy, cho dẫu nỗi buồn hay tuyệt vọng có dâng cao đến đâu. Lòng vị tha, mối trân trọng tình cảm gia đình vẫn là chiếc chìa khóa để mở tất cả các cánh cửa...', N'https://product.hstatic.net/1000363117/product/8934974200802_ed75f8ad546d4c70bbbf72a374905bf9_master.jpg', NULL, 2)
INSERT [dbo].[Book] ([ID], [Name], [Price], [Category_ID], [Sale], [Content], [Image], [Author], [Count]) VALUES (N'VH03      ', N'AGASSI - 10 MINS - WE. SECRET YOU LOOKS LIKE MORE BEAUTIFUL AND HAPPIER', 174, N'VH        ', 10, N'Câu chuyện đưa chúng ta tới những miền đất văn hoá khát khao ? Sắc lung linh hay một sự thật hoàn toàn khác đang chờ ta khám phá? Có một thế hệ như thế và có cả phần giống với tất cả chúng ta. 

Những trải nghiệm của tuổi thanh xuân tạo nên dòng chảy mạch truyện “Agassi”. Hẳn là ai cũng có một thời để sống mà vẫn phải đi tìm mục đích cho chuyến hành trình cuộc đời, trải nghiệm những thứ ta chưa biết; có người đi dài hơn, có người đi đến một nửa rồi bỏ cuộc; có người tạm dừng, rẽ ngang rồi lại bước tiếp. Câu chuyện của “Agassi” có trong mỗi chúng ta. Câu chuyện này là trang đời đẹp đẽ nhưng cũng nhiều băn khoăn và ngã rẽ. Dù ở thời nào đi nữa, ở vị trí vòng quay thứ bao nhiêu của sự sống trái đất, thì chúng ta đều từng sống cùng một nhịp đập trái tim, có cùng những nhiệt huyết ngây ngô mà lớn hơn một chút thôi thì có lẽ bạn đã quên bẵng đi. Hơn nữa, ở trong tác phẩm, bạn sẽ nhìn thấy bức tranh nhiều sắc thái văn hoá, quan điểm đa chiều của cộng đồng rộng lớn và cũng thấy được vị thế của một cộng đồng. 

Không gian nơi tác phẩm “Agassi” trải qua nhiều mảnh đất và nền văn hóa khác nhau. Đó không chỉ là Việt Nam, hay Hàn Quốc, không gian ấy còn trải qua miền đất văn hóa khác nhau từ châu Âu, châu Mỹ hay Nhật Bản. Vì vậy nó đặc biệt là tác phẩm sẽ hấp dẫn những trí tưởng tượng, tò mò và mở ra những kiến thức mới mẻ. Dưới cái nhìn và cách tiếp cận của tác giả, tác phẩm sẽ mang tới những thứ mà độc giả không thể tìm kiếm được từ những tác phẩm được viết bởi tác giả khác tại cả hai miền đất. Không chỉ được khám phá từng ngõ ngách của các miền đất, trong tác phẩm độc giả còn thấy được cả mọi khía cạnh và những câu hỏi ngây ngô trong sáng, những cảm xúc kỳ lạ về bản thân, chuyện tình yêu trong sáng của các nhân vật. Mirae và Haruto có một tình yêu thuần khiết nhưng cũng phải đến cả thập kỷ họ mới gặp được nhau. Mai và Ja-pyeong tuy nhanh chóng đi tới mối quan hệ tình yêu, nhưng họ không vội kết hôn ngay. Đôi khi bạn sẽ sốc một chút vì cách chọn hành động của Haruto khi anh bạn đối diện với Mirae và Choi. Vậy lý do là gì mà anh ta làm vậy là phần mà độc giả có quyền lựa chọn và suy ngẫm. 

Trong bức tranh đa chiều của tác phẩm, độc giả cũng thấy được cả tình bạn và những cuộc gặp gỡ đáng quý trong nhân sinh. Và mọi người cảm thấy nên trân trọng mọi khoảnh khắc, thời gian và những mối nhân duyên trong cuộc đời.', N'https://product.hstatic.net/1000363117/product/agassi_b2a7e3d674cd4879be35a697a915ae9c_master.jpg', NULL, 3)
INSERT [dbo].[Book] ([ID], [Name], [Price], [Category_ID], [Sale], [Content], [Image], [Author], [Count]) VALUES (N'VH04      ', N'TRĂNG TAN ĐÁY NƯỚC', 150, N'VH        ', 10, N'Tập truyện ngắn Trăng Tan Đáy Nước là sợi tơ tình xuyên suốt 2000 năm lịch sử. 

Sợi tơ tình ấy, thấm dẫm máu xương dân tộc, đong đầy nước mắt giai nhân, quẩn quanh dấu chân quân tử. 

Sợi tơ tình ấy, bắt đầu từ Trọng Thuỷ - Mị Châu, câu chuyện bi thương khiến nhà tan nước mất. Trải hai thiên niên kỷ, vẫn sợi tơ tình ấy, kết lại bằng mối nhân duyên giữa Vua Bảo Đại và Hoàng Hậu Nam Phương. Thời khắc đó, đất nước đã vẹn tròn. 

Nửa cuộc đời sau của Chiêu Thánh có hạnh phúc hay không, chỉ mình nàng tỏ thấu. An Tư, nàng công chúa vì báo đền giang sơn mà gả cho giặc Thát, liệu rằng có kết cục tha hương? Từ một chàng thiếu niên nặng gánh thù cha, Trần Quốc Tuấn phải kinh qua những gì mới tạc nên danh tướng? 

Những con người kia và đoạn tình cảm đau thương ngắn ngủi mười mấy năm, đặt cạnh vạn dặm non sông thật nhỏ bé vô cùng. 

Tôi ở đây, góp chút sức hèn cổ nhân “lên tiếng”, để họ tự kể mối tơ tình, hoạ lại thời khắc điêu linh, dệt nên giang sơn thịnh thế.', N'https://product.hstatic.net/1000363117/product/c5355b7a0aad677530158c96b6812956_6759761a9527472ebfff639ace6e9827_master.jpg', NULL, 2)
INSERT [dbo].[Book] ([ID], [Name], [Price], [Category_ID], [Sale], [Content], [Image], [Author], [Count]) VALUES (N'VH05      ', N'CON THÚ MÙ', 169, N'VH        ', 10, N'"Con Thú Mù" là một tập truyện "hai trong một" của bậc thầy trinh thám kinh dị xứ Phù Tang Edogawa Ranpo. Tập truyện gồm 2 tiểu thuyết ngắn, lần đầu tiên được dịch mới và giới thiệu chính thức đến bạn đọc Việt Nam. 

Con Thú Mù kể về một hoạ sĩ khiếm thị, chỉ có thể cảm nhận sự vật qua đôi bàn tay. Lão cho rằng một tuyệt tác nghệ thuật cần phải được tiếp nhận bằng xúc giác. Bảy cô gái với bảy vẻ đẹp khác nhau đã bị lão dẫn về căn phòng riêng của mình, sau đó những án mạng kinh hoàng xảy ra, để phục vụ cho một tuyệt tác nghệ thuật có một không hai. 

Trong tác phẩm thứ hai Đảo Kì Dị, Hitomi Hirosuke - một nhà văn thất chí đang ôm mộng tưởng viết một tác phẩm lớn về một thiên đàng nhân tạo. Bước ngoặt đến khi hắn biết đến cái chết của Komoda Genzaburo - người bạn có ngoại hình rất giống Hitomi. Anh ta quyết định giả mạo danh tính của người đã khuất để đoạt lấy tài sản, sau đó xây dựng một công viên giải trí độc đáo trên một hòn đảo huyền bí. Nhưng thiên đàng mà Hitomi định xây ngày càng giống với địa ngục... 

Từng trang sách thấm đẫm vẻ đẹp ma mị, u hoài và lạnh gáy rùng rợn, "Con thú mù" và "Đảo kì dị" là hai đỉnh cao trong sự nghiệp sáng tác của Ranpo, khi ác tâm và chủ nghĩa duy mỹ thuần khiết đã sánh đôi nhau đi đến tận cùng.', N'https://product.hstatic.net/1000363117/product/60f8091108514c39a7237da82a39c0fc_bc355604ad6146b5b3fb3fc5de39fd61_master.jpg', NULL, 5)
INSERT [dbo].[Book] ([ID], [Name], [Price], [Category_ID], [Sale], [Content], [Image], [Author], [Count]) VALUES (N'VH06      ', N'GIẾT CON CHIM NHẠI (BÌA MỀM) ', 120, N'VH        ', 10, N'Nào, hãy mở cuốn sách này ra. Bạn phải làm quen ngay với bố Atticus của hai anh em - Jem và Scout, ông bố luật sư có một cách riêng, để những đứa trẻ của mình cứng cáp và vững vàng hơn khi đón nhận những bức xúc không sao hiểu nổi trong cuộc sống. Bạn sẽ nhớ rất lâu người đàn ông thích trốn trong nhà Boo Radley, kẻ bị đám đông coi là lập dị đã chọn một cách rất riêng để gửi những món quà nhỏ cho Jem và Scout, và khi chúng lâm nguy, đã đột nhiên xuất hiện để che chở. Và tất nhiên, bạn không thể bỏ qua anh chàng Tom Robinson, kẻ bị kết án tử hình vì tội hãm hiếp một cô gái da trắng, sự thật thà và suy nghĩ quá đỗi đơn giản của anh lại dẫn đến một cái kết hết sức đau lòng, chỉ vì lý do anh là một người da đen. 
 
Cho dù được kể dưới góc nhìn của một cô bé, cuốn sách Giết con chim nhạikhông né tránh bất kỳ vấn đề nào, gai góc hay lớn lao, sâu xa hay phức tạp: nạn phân biệt chủng tộc, những định kiến khắt khe, sự trọng nam khinh nữ… Góc nhìn trẻ thơ là một dấu ấn đậm nét và cũng là đặc sắc trong Giết con chim nhại. Trong sáng, hồn nhiên và đầy cảm xúc, những câu chuyện tưởng như chẳng có gì to tát gieo vào người đọc hạt mầm yêu thương. 
 
Gần 50 năm từ ngày đầu ra mắt, Giết con chim nhại, tác phẩm đầu tay và cũng là cuối cùng của nữ nhà văn Mỹ Harper Lee vẫn đầy sức hút với độc giả ở nhiều lứa tuổi. Thông điệp yêu thương trải khắp các chương sách là một trong những lý do khiến Giết con chim nhại giữ sức sống lâu bền của mình trong trái tim độc giả ở nhiều quốc gia, nhiều thế hệ. Những độc giả nhí tìm cho mình các trò nghịch ngợm và cách nhìn dí dỏm về thế giới xung quanh. Người lớn lại tìm ra điều thú vị sâu xa trong tình cha con nhà Atticus, và đặc biệt là tình người trong cuộc sống, như bé Scout quả quyết nói “em nghĩ chỉ có một hạng người. Đó là người”.', N'https://product.hstatic.net/1000363117/product/image_180771_1910840921204667b95084d55f852843_master.jpg', NULL, 1)
INSERT [dbo].[Book] ([ID], [Name], [Price], [Category_ID], [Sale], [Content], [Image], [Author], [Count]) VALUES (N'VH07      ', N'KHÚC THỤY DU ', 125, N'VH        ', 10, N'Khúc thụy du là tập thơ đánh dấu sự trở lại của tiếng thơ Du Tử Lê. 50 bài thơ tình, thơ thế sự đã được phổ nhạc, rất phổ biến của Du Tử Lê trong nửa thế kỷ qua đã được tuyển chọn trong tập thơ này với một sự sàng lọc kỹ lưỡng của chính tác giả và những người làm sách tâm huyết. 

VỀ TÁC PHẨM 

Thơ Du Tử Lê, loài thơ được tạo nên bởi phẩm tính thi sĩ mạnh mẽ tới mức, chúng dẫu có mang những khuôn thức, thì nội tại cũng luôn quẫy đạp để tìm cái vô hạn; xác chữ dẫu có khoác vào khái niệm thì cũng chỉ để hướng tới cái tình ý ngoài lời. Và trên đơn vị bài thơ, dẫu được xác định tọa độ bằng những hệ tứ xuyên suốt thì đó cũng chỉ là những tọa độ hư ảo. 

Những bài thơ tụng ca nhân tình, quê xứ, yêu đương trong tập thơ này đã là chất men phiêu lãng cất cánh thành ca từ trong những sáng tác nổi tiếng của các nhạc sĩ tài hoa: Phạm Duy, Phạm Đình Chương, Anh Bằng, Đăng Khánh, Trần Duy Đức… 

Tập thơ gói lại rất nhiều sáng tác nổi tiếng của Du Tử Lê: Khúc Thụy Du, Khi tôi chết hãy đem tôi ra biển, Ta tiếc thiên đường mới lập xong, Người từ phương Đông qua,… và cập nhật sáng tác mới nhất của ông: Nuôi người, trang sách thơm. 

Thơ Du Tử Lê sống động, khiêm cung và bao dung trong lòng công chúng, hóa giải trước muôn trùng định kiến, bay trên những đứt gãy thế cuộc lẫn đời riêng. 

Tuyển thơ Khúc Thụy Du (thuộc tủ sách Tinh hoa Sài Gòn do Phanbook tổ chức) là một kết tinh tương thích với lối đọc thơ, sống thơ của ngày hôm nay! ', N'https://product.hstatic.net/1000363117/product/image_175793_6543a8a26a0642669108f81fd1f9b215_master.jpg', NULL, 2)
INSERT [dbo].[Book] ([ID], [Name], [Price], [Category_ID], [Sale], [Content], [Image], [Author], [Count]) VALUES (N'VH08      ', N'GIỮ ĐỜI CHO NHAU ', 139, N'VH        ', 10, N'Hai tháng sau khi xuất bản tuyển thơ Khúc Thụy Du (Phanbook & NXB Hội Nhà Văn) được độc giả nhiệt tình đón nhận, Phanbook xin tiếp tục giới thiệu đến độc giả tuyển tùy bút Giữ Đời Cho Nhau của tác giả Du Tử Lê. 

Ngoài tư cách nhà thơ nổi tiếng, Du Tử Lê còn được biết đến là một cây bút truyện ngắn, tùy bút khá đặc sắc của văn chương Sài Gòn trước 1975; là một chân dung đáng chú ý của dòng chảy văn học Việt Nam ly hương. Vẫn với một tâm hồn đa cảm, duy tình và phóng khoáng, những trang văn của Du Tử Lê đã trổ ngõ mà chảy vào trái tim người cùng thời, cùng cảnh ngộ, khơi gợi những giá trị thiện lành, nhân cảm trong một đời sống, một lịch sử quá nhiều bất trắc. 

Tuyển tùy bút Giữ Đời Cho Nhau là tập hợp 10 bài tùy bút trong quyển Mùa Hoa Móng Tay do Tạp chí Văn, ấn hành năm 1972 và 16 bài tùy bút mới được tác giả viết sau này, trong đó, bài mới nhất (Những “địa đạo” đêm Sài Gòn xưa) được viết vào đầu 2018. 

Tuyển tùy bút này có hai phần chính: Ngày tháng tôi và Hương kỷ niệm, đi theo một mạch xuyên suốt: chuyển từ những xúc cảm, chuyện kể thuộc đời riêng đến những ký ức về văn hóa Sài Gòn qua những chân dung nhân vật một thời: Từ Mẫn, Phạm Đình Chương, Trần Phong Giao, Lê Tài Điển… hay những hiện tượng văn nghệ Sài Gòn như: sinh hoạt phòng trà, làm tạp chí, xuất bản, sinh hoạt mỹ thuật,... 

Phía sau những nhân vật dù cụ thể hay phiếm chỉ, các tùy bút của Du Tử Lê đều tỏa ra một thứ ánh sáng của tin yêu, một sự gắn bó tốt đẹp, một tinh thần cởi mở và niềm tín thác vào nhân gian không toan tính. 

Những tùy bút giàu mỹ cảm đó, bên cạnh những bài thơ lãng mạn và giàu suy tư của ông đã hướng đến một sự nhất quán tinh tế, lạ lùng. 

Nhưng nếu những bài thơ thơ gói gọn trong một giới hạn với đặc thù ngôn ngữ và nhạc tính riêng, thì tùy bút cho phép Du Tử Lê có không gian để diễn giải và triển khai một cách tự do các ấn tượng cá nhân phía sau mỗi tình tiết. Sự tự do của một người viết giữ được lửa ấm của trái tim tự tại mà chan hòa. 

Giữ Đời Cho Nhau đem lại cho người đọc hôm nay những khoảnh khắc thưởng lãm vẻ đẹp bay bổng của thứ văn xuôi tiệm cận phẩm tính thi ca. 

Trân trọng giới thiệu cùng bạn đọc! ', N'https://product.hstatic.net/1000363117/product/527770987a8055dc2324471b210a38f2_thanh_ly_f9d3478846694fa9967ba8ee267c0cc9_master.jpg', NULL, 3)
INSERT [dbo].[Book] ([ID], [Name], [Price], [Category_ID], [Sale], [Content], [Image], [Author], [Count]) VALUES (N'VH09      ', N'CÒN CHÚT GÌ ĐỂ NHỚ (2022) ', 110, N'VH        ', 10, N'Đó là những kỷ niệm thời đi học của Chương, lúc mới bước chân vào Sài Gòn và làm quen với cuộc sống đô thị. Là những mối quan hệ bạn bè tưởng chừng hời hợt thoảng qua nhưng gắn bó suốt cuộc đời. Cuộc sống đầy biến động đã xô dạt mỗi người mỗi nơi, nhưng trải qua hàng mấy chục năm, những kỷ niệm ấy vẫn luôn níu kéo Chương về với một thời để nhớ.', N'https://product.hstatic.net/1000363117/product/8934974177944_d3c3325415f345de8882af27fff257be_master.jpg', NULL, 5)
INSERT [dbo].[Book] ([ID], [Name], [Price], [Category_ID], [Sale], [Content], [Image], [Author], [Count]) VALUES (N'VH10      ', N'NHỮNG CÔ EM GÁI (TÁI BẢN 2022) ', 105, N'VH        ', 10, N'Khoa từ quê ra thành phố học, tấp tểnh làm thơ được đăng báo và bắt đầu nổi tiếng trong giới học sinh. Nhờ thế, Khoa được các bạn trai trong lớp hâm mộ, nhờ làm thơ tặng em gái mình, thực tế là dùng thơ ấy tặng bạn gái hoặc người yêu. Run rủi thế nào, những bài thơ ấy được truyền tay qua một con đường vòng nào đó lại đến tay Quyên, cô gái mà Khoa thầm yêu trộm nhớ và những bài thơ làm giùm bạn bè ấy đã lấy cảm tưởng thật từ mối tình chưa ngỏ với Quyên. Sự việc ấy gây nhiều hiểu lầm và nuôi trong Khoa niềm hy vọng trước khi Khoa đối diện với sự thật. ', N'https://product.hstatic.net/1000363117/product/8934974177968_c4009c90e1284ada8ec1a8a2b5321737_master.jpg', NULL, 1)
INSERT [dbo].[Book] ([ID], [Name], [Price], [Category_ID], [Sale], [Content], [Image], [Author], [Count]) VALUES (N'VH11      ', N'TRẠI HOA VÀNG (2022) ', 120, N'VH        ', 10, N'Truyện đã được đăng dài kỳ trên báo Mực Tím. Chuẩn nhà nghèo, học không khá lắm, nhưng có nhiều bạn. Yêu hoa, Chuẩn đã tự trồng được một vườn hoa vàng. Có cô bé tên Thảo hàng xóm thường hay sang chơi cùng chăm sóc hoa với Chuẩn. Một hôm, Thảo ngỏ ý xin một đóa hồng, Chuẩn đã ngần ngại vì nghĩ hoa hồng chỉ tặng cho người mình yêu…. Lúc đó, Chuẩn đã phải lòng Cẩm Phô – một người bạn gái học chung từng bênh vực cho Chuẩn. Và…', N'https://product.hstatic.net/1000363117/product/8934974178019_f375eec72b154d9bae669c74724001a6_master.jpg', NULL, 2)
INSERT [dbo].[Book] ([ID], [Name], [Price], [Category_ID], [Sale], [Content], [Image], [Author], [Count]) VALUES (N'VH12      ', N'THƯƠNG NHỚ TRÀ LONG (TÁI BẢN 2019) ', 78, N'VH        ', 10, N'Một cuốn sách lãng mạn, trong từng con chữ đầy ắp tình yêu với mưa, với lá, với ngôi nhà cũ, cuốn sách xưa, cùng nỗi nhớ quê và những kỷ niệm thuở nhỏ... Có thể thấy mùi vị của những món ăn mẹ nấu, màu sắc trái cây mẹ mua, những trò chơi của con nhà nghèo…, từ ký ức tác giả đã vẽ ra cho người đọc cả một miền quê với hình ảnh, bối cảnh, không gian, con người của thời ấy, chân thực và tinh tế. ', N'https://product.hstatic.net/1000363117/product/image_187703_a9455f1e157949a784b3481f9498d97c_master.jpg', NULL, 3)
INSERT [dbo].[Book] ([ID], [Name], [Price], [Category_ID], [Sale], [Content], [Image], [Author], [Count]) VALUES (N'VH13      ', N'CON CHÓ NHỎ MANG GIỎ HOA HỒNG (TÁI BẢN 2020) ', 95, N'VH        ', 10, N'Cái tựa sách quả là có sức gợi tò mò. 

Tại sao lại là con chó mang giỏ hoa hồng? Nó mang cho bạn nó, hay cho những ai biết yêu thương nó?   

Câu chuyện về 5 chú chó đầy thú vị và cũng không kém cảm xúc lãng mạn- tác phẩm mới nhất của nhà văn bestseller Nguyễn Nhật Ánh sẽ khiến bạn thay đổi nhiều trong cách nhìn về loài thú cưng số 1 thế giới này. ', N'https://product.hstatic.net/1000363117/product/image_195509_1_29717_fe39e983d96b4072bf85c2375a9b83eb_master.jpg', NULL, 5)
INSERT [dbo].[Book] ([ID], [Name], [Price], [Category_ID], [Sale], [Content], [Image], [Author], [Count]) VALUES (N'VH14      ', N'NHỮNG CHÀNG TRAI XẤU TÍNH (TÁI BẢN 2022) ', 85, N'VH        ', 10, N'Ở hồ bơi công cộng trong những ngày hè nóng nực, câu chuyện kề về cuộc gặp gỡ và tình cảm gian nan nhưng không kém phần tinh nghịch với một cô gái đẹp như “nữ minh tinh Hollywood” của hai cậu bạn thân tên Biền và Tưởng. Mỗi ngày hai cậu bạn đều rủ nhau đi bơi và đã trót “phải lòng” cô gái ấy, nhưng có một điều khiến cả hai chàng trai không ít lần hoang mang và khó hiểu là sự thay đổi “như thời tiết” xảy ra mỗi ngày trong tính cách của “nữ minh tinh”, cùng với đó là tình cảm của cô nàng với họ cũng thay đổi đến chóng mặt, khiến họ theo không kịp và nhiều lúc xảy ra xích mích. Biền và Tường làm đủ mọi cách, bày đủ trò tinh quái để tìm hiểu nguyên nhân về cô nàng kỳ lạ này. ', N'https://product.hstatic.net/1000363117/product/8934974177319_30372124407a4f218c77b2cba107fa38_master.jpg', NULL, 5)
INSERT [dbo].[Book] ([ID], [Name], [Price], [Category_ID], [Sale], [Content], [Image], [Author], [Count]) VALUES (N'VH15      ', N'PHÒNG TRỌ BA NGƯỜI (TÁI BẢN 2022) ', 110, N'VH        ', 10, N'Phòng trọ ba người là nơi dành cho ba chàng sinh viên Chuyên, Nhiệm, và Mẫn trú ngụ, là nơi họ chia sẻ việc học hành, những trò nghịch ngợm và chia sẻ cả những buồn vui trong đời sống tình cảm. Mẫn, chàng trai nhút nhát vốn quan niệm tình yêu là thứ “ xa xỉ phẩm”, đến lúc phải dựng lên vở kịch tình yêu với sự trợ sức của Thu Thảo, cô học trò tinh nghịch của anh. Trò chơi tưởng chỉ để góp vào không khí sôi động của căn gác trọ ấy, không ngờ đã thực sự cuốn hút chàng trai chuyên “dị ứng với phụ nữ” ấy. Khi buộc lòng phải chấm dứt với trò chơi, cũng là lúc Mẫn cảm thấy bâng khuâng như phải chia tay với tình cảm thực sự.', N'https://product.hstatic.net/1000363117/product/8934974177982_7a1349f155094e7aac629d9504ae4af8_master.jpg', NULL, 2)
INSERT [dbo].[Book] ([ID], [Name], [Price], [Category_ID], [Sale], [Content], [Image], [Author], [Count]) VALUES (N'VH16      ', N'NHỮNG THIẾU NỮ NHÀ MARCH ', 118, N'VH        ', 10, N'Trong kho tàng văn học kinh điển, hiếm có tác phẩm nào dễ đọc, bình dị lại có sức sống mãnh liệt như Những thiếu nữ nhà March. 

Lấy bối cảnh Nội chiến Mỹ những năm 1860 nhưng câu chuyện không kể về những anh hùng ngoài mặt trận mà chỉ xoay quanh cuộc sống nơi hậu phương của gia đình March gồm bà mẹ và bốn cô con gái ở độ tuổi từ mười hai tới mười sáu. Meg xinh đẹp, Jo hậu đậu, Beth trầm lặng và Amy thanh lịch, bốn con người, bốn tính cách khác biệt đã cùng nhau vẽ nên một bức tranh sống động, chi tiết về miền Bắc nước Mỹ thời kỳ này. 

Truyện của Louisa May Alcott luôn mang đậm hơi thở thời đại từ lề lối sinh hoạt, ứng xử, con người ở nhiều tầng lớp xã hội cho tới những điều nhỏ nhặt nhất như trang phục, trò chơi, vật dụng hàng ngày. Nhưng mặt khác, tư tưởng tác phẩm lại chưa từng lỗi thời, hay đúng hơn là chưa từng không hợp thời bất kể là thế kỷ mười chín hay thế kỷ hai mốt. Bởi không hề áp đặt nữ quyền một cách cực đoan, cũng chẳng gò ép phụ nữ vào khuôn khổ truyền thống hà khắc, mọi nhân vật đều được tác giả khuyến khích trở thành phiên bản tốt nhất của chính mình, tìm lấy điều làm mình hạnh phúc, dù đó chỉ đơn giản là"một ông chồng tuyệt vời và những đứa con thiên thần", là "ở cùng bố mẹ, chăm sóc cho mọi người trong nhà" hay tham vọng lớn lao "làm cái gì đó vĩ đại", "tới Rome và vẽ những tác phẩm đỉnh cao". 

Từ đây, thế giới nhỏ bé của bốn cô thiếu nữ đã trở thành nguồn cảm hứng cho hàng triệu độc giả toàn thế giới xuyên suốt ba thế kỷ, cổ vũ họ chủ động nắm giữ vận mệnh của chính mình. ', N'https://product.hstatic.net/1000363117/product/9786044777276_83099fbf378a42afb43d1e4408229267_master.jpg', NULL, 3)
INSERT [dbo].[Book] ([ID], [Name], [Price], [Category_ID], [Sale], [Content], [Image], [Author], [Count]) VALUES (N'VH17      ', N'TẶNG HOA CHO QUÁI VẬT TRONG RỪNG ', 115, N'VH        ', 5, N'Cleo là cậu ấm con nhà danh giá với thể chất yếu ớt, tinh thần yếu đuối, và cuộc sống tù túng dưới sự áp chế của người cha khắc nghiệt lạnh lùng cùng sự khinh khi của hầu hết gia nhân. 

 
Mặc dù nhạt nhòa trong thế giới quyền lực danh vọng, nhưng Cleo là một tài năng đang dần nở rộ trong thế giới hội họa. Cuộc sống của cậu đột ngột thay đổi khi gia tộc đẩy cậu vào một thử thách khó khăn - Thử thách Hoa hồng xanh.  

 
Vượt qua các quái vật trong rừng, hái bông hoa về đúng giờ, Cleo sẽ được thừa kế gia sản và tước vị.  

 
Trái lại, cậu sẽ sống trong áp chế và khinh khi mãi mãi. 

 
Ngay đêm đầu tiên vào rừng, Cleo đã bị tùy tùng bỏ rơi. Nhưng khó khăn lớn nhất là khi cậu bất ngờ rơi vào tay hoa ăn thịt người mang hình hài thiếu nữ khỏa thân. Sinh tồn của Cleo giờ phụ thuộc vào khả năng xoay xở của cậu với bông hoa vô tư nhưng đầy nguy hiểm ấy. 

 
Tặng hoa cho quái vật trong rừng, là ẩn dụ về cuộc gặp gỡ giữa hai thế giới, hai giống loài, và mê hoặc hơn là hành trình khám phá ra màu sắc cuộc sống cùng ý nghĩa thực sự của đời mình.  

 
Rừng già âm u đầy rẫy hiểm nguy lại là nơi nảy nở những giác ngộ quý giá và tình cảm nguyên sơ, làm đổi thay không chỉ cuộc sống của Cleo, mà còn của cả dân chúng, của nếp sống và truyền thuyết bao đời trong vùng. ', N'https://product.hstatic.net/1000363117/product/8935250712453_8363dbfffee946e985c324eb5e5335e9_master.jpg', NULL, 1)
INSERT [dbo].[Book] ([ID], [Name], [Price], [Category_ID], [Sale], [Content], [Image], [Author], [Count]) VALUES (N'VH18      ', N'NGƯỜI THẮP SAO TRỜI ', 60, N'VH        ', 5, N'Bất kể gặp phải ai, đó đều là người chắc chắn phải gặp. 
Dù xảy ra chuyện gì, đó đều là chuyện chắc chắn xảy ra. 
Tất cả phát sinh vào thời điểm nào, đó đều là thời điểm không thể thay đổi. 
Bởi vậy đừng ao ước được làm lại, đừng mất công tiếc nuối: Giá như… 

Đạo lý này, sau rất nhiều chuyện anh mới hiểu được. 
Là sau chuyện tay họa sĩ đi đổ rác, phát hiện ra anh và chống đối bằng vũ lực. 
Sau chuyện súng anh cướp cò, làm hắn ngã lầu thiệt mạng. 
Dĩ nhiên sau cả chuyện em hắn rơi vào đời anh như cục nợ, khuấy đảo mọi ngăn nắp tỉnh táo bằng tư duy thơ trẻ và ứng xử ngoài hành tinh của cậu ta. 

Hai con người khiếm khuyết giữa đời đã gặp gỡ và lấp đầy nhau bằng những cách rất riêng. 
Cậu bị cướp đi chốn dung thân bấp bênh, và được đền trả bằng chở che trường cửu. 
Anh chỉ vẽ cho cậu một con cừu, mà được đáp lại bằng muôn chiều xán lạn… ', N'https://product.hstatic.net/1000363117/product/8935250712002_8e1506c6389d459691c1830da57dc8b5_master.jpg', NULL, 4)
INSERT [dbo].[Book] ([ID], [Name], [Price], [Category_ID], [Sale], [Content], [Image], [Author], [Count]) VALUES (N'VH19      ', N'BIẾN TẤU DIOGENES ', 160, N'VH        ', 5, N'Tập truyện ngắn thuộc nhiều thể loại như trinh thám, kinh dị, kì bí, khoa học viễn tưởng, siêu thực huyền ảo, như dệt thành một tổ khúc đánh dấu 10 năm sáng tác của Chan Ho Kei. 

Đây là một thử nghiệm mới mẻ đầy táo bạo, thể hiện quá trình sáng tạo và nỗ lực làm mới mình của tác giả. 

Với cuốn sách này, độc giả sẽ bước vào một cuộc phiêu lưu với những cú cua gắt đậm chất Chan Ho Kei. ', N'https://product.hstatic.net/1000363117/product/bi_n_t_u_diogenes_-_b_a_1_675a93d17eea4261bdb56dd033864c3e_master.jpg', NULL, 5)
INSERT [dbo].[Book] ([ID], [Name], [Price], [Category_ID], [Sale], [Content], [Image], [Author], [Count]) VALUES (N'VH20      ', N'NGƯỜI KÉO ', 135, N'VH        ', 5, N'Trong thành phố có một kẻ giết người hàng loạt… 

Với thủ pháp đặc trưng là đâm phập kéo vào họng nạn nhân. 

Thi thoảng hắn cũng gia giảm một chút công đoạn khác. Ví như có lần hạ sát một cô bé giỏi tiếng Anh, hắn đã tò mò rạch nát má cô ra để ngó vào trong xem cái lưỡi nói giỏi tiếng Anh trông thế nào. 

Nhưng cách thức cơ bản vẫn là: đâm kéo vào họng. 

Truyền thông bèn đặt cho hắn hỗn danh: Người kéo. 

Một ngày nọ, Người kéo lên đường đến địa điểm đã định để giết nạn nhân tiếp theo, thì lại chỉ nhặt được xác cô bé. Ai đó đã nẫng tay trên con mồi của hắn, và ngang ngược hơn là, bằng đúng thủ pháp hắn vẫn dùng: đâm kéo vào họng nạn nhân. 

Cảm thấy tự tôn bị thương tổn, Người kéo bắt đầu lên đường săn lùng kẻ sát nhân mạo danh mình. 

Từ đó đem đến một mô típ rất hiếm gặp trong trinh thám: 

Không phải cuộc đấu tranh giữa Thiện và Ác! 

Mà là màn đấu trí nghiệt ngã giữa Ác và Tà! ', N'https://product.hstatic.net/1000363117/product/nguoi-keo---bia-1-26.7_575d8aa45e39437b9b9fb3c05c984de9_master.jpg', NULL, 2)
INSERT [dbo].[Book] ([ID], [Name], [Price], [Category_ID], [Sale], [Content], [Image], [Author], [Count]) VALUES (N'VH21      ', N'TỘI TÌNH VÌ YÊU ', 130, N'VH        ', 5, N'Có một loại sâu sống kí sinh trong cơ thể con người, cách trừ khử duy nhất là tự bỏ đói bản thân, đặt một món ăn nóng sốt nơi miệng, đợi con sâu ngửi thấy mùi thức ăn, chậm rãi duỗi mình ra và tìm đường bò ngược lên. 

Có một thứ bí mật đen tối ẩn sâu dưới những nếp gấp thời gian, cách trừ khử duy nhất là bỏ đói ký ức, đừng động tay vào nó, trông thấy cũng tảng lờ, và chối bỏ mọi lời cáo buộc liên quan đến bí mật ấy. 

Nhưng sẽ ra sao nếu có người, vô tình hoặc cố ý, không muốn trừ khử? Sẽ ra sao nếu trên đời thật sự có nhân quả? 

Con người có bản tính tò mò. Nhờ vậy, ta luôn khát khao chinh phục tự nhiên và khám phá những chân trời mới. Nhưng cũng chính bởi tò mò, Adam rủ Eva ăn trái cấm và bị đuổi khỏi vườn địa đàng, Pandora mở chiếc hộp thần khiến bệnh tật tràn lan, nhũng nhiễu thế gian đời đời kiếp kiếp. Và giờ đây, hậu quả của tò mò hiện hình trong một phiên bản mới, câu chuyện về Cecilia tội nghiệp với lá thư định mệnh.  

TỘI TÌNH VÌ YÊU, tiểu thuyết tâm lý xã hội của Liane Moriaty, là một hành trình cảm xúc, dẫn dắt người ta đi từ dằn vặt này tới giày vò khác, đầy khổ đau, tuyệt vọng xen những phút giây lặng lẽ, an nhiên; như mặt biển hiền hòa trước cơn cuồng phong, bão tố. Một bí mật nên được chôn vùi mãi mãi đã bị mở ra. Và quả báo xuất hiện, trò đùa số phận bắt đầu… ', N'https://product.hstatic.net/1000363117/product/toi-tinh.jpg_c7ce7eb915254ff6adba30e004e959ec_master.jpg', NULL, 1)
INSERT [dbo].[Book] ([ID], [Name], [Price], [Category_ID], [Sale], [Content], [Image], [Author], [Count]) VALUES (N'VH22      ', N'ANOTHER 2001 ', 320, N'VH        ', 0, N'Trụy tim, xe tông sập nhà, thang rơi tự do, ngã lầu gãy cổ, họng cắm mũi dù… Đó là vài trong nhiều nguyên nhân dẫn đến cái chết của những người liên quan với lớp 9-3 vào năm 1998. 

Yên ả hai năm, hôm khai giảng niên khóa 2001, lớp hụt đi một bộ bàn ghế, cho thấy tai ương đã quay lại và kẻ đã chết đang hồi sinh. 

Từ đây, các thiếu nam thiếu nữ ở lứa tuổi rong chơi, chỉ cần biết ăn ngủ biết học hành là đủ, bỗng phải tiếp nhận thử thách lớn nhất đời người: tồn vong. 

Từ đây, mưa đá, quạ đuổi, ruồi bay, sương dày, cốc xoay, xe rác, bồn tắm… đều trở thành hung khí khó lường, đẩy những người liên quan vào vòng tay Thần Chết, tạo nên một năm phát sinh nguy hiểm bậc nhất, cũng tạo nên bom tấn bậc nhất trong vũ trụ ANOTHER, từ nguyên nhân tử vong, tần suất tai ương, mức độ thiệt hại… cho đến tư tưởng xã hội, quan điểm tâm linh và kích cỡ của chính cuốn sách. 

ANOTHER 2001 

- Dẫn người đọc đi sâu hơn vào tâm lý hỗn mang khi con người ta phải sống trong một thế giới liên tục tái thiết lập, nơi kí ức bị bóp méo, các bản ghi bị chỉnh sửa, logic thông thường nằm bẹp dí dưới gan bàn chân những thế lực kì dị vô hình. 

- Sử dụng cách thức hợp lý để phá vỡ bất hạnh phi lý, kéo nhân vật và cả người đọc ra khỏi màn sương bí hiểm của tai ương, kèm theo lời khuyên kín đáo về yêu cầu ứng xử trung dung với vũ trụ nếu muốn sống yên bình, đúc kết từ bề dày tuổi đời, tuổi nghề, cũng như chiêm nghiệm của tác giả sau hai năm chao đảo vì đại dịch. 

- Ra mắt tám năm sau Another (tiếng Việt) và năm năm sau Another S/0, ANOTHER 2001 tiếp tục khẳng định bút lực hùng hậu và ý tưởng dồi dào của Yukito Ayatsuji, tên tuổi vàng trong làng trinh thám tân cổ điển Nhật Bản. ', N'https://product.hstatic.net/1000363117/product/another2001_-_bia1_1_a04df0e24b0d4ee887447e6f04fe6e67_master.jpg', NULL, 3)
INSERT [dbo].[Book] ([ID], [Name], [Price], [Category_ID], [Sale], [Content], [Image], [Author], [Count]) VALUES (N'VH23      ', N'NHỮNG ĐÊM SƯƠNG ', 110, N'VH        ', 10, N'Truyện “Cô gái quê”, trong phần Quê hương Kinh Bắc, mở đầu cho cuốn sách, là câu chuyện của một chàng trai đã rời quê để đến Hà Thành hoa lệ sinh sống. Một hôm chàng quyết định bán tất cả điền thổ mà cha mẹ để lại nơi quê nhà, để toàn tâm với cuộc sống nơi đô hội. Nhưng trong những ngày về quê, chàng đã cảm nhận được hơi thở của đất đai thông qua những thổ lộ của ông lão làm công giữ đất, về những kỷ niệm của cha mẹ chàng với mảnh đất quê hương. Cũng tại đây chàng đã cảm thấy được sức sống mới qua vẻ đẹp thanh tân của cô con gái ông lão làm vườn. Tất cả những thay đổi trong nhận thức và cảm xúc đã khiến chàng quyết định giữ lại mảnh đất, nơi chôn nhau cắt rún của mình. Đây là một truyện ngắn xuất sắc của Ngọc Giao và nó xứng đáng được mở đầu tập truyện.  

Truyện ngắn “Lucie” kể về mối tình của chàng sinh viên trẻ tuổi với một phụ nữ người Pháp có một con, với nỗi tuyệt vọng và sự cao thượng đan xen, khiến cho cái kết buồn nhưng không bi luỵ; độc giả cũng bất ngờ đến ngỡ ngàng khi người đàn bà ấy trước khi trở thành một nữ tu, đã để lại lời nhắn nhủ cho chàng trai trẻ rằng, nàng hy vọng một ngày nào đó chàng trai sẽ gặp lại cô con gái bé bỏng của nàng khi cô bé lớn lên. 

Một trong những truyện điển hình viết về Hà Nội có thể khiến ta thổn thức, đó là truyện “Người đưa thư”. Ta vừa dõi theo những thăng trầm của người đàn ông đưa thư gắn bó cuộc đời mình với từng góc phố, từng câu chuyện đời người Hà Nội, mà như vừa thấy hiển hiện những thăng trầm của chính thành phố này qua bao bể dâu.  

Có rất nhiều điều khiến ta nhớ, bâng khuâng khi đọc “Những đêm sương”. Không chỉ là tác phẩm văn chương thực thụ được viết bởi ngòi bút lão luyện và tinh thần tao nhã; nó còn có thể được xem như di sản văn học quý giá viết về Hà Nội xưa với những trải nghiệm của người trong cuộc và với nhiều chi tiết được xem như sử liệu.  ', N'https://product.hstatic.net/1000363117/product/image_228750_24960858afb243788382ac2ead60e893_master.jpg', NULL, 2)
INSERT [dbo].[Book] ([ID], [Name], [Price], [Category_ID], [Sale], [Content], [Image], [Author], [Count]) VALUES (N'VH24      ', N'KÝ SỰ NGƯỜI ĐÀN BÀ BỊ CHỒNG BỎ ', 94.5, N'VH        ', 10, N'Là tập ký sự không chỉ về một mà nhiều người đàn bà bị chồng bỏ. Họ là những người đàn bà say yêu: yêu đàn ông, yêu nghệ thuật và yêu cả những nỗi đau đớn của chính mình. 

Và đây cũng là bức tranh với những gam màu thăng trầm của nghệ thuật Cải lương nói riêng và Sân khấu nói chung.  ', N'https://product.hstatic.net/1000363117/product/nxbtre_full_15482020_014816_2e0cf1175cb64c3fa00da17acad3b140_master.jpg', NULL, 1)
INSERT [dbo].[Book] ([ID], [Name], [Price], [Category_ID], [Sale], [Content], [Image], [Author], [Count]) VALUES (N'VH25      ', N'BỎ QUA RẤT UỔNG ', 70, N'VH        ', 10, N'Bỏ qua rất uổng là tập bút kí, tản văn của nhà thơ Lê Giang, ghi lại những kỉ niệm, cảm nhận của nhà thơ về cuộc sống, con người và cách con người – cuộc sống đãi đằng nhau, với cái tình đằm thắm, dịu dàng, đôi chỗ chòng ghẹo duyên dáng. Đúng như châm ngôn của bà: Sống để mà nhớ lấy.', N'https://product.hstatic.net/1000363117/product/8934974152941_5a3ad128c1274857883138e0a7fb4252_master.jpg', NULL, 4)
INSERT [dbo].[Book] ([ID], [Name], [Price], [Category_ID], [Sale], [Content], [Image], [Author], [Count]) VALUES (N'VH26      ', N'CON TIN STOCKHOLM ', 80, N'VH        ', 10, N'“Con tin Stockholm” là tuyển tập truyện ngắn mới của Hoàng Công Danh. Truyện ngắn Hoàng Công Danh được cấu trúc hiện đại, các chi tiết hấp dẫn, ám ảnh, bất ngờ nhưng lại tạo ra độ sâu suy tưởng đặc trưng. Tập truyện này sẽ cho ta ấn tượng như đọc một tiểu thuyết. 

“Truyện ngắn Con tin Stockholm - Hoàng Công Danh nói về một sự đời đắng ngắt, ấy là con người thật đáng thương trong khát vọng tự do. “Người ta có cởi trói cho nhau được không?” Câu hỏi quá khó nếu như người ta còn muốn trói buộc nhau, muốn bắt nhau làm con tin. Ngược lại thì quá dễ.  Khó khó dễ dễ, được được mất mất, sắc sắc không không, những câu hỏi của tự do đều vậy cả.” – Nguyễn Quang Thiều 

“Con mèo vừa sống vừa chết. Tiếng mèo có thể gây mất ngủ. Quá bình thường! Tiếng mèo làm cho một nhà khoa học và một nhà văn phải đi tìm và cùng hẹn nhau sáng tạo trong lĩnh vực của họ - đến đây thì mọi chuyện đã trở nên khác thường. Điều đáng nói ở đây là cô gái và chàng trai đều nghiêm túc, và hoàn cảnh mới “có vấn đề”. Hoàng Công Danh là nhà văn hướng đến sự tìm tòi.” – Lê Anh Hoài ', N'https://product.hstatic.net/1000363117/product/image_227308_86237fc777394549a7fbd5ab17402061_master.jpg', NULL, 5)
INSERT [dbo].[Book] ([ID], [Name], [Price], [Category_ID], [Sale], [Content], [Image], [Author], [Count]) VALUES (N'VH27      ', N'CON DÂU 4.0 - MẸ CHỒNG HIỆN ĐẠI ', 110, N'VH        ', 10, N'“Cuốn sách này tôi muốn dành tặng tất cả những bà mẹ có con trai và con gái. Có con trai, thì chúng ta sẽ là mẹ chồng, còn nếu có con gái thì con chúng ta cũng có thể sẽ đi làm dâu một bà mẹ chồng nào đó. Làm thế nào để tất cả những phụ nữ khi cùng yêu thương một người đàn ông sẽ vui vẻ hạnh phúc chứ không phải đứng ở hai chiến tuyến mà hét lên “Mẹ hay vợ, anh hãy chọn đi!”. Tại sao chàng trai ấy phải chọn, trong khi hoàn toàn có thể có cả hai trong yêu thương?” 

Mong muốn của tác giả khi ghi lại những câu chuyện nho nhỏ này chỉ đơn giản vậy thôi, chỉ cần nếu như có ai đó xem đây như một cuốn “Hướng dẫn sử dụng Mẹ Chồng- Nàng Dâu”, sẽ tham khảo được phần nào khiến cho chuỗi ngày làm mẹ chồng hay nàng dâu của bản thân mình nhẹ nhõm, hoặc họ có thể “tối ưu hóa” mối quan hệ đặc biệt này hơn, hài lòng về nhau hơn… 

Một style về kỹ năng sống, được viết dưới giọng hài hước tràn đầy thương yêu“', N'https://product.hstatic.net/1000363117/product/image_227305_f88d6a76efbf45fcbdd3086a1a19e02f_master.jpg', NULL, 2)
INSERT [dbo].[Book] ([ID], [Name], [Price], [Category_ID], [Sale], [Content], [Image], [Author], [Count]) VALUES (N'VH28      ', N'PHAN TRIỀU HẢI - TRUYỆN NGẮN ', 176, N'VH        ', 10, N'“Phan Triều Hải – Truyện ngắn” là tập hợp từ 5 tập truyện mỏng đã từng xuất bản, tạo được dấu ấn riêng của nhà văn Phan Triều Hải, gồm: Vào đời (1994), Những linh hồn lạc (1995), Quán bò rừng (1995), Có một người nằm trên mái nhà (1997) và Những con đường không đến Seattle (2005). 

Những chàng trai, cô gái trong các truyện ngắn Phan Triều Hải lúc bấy giờ chưa xài điện thoại thông minh và chưa tự bào mòn nội tâm của mình trên các trang mạng xã hội. Họ tự nhiên sống, yêu đương, trắc ẩn, mộng mơ (thậm chí, “hoang đàng”) trong bối cảnh không gian đô thị bắt đầu dồn nén bởi những áp lực nội sinh và từ bên ngoài. 

Họ trôi nổi đó, rồi chăm chút suy tư đó. 

Mỗi câu chuyện là một mảnh ghép được ráp nối khéo léo, trong một tinh thần ung dung. 

Và ung dung, có bề lạnh lẽo, cũng là một đặc thù của văn chương Phan Triều Hải. Tác giả ý thức tiết chế những dấu biểu thị tình thái cảm xúc trong các câu văn. Thường xuyên sử dụng câu ngắn, có sự can thiệp sòng phẳng của lý trí. Kể cả đó là thứ lý trí khi người ta 20 tuổi, dễ nhìn về cuộc đời xung quanh với ít nhiều tâm tình hồ hởi, bộc phát hay cường điệu. Đây là một thứ văn chương mà người viết kiểm soát ngôn ngữ cao độ. Những truyện ngắn được tổ chức trong một cấu trúc chặt, gọn, tự nhiên và thường kết thúc mở. Ở đâu đó, nếu có các đoạn triết lý chủ quan, thì cũng chỉ là những tiểu tiết được đan cài hợp lý, không gây ra cảm giác áp đặt. 

Đã có một giai đoạn văn chương có tính chuyển tiếp, ít ra trong tư duy hiện thực, đủ tạo ấn tượng êm đềm ở khoảng hậu Đổi mới. Có thể kể lại những cái tên: Phan Thị Vàng Anh, Phan Triều Hải, Nguyễn Thị Châu Giang, Lưu Sơn Minh, Nguyễn Thị Thu Huệ,… Viết, có lẽ đã thực sự là một nhu cầu bộc bạch đầy trong sáng và tự nhiên của từng tác giả tuổi đôi mươi, ở thời điểm bản lề của những đổi thay bối cảnh, tâm cảnh sống. Tốc độ thay đổi chưa đủ làm chao đảo, khiến họ phải quay quắt âu lo đánh mất những nền tảng quá hệ trọng, nhưng họ cũng không còn được phép chậm rãi hay lệ thuộc vào tư duy cũ để thúc thủ minh họa hay lãng đãng viễn mơ. Trong hiện thực của họ, vẫn còn đó mảnh đất cho cái đẹp, chất thơ trong những băn khoăn về tồn tại vượt thoát trên những lao xao bối cảnh. Với truyện ngắn Phan Triều Hải, vẻ đẹp xa vắng của một cô gái ngắm trăng ở quầy bar, tâm hồn đơn độc nơi người đàn ông chỉ chờ đêm xuống để nằm trên mái nhà theo dõi sự chuyển động lặng yên trong bố cục bầu trời, chuyện về sự thay đổi của những chiếc tô nhựa “trôi nổi” trên mâm cơm một gia đình trẻ, những người làm thơ ở tỉnh lẻ, cái chết của một dân quân ở tuổi hai mươi,… tất cả các chi tiết như vậy được kể nhẹ tênh, nhưng phóng chiếu các thay đổi thói quen, lối sống, tâm hồn ở vào một giai đoạn khá đặc biệt trong lịch sử tinh thần của chúng ta… 

Với bạn đọc trẻ hôm nay, thưởng thức lại truyện ngắn Phan Triều Hải cũng là một dịp được trở về với một thế giới vốn dĩ là nó, ngổn ngang không ngừng, suy tư không ngừng – nhưng đừng đánh mất cảm giác sống, đừng làm thất lạc sự tự tại trong cuộc kiếm tìm cái thuần khiết, tươi mới của nội tâm trước cuộc đời. 

Đã đủ một khoảng lùi để nhìn lại những đóng góp tiêu biểu của văn chương đương đại. Từ sự tập hợp này, Phanbook muốn cùng độc giả văn chương đọc lại một cách đủ đầy sáng tác của một trong những nhà văn trẻ từng được độc giả thế hệ mình ái mộ trong thập niên 1990 đến nửa đầu thập niên 2000. 

Trân trọng giới thiệu cùng bạn đọc! ', N'https://product.hstatic.net/1000363117/product/phan_trieu_hai___truyen_ngan_1_2018_10_05_16_05_42_8d0fd5e41f474ea0a0b71c29e10159f8_master.jpg', NULL, 1)
INSERT [dbo].[Book] ([ID], [Name], [Price], [Category_ID], [Sale], [Content], [Image], [Author], [Count]) VALUES (N'VH29      ', N'HOA CÚC DẠI ', 179, N'VH        ', 10, N'Hoa cúc dại của nhà văn Kim Ân là một tập truyện ngắn hậu chiến xuất sắc, không thể bỏ qua. 

Thế giới nhân vật trong tập truyện này được mở ra phong phú với nhiều hạng người trong xã hội hiện đại có nội tâm phức tạp, biến chuyển tâm lý đầy bất ngờ. Bằng lối viết điêu luyện của người đã trải qua nhiều năm thăng trầm thời cuộc, các hình tượng trong văn chương Kim Ân hướng đến tính điển hình, hứa hẹn có sức sống dài lâu. 

Ngoái lại quá khứ với tinh thần độ lượng, bao dung, tác giả tập truyện ngắn Hoa cúc dại truyền trao đến người đọc một thông điệp nhân văn: người ta không thể sống mãi với những vết thương hay sự giày vò hôm qua ', N'https://product.hstatic.net/1000363117/product/untitled_1_4_004a30048e374b1c882655b957678ef3_master.jpg', NULL, 3)
INSERT [dbo].[Book] ([ID], [Name], [Price], [Category_ID], [Sale], [Content], [Image], [Author], [Count]) VALUES (N'VH30      ', N'THƯ GỬI MINA ', 185, N'VH        ', 10, N'Một tiểu thuyết được cấu thành từ 30 bức thư của một nhà văn gốc Việt sống tại Paris viết cho người bạn Afgahnistan đã mất liên lạc. 

Những lá thư nằm bên ngoài một dự định tác phẩm, đã trở thành tác phẩm; là những liên văn bản về bức tranh khủng hoảng kinh tế, chính trị và di dân. 

Mùa thu 2016, nhân vật chính, một nhà văn nữ gốc Việt sống ở Paris, đã quay lại căn phòng áp mái giữa khu Pigalle nóng bỏng từng chứng kiến những ngày đầu tiên cô đặt chân đến Pháp, để bắt tay vào một bản thảo mới. Nhưng thay vì theo đuổi một cuốn tiểu thuyết như việc mà cô vẫn làm, cô đã ngồi viết thư cho Mina một người bạn gái gốc Afghanistan mà cô đã mất liên lạc ngay sau ngày cả hai cùng tốt nghiệp đại học ở Nga. 

30 bức thư trong vòng 2 tuần, không bao giờ được gửi đi, dần dần trở thành một dạng nhật ký nơi cô có thể thổ lộ mọi điều – về nghề viết, về nhân tình thế thái, về cuộc sống tha hương, về quan hệ vợ chồng trống rỗng, về mối tình tuyệt vọng xa xưa, về những nỗi niềm riêng tư bấy lâu bị chôn vùi, về những hành động vô nghĩa của một cuộc sống thường nhật nhàm chán đến kinh ngạc… Tất cả trên một phông nền rộng lớn chạy từ Hà Nội của bao cấp đến Sài Gòn của ngày hôm nay, qua nước Nga của perestroika, Kabul của nội chiến và chưa chắc đã dừng ở Paris của đầu thế kỷ 21 với khủng hoảng kinh tế, chính trị và di dân. 

Một tiểu thuyết tiếng Việt đương đại, đủ sức hòa mình vào dòng chảy văn chương di dân toàn cầu. 

Đây là tiểu thuyết thứ 8 của của nhà văn Thuận. ', N'https://product.hstatic.net/1000363117/product/image_186230_72ba43fd24944593add34ccbee7ad823_master.jpg', NULL, 2)
INSERT [dbo].[Book] ([ID], [Name], [Price], [Category_ID], [Sale], [Content], [Image], [Author], [Count]) VALUES (N'VH31      ', N'ĐỐI THOẠI VỚI TUỔI ĐÔI MƯƠI ', 78, N'VH        ', 10, N' Đối Thoại Với Tuổi Đôi Mươi là những lời tâm sự, tâm tình chân thành, thẳng thắn và cởi mở về tất cả mọi thứ trên đời, trong cuộc sống của chúng ta của nhạc sĩ, nhà văn, nhà báo, nhà giáo Vũ Đức Sao Biển. Từ những kỷ niệm tươi đẹp của một thời đôi mươi phơi phới đến những gian truân của một đời người… ', N'https://product.hstatic.net/1000363117/product/8934974148517_bce3a1abf9f94d13b142581aa2b9a536_master.jpg', NULL, 1)
INSERT [dbo].[Book] ([ID], [Name], [Price], [Category_ID], [Sale], [Content], [Image], [Author], [Count]) VALUES (N'VH32      ', N'XE MÁY TIẾU NGẠO ', 45, N'VH        ', 10, N'Cái tựa làm lộ ngay nội dung chiếm nhiều trang nhất trong cuốn sách: Xe - máy tiếu - ngạo, tức là rất nhiều chuyện xoay quanh cái xe máy: chuyện đi xe máy “như một cảm hứng” , như một thú chơi đã có từ lâu ở trời Âu Mỹ rồi đến ở ta; xe máy có “số má”, số má là biển số đẹp, số tiến số lùi mang số mệnh…; xe máy có “đời”, và có “thời”: từ lúc là thước đo giá trị giàu nghèo của anh trong xã hội đến lúc không còn là ngôi vô địch nữa; chuyện sửa xe máy từ chỗ sợ bị “luộc” đến khi thợ và chủ xe thành bạn tâm giao; chuyện buôn bán, và nhất là văn hóa đi xe máy- một chuyện nhức nhối, nói như tác giả “Phương tiện thay đổi hành vi, việc cải thiện tốc độ của xe máy đã tác động đến thói quen lưu thông ghê gớm”… 

Thú vị nhất là cụm “Mình nghĩ gì khi đi xe máy”, tựa nhại theo tên cuốn sách “Mình nghĩ gì khi mình nói chuyện tình”. Những câu từ tốn hóm hỉnh kể lại tâm lý người đi xe, những so sánh làm sáng thêm ý tứ từ con chữ sử dụng những trích đoạn ca từ hay đoạn văn của các nhạc sỹ nhà văn nổi tiếng. Tư duy chữ và vốn văn hóa cùng vốn sống phong phú luôn là thế mạnh của cây bút này, thậm chí cả chuyện đời xe ôm anh cũng được đưa vào nguyên một bài. 

Chi tiết và công phu là thống kê “Trăn năm xe máy” 4061 chữ của tác giả về xe máy ở Việt Nam, từ khi chiếc xe đầu xuất hiện, đến con số xe Honda xuất xưởng bao nhiêu chiếc năm 2011, các sự kiện liên quan đến việc đi xe máy, và có cả so sánh giá trị của xe với bát phở qua mấy thời kỳ! 

Một phần cuối của sách là những bài hấp dẫn không kém về đô thị: xe hơi, xe bò, ngõ, phố, chợ, hàng ăn rong, hồ, khí hậu bốn mùa.. 

Vẫn một lối viết nhẩn nha và bất ngờ dí dỏm, thêm những bất ngờ mang màu sắc khảo sát xã hội học, Nguyễn Trương Quý đã mang lại một món mới trong rừng tạp bút hiện đại, bạn đọc có lẽ sẽ thích thú đọc để biết, hoặc để nhớ lại một thời phố thị và những chuyện liên quan đến đủ thứ, trong đó có cái xe máy. ', N'https://product.hstatic.net/1000363117/product/xe-may-tieu-ngao_1_670ba0a5521c4fe5bbf48c75faf5572d_master.jpg', NULL, 2)
INSERT [dbo].[Book] ([ID], [Name], [Price], [Category_ID], [Sale], [Content], [Image], [Author], [Count]) VALUES (N'VH33      ', N'CỦA ĐỂ DÀNH ', 135, N'VH        ', 10, N'Đã từ lâu, người ta đọc Nguyễn Thị Thu Huệ không như một tác giả của những truyện cụ thể nữa, mà đọc một giọng văn đặc biệt. 
Dù viết về những cảnh huống nghịch lý của đời sống hay những khát khao kiếm tìm cái gọi là hạnh phúc ở đời, các truyện ngắn của Nguyễn Thị Thu Huệ đảm bảo một giọng sắc cạnh nhưng cũng trễ nải rất đàn bà. Người đọc gặp lại sự biến đổi của xã hội Việt Nam suốt hai thập niên qua những truyện ngắn đặc sắc trong tập sách này, và cũng ghi nhận một phong cách Nguyễn Thị Thu Huệ trong văn đàn Việt. 
Của để dành của chúng ta trong cuộc đời là gì, hay chính là câu hỏi muôn thuở về mục đích sống. Trên tất cả những vật chất phù du, những hạt mầm thiện vẫn được dành để gieo những mùa sau. ', N'https://product.hstatic.net/1000363117/product/8934974153450_df2b52d956974e958de99cce2498a5da_master.jpg', NULL, 3)
INSERT [dbo].[Book] ([ID], [Name], [Price], [Category_ID], [Sale], [Content], [Image], [Author], [Count]) VALUES (N'VH34      ', N'TÔI LÀ BÊTÔ ', 95, N'VH        ', 10, N'Truyện Tôi là Bêtô là sáng tác mới nhất của nhà văn Nguyễn Nhật Ánh được viết theo phong cách hoàn toàn khác so với những tác phẩm trước đây của ông. Những mẩu chuyện, hay những phát hiện của chú chó Bêtô đầy thú vị, vừa hài hước, vừa chiêm nghiệm một cách nhẹ nhàng “vô vàn những điều thú vị mà cuộc sống cố tình giấu kín ở ngóc ngách nào đó trong tâm hồn của mỗi chúng ta”. ', N'https://product.hstatic.net/1000363117/product/nxbtre_full_24352023_043531_1d4b0431dc884779a6b133b8cbef40e8_master.jpg', NULL, 5)
INSERT [dbo].[Book] ([ID], [Name], [Price], [Category_ID], [Sale], [Content], [Image], [Author], [Count]) VALUES (N'VH35      ', N'CÓ HAI CON MÈO NGỒI BÊN CỬA SỔ ', 100, N'VH        ', 10, N'Có hai con mèo ngồi bên cửa sổ là tác phẩm đầu tiên của nhà văn Nguyễn Nhật Ánh viết theo thể loại đồng thoại. Đặc biệt hơn nữa là viết về tình bạn của hai loài vốn là thù địch của nhau mèo và chuột. Đó là tình bạn giữa mèo Gấu và chuột Tí Hon. 

Để biết tại sao mèo Gấu lại chơi thân với chuột Tí Hon, thì mời bạn hãy mở sách ra. 

Cuốn truyện mỏng mảnh vừa phải, hình vẽ của họa sĩ Hoàng Tường sinh động đến từng nét nũng nịu hay kiêu căng của nàng mèo người yêu mèo Gấu, câu chuyện thì hấp dẫn duyên dáng điểm những bài thơ tình lãng mạn nao lòng song đọc to lên thì khiến cười hinh hích… 

Bạn hãy đọc nhé, để thấy, Nguyễn Nhật Ánh đã viết truyện đồng thoại theo cái cách của riêng mình độc đáo như thế nào. ', N'https://product.hstatic.net/1000363117/product/copy_25_nxbtre_full_16462018_114633_d89daf26ef784157bb866aa23e2ada24_master.jpg', NULL, 4)
INSERT [dbo].[Book] ([ID], [Name], [Price], [Category_ID], [Sale], [Content], [Image], [Author], [Count]) VALUES (N'VH36      ', N'QUÁN GÒ ĐI LÊN - KHỔ LỚN (TÁI BẢN 2022) ', 120, N'VH        ', 10, N'Chuyện diễn ra ở quán Đo Đo, quán ăn do tác giả sáng lập để nhớ quê nhà, nơi có chợ Đo Đo – chỗ Quán Gò đi lên ấy. 

Bởi thế, trong câu truyện tràn ngập những nỗi nhớ, nhớ món ăn, nhớ giọng nói, nhớ thói quen, nhớ kỉ niệm… 

Dẫu là câu chuyện ngập tràn nỗi nhớ, vẫn nghe trong đó những tiếng cười rất vui. ', N'https://product.hstatic.net/1000363117/product/8934974177999_9398d81f8ffa46bc8cde0c37c2eee66e_master.jpg', NULL, 1)
INSERT [dbo].[Book] ([ID], [Name], [Price], [Category_ID], [Sale], [Content], [Image], [Author], [Count]) VALUES (N'VH37      ', N'HÃY YÊU ĐỜI ĐI - NHẬT KÝ BÍ MẬT MỚI CỦA ÔNG HENDRIK GROEN ', 245, N'VH        ', 10, N'Trong phần tiếp theo của quyển sách nổi tiếng thế giới "Nhật ký bí mật của ông Hendrik Groen", ông già nghiêm khắc được mọi người yêu mến đã trở lại cùng tài kể chuyện hài hước và lôi cuốn của mình, từ đó mở ra những cuộc phiêu lưu mới nhất của ông cùng Câu lạc bộ Già Nhưng Không Cỗi. Hơn bao giờ hết, ông Hendrik quyết tâm vọc vạch thế giới hòng tìm kiếm niềm vui và hướng đôi mắt lấp lánh nhìn về phía tươi sáng của cuộc sống. 

Sau một năm đau buồn trước cái chết của người bạn Eefje yêu quý, ông Hendrik đã trở nên lọm khọm hơn, nhưng ý thích nghịch ngợm trẻ trung nơi ông vẫn không hề giảm sút. Trước nguy cơ viện dưỡng lão sắp bị phá hủy, ông Hendrik và những người bạn thân thiết của mình không khỏi lo lắng và quyết tâm bước vào cuộc để cứu vãn tình thế. 

Ông Hendrik Groen bất bại đã trở thành hiện tượng văn hóa ở quê hương Hà Lan của ông; và giờ đây, ông cùng với hình tượng nổi tiếng của mình thực hiện hành trình chinh phục thế giới. Tác phẩm bán chạy của Hà Lan, ‘Nhật ký bí mật của ông Hendrik Groen’ sẽ không chỉ làm hài lòng độc giả lớn tuổi bằng cách viết dí dỏm và tâm lý, mà còn cuốn hút và truyền cảm hứng cho những người còn nhiều năm nữa mới phải nếm trải tuổi già. ', N'https://product.hstatic.net/1000363117/product/hay-yeu-doi-di-nhat-ky-bi-mat-moi-cua-ong-hendrik-groen-85-tuoi-3_769e42989e584a3ba14f60165bb752d8_master.jpg', NULL, 2)
INSERT [dbo].[Book] ([ID], [Name], [Price], [Category_ID], [Sale], [Content], [Image], [Author], [Count]) VALUES (N'VH38      ', N'NAMASKAR! XIN CHÀO ẤN ĐỘ (TÁI BẢN 2020) ', 130, N'VH        ', 10, N'Namaskar! Xin chào Ấn Độ của Hồ Anh Thái được xuất bản lần đầu vào năm 2008, nay được Nxb. Trẻ tái bản lại cùng lúc với cuốn Salam! Chào Ba Tư – một sáng tác mới của tác giả, làm thành một bộ 2 cuốn về hai nền văn hóa lâu đời của thế giới. 

Namaska! Xin chào Ấn Độ phác họa đất nước Ấn Độ khái quát từ chiều dài lịch sử đến bề rộng, chiều sâu về văn hóa, tôn giáo,… được trình bày theo lối nghĩ khoa học, sắc bén của một nhà ngoại giao, tiến sĩ văn hóa Phương Đông qua lối viết mềm mại của nhà văn Hồ Anh Thái. 

Được đánh giá là một cuốn sách độc đáo có ích dành cho những ai lần đầu tiên đến Ấn Độ, hoặc muốn khám phá đất nước - văn hóa - con người Ấn Độ, vì đọc Namaska! Xin chào Ấn Độ có thể tìm thấy ngay những điều cần quan tâm: Lịch sử hay Kinh sách; Tôn giáo hay Văn hóa hay Văn chương… Những khái niệm về Ấn Độ đã được tóm lược một cách súc tích, ngắn gọn nhưng sáng rõ ở mức dễ tiếp nhận nhất, được trình bày theo quan niệm của đạo Hindu: tư tưởng, sản phẩm văn hóa, biểu tượng ký hiệu, phong tục tập quán... 

Cuốn sách hấp dẫn hơn một cuốn nhập môn là bởi giọng văn Hồ Anh Thái. Anh sử dụng nhiều thể loại cho từng phần: du ký dành cho các miền văn hóa, tản văn khi viết về tính cách Ấn, khảo cứu, tiểu luận khi đề cập tôn giáo,lịch sử, phong tục tập quán. Sách còn đẹp vì còn có nhiều minh họa - là những bức tranh thần thánh Hindu theo phong cách tranh thờ dân gian hoặc tranh tượng hiện đại, và hình các biểu trưng. ', N'https://product.hstatic.net/1000363117/product/image_195509_1_31042_00407ae75c4843518980ffd432be61e2_master.jpg', NULL, 3)
INSERT [dbo].[Book] ([ID], [Name], [Price], [Category_ID], [Sale], [Content], [Image], [Author], [Count]) VALUES (N'VH39      ', N'Ở LẠI ĐỂ CHỜ NHAU ', 119, N'VH        ', 10, N'Thủ đô New Delhi của Ấn Độ. 

Ký túc xá sinh viên nước ngoài. 

Anh bạn Modi từ châu Phi đến, gặp ai mới quen đều vay tiền và không bao giờ trả nợ. Anh bạn Heirich từ Đức sang, cải theo đạo Hindu và bỏ tiền “mua” một cô vợ Ấn Độ. Vợ chồng Brian - Mary người Mỹ lúc nào cũng lặng lẽ thì nhận một đứa trẻ sơ sinh Ấn Độ làm con nuôi. Cô sinh viên người Việt bơ vơ giữa sân bay Bangalore được một gia đình Ấn Độ nhận vào trong những ngày đầu ở xứ lạ. Anh chàng Lim người Hàn Quốc nóng tính đang ôm ấp ý tưởng viết một quyển truyện tình mà không có một chữ yêu nào… 

Nhà văn Hồ Anh Thái kể về những người bạn sinh viên của mình, từ nhiều đất nước họ đến Ấn Độ. Nền văn minh cổ quyến rũ họ, trở thành điểm hẹn cho họ. Rồi họ chia tay, trở về với các lục địa của mình, nhưng nền văn minh sông Hằng như có ma lực đã theo họ suốt cuộc đời. 

Tập truyện như một tiểu thuyết liên hoàn, một thiên hồi ký độc đáo, lôi cuốn, tươi vui và nhiều khi rưng rưng cảm xúc. ', N'https://product.hstatic.net/1000363117/product/image_195509_1_45372_5b0b70f660c64178ba00ffd98ce8142e_master.jpg', NULL, 5)
INSERT [dbo].[Book] ([ID], [Name], [Price], [Category_ID], [Sale], [Content], [Image], [Author], [Count]) VALUES (N'VH40      ', N'AI CŨNG XỨNG ĐÁNG ĐƯỢC HẠNH PHÚC (TÁI BẢN 2020) ', 119, N'VH        ', 10, N'Với “Ai cũng xứng đáng được hạnh phúc”, vẫn giữ phong cách khó lẫn, chị kể về những trải nghiệm sâu sắc bằng lối văn nói giản dị, như một người bạn thân đang thủ thỉ. Một cuốn sách mà mỗi người đều có thể thấy mình trong đó. Để tuổi trẻ đừng lãng quên những quyền lực của mình. Để cha mẹ thấu hiểu và biết cách trò chuyện với con cái. Để bạn bao dung và trắc ẩn hơn với chính mình và người khác. 

“Không ai chọn được nơi mình sinh ra, nhưng chúng ta vẫn có thể chọn được tâm thế của mình khi đối diện với những vấn đề của cuộc sống. Hạnh phúc không xa xôi, hạnh phúc ở ngay bên trong ta”. 

Những thông điệp về học hành, sự nghiệp, về gia đình, về tình yêu, về cuộc sống... xuất hiện trong sách đầy mới mẻ và khác biệt, nhưng không xa vời. Có lẽ đây là môt dạng sách phát triển bản thân khá đặc biệt, bởi nó có nhiều tính báo chí, với những câu chuyện nóng hổi của xã hội Việt Nam hiện đại, cùng với những trải nghiệm chân thực từ chính tác giả, và rất nhiều những tâm sự chị nhận được suốt hành trình 17 làm báo tuổi teen. Do đó, những lời khuyên sống tử tế, yêu lành mạnh, thái độ tích cực... của chị với người trẻ rất dễ thấm, không bề trên, không hề giáo điều. 

Cuốn sách “Ai cũng xứng đáng được hạnh phúc” lần này Thu Hà tiếp tục hợp tác với Minh Châu Books, bao gồm 4 chương: 

Em có đủ thú vị – Chương dành riêng để bạn trẻ định vị và xây dựng những kỹ năng cần thiết cho bản thân. Những bí quyết sống tử tế, xây dựng tự tin, thiết kế tương lai… và làm cho mình “trở nên đắt giá” được bật mí. Bạn cũng sẽ “mở khóa” được cho câu hỏi làm sao để thoát khỏi “câu lạc bộ những người nhạt”, làm sao để không phải đứng thêm vào dãy người thất nghiệp khổng lồ ngày càng tăng… 

Nếu em thất bại và nhầm đường thì sao – Thế kỷ 21 đang thay đổi nhanh ngoài sức tưởng tượng của nhân loại và chúng ta chuẩn bị bước vào một thế giới tương lai vô cùng bất định. Những kiến thức cụ thể trong sách giáo khoa, hay trong những giờ lên lớp không bao giờ là đủ. Chương này cho chúng ta cơ hội nhìn lại ý nghĩa thật sự của việc học và định hướng đâu mới là điều cần phải trau dồi nhất. 

Tình yêu đích thực sẽ khiến em tự do – Một chương đặc biệt dành riêng cho tình yêu, cho những trái tim dễ thổn thức và xao xuyến vì một người đặc biệt. Để biết yêu người, để biết yêu mình, và để biết cách chia tay an toàn và bình an. Và nếu có thất tình? Hãy cám ơn vì đây là lúc để nhận ra rằng người hiện tại không phải dành cho mình. 

Như cây xương rồng nở hoa – Gia đình là một chương rất đáng đọc của quyển sách này. Có những bài viết đăng trên FB Thu Hà nhận được trên 36 ngàn lượt like, trên 21 ngàn lượt share và trên 4 ngàn lời bình luận, cùng nhiều lời tâm sự đẫm nước mắt. Đọc để thấu hiểu, cảm thông và yêu thương nhiều hơn nữa. Ai mà chẳng muốn một ngôi nhà bão dừng sau cánh cửa. Nhưng đôi khi, một hoàn cảnh không mong muốn, đã tặng ta những nhát cắt, và những cú mài xát đau đớn. Tuy nhiên, không có gì là vô nghĩa, kể cả nỗi đau! 

Cuối cùng thì, như Thu Hà nói: Cách bảo vệ mình hiệu quả nhất, mạnh mẽ nhất, an toàn nhất, chính là làm một người tử tế! 

Và, ai cũng xứng đáng được hạnh phúc. ', N'https://product.hstatic.net/1000363117/product/image_195509_1_56470_a2178c4850b94bd6aaa03e7b832981d8_master.jpg', NULL, 4)
INSERT [dbo].[Book] ([ID], [Name], [Price], [Category_ID], [Sale], [Content], [Image], [Author], [Count]) VALUES (N'VPP01     ', N'BÚT GEL GROUP 07', 6, N'VPP       ', 5, N'Bút có thiết kế đơn giản, thân tròn, nhỏ và ngắn, rất phù hợp với tay cầm của học sinh tiểu học. 

Thân bút bằng nhựa trắng đục, nắp nhựa trong được pha màu theo màu mực. 

Mực màu đậm và tươi sáng, viết êm trơn, ra đều và liên tục. 

Bảo quản: Tránh va chạm vào các vật cứng quá mạnh. Tránh để sản phẩm ở gần nhiệt độ quá cao. ', N'https://product.hstatic.net/1000363117/product/image_195509_1_37682_9e26024170c745c6a87c4299e0c35874_master.jpg', NULL, 1)
INSERT [dbo].[Book] ([ID], [Name], [Price], [Category_ID], [Sale], [Content], [Image], [Author], [Count]) VALUES (N'VPP02     ', N'BÚT BI 0.5 MM THIÊN LONG TL-027 - MỰC XANH', 6, N'VPP       ', 5, N'Đây là một trong những cây bút đang được học sinh sử dụng nhiều nhất tại Việt Nam. Bút có thiết kế tối giản, nhưng tinh tế và ấn tượng. Toàn bộ thân bút làm từ nhựa trong, phối hợp hoàn hảo với màu ruột bút bên trong.', N'https://product.hstatic.net/1000363117/product/image_195509_1_23091_60707550f4394b35af9f8997ca7b1964_master.jpg', NULL, 2)
INSERT [dbo].[Book] ([ID], [Name], [Price], [Category_ID], [Sale], [Content], [Image], [Author], [Count]) VALUES (N'VPP03     ', N'BÚT BI 0.5 MM TREEDEN - THIÊN LONG TL-079 - MỰC XANH', 6, N'VPP       ', 5, N'Bút có thiết kế hiện đại, kết hợp hài hòa giữa phần thân dưới bằng nhựa trong nhỏ và thon dài với phần giắt bút màu nhựa trắng đục khỏe khoắn.Cảm giác cầm bút rất thoải mái, viết rất êm. Nét viết thanh mảnh và sắc nét.', N'https://product.hstatic.net/1000363117/product/image_195509_1_23094_c034a04f6d3646f89914ea6f730f2ff4_master.jpg', NULL, 3)
INSERT [dbo].[Book] ([ID], [Name], [Price], [Category_ID], [Sale], [Content], [Image], [Author], [Count]) VALUES (N'VPP04     ', N'BÚT BI 0.5 MM LARIS - THIÊN LONG TL-095 - MỰC XANH ', 6, N'VPP       ', 5, N'Bút Bi Laris TL-095 - Mực Xanh - Thân Xanh có thiết kế đột phá với cơ cấu bấm sáng tạo: Ruột tự động bật lên khi cài giắt bút vào túi áo. 

Kiểu dáng hiện đại, phần tay cầm có đệm cao su mềm (grip) giúp cho cầm bút rất thoải mái. 

Viết rất trơn, êm, mực ra đều, liên tục, đầu bút dạng needle và màu mực: 0.5mm. ', N'https://product.hstatic.net/1000363117/product/8935001804079-mau1-_3__3f1b7cb0c4dd469a86f3cacc5533623b_master.jpg', NULL, 2)
INSERT [dbo].[Book] ([ID], [Name], [Price], [Category_ID], [Sale], [Content], [Image], [Author], [Count]) VALUES (N'VPP05     ', N'BÚT BI 0.5 MM THIÊN LONG TL-027 - MỰC ĐỎ', 6, N'VPP       ', 5, N'Đây là một trong những cây bút đang được học sinh sử dụng nhiều nhất tại Việt Nam. Bút có thiết kế tối giản, nhưng tinh tế và ấn tượng. Toàn bộ thân bút làm từ nhựa trong, phối hợp hoàn hảo với màu ruột bút bên trong.', N'https://product.hstatic.net/1000363117/product/8935001804628_8cdc9394fd504e319a3a2b498603a52e_master.jpg', NULL, 3)
INSERT [dbo].[Book] ([ID], [Name], [Price], [Category_ID], [Sale], [Content], [Image], [Author], [Count]) VALUES (N'VPP06     ', N'BÚT BI 0.5MM THIÊN LONG TL-089 - MỰC XANH ', 5, N'VPP       ', 5, N'Bút Bi TL-089 - Mực Xanh có thiết kế ấn tượng. Toàn bộ thân bút làm từ nhựa trong, phối hợp hoàn hảo với màu ruột bút bên trong. 

Đặc điểm: 

- Bút được thiết kế với đầu bút nhỏ 0.5 mm, cho nét viết nhỏ, nét bút trơn, êm , mực ra đều và liên tục, đảm bảo được nhu cầu ghi chép của tất cả các đối tượng 

- Bút bi dạng bấm cò, nơi tì ngón tay có tiết diện hình tam giác vừa vặn với tay cầm giúp giảm trơn tuột khi viết thường xuyên. 

- Cơ chế bấm nằm gọn dưới giắt bút giúp thuận tay khi sử dụng.', N'https://product.hstatic.net/1000363117/product/8935001803942_0db7fe257c3a4a9c91acfd48ac3e231e_master.jpg', NULL, 1)
INSERT [dbo].[Book] ([ID], [Name], [Price], [Category_ID], [Sale], [Content], [Image], [Author], [Count]) VALUES (N'VPP07     ', N'CHUỐT BÚT CHÌ STABILO PS4518-EXAM GRADE CHỮ NHẬT ', 32, N'VPP       ', 5, N' Gọt chì mini kích thước nhỏ dễ dàng mang theo và sử dụng. 

Gọt chì được chia làm hai phần. Phần nắp của gọt chì màu đỏ bao lấy thân để giữ vụn chì khi gọt không vương vãi. 

Gọt chì được thiết kế vừa vặn với ngón cái và ngón trỏ giúp bạn dễ dàng mở nắp đổ vụn vỏ bút chì ra ngoài. ', N'https://product.hstatic.net/1000363117/product/image_195509_1_24147_8fcd4bcd58d0435aa981234275b166a0_master.jpg', NULL, 2)
INSERT [dbo].[Book] ([ID], [Name], [Price], [Category_ID], [Sale], [Content], [Image], [Author], [Count]) VALUES (N'VPP08     ', N'BÚT NƯỚC TTORU - MỰC TÍM ', 10, N'VPP       ', 5, N'Đầu bi mảnh, nhỏ và trơn mượt 

- Bút được làm bằng nhựa cao cấp 

- Bút Nước TTORU có thiết kế thon gọn, trẻ trung, dễ thương với những hoạ tiết rất ngộ nghĩnh. Thân bút bằng nhựa trong, giúp bạn dễ dàng nhìn thấy được lượng mực. Nắp viết chắc chắn, bảo vệ ngòi một cách tối ưu nhất. ', N'https://product.hstatic.net/1000363117/product/8802203762202_c7567ee628584223889c1dc0542cfe48_master.jpg', NULL, 3)
INSERT [dbo].[Book] ([ID], [Name], [Price], [Category_ID], [Sale], [Content], [Image], [Author], [Count]) VALUES (N'VPP09     ', N'BÚT LÔNG KIM THIÊN LONG FL-08/DO - MỰC TÍM ( MÀU THÂN BÚT GIAO NGẪU NHIÊN) ', 10, N'VPP       ', 5, N'- Đầu bi 0.5mm, sản xuất tại Thụy Sỹ, bọc kim loại. 

- Lượng mực viết dài 1200-1500m, không bị lem và đều 

- Nét viết thanh mãnh nhỏ, trơn, êm 

- Dáng bút thon gọn dễ cầm , xinh xắn thích hợp với trẻ em. 

- Thân in hình Doraemon rất được các bạn trẻ yêu mến và sinh động tạo sự thích thú cho các em rèn luyện chữ viết ', N'https://product.hstatic.net/1000363117/product/8935001813248_1_2_b1cdb3d86cf14c20a7de6304ae2210a6_master.jpg', NULL, 5)
INSERT [dbo].[Book] ([ID], [Name], [Price], [Category_ID], [Sale], [Content], [Image], [Author], [Count]) VALUES (N'VPP10     ', N'GÔM STABILO ER191E - EXAM GRADE ĐEN NHỎ ', 23, N'VPP       ', 5, N'Gôm STABILO ER191E - Exam Grade Đen Nhỏ giúp bạn nhanh chóng tẩy sạch các vết chì mà không cần phải dùng lực ấn quá mạnh. Gôm được làm từ cao su tự nhiên, dẻo dai, có độ đàn hồi tốt, ít tạo bọt trong quá trình xóa, không có tính bào mòn cao, không làm nhăn hay rách giấy.  

Với công nghệ xử lí tiên tiến, Gôm STABILO ER191E - Exam Grade Đen Nhỏ không khô cứng khi để lâu, giữ nguyên chất lượng theo thời gian. Bên ngoài gôm được bọc một lớp giấy cứng, không chỉ mang đến tính thẩm mỹ cho sản phẩm mà còn giúp bảo vệ gôm không bị bụi bẩn xâm nhập. Sản phẩm là một trong những vật dụng cần thiết và không thể thiếu trong học tập, làm việc, đặc biệt là vẽ kỹ thuật. ', N'https://product.hstatic.net/1000363117/product/image_195509_1_24143_a1af168c445947a8b3dbf837b3f3992a_master.jpg', NULL, 4)
INSERT [dbo].[Book] ([ID], [Name], [Price], [Category_ID], [Sale], [Content], [Image], [Author], [Count]) VALUES (N'VPP11     ', N'BÚT GEL-B011 - MỰC XANH ', 10, N'VPP       ', 5, N'Tính năng nổi bật: 

Bút có thiết kế đơn giản và hiện đại. Thân và nắp bút bằng nhựa sáng bóng sang trọng. 

Thân bút tròn và dài rất phù hợp với tay cầm của Học Sinh, Sinh Viên, Nhân Viên Văn Phòng. 

Mực nước màu đậm và tươi sáng, viết êm trơn, ra đều và liên tục. 

Đầu bút cao cấp 0.5mm giúp nét viết mảnh, nhỏ. 

Đặc điểm: 

Thân bút có hình ảnh sinh động ngộ nghĩnh.  

Thân bút được thiết kế gọn nhẹ giúp cho người viết không bị mỏi tay. 

Đặc điểm nổi bật: 

Bút Gel là nhãn hàng Bút viết ra đời nhằm mang đến sự tiện lợi, thoải mái cho người sử dụng. Thiết kế bút phù hợp với người Việt, tạo cho người viết không bị mỏi tay. Đầu bi cao cấp giúp mực trợn mượt, phù hợp cho người viết nhiều, tốc ký như học sinh phổ thông, sinh viên. Vỏ bút làm bằng nhựa trong giúp người viết dễ dàng kiểm tra lượng mực của bút, viết được đến khi hết mực mà không lo tắc hay lắng cặn. 

Với thiết kế trang nhã, màu sắc tươi sáng phù hợp với nhu cầu sử dụng của nhiều người, Bút Gel đã trở thành người bạn đồng hành của nhiều học sinh. ', N'https://product.hstatic.net/1000363117/product/8935001852742-5_9b24e661c5944ffbaadcf4d99eed36ce_master.jpg', NULL, 1)
INSERT [dbo].[Book] ([ID], [Name], [Price], [Category_ID], [Sale], [Content], [Image], [Author], [Count]) VALUES (N'VPP12     ', N'BÚT GEL THIÊN LONG GEL-022 ', 6, N'VPP       ', 5, N'Đặc điểm: 

- Dạng bút gel đậy nắp. 

- Bút có thiết kế đơn giản và hiện đại. Thân và nắp bút bằng nhựa trong, tảm mạ crom sáng bóng sang trọng. 

- Thân bút tròn và dài rất phù hợp với tay cầm của HS, SV, NVVP. 

- Mực màu đậm và tươi sáng, viết êm trơn, ra đều và liên tục. 

- Đầu bút dạng pipe. 

Bảo quản: 

Luôn đậy kín nắp bút sau khi sử dụng. Không tiếp xúc trực tiếp với ánh sáng mặt trời, nơi có nhiệt độ cao. ', N'https://product.hstatic.net/1000363117/product/8935001852131_999087416e9a471fada841bb6c3db44a_master.jpg', NULL, 2)
INSERT [dbo].[Book] ([ID], [Name], [Price], [Category_ID], [Sale], [Content], [Image], [Author], [Count]) VALUES (N'VPP13     ', N'RUỘT CHÌ 0.5MM, 2B, 75MM, 24 CÁI/TUÝP - PC3206R24-2B ', 25, N'VPP       ', 5, NULL, N'https://product.hstatic.net/1000363117/product/image_195509_1_26066_f0612a76050e41dda5e68fe109c6fc70_master.jpg', NULL, 3)
INSERT [dbo].[Book] ([ID], [Name], [Price], [Category_ID], [Sale], [Content], [Image], [Author], [Count]) VALUES (N'VPP14     ', N'BÚT BI 0.8 MM THIÊN LONG TL-025 GRIP - MỰC XANH ', 8, N'VPP       ', 5, N'Bút có thiết kế đơn giản, thân tròn.Thân bút nhựa trong, tảm có đệm mềm (grip) giúp cầm êm tay và giảm trơn trợt khi viết. 

Đặc điểm: 

- Đầu bi: 0.8 mm dạng Cone , sản xuất tại Thụy Sĩ. 
- Grip cùng màu mực 
- Độ dài viết được: 1.200-1.500m. 
- Mực đạt tiêu chuẩn: ASTM D-4236, ASTM F 963-91, EN71/3, TSCA. 
- Thân bút thanh mảnh cơ chế bấm khế tiện dụng phù hợp cho mọi người. 
- Thay ruột khi hết mực. ', N'https://product.hstatic.net/1000363117/product/8935001800354_352e0b897d4245ba85070d114cb77e9b_master.jpg', NULL, 2)
INSERT [dbo].[Book] ([ID], [Name], [Price], [Category_ID], [Sale], [Content], [Image], [Author], [Count]) VALUES (N'VPP15     ', N'BÚT GEL-B015 (MÀU NGẪU NHIÊN) ', 12, N'VPP       ', 5, N'Bút có 5 tone màu pastel bắt mắt, với thiết kế đơn giản, hiện đại, hợp thời trang, hợp xu hướng. 

Tone màu Pastel - màu Vintage - màu dịu mát và ấm áp, mang lại sự nhẹ nhàng, thanh lịch, thoải mái…cho cảm giác mới lạ, nổi bật cá tính. 

Bút được thiết kế ấn tượng, hiện đại, trẻ trung, màu sắc đa dạng và phong phú, thích hợp cho mọi đối tượng học sinh, sinh viên và nhân viên văn phòng. 

Bút dạng mực gel, viết trơn êm, mực ra đều, liên tục, có thể thay ruột dễ dàng khi bút hết mực. ', N'https://product.hstatic.net/1000363117/product/mgmfgmfg_13e61ecd7ae8418bb06dff9256b7cf46_master_d922988551404c20a0c40408bde9c6fd_master.png', NULL, 1)
INSERT [dbo].[Book] ([ID], [Name], [Price], [Category_ID], [Sale], [Content], [Image], [Author], [Count]) VALUES (N'VPP16     ', N'CHÌ GỖ THIÊN LONG GP-018 2B ', 6, N'VPP       ', 5, N'- Bút chì gỗ Thiên Long GP-018 thích hợp cho các hoạt động như ghi chép, vẽ nháp, học tập. Đặc biệt thích hợp cho các em học sinh tiểu học.  

- Bút chì thân gỗ, thân dạng hình lục giác, dễ cầm nắm khi viết. Thân thiết kế đơn giản nhưng sang trọng, sơn một màu vàng. 

- Ruột chì loại 2B, mềm và đen. Nét đậm, lướt nhẹ nhàng trên bề mặt giấy. ', N'https://product.hstatic.net/1000363117/product/8935001822905_1_3ff19270b38140e8af7946b4123a3c47_master.jpg', NULL, 2)
INSERT [dbo].[Book] ([ID], [Name], [Price], [Category_ID], [Sale], [Content], [Image], [Author], [Count]) VALUES (N'VPP17     ', N'BÚT LÔNG KIM THIÊN LONG BEEBEE FL-04 - MỰC TÍM ', 10, N'VPP       ', 5, N'- Nét viết nhỏ, viết êm với đầu bi 0,3mm. 

- Dáng bút thon gọn dễ cầm, xinh xắn kết hợp với thiết kế ngộ nghĩnh, sinh động phù hợp với trẻ em. 

- Sản phẩm sử dụng đầu bút bằng kim loại, ngòi bút bằng nhựa acetal, chịu được độ mài mòn cao. 

- Mực đậm nhanh khô, màu tươi sáng. Mực không bị lem, phù hợp cho cách viết chữ của các bé cấp 01. ', N'https://product.hstatic.net/1000363117/product/image_195509_1_44341_e95d8d28aadf497fba46e1922fd920a8_master.jpg', NULL, 3)
INSERT [dbo].[Book] ([ID], [Name], [Price], [Category_ID], [Sale], [Content], [Image], [Author], [Count]) VALUES (N'VPP18     ', N'BÚT GEL-012/DO - MỰC XANH ', 11, N'VPP       ', 5, N'Tính năng nổi bật: 

Bút có thiết kế đơn giản nhưng khoa học, thân tròn, nhỏ rất phù hợp với tay cầm của học sinh 
tiểu học. 
Thân bút bằng nhựa trắng đục, in transfer flm hình nhân vật Doraemon rất thu hút. 
Mực màu đậm và tươi sáng, viết êm trơn, ra đều và liên tục 

Đặc điểm bút Gel-012/DO 
Đầu bi: 0.5mm, dạng needle , sản suất tại Thụy Sĩ. 
Bút dạng đậy nắp, có grip. 
Độ dài viết được: 500-1000m. 
Mực đạt chuẩn: ASTM D-4236, EN71/3. 

Lợi ích: 
Grip giúp êm tay và chống trơn tuột khi sử dụng lâu. 
Thiết kế bút hiện đại, được in bằng kỹ thuật cao cấp làm tăng thêm tính sang trọng cho sản phẩn, phù hợp cho giới văn phòng.  

Bảo quản: 
Tránh va chạm vào các vật cứng quá mạnh. 
Tránh để sản phẩm ở gần nhiệt độ quá cao.', N'https://product.hstatic.net/1000363117/product/but_gel_thien_long_gel-012do__14_f80f29331924405fa037a1f5452e3b87_master.jpg', NULL, 2)
INSERT [dbo].[Book] ([ID], [Name], [Price], [Category_ID], [Sale], [Content], [Image], [Author], [Count]) VALUES (N'VPP19     ', N'BÚT BI 0.5 MM THIÊN LONG TL-097 - MỰC ĐỎ ', 5, N'VPP       ', 5, N'Đặc tính sản phẩm: 

- Đầu bi: 0.5mm, dạng needle sản xuất tại Thụy Sĩ 
- Độ dài viết được: 1.000-1.500m 
- Mực đạt chuẩn: ASTM D-4236, ASTM F 963-91, EN71/3, TSCA 

Lợi ích:  

- Đầu bi nhỏ tạo nét viết thanh mảnh 
- Sản phẩm được thiết kế trẻ trung năng động phù hợp cho học sinh, sinh viên 

Lưu ý : 

Bấm lại sau khi sử dụng 

Bảo quản: 

Bảo quản nơi khô ráo, thoáng mát. ', N'https://product.hstatic.net/1000363117/product/103_2_dec54f83ed7c4072a8cbdeb66ea9a6d4_master.jpg', NULL, 2)
INSERT [dbo].[Book] ([ID], [Name], [Price], [Category_ID], [Sale], [Content], [Image], [Author], [Count]) VALUES (N'VPP20     ', N'BÚT BI 0.6 MM CANDEE - THIÊN LONG TL-090 - MỰC XANH ', 4, N'VPP       ', 5, N'Dạng bút bi đậy nắp.Đầu bút dạng needle.Bút có cấu tạo khác hoàn toàn với các dạng bút truyền thống. Mực được bơm thẳng vào thân bút để sử dụng. Bút đùn là dạng bút không ruột, mực được bơm thẳng vào vỏ bút (hay nói cách khác là ruột bút cũng chính là thân bút). Chính vì thế mà trọng lượng của bút nhẹ hơn, phù hợp những người cần viết nhiều, tốc ký, ít gây mỏi tay. 

- Thân bút bằng nhựa trong pha màu dạng xoắn, nhìn rất đẹp mắt như hình dạng cây nến nhỏ. 

- Nắp bút bằng nhựa màu được phối theo các màu mực 

- Đầu bi được sản xuất tại Thụy sĩ, chất mực đạt chuẩn ASTM D-4236, ASTM F 963-91, EN71/3, TSCA cho nét chữ thanh mảnh, sắc nét, gọn gàng. 

- Độ dài viết được của bút là từ 1.000 đến 1.500m chiều dài nét mực. ', N'https://product.hstatic.net/1000363117/product/but_bi_thien_long_tl-90__0-6_0d1a4e7c979f47d5a3c84c20b036d8e8_master.jpg', NULL, 3)
INSERT [dbo].[Book] ([ID], [Name], [Price], [Category_ID], [Sale], [Content], [Image], [Author], [Count]) VALUES (N'VPP21     ', N'BÚT BI 0.5 MM TREEDEN - THIÊN LONG TL-079 - MỰC ĐỎ ', 6, N'VPP       ', 5, N'Đặc tính sản phẩm: 

- Đầu bút dạng Needle , kích thước 0.5mm 

- Màu mực Trendee TL-079 đậm, tươi, mực ra đều và liên tục. 

- Cây bút đẹp, nhỏ nhọn khá nhẹ nhàng, thú vị, nét viết trơn êm, sắc sảo, chữ viết đẹp. 

- Ở tất cả sản phẩm bút bi TL-079, tên bút "Trendee" được dập nổi trên thân 

- Sản phẩm có đầu bấm và lo xo nhạy và bền, không bung, không kẹt, vướng 

- Thân bút bằng nhựa nhìn thấy rõ ruột bút và màu mực bên trong 

Lưu ý : 

Bấm lại sau khi sử dụng 

Bảo quản: 

Bảo quản nơi khô ráo, thoáng mát. ', N'https://product.hstatic.net/1000363117/product/8935001804918_2_ae611113b974432d857288b2f027110c_master.jpg', NULL, 5)
INSERT [dbo].[Book] ([ID], [Name], [Price], [Category_ID], [Sale], [Content], [Image], [Author], [Count]) VALUES (N'VPP22     ', N'STICKER, HÌNH DÁN TRANG TRÍ HÌNH HOA CỎ ', 29, N'VPP       ', 10, N'Chất liệu: PET 
Kích thước: ~3 - 5cm 
Quy cách: 40 sticker/bộ 
*Giao mẫu ngẫu nhiên 
 
Hình dán trang trí tập, sổ journal, planner ', N'https://product.hstatic.net/1000363117/product/o1cn01buz9q81ld7hjiqsxl___2947054784-0-cib_dc32330f3216417192262ab9dcad26c1_master.jpg', NULL, 1)
INSERT [dbo].[Book] ([ID], [Name], [Price], [Category_ID], [Sale], [Content], [Image], [Author], [Count]) VALUES (N'VPP23     ', N'BÚT BI PASTEL PRO 027 0.5 MM - THIÊN LONG TL-105 - MỰC XANH (MÀU NGẪU NHIÊN) ', 8, N'VPP       ', 5, N'- Thân bút màu pastel thời trang. 

- Mực êm trơn, đều, mượt, không chảy mực. 

- Lực kẹp giắt chắc chắn, có thể cài được sổ bìa dày 3 mm. 

- Cơ cấu bấm sáng tạo, tự thu ngòi khi cài bút vào tập - túi áo - sổ... ', N'https://product.hstatic.net/1000363117/product/8935324002893_09fc0316ba4e415e96c22e70f90a8b4b_master.png', NULL, 2)
GO
INSERT [dbo].[Cart] ([UserName], [Book_ID]) VALUES (N'haha', N'CK20      ')
INSERT [dbo].[Cart] ([UserName], [Book_ID]) VALUES (N'haha', NULL)
INSERT [dbo].[Cart] ([UserName], [Book_ID]) VALUES (N'haha', N'TN03      ')
INSERT [dbo].[Cart] ([UserName], [Book_ID]) VALUES (N'haha', N'CK28      ')
INSERT [dbo].[Cart] ([UserName], [Book_ID]) VALUES (N'test', N'CK04      ')
INSERT [dbo].[Cart] ([UserName], [Book_ID]) VALUES (N'test', N'CK21      ')
INSERT [dbo].[Cart] ([UserName], [Book_ID]) VALUES (N'test', N'CK28      ')
GO
INSERT [dbo].[Category] ([ID], [Name]) VALUES (N'CK        ', N'Sách có chữ ký')
INSERT [dbo].[Category] ([ID], [Name]) VALUES (N'TN        ', N'Sách thiếu nhi')
INSERT [dbo].[Category] ([ID], [Name]) VALUES (N'TT        ', N'Sách trinh thám')
INSERT [dbo].[Category] ([ID], [Name]) VALUES (N'VH        ', N'Sách văn học')
INSERT [dbo].[Category] ([ID], [Name]) VALUES (N'VPP       ', N'Sách văn phòng phẩm')
GO
INSERT [dbo].[Infor_user] ([User_ID], [Name], [Email], [SDT], [Date], [Gender], [Address], [Image]) VALUES (N'haha', N'hmm', N'duclop8a1@gmail.com', N'0981159445', CAST(N'2024-10-09' AS Date), N'2', N'Hà Nội', NULL)
INSERT [dbo].[Infor_user] ([User_ID], [Name], [Email], [SDT], [Date], [Gender], [Address], [Image]) VALUES (N'admin', N'cu nam béo', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Infor_user] ([User_ID], [Name], [Email], [SDT], [Date], [Gender], [Address], [Image]) VALUES (N'hehe', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Infor_user] ([User_ID], [Name], [Email], [SDT], [Date], [Gender], [Address], [Image]) VALUES (N'test', N'test test', NULL, NULL, NULL, N'1', N'Đà Nẵng', NULL)
GO
INSERT [dbo].[Login] ([UserName], [PassWord], [Permission]) VALUES (N'admin', N'admin', 1)
INSERT [dbo].[Login] ([UserName], [PassWord], [Permission]) VALUES (N'haha', N'haha', 0)
INSERT [dbo].[Login] ([UserName], [PassWord], [Permission]) VALUES (N'hehe', N'hehe', 0)
INSERT [dbo].[Login] ([UserName], [PassWord], [Permission]) VALUES (N'rezorito', N'rezorito', 1)
INSERT [dbo].[Login] ([UserName], [PassWord], [Permission]) VALUES (N'test', N'test', 0)
GO
INSERT [dbo].[Order] ([ID], [User_ID], [Date], [DatePay], [Price], [PthVC], [PthTT], [TT], [Address], [UserName], [Email], [SDT]) VALUES (N'3U2OCWXF  ', N'admin', CAST(N'2024-11-22' AS Date), NULL, 879, 0, 0, 2, N'Hà Nội', N'Phạm Ngọc Nghĩa', N'duclop7a1@gmail.com', N'0981159445')
INSERT [dbo].[Order] ([ID], [User_ID], [Date], [DatePay], [Price], [PthVC], [PthTT], [TT], [Address], [UserName], [Email], [SDT]) VALUES (N'7ZGSRRBO  ', N'admin', CAST(N'2024-11-22' AS Date), NULL, 308, 0, 0, 1, N'Hà Nội', N'Phạm Ngọc Nghĩa', N'duclop7a1@gmail.com', N'0981159445')
INSERT [dbo].[Order] ([ID], [User_ID], [Date], [DatePay], [Price], [PthVC], [PthTT], [TT], [Address], [UserName], [Email], [SDT]) VALUES (N'APZHZXMW  ', N'admin', CAST(N'2024-11-21' AS Date), NULL, 172, 0, 0, 0, N'Hà Nội', N'Phạm Ngọc Nghĩa', N'duclop7a1@gmail.com', N'0981159445')
INSERT [dbo].[Order] ([ID], [User_ID], [Date], [DatePay], [Price], [PthVC], [PthTT], [TT], [Address], [UserName], [Email], [SDT]) VALUES (N'G8DQRGCN  ', N'admin', CAST(N'2024-11-21' AS Date), NULL, 180, 0, 0, 0, N'Hà Nội', N'Phạm Ngọc Nghĩa', N'duclop7a1@gmail.com', N'0981159445')
INSERT [dbo].[Order] ([ID], [User_ID], [Date], [DatePay], [Price], [PthVC], [PthTT], [TT], [Address], [UserName], [Email], [SDT]) VALUES (N'KO3X69OV  ', N'admin', CAST(N'2024-11-22' AS Date), CAST(N'2024-11-22' AS Date), 293, 0, 0, 3, N'Hà Nội', N'Phạm Ngọc Nghĩa', N'duclop7a1@gmail.com', N'0981159445')
INSERT [dbo].[Order] ([ID], [User_ID], [Date], [DatePay], [Price], [PthVC], [PthTT], [TT], [Address], [UserName], [Email], [SDT]) VALUES (N'NDM6YB8I  ', N'admin', CAST(N'2024-11-21' AS Date), NULL, 274, 0, 0, 2, N'Hà Nội', N'Phạm Ngọc Nghĩa', N'duclop7a1@gmail.com', N'0981159445')
INSERT [dbo].[Order] ([ID], [User_ID], [Date], [DatePay], [Price], [PthVC], [PthTT], [TT], [Address], [UserName], [Email], [SDT]) VALUES (N'PCQV8GAN  ', N'admin', CAST(N'2024-11-22' AS Date), NULL, 70, 0, 0, 0, N'Hà Nội', N'Phạm Ngọc Nghĩa', N'duclop7a1@gmail.com', N'0981159445')
INSERT [dbo].[Order] ([ID], [User_ID], [Date], [DatePay], [Price], [PthVC], [PthTT], [TT], [Address], [UserName], [Email], [SDT]) VALUES (N'Q6VUVX90  ', N'admin', CAST(N'2024-11-22' AS Date), NULL, 274, 0, 0, 1, N'Hà Nội', N'Phạm Ngọc Nghĩa', N'duclop7a1@gmail.com', N'0981159445')
INSERT [dbo].[Order] ([ID], [User_ID], [Date], [DatePay], [Price], [PthVC], [PthTT], [TT], [Address], [UserName], [Email], [SDT]) VALUES (N'S4WXIX9T  ', N'admin', CAST(N'2024-11-26' AS Date), NULL, 172, 0, 1, 1, N'Hà Nội', N'Phạm Ngọc Nghĩa', N'duclop7a1@gmail.com', N'0981159445')
INSERT [dbo].[Order] ([ID], [User_ID], [Date], [DatePay], [Price], [PthVC], [PthTT], [TT], [Address], [UserName], [Email], [SDT]) VALUES (N'WMG1G5UY  ', N'admin', CAST(N'2024-11-27' AS Date), NULL, 207, 0, 0, 1, N'Hà Nội', N'cu nam béo', N'duclop7a1@gmail.com', N'0981159445')
GO
INSERT [dbo].[Order_detail] ([Order_ID], [Book_ID]) VALUES (N'G8DQRGCN  ', N'CK21      ')
INSERT [dbo].[Order_detail] ([Order_ID], [Book_ID]) VALUES (N'G8DQRGCN  ', N'TN03      ')
INSERT [dbo].[Order_detail] ([Order_ID], [Book_ID]) VALUES (N'NDM6YB8I  ', N'TN13      ')
INSERT [dbo].[Order_detail] ([Order_ID], [Book_ID]) VALUES (N'NDM6YB8I  ', N'TN21      ')
INSERT [dbo].[Order_detail] ([Order_ID], [Book_ID]) VALUES (N'NDM6YB8I  ', N'TN29      ')
INSERT [dbo].[Order_detail] ([Order_ID], [Book_ID]) VALUES (N'S4WXIX9T  ', N'CK28      ')
INSERT [dbo].[Order_detail] ([Order_ID], [Book_ID]) VALUES (N'S4WXIX9T  ', N'TN03      ')
INSERT [dbo].[Order_detail] ([Order_ID], [Book_ID]) VALUES (N'APZHZXMW  ', N'CK28      ')
INSERT [dbo].[Order_detail] ([Order_ID], [Book_ID]) VALUES (N'APZHZXMW  ', N'TN03      ')
INSERT [dbo].[Order_detail] ([Order_ID], [Book_ID]) VALUES (N'PCQV8GAN  ', N'TN08      ')
INSERT [dbo].[Order_detail] ([Order_ID], [Book_ID]) VALUES (N'7ZGSRRBO  ', N'TN03      ')
INSERT [dbo].[Order_detail] ([Order_ID], [Book_ID]) VALUES (N'7ZGSRRBO  ', N'TN29      ')
INSERT [dbo].[Order_detail] ([Order_ID], [Book_ID]) VALUES (N'7ZGSRRBO  ', N'TN34      ')
INSERT [dbo].[Order_detail] ([Order_ID], [Book_ID]) VALUES (N'Q6VUVX90  ', N'TN29      ')
INSERT [dbo].[Order_detail] ([Order_ID], [Book_ID]) VALUES (N'Q6VUVX90  ', N'TN21      ')
INSERT [dbo].[Order_detail] ([Order_ID], [Book_ID]) VALUES (N'Q6VUVX90  ', N'TN13      ')
INSERT [dbo].[Order_detail] ([Order_ID], [Book_ID]) VALUES (N'KO3X69OV  ', N'TN34      ')
INSERT [dbo].[Order_detail] ([Order_ID], [Book_ID]) VALUES (N'KO3X69OV  ', N'TN39      ')
INSERT [dbo].[Order_detail] ([Order_ID], [Book_ID]) VALUES (N'3U2OCWXF  ', N'TN39      ')
INSERT [dbo].[Order_detail] ([Order_ID], [Book_ID]) VALUES (N'3U2OCWXF  ', N'CK04      ')
INSERT [dbo].[Order_detail] ([Order_ID], [Book_ID]) VALUES (N'3U2OCWXF  ', N'CK21      ')
INSERT [dbo].[Order_detail] ([Order_ID], [Book_ID]) VALUES (N'3U2OCWXF  ', N'CK28      ')
INSERT [dbo].[Order_detail] ([Order_ID], [Book_ID]) VALUES (N'3U2OCWXF  ', N'TN03      ')
INSERT [dbo].[Order_detail] ([Order_ID], [Book_ID]) VALUES (N'3U2OCWXF  ', N'TN08      ')
INSERT [dbo].[Order_detail] ([Order_ID], [Book_ID]) VALUES (N'3U2OCWXF  ', N'TN34      ')
INSERT [dbo].[Order_detail] ([Order_ID], [Book_ID]) VALUES (N'3U2OCWXF  ', N'TN29      ')
INSERT [dbo].[Order_detail] ([Order_ID], [Book_ID]) VALUES (N'3U2OCWXF  ', N'TN21      ')
INSERT [dbo].[Order_detail] ([Order_ID], [Book_ID]) VALUES (N'3U2OCWXF  ', N'TN13      ')
INSERT [dbo].[Order_detail] ([Order_ID], [Book_ID]) VALUES (N'WMG1G5UY  ', N'CK28      ')
INSERT [dbo].[Order_detail] ([Order_ID], [Book_ID]) VALUES (N'WMG1G5UY  ', N'TN03      ')
INSERT [dbo].[Order_detail] ([Order_ID], [Book_ID]) VALUES (N'WMG1G5UY  ', N'TN08      ')
GO
ALTER TABLE [dbo].[Book]  WITH CHECK ADD  CONSTRAINT [FK_Book_Category] FOREIGN KEY([Category_ID])
REFERENCES [dbo].[Category] ([ID])
GO
ALTER TABLE [dbo].[Book] CHECK CONSTRAINT [FK_Book_Category]
GO
ALTER TABLE [dbo].[Cart]  WITH CHECK ADD  CONSTRAINT [FK_Cart_Book] FOREIGN KEY([Book_ID])
REFERENCES [dbo].[Book] ([ID])
GO
ALTER TABLE [dbo].[Cart] CHECK CONSTRAINT [FK_Cart_Book]
GO
ALTER TABLE [dbo].[Cart]  WITH CHECK ADD  CONSTRAINT [FK_Cart_Login] FOREIGN KEY([UserName])
REFERENCES [dbo].[Login] ([UserName])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Cart] CHECK CONSTRAINT [FK_Cart_Login]
GO
ALTER TABLE [dbo].[Infor_user]  WITH CHECK ADD  CONSTRAINT [FK_Infor_user_Login] FOREIGN KEY([User_ID])
REFERENCES [dbo].[Login] ([UserName])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Infor_user] CHECK CONSTRAINT [FK_Infor_user_Login]
GO
ALTER TABLE [dbo].[Order]  WITH CHECK ADD  CONSTRAINT [FK_Order_Login] FOREIGN KEY([User_ID])
REFERENCES [dbo].[Login] ([UserName])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Order] CHECK CONSTRAINT [FK_Order_Login]
GO
ALTER TABLE [dbo].[Order_detail]  WITH CHECK ADD  CONSTRAINT [FK_Order_detail_Book] FOREIGN KEY([Book_ID])
REFERENCES [dbo].[Book] ([ID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Order_detail] CHECK CONSTRAINT [FK_Order_detail_Book]
GO
ALTER TABLE [dbo].[Order_detail]  WITH CHECK ADD  CONSTRAINT [FK_Order_detail_Order] FOREIGN KEY([Order_ID])
REFERENCES [dbo].[Order] ([ID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Order_detail] CHECK CONSTRAINT [FK_Order_detail_Order]
GO
USE [master]
GO
ALTER DATABASE [QLBOOKSTORE] SET  READ_WRITE 
GO
