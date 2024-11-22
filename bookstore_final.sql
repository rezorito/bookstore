USE [master]
GO
/****** Object:  Database [QLBOOKSTORE]    Script Date: 11/22/2024 3:06:43 PM ******/
CREATE DATABASE [QLBOOKSTORE]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'QLBOOKSTORE', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.RITO\MSSQL\DATA\QLBOOKSTORE.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'QLBOOKSTORE_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.RITO\MSSQL\DATA\QLBOOKSTORE_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [QLBOOKSTORE] SET COMPATIBILITY_LEVEL = 160
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
ALTER DATABASE [QLBOOKSTORE] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [QLBOOKSTORE] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'QLBOOKSTORE', N'ON'
GO
ALTER DATABASE [QLBOOKSTORE] SET QUERY_STORE = ON
GO
ALTER DATABASE [QLBOOKSTORE] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [QLBOOKSTORE]
GO
/****** Object:  Table [dbo].[Book]    Script Date: 11/22/2024 3:06:43 PM ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Cart]    Script Date: 11/22/2024 3:06:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cart](
	[UserName] [varchar](50) NULL,
	[Book_ID] [char](10) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Category]    Script Date: 11/22/2024 3:06:44 PM ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Infor_user]    Script Date: 11/22/2024 3:06:44 PM ******/
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
/****** Object:  Table [dbo].[Login]    Script Date: 11/22/2024 3:06:44 PM ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Order]    Script Date: 11/22/2024 3:06:44 PM ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Order_detail]    Script Date: 11/22/2024 3:06:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Order_detail](
	[Order_ID] [char](10) NULL,
	[Book_ID] [char](10) NULL
) ON [PRIMARY]
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
