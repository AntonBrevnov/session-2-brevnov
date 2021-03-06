USE [master]
GO
/****** Object:  Database [user2]    Script Date: 14.12.2021 15:40:21 ******/
CREATE DATABASE [user2]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'user2', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\user2.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'user2_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\user2_log.ldf' , SIZE = 1536KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [user2] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [user2].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [user2] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [user2] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [user2] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [user2] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [user2] SET ARITHABORT OFF 
GO
ALTER DATABASE [user2] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [user2] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [user2] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [user2] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [user2] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [user2] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [user2] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [user2] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [user2] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [user2] SET  ENABLE_BROKER 
GO
ALTER DATABASE [user2] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [user2] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [user2] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [user2] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [user2] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [user2] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [user2] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [user2] SET RECOVERY FULL 
GO
ALTER DATABASE [user2] SET  MULTI_USER 
GO
ALTER DATABASE [user2] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [user2] SET DB_CHAINING OFF 
GO
ALTER DATABASE [user2] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [user2] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [user2] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [user2] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'user2', N'ON'
GO
ALTER DATABASE [user2] SET QUERY_STORE = OFF
GO
USE [user2]
GO
/****** Object:  Table [dbo].[Agents]    Script Date: 14.12.2021 15:40:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Agents](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[TypeID] [bigint] NOT NULL,
	[TypeName] [nvarchar](255) NULL,
	[Name] [nvarchar](255) NULL,
	[Email] [nvarchar](255) NULL,
	[Phone] [nvarchar](255) NULL,
	[Logotype] [nvarchar](255) NULL,
	[Address] [nvarchar](255) NULL,
	[Priority] [int] NULL,
	[Director] [nvarchar](255) NULL,
	[INN] [float] NULL,
	[KPP] [float] NULL,
 CONSTRAINT [PK_Agents] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProductSale]    Script Date: 14.12.2021 15:40:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductSale](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[ProductID] [bigint] NOT NULL,
	[ProductName] [nvarchar](255) NULL,
	[AgentID] [bigint] NOT NULL,
	[AgentName] [nvarchar](255) NULL,
	[DateOfRelease] [datetime] NULL,
	[CountOfProduct] [int] NOT NULL,
 CONSTRAINT [PK_ProductSale] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[VW_AgentDetails]    Script Date: 14.12.2021 15:40:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_AgentDetails]
AS
SELECT        TOP (100) PERCENT ID, TypeName, Name, Phone, Priority,
                             (SELECT        dbo.ProductSale.CountOfProduct
                               FROM            dbo.ProductSale INNER JOIN
                                                         dbo.Agents ON dbo.Agents.ID = dbo.ProductSale.AgentID
                               WHERE        (YEAR(dbo.ProductSale.DateOfRelease) = YEAR(GETDATE()))) AS CountOfSales
FROM            dbo.Agents AS Agents_1
ORDER BY Priority DESC
GO
/****** Object:  Table [dbo].[ChangePriorityHistory]    Script Date: 14.12.2021 15:40:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ChangePriorityHistory](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[Date] [date] NULL,
	[AgentID] [bigint] NULL,
	[Priority] [int] NULL,
 CONSTRAINT [PK_ChangePriorityHistory] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProductsShort]    Script Date: 14.12.2021 15:40:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductsShort](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](255) NULL,
	[TypeID] [bigint] NOT NULL,
	[TypeName] [nvarchar](255) NULL,
	[Article] [float] NULL,
	[CountOfPeople] [float] NULL,
	[FactoryNumber] [float] NULL,
	[MinPrice] [money] NULL,
 CONSTRAINT [PK_ProductsShort] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TypeOfAgents]    Script Date: 14.12.2021 15:40:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TypeOfAgents](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
 CONSTRAINT [PK_TypeOfAgents] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TypeOfProducts]    Script Date: 14.12.2021 15:40:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TypeOfProducts](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
 CONSTRAINT [PK_TypeOfProducts] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Agents] ON 

INSERT [dbo].[Agents] ([ID], [TypeID], [TypeName], [Name], [Email], [Phone], [Logotype], [Address], [Priority], [Director], [INN], [KPP]) VALUES (2, 2, N'МКК', N'МетизСтрой', N'kristina.pakomov@burova.ru', N'8-800-172-62-56', N'\agents\agent_94.png', N'254238, Нижегородская область, город Павловский Посад, проезд Балканская, 23', 374, N'Ева Борисовна Беспалова', 4024742936, 295608432)
INSERT [dbo].[Agents] ([ID], [TypeID], [TypeName], [Name], [Email], [Phone], [Logotype], [Address], [Priority], [Director], [INN], [KPP]) VALUES (3, 4, N'ОАО', N'РадиоСевер', N'maiy.belov@rogov.ru', N'(495) 368-86-51', N'\agents\agent_123.png', N'491360, Московская область, город Одинцово, въезд Ленина, 19', NULL, N'Карпов Иосиф Максимович', 5889206249, 372789083)
INSERT [dbo].[Agents] ([ID], [TypeID], [TypeName], [Name], [Email], [Phone], [Logotype], [Address], [Priority], [Director], [INN], [KPP]) VALUES (4, 5, N'ООО', N'Компания КазАлмаз', N'irina.gusina@vlasova.ru', N'8-800-533-24-75', N'\agents\agent_80.png', N'848810, Кемеровская область, город Лотошино, пер. Ломоносова, 90', 396, N'Марк Фёдорович Муравьёва', 3084797352, 123190924)
INSERT [dbo].[Agents] ([ID], [TypeID], [TypeName], [Name], [Email], [Phone], [Logotype], [Address], [Priority], [Director], [INN], [KPP]) VALUES (5, 5, N'ООО', N'Компания СервисРадиоГор', N'nika.nekrasova@kovalev.ru', N'8-800-676-32-86', N'\agents\agent_40.png', N'547196, Ульяновская область, город Серебряные Пруды, въезд Балканская, 81', NULL, N'Попов Вадим Александрович', 8880473721, 729975116)
INSERT [dbo].[Agents] ([ID], [TypeID], [TypeName], [Name], [Email], [Phone], [Logotype], [Address], [Priority], [Director], [INN], [KPP]) VALUES (6, 1, N'ЗАО', N'ВодТверьХозМашина', N'tkrylov@baranova.net', N'+7 (922) 849-91-96', N'\agents\agent_56.png', N'145030, Сахалинская область, город Шатура, въезд Гоголя, 79', 8, N'Александра Дмитриевна Ждановаа', 4174253174, 522227145)
INSERT [dbo].[Agents] ([ID], [TypeID], [TypeName], [Name], [Email], [Phone], [Logotype], [Address], [Priority], [Director], [INN], [KPP]) VALUES (7, 4, N'ОАО', N'Тех', N'vasilisa99@belyev.ru', N'+7 (922) 427-13-31', N'\agents\agent_61.png', N'731935, Калининградская область, город Павловский Посад, наб. Гагарина, 59', NULL, N'Аким Романович Логинова', 9282924869, 587356429)
INSERT [dbo].[Agents] ([ID], [TypeID], [TypeName], [Name], [Email], [Phone], [Logotype], [Address], [Priority], [Director], [INN], [KPP]) VALUES (8, 5, N'ООО', N'ТверьМетизУралСнос', N'rlazareva@novikov.ru', N'(35222) 57-92-75', N'\agents\agent_109.png', N'880551, Ленинградская область, город Красногорск, ул. Гоголя, 61', NULL, N'Зоя Андреевна Соболева', 1076095397, 947828491)
INSERT [dbo].[Agents] ([ID], [TypeID], [TypeName], [Name], [Email], [Phone], [Logotype], [Address], [Priority], [Director], [INN], [KPP]) VALUES (9, 1, N'ЗАО', N'МясРеч', N'bkozlov@volkov.ru', N'8-800-453-63-45', N'\agents\agent_58.png', N'903648, Калужская область, город Воскресенск, пр. Будапештсткая, 91', NULL, N'Белоусоваа Ирина Максимовна', 9254261217, 656363498)
INSERT [dbo].[Agents] ([ID], [TypeID], [TypeName], [Name], [Email], [Phone], [Logotype], [Address], [Priority], [Director], [INN], [KPP]) VALUES (10, 1, N'ЗАО', N'Флот', N'gerasim.makarov@kornilov.ru', N'8-800-144-25-38', N'\agents\agent_87.png', N'505562, Тюменская область, город Наро-Фоминск, пр. Косиора, 11', 473, N'Василий Андреевич Ковалёв', 1112170258, 382584255)
INSERT [dbo].[Agents] ([ID], [TypeID], [TypeName], [Name], [Email], [Phone], [Logotype], [Address], [Priority], [Director], [INN], [KPP]) VALUES (11, 1, N'ЗАО', N'CибПивОмскСнаб', N'evorontova@potapova.ru', N'+7 (922) 153-95-22', N'\agents\agent_46.png', N'816260, Ивановская область, город Москва, ул. Гагарина, 31', 477, N'Людмила Александровна Сафонова', 5676173945, 256512286)
INSERT [dbo].[Agents] ([ID], [TypeID], [TypeName], [Name], [Email], [Phone], [Logotype], [Address], [Priority], [Director], [INN], [KPP]) VALUES (12, 1, N'ЗАО', N'ЦементАсбоцемент', N'polykov.veronika@artemeva.ru', N'(495) 184-87-92', NULL, N'619540, Курская область, город Раменское, пл. Балканская, 12', NULL, N'Воронова Мария Александровна', 4345774724, 352469905)
INSERT [dbo].[Agents] ([ID], [TypeID], [TypeName], [Name], [Email], [Phone], [Logotype], [Address], [Priority], [Director], [INN], [KPP]) VALUES (13, 1, N'ЗАО', N'ТелеГлавВекторСбыт', N'nsitnikov@kovaleva.ru', N'(35222) 56-15-37', N'\agents\agent_31.png', N'062489, Челябинская область, город Пушкино, въезд Бухарестская, 07', NULL, N'Екатерина Фёдоровна Ковалёва', 9504787157, 419758597)
INSERT [dbo].[Agents] ([ID], [TypeID], [TypeName], [Name], [Email], [Phone], [Logotype], [Address], [Priority], [Director], [INN], [KPP]) VALUES (14, 4, N'ОАО', N'Инфо', N'arsenii.mikailova@prokorov.com', N'8-800-793-59-97', N'\agents\agent_89.png', N'100469, Рязанская область, город Ногинск, шоссе Гагарина, 57', 304, N'Баранова Виктор Романович', 6549468639, 718386757)
INSERT [dbo].[Agents] ([ID], [TypeID], [TypeName], [Name], [Email], [Phone], [Logotype], [Address], [Priority], [Director], [INN], [KPP]) VALUES (15, 1, N'ЗАО', N'ЭлектроРемОрионЛизинг', N'anfisa.fedotova@tvetkov.ru', N'(495) 519-97-41', N'\agents\agent_68.png', N'594365, Ярославская область, город Павловский Посад, бульвар Космонавтов, 64', NULL, N'Тарасова Дан Львович', 1340072597, 500478249)
INSERT [dbo].[Agents] ([ID], [TypeID], [TypeName], [Name], [Email], [Phone], [Logotype], [Address], [Priority], [Director], [INN], [KPP]) VALUES (16, 5, N'ООО', N'Компания ТелекомХмельГаражПром', N'qkolesnikova@kalinina.ru', N'(812) 983-91-73', N'\agents\agent_71.png', N'126668, Ростовская область, город Зарайск, наб. Гагарина, 69', 457, N'Костина Татьяна Борисовна', 1614623826, 824882264)
INSERT [dbo].[Agents] ([ID], [TypeID], [TypeName], [Name], [Email], [Phone], [Logotype], [Address], [Priority], [Director], [INN], [KPP]) VALUES (17, 5, N'ООО', N'Компания Алмаз', N'akalinina@zaitev.ru', N'+7 (922) 688-74-22', N'\agents\agent_121.png', N'016215, Воронежская область, город Зарайск, ул. Косиора, 48', 259, N'Фоминаа Лариса Романовна', 6698862694, 662876919)
INSERT [dbo].[Agents] ([ID], [TypeID], [TypeName], [Name], [Email], [Phone], [Logotype], [Address], [Priority], [Director], [INN], [KPP]) VALUES (18, 4, N'ОАО', N'МясТрансМоторЛизинг', N'vlad.sokolov@andreev.org', N'+7 (922) 676-34-94', N'\agents\agent_62.png', N'765320, Ивановская область, город Шатура, спуск Гоголя, 88', NULL, N'Тамара Дмитриевна Семёноваа', 6148685143, 196332656)
INSERT [dbo].[Agents] ([ID], [TypeID], [TypeName], [Name], [Email], [Phone], [Logotype], [Address], [Priority], [Director], [INN], [KPP]) VALUES (19, 3, N'МФО', N'Монтаж', N'zakar.sazonova@gavrilov.ru', N'(495) 867-76-15', NULL, N'066594, Магаданская область, город Шаховская, спуск Сталина, 59', 300, N'Блохина Сергей Максимович', 6142194281, 154457435)
INSERT [dbo].[Agents] ([ID], [TypeID], [TypeName], [Name], [Email], [Phone], [Logotype], [Address], [Priority], [Director], [INN], [KPP]) VALUES (20, 5, N'ООО', N'ВостокГлав', N'gordei95@kirillov.ru', N'(812) 949-29-26', N'\agents\agent_63.png', N'217022, Ростовская область, город Озёры, ул. Домодедовская, 19', 107, N'Инга Фёдоровна Дмитриева', 3580946305, 405017349)
INSERT [dbo].[Agents] ([ID], [TypeID], [TypeName], [Name], [Email], [Phone], [Logotype], [Address], [Priority], [Director], [INN], [KPP]) VALUES (21, 3, N'МФО', N'Газ', N'ulyna.antonov@noskov.ru', N'(35222) 22-45-58', N'\agents\agent_76.png', N'252821, Тамбовская область, город Пушкино, ул. Чехова, 40', NULL, N'Терентьев Илларион Максимович', 8876413796, 955381891)
INSERT [dbo].[Agents] ([ID], [TypeID], [TypeName], [Name], [Email], [Phone], [Logotype], [Address], [Priority], [Director], [INN], [KPP]) VALUES (22, 4, N'ОАО', N'ЭлектроТранс', N'boleslav.zukova@nikiforova.com', N'(812) 342-24-31', N'\agents\agent_91.png', N'434616, Калининградская область, город Павловский Посад, пл. Ладыгина, 83', 129, N'Сава Александрович Титова', 6019144874, 450629885)
INSERT [dbo].[Agents] ([ID], [TypeID], [TypeName], [Name], [Email], [Phone], [Logotype], [Address], [Priority], [Director], [INN], [KPP]) VALUES (23, 4, N'ОАО', N'Электро', N'likacev.makar@antonov.ru', N'8-800-714-36-41', N'\agents\agent_93.png', N'966815, Новгородская область, город Одинцово, пр. Космонавтов, 19', 366, N'Шарапова Елена Дмитриевна', 7896029866, 786038848)
INSERT [dbo].[Agents] ([ID], [TypeID], [TypeName], [Name], [Email], [Phone], [Logotype], [Address], [Priority], [Director], [INN], [KPP]) VALUES (24, 2, N'МКК', N'Гор', N'maiy12@koklov.net', N'(495) 973-48-55', N'\agents\agent_52.png', N'376483, Калужская область, город Сергиев Посад, ул. Славы, 09', NULL, N'Нонна Львовна Одинцоваа', 7088187045, 440309946)
INSERT [dbo].[Agents] ([ID], [TypeID], [TypeName], [Name], [Email], [Phone], [Logotype], [Address], [Priority], [Director], [INN], [KPP]) VALUES (25, 5, N'ООО', N'Компания Гараж', N'asiryeva@andreeva.com', N'+7 (922) 848-38-54', N'\agents\agent_66.png', N'395101, Белгородская область, город Балашиха, бульвар 1905 года, 00', NULL, N'Владлена Фёдоровна Ларионоваа', 6190244524, 399106161)
INSERT [dbo].[Agents] ([ID], [TypeID], [TypeName], [Name], [Email], [Phone], [Logotype], [Address], [Priority], [Director], [INN], [KPP]) VALUES (26, 6, N'ПАО', N'ОрионГлав', N'sermakova@sarova.net', N'+7 (922) 684-13-74', N'\agents\agent_106.png', N'729639, Магаданская область, город Талдом, въезд Будапештсткая, 98', 482, N'Тимофеева Григорий Андреевич', 9032455179, 763045792)
INSERT [dbo].[Agents] ([ID], [TypeID], [TypeName], [Name], [Email], [Phone], [Logotype], [Address], [Priority], [Director], [INN], [KPP]) VALUES (27, 3, N'МФО', N'ГлавITФлотПроф', N'savva.rybov@kolobov.ru', N'(812) 146-66-46', N'\agents\agent_64.png', N'447811, Мурманская область, город Егорьевск, ул. Ленина, 24', NULL, N'Зыкова Стефан Максимович', 2561361494, 525678825)
INSERT [dbo].[Agents] ([ID], [TypeID], [TypeName], [Name], [Email], [Phone], [Logotype], [Address], [Priority], [Director], [INN], [KPP]) VALUES (28, 6, N'ПАО', N'ТверьМонтажОмск', N'dteterina@selezneva.ru', N'8-800-363-43-86', N'\agents\agent_128.png', N'761751, Амурская область, город Балашиха, шоссе Гоголя, 02', 272, N'Матвей Романович Большакова', 2421347164, 157370604)
INSERT [dbo].[Agents] ([ID], [TypeID], [TypeName], [Name], [Email], [Phone], [Logotype], [Address], [Priority], [Director], [INN], [KPP]) VALUES (29, 4, N'ОАО', N'РемСантехОмскБанк', N'anisimov.mark@vorobev.ru', N'(812) 182-44-77', N'\agents\agent_57.png', N'289468, Омская область, город Видное, пер. Балканская, 33', 442, N'Фокина Искра Максимовна', 6823050572, 176488617)
INSERT [dbo].[Agents] ([ID], [TypeID], [TypeName], [Name], [Email], [Phone], [Logotype], [Address], [Priority], [Director], [INN], [KPP]) VALUES (30, 4, N'ОАО', N'ЭлектроМоторТрансСнос', N'inessa.voronov@sidorova.ru', N'(35222) 43-62-19', NULL, N'913777, Самарская область, город Красногорск, ул. Бухарестская, 49', 151, N'Людмила Евгеньевна Новиковаа', 6608362851, 799760512)
INSERT [dbo].[Agents] ([ID], [TypeID], [TypeName], [Name], [Email], [Phone], [Logotype], [Address], [Priority], [Director], [INN], [KPP]) VALUES (31, 2, N'МКК', N'ТверьХозМорСбыт', N'marina58@koroleva.com', N'(495) 416-75-67', N'\agents\agent_117.png', N'252101, Ростовская область, город Дорохово, пер. Ленина, 85', NULL, N'Аким Львович Субботина', 6681338084, 460530907)
INSERT [dbo].[Agents] ([ID], [TypeID], [TypeName], [Name], [Email], [Phone], [Logotype], [Address], [Priority], [Director], [INN], [KPP]) VALUES (32, 5, N'ООО', N'Компания ТомскХоз', N'nelli11@gureva.ru', N'+7 (922) 849-13-37', N'\agents\agent_115.png', N'861543, Томская область, город Истра, бульвар Славы, 42', NULL, N'Лазарева Аркадий Сергеевич', 8430391035, 961540858)
INSERT [dbo].[Agents] ([ID], [TypeID], [TypeName], [Name], [Email], [Phone], [Logotype], [Address], [Priority], [Director], [INN], [KPP]) VALUES (33, 5, N'ООО', N'Компания МясДизайнДизайн', N'gleb.gulyev@belyeva.com', N'(812) 535-17-25', N'\agents\agent_53.png', N'557264, Брянская область, город Серпухов, въезд Гоголя, 34', NULL, N'Клементина Сергеевна Стрелкова', 8004989990, 908629456)
INSERT [dbo].[Agents] ([ID], [TypeID], [TypeName], [Name], [Email], [Phone], [Logotype], [Address], [Priority], [Director], [INN], [KPP]) VALUES (34, 5, N'ООО', N'Компания ЖелДорТверьМонтаж', N'burova.zlata@zueva.ru', N'(495) 521-61-75', N'\agents\agent_85.png', N'152424, Рязанская область, город Сергиев Посад, ул. 1905 года, 27', NULL, N'Нестор Максимович Гуляев', 3325722996, 665766347)
INSERT [dbo].[Agents] ([ID], [TypeID], [TypeName], [Name], [Email], [Phone], [Logotype], [Address], [Priority], [Director], [INN], [KPP]) VALUES (35, 5, N'ООО', N'МетизТехАвтоПроф', N'anastasiy.gromov@samsonova.com', N'(495) 581-42-46', N'\agents\agent_33.png', N'713016, Брянская область, город Подольск, пл. Домодедовская, 93', 321, N'Егор Фёдорович Третьякова', 2988890076, 215491048)
INSERT [dbo].[Agents] ([ID], [TypeID], [TypeName], [Name], [Email], [Phone], [Logotype], [Address], [Priority], [Director], [INN], [KPP]) VALUES (36, 3, N'МФО', N'Гараж', N'antonin51@korolev.com', N'(35222) 54-72-59', N'\agents\agent_90.png', N'585758, Самарская область, город Красногорск, бульвар Балканская, 13', 107, N'Панфилов Константин Максимович', 2638464552, 746822723)
INSERT [dbo].[Agents] ([ID], [TypeID], [TypeName], [Name], [Email], [Phone], [Logotype], [Address], [Priority], [Director], [INN], [KPP]) VALUES (37, 2, N'МКК', N'ГазДизайнЖелДор', N'elizaveta.komarov@rybakov.net', N'(495) 797-97-33', N'\agents\agent_49.png', N'695230, Курская область, город Красногорск, пр. Гоголя, 64', 236, N'Лев Иванович Третьяков', 2396029740, 458924890)
INSERT [dbo].[Agents] ([ID], [TypeID], [TypeName], [Name], [Email], [Phone], [Logotype], [Address], [Priority], [Director], [INN], [KPP]) VALUES (38, 4, N'ОАО', N'РемГаражЛифт', N'novikova.gleb@sestakov.ru', N'8-800-772-27-53', N'\agents\agent_65.png', N'048715, Ивановская область, город Люберцы, проезд Космонавтов, 89', 374, N'Филатов Владимир Максимович', 1656477206, 988968838)
INSERT [dbo].[Agents] ([ID], [TypeID], [TypeName], [Name], [Email], [Phone], [Logotype], [Address], [Priority], [Director], [INN], [KPP]) VALUES (39, 3, N'МФО', N'СантехБашкир', N'nikodim81@kiseleva.com', N'+7 (922) 155-87-39', N'\agents\agent_99.png', N'180288, Тверская область, город Одинцово, ул. Бухарестская, 37', 369, N'Виктор Иванович Молчанов', 4159215346, 639267493)
INSERT [dbo].[Agents] ([ID], [TypeID], [TypeName], [Name], [Email], [Phone], [Logotype], [Address], [Priority], [Director], [INN], [KPP]) VALUES (40, 2, N'МКК', N'ЮпитерЛенГараж-М', N'larkipova@gorbunov.ru', N'(495) 327-58-25', N'\agents\agent_48.png', N'339507, Московская область, город Видное, ул. Космонавтов, 11', NULL, N'Васильева Валерия Борисовна', 2038393690, 259672761)
INSERT [dbo].[Agents] ([ID], [TypeID], [TypeName], [Name], [Email], [Phone], [Logotype], [Address], [Priority], [Director], [INN], [KPP]) VALUES (41, 1, N'ЗАО', N'ОрионСофтВодСнос', N'isukanov@sobolev.com', N'(35222) 59-75-11', N'\agents\agent_97.png', N'577227, Калужская область, город Павловский Посад, наб. Чехова, 35', 361, N'Мухина Ян Фёдорович', 1522348613, 977738715)
INSERT [dbo].[Agents] ([ID], [TypeID], [TypeName], [Name], [Email], [Phone], [Logotype], [Address], [Priority], [Director], [INN], [KPP]) VALUES (42, 4, N'ОАО', N'КазХоз', N'istrelkova@fomin.ru', N'+7 (922) 728-85-62', NULL, N'384162, Астраханская область, город Одинцово, бульвар Гагарина, 57', 213, N'Степанова Роман Иванович', 6503377671, 232279972)
INSERT [dbo].[Agents] ([ID], [TypeID], [TypeName], [Name], [Email], [Phone], [Logotype], [Address], [Priority], [Director], [INN], [KPP]) VALUES (43, 6, N'ПАО', N'БухВжух', N'valentina.bolsakova@aksenova.ru', N'(495) 367-21-41', NULL, N'481744, Амурская область, город Щёлково, пл. Сталина, 48', 327, N'Тарасов Болеслав Александрович', 2320989197, 359282667)
INSERT [dbo].[Agents] ([ID], [TypeID], [TypeName], [Name], [Email], [Phone], [Logotype], [Address], [Priority], [Director], [INN], [KPP]) VALUES (44, 4, N'ОАО', N'ХозЮпитер', N'jisakova@nazarova.com', N'+7 (922) 332-48-96', N'\agents\agent_114.png', N'038182, Курганская область, город Москва, спуск Космонавтов, 16', NULL, N'Максимоваа Вера Фёдоровна', 6667635058, 380592865)
INSERT [dbo].[Agents] ([ID], [TypeID], [TypeName], [Name], [Email], [Phone], [Logotype], [Address], [Priority], [Director], [INN], [KPP]) VALUES (45, 3, N'МФО', N'ВостокКазРыб', N'flukin@misin.org', N'(495) 987-31-63', N'\agents\agent_112.png', N'059565, Оренбургская область, город Истра, шоссе Домодедовская, 27', 361, N'Самсонов Родион Романович', 7411284960, 176779733)
INSERT [dbo].[Agents] ([ID], [TypeID], [TypeName], [Name], [Email], [Phone], [Logotype], [Address], [Priority], [Director], [INN], [KPP]) VALUES (46, 1, N'ЗАО', N'ЦементКрепТех-М', N'yna.evdokimov@gordeeva.ru', N'(812) 838-79-58', N'\agents\agent_82.png', N'263764, Свердловская область, город Раменское, пер. Косиора, 28', 189, N'Сергеев Владлен Александрович', 5359981084, 680416300)
INSERT [dbo].[Agents] ([ID], [TypeID], [TypeName], [Name], [Email], [Phone], [Logotype], [Address], [Priority], [Director], [INN], [KPP]) VALUES (47, 3, N'МФО', N'Строй', N'soloveva.adam@andreev.ru', N'(812) 447-45-59', NULL, N'763019, Омская область, город Шатура, пл. Сталина, 56', NULL, N'Кудрявцев Адриан Андреевич', 6678884759, 279288618)
INSERT [dbo].[Agents] ([ID], [TypeID], [TypeName], [Name], [Email], [Phone], [Logotype], [Address], [Priority], [Director], [INN], [KPP]) VALUES (48, 1, N'ЗАО', N'БашкирЮпитерТомск', N'dyckov.veniamin@kotova.ru', N'(812) 189-59-57', N'\agents\agent_59.png', N'035268, Сахалинская область, город Волоколамск, проезд Ладыгина, 51', 139, N'Фадеева Раиса Александровна', 1606315697, 217799345)
INSERT [dbo].[Agents] ([ID], [TypeID], [TypeName], [Name], [Email], [Phone], [Logotype], [Address], [Priority], [Director], [INN], [KPP]) VALUES (49, 5, N'ООО', N'Компания КазМеталКазань', N'mmoiseev@teterin.ru', N'(495) 685-34-29', N'\agents\agent_130.png', N'532703, Пензенская область, город Чехов, наб. Чехова, 81', 252, N'Валерий Владимирович Хохлова', 4598939812, 303467543)
INSERT [dbo].[Agents] ([ID], [TypeID], [TypeName], [Name], [Email], [Phone], [Logotype], [Address], [Priority], [Director], [INN], [KPP]) VALUES (50, 5, N'ООО', N'Компания Газ', N'alina56@zdanov.com', N'(35222) 75-96-85', N'\agents\agent_120.png', N'310403, Кировская область, город Солнечногорск, пл. Балканская, 76', 445, N'Давид Андреевич Фадеев', 2262431140, 247369527)
INSERT [dbo].[Agents] ([ID], [TypeID], [TypeName], [Name], [Email], [Phone], [Logotype], [Address], [Priority], [Director], [INN], [KPP]) VALUES (51, 5, N'ООО', N'Компания Монтаж', N'afanasev.anastasiy@muravev.ru', N'(35222) 92-45-98', N'\agents\agent_75.png', N'036381, Брянская область, город Кашира, бульвар Гагарина, 76', NULL, N'Силин Даниил Иванович', 6206428565, 118570048)
INSERT [dbo].[Agents] ([ID], [TypeID], [TypeName], [Name], [Email], [Phone], [Logotype], [Address], [Priority], [Director], [INN], [KPP]) VALUES (52, 1, N'ЗАО', N'СервисХмельМонтаж', N'galina31@melnikov.ru', N'+7 (922) 344-73-38', N'\agents\agent_92.png', N'928260, Нижегородская область, город Балашиха, пл. Косиора, 44', 124, N'Анжелика Дмитриевна Горбунова', 3459886235, 356196105)
INSERT [dbo].[Agents] ([ID], [TypeID], [TypeName], [Name], [Email], [Phone], [Logotype], [Address], [Priority], [Director], [INN], [KPP]) VALUES (53, 4, N'ОАО', N'ВодГараж', N'pmaslov@fomiceva.com', N'+7 (922) 363-86-67', N'\agents\agent_67.png', N'988899, Саратовская область, город Раменское, пр. Славы, 40', 250, N'Лаврентий Фёдорович Логинова', 5575072431, 684290320)
INSERT [dbo].[Agents] ([ID], [TypeID], [TypeName], [Name], [Email], [Phone], [Logotype], [Address], [Priority], [Director], [INN], [KPP]) VALUES (54, 2, N'МКК', N'CибГаз', N'inna.sarova@panfilov.ru', N'(495) 945-37-25', N'\agents\agent_103.png', N'365674, Архангельская область, город Серебряные Пруды, пр. Ленина, 29', NULL, N'Вячеслав Романович Третьякова', 6483417250, 455013058)
INSERT [dbo].[Agents] ([ID], [TypeID], [TypeName], [Name], [Email], [Phone], [Logotype], [Address], [Priority], [Director], [INN], [KPP]) VALUES (55, 2, N'МКК', N'БашкирФлотМотор-H', N'morozova.nika@kazakova.ru', N'(495) 793-84-82', N'\agents\agent_36.png', N'008081, Тюменская область, город Ногинск, въезд Гагарина, 94', NULL, N'Марат Алексеевич Фролов', 1657476072, 934931159)
INSERT [dbo].[Agents] ([ID], [TypeID], [TypeName], [Name], [Email], [Phone], [Logotype], [Address], [Priority], [Director], [INN], [KPP]) VALUES (56, 6, N'ПАО', N'МеталСервисМор', N'xdanilov@titov.ru', N'(35222) 91-28-62', NULL, N'293265, Иркутская область, город Клин, пр. Славы, 12', NULL, N'Коновалова Кирилл Львович', 6922817841, 580142825)
INSERT [dbo].[Agents] ([ID], [TypeID], [TypeName], [Name], [Email], [Phone], [Logotype], [Address], [Priority], [Director], [INN], [KPP]) VALUES (57, 1, N'ЗАО', N'Рем', N'zanna25@nikiforova.com', N'(495) 987-88-53', N'\agents\agent_79.png', N'707812, Иркутская область, город Шаховская, ул. Гагарина, 17', 329, N'Шароваа Елизавета Львовна', 3203830728, 456254820)
INSERT [dbo].[Agents] ([ID], [TypeID], [TypeName], [Name], [Email], [Phone], [Logotype], [Address], [Priority], [Director], [INN], [KPP]) VALUES (58, 5, N'ООО', N'СантехСеверЛенМашина', N'pgorbacev@vasilev.net', N'(812) 918-88-43', N'\agents\agent_74.png', N'606990, Новосибирская область, город Павловский Посад, въезд Домодедовская, 38', NULL, N'Павел Максимович Рожков', 3506691089, 830713603)
INSERT [dbo].[Agents] ([ID], [TypeID], [TypeName], [Name], [Email], [Phone], [Logotype], [Address], [Priority], [Director], [INN], [KPP]) VALUES (59, 5, N'ООО', N'Цемент', N'panova.klementina@bobrov.ru', N'8-800-517-78-47', N'\agents\agent_54.png', N'084315, Амурская область, город Шаховская, наб. Чехова, 62', NULL, N'Анфиса Фёдоровна Буроваа', 9662118663, 650216214)
INSERT [dbo].[Agents] ([ID], [TypeID], [TypeName], [Name], [Email], [Phone], [Logotype], [Address], [Priority], [Director], [INN], [KPP]) VALUES (60, 1, N'ЗАО', N'Вод', N'savva86@zaiteva.ru', N'(495) 142-19-84', N'\agents\agent_129.png', N'964386, Оренбургская область, город Чехов, пл. Косиора, 80', NULL, N'Зоя Романовна Селезнёва', 1296063939, 447430051)
INSERT [dbo].[Agents] ([ID], [TypeID], [TypeName], [Name], [Email], [Phone], [Logotype], [Address], [Priority], [Director], [INN], [KPP]) VALUES (61, 6, N'ПАО', N'Орион', N'aleksei63@kiselev.ru', N'8-800-621-61-93', N'\agents\agent_77.png', N'951035, Ивановская область, город Ступино, шоссе Космонавтов, 73', NULL, N'Мартынов Михаил Борисович', 2670166502, 716874456)
INSERT [dbo].[Agents] ([ID], [TypeID], [TypeName], [Name], [Email], [Phone], [Logotype], [Address], [Priority], [Director], [INN], [KPP]) VALUES (62, 4, N'ОАО', N'СтройГорНефть', N'lysy.kolesnikova@molcanova.com', N'(812) 385-21-37', N'\agents\agent_37.png', N'444539, Ульяновская область, город Лотошино, спуск Будапештсткая, 95', 161, N'Тарасова Макар Максимович', 5916775587, 398299418)
INSERT [dbo].[Agents] ([ID], [TypeID], [TypeName], [Name], [Email], [Phone], [Logotype], [Address], [Priority], [Director], [INN], [KPP]) VALUES (63, 5, N'ООО', N'Компания Хмель', N'ermakov.mark@isakova.ru', N'(812) 421-77-82', NULL, N'889757, Новосибирская область, город Раменское, бульвар 1905 года, 93', NULL, N'Владимир Борисович Суворова', 9004087602, 297273898)
INSERT [dbo].[Agents] ([ID], [TypeID], [TypeName], [Name], [Email], [Phone], [Logotype], [Address], [Priority], [Director], [INN], [KPP]) VALUES (64, 5, N'ООО', N'Компания ВодАлмазIT', N'zakar37@nikolaeva.ru', N'(35222) 52-76-16', N'\agents\agent_111.png', N'302100, Нижегородская область, город Мытищи, пер. 1905 года, 63', NULL, N'Гуляев Егор Евгеньевич', 2345297765, 908449277)
INSERT [dbo].[Agents] ([ID], [TypeID], [TypeName], [Name], [Email], [Phone], [Logotype], [Address], [Priority], [Director], [INN], [KPP]) VALUES (65, 6, N'ПАО', N'БашкирРечТомск', N'aleksandra77@karpov.com', N'8-800-254-71-85', N'\agents\agent_100.png', N'136886, Амурская область, город Видное, въезд Космонавтов, 39', NULL, N'Назарова Вера Андреевна', 7027724917, 823811460)
INSERT [dbo].[Agents] ([ID], [TypeID], [TypeName], [Name], [Email], [Phone], [Logotype], [Address], [Priority], [Director], [INN], [KPP]) VALUES (66, 1, N'ЗАО', N'СофтРосБух', N'ivanova.antonin@rodionov.ru', N'+7 (922) 445-69-17', N'\agents\agent_124.png', N'747695, Амурская область, город Сергиев Посад, въезд Бухарестская, 46', NULL, N'Белова Полина Владимировна', 8321561226, 807803984)
INSERT [dbo].[Agents] ([ID], [TypeID], [TypeName], [Name], [Email], [Phone], [Logotype], [Address], [Priority], [Director], [INN], [KPP]) VALUES (67, 2, N'МКК', N'ТелекомЮпитер', N'kulikov.adrian@zuravlev.org', N'(812) 895-67-23', N'\agents\agent_81.png', N'959793, Курская область, город Егорьевск, бульвар Ленина, 72', NULL, N'Калинина Татьяна Ивановна', 9383182378, 944520594)
INSERT [dbo].[Agents] ([ID], [TypeID], [TypeName], [Name], [Email], [Phone], [Logotype], [Address], [Priority], [Director], [INN], [KPP]) VALUES (68, 1, N'ЗАО', N'УралСтройХмель', N'aleksandr95@kolobova.ru', N'(35222) 39-23-65', N'\agents\agent_113.png', N'462632, Костромская область, город Шаховская, шоссе Сталина, 92', 372, N'Август Борисович Красильникова', 8773558039, 402502867)
INSERT [dbo].[Agents] ([ID], [TypeID], [TypeName], [Name], [Email], [Phone], [Logotype], [Address], [Priority], [Director], [INN], [KPP]) VALUES (69, 3, N'МФО', N'АсбоцементТехАвто', N'matveev.yliy@kiseleva.ru', N'+7 (922) 977-68-84', N'\agents\agent_110.png', N'304975, Пензенская область, город Солнечногорск, шоссе Балканская, 76', 247, N'Сидорова Любовь Ивановна', 7626076463, 579234124)
INSERT [dbo].[Agents] ([ID], [TypeID], [TypeName], [Name], [Email], [Phone], [Logotype], [Address], [Priority], [Director], [INN], [KPP]) VALUES (70, 5, N'ООО', N'Компания ФинансСервис', N'robert.serbakov@safonova.ru', N'(812) 878-42-71', N'\agents\agent_38.png', N'841700, Брянская область, город Серпухов, спуск Домодедовская, 35', 395, N'Клавдия Сергеевна Виноградова', 7491491391, 673621812)
INSERT [dbo].[Agents] ([ID], [TypeID], [TypeName], [Name], [Email], [Phone], [Logotype], [Address], [Priority], [Director], [INN], [KPP]) VALUES (71, 4, N'ОАО', N'Софт', N'jterentev@ersov.com', N'(35222) 12-82-65', N'\agents\agent_122.png', N'453714, Смоленская область, город Одинцово, спуск Косиора, 84', NULL, N'Петухова Прохор Фёдорович', 3889910123, 952047511)
INSERT [dbo].[Agents] ([ID], [TypeID], [TypeName], [Name], [Email], [Phone], [Logotype], [Address], [Priority], [Director], [INN], [KPP]) VALUES (72, 4, N'ОАО', N'ТелекомГор', N'gorskov.larisa@kalinin.com', N'(35222) 78-93-21', N'\agents\agent_98.png', N'210024, Белгородская область, город Сергиев Посад, наб. Ломоносова, 43', 255, N'Ксения Андреевна Михайлова', 3748947224, 766431901)
INSERT [dbo].[Agents] ([ID], [TypeID], [TypeName], [Name], [Email], [Phone], [Logotype], [Address], [Priority], [Director], [INN], [KPP]) VALUES (73, 6, N'ПАО', N'РемСтрем', N'rafail96@sukin.ru', N'(35222) 55-28-24', N'\agents\agent_116.png', N'373761, Псковская область, город Наро-Фоминск, наб. Гагарина, 03', NULL, N'Альбина Александровна Романова', 9006569852, 152177100)
INSERT [dbo].[Agents] ([ID], [TypeID], [TypeName], [Name], [Email], [Phone], [Logotype], [Address], [Priority], [Director], [INN], [KPP]) VALUES (74, 5, N'ООО', N'Лифт', N'zinaida01@bespalova.ru', N'(812) 484-92-38', N'\agents\agent_101.png', N'479565, Курганская область, город Клин, пл. Ленина, 54', NULL, N'Вера Евгеньевна Денисоваа', 6169713039, 848972934)
INSERT [dbo].[Agents] ([ID], [TypeID], [TypeName], [Name], [Email], [Phone], [Logotype], [Address], [Priority], [Director], [INN], [KPP]) VALUES (75, 5, N'ООО', N'Компания МоторТелекомЦемент-М', N'larisa44@silin.org', N'(812) 857-95-57', N'\agents\agent_118.png', N'021293, Амурская область, город Наро-Фоминск, шоссе Славы, 40', NULL, N'Иван Евгеньевич Белоусова', 7326832482, 440199498)
INSERT [dbo].[Agents] ([ID], [TypeID], [TypeName], [Name], [Email], [Phone], [Logotype], [Address], [Priority], [Director], [INN], [KPP]) VALUES (76, 4, N'ОАО', N'ЮпитерТяжОрионЭкспедиция', N'gblokin@orlov.net', N'(35222) 95-63-65', N'\agents\agent_44.png', N'960726, Томская область, город Орехово-Зуево, въезд 1905 года, 51', NULL, N'Валерий Евгеньевич Виноградов', 6843174002, 935556458)
INSERT [dbo].[Agents] ([ID], [TypeID], [TypeName], [Name], [Email], [Phone], [Logotype], [Address], [Priority], [Director], [INN], [KPP]) VALUES (77, 3, N'МФО', N'Транс', N'artem.fadeev@polykov.com', N'8-800-954-23-89', N'\agents\agent_127.png', N'508299, Кемеровская область, город Кашира, пер. Гагарина, 42', NULL, N'Евсеева Болеслав Сергеевич', 9604275878, 951258069)
INSERT [dbo].[Agents] ([ID], [TypeID], [TypeName], [Name], [Email], [Phone], [Logotype], [Address], [Priority], [Director], [INN], [KPP]) VALUES (78, 4, N'ОАО', N'РемВод', N'komarov.elizaveta@agafonova.ru', N'+7 (922) 353-31-72', N'\agents\agent_126.png', N'449723, Смоленская область, город Наро-Фоминск, пер. Ломоносова, 94', 1, N'Медведеваа Ярослава Фёдоровна', 3986603105, 811373078)
INSERT [dbo].[Agents] ([ID], [TypeID], [TypeName], [Name], [Email], [Phone], [Logotype], [Address], [Priority], [Director], [INN], [KPP]) VALUES (79, 6, N'ПАО', N'АсбоцементЛифтРеч-H', N'vladlena58@seliverstova.ru', N'(495) 245-57-16', N'\agents\agent_105.png', N'599158, Ростовская область, город Озёры, ул. Космонавтов, 05', NULL, N'Кондратьева Таисия Андреевна', 6567878928, 560960507)
INSERT [dbo].[Agents] ([ID], [TypeID], [TypeName], [Name], [Email], [Phone], [Logotype], [Address], [Priority], [Director], [INN], [KPP]) VALUES (80, 5, N'ООО', N'РосАвтоМонтаж', N'lapin.inessa@isaeva.com', N'(495) 445-97-76', N'\agents\agent_55.png', N'331914, Курская область, город Ногинск, спуск Ладыгина, 66', 10, N'Диана Алексеевна Исаковаа', 4735043946, 263682488)
INSERT [dbo].[Agents] ([ID], [TypeID], [TypeName], [Name], [Email], [Phone], [Logotype], [Address], [Priority], [Director], [INN], [KPP]) VALUES (81, 5, N'ООО', N'Компания СервисТелеМотор', N'veronika.egorov@bespalova.com', N'+7 (922) 461-25-29', N'\agents\agent_102.png', N'625988, Вологодская область, город Озёры, пр. Гоголя, 18', 81, N'Фролова Эдуард Борисович', 3248454160, 138472695)
INSERT [dbo].[Agents] ([ID], [TypeID], [TypeName], [Name], [Email], [Phone], [Logotype], [Address], [Priority], [Director], [INN], [KPP]) VALUES (82, 6, N'ПАО', N'ФинансТелеТверь', N'medvedev.klim@afanasev.com', N'(812) 115-56-93', N'\agents\agent_45.png', N'687171, Томская область, город Лотошино, пл. Славы, 59', NULL, N'Зайцеваа Дарья Сергеевна', 2646091050, 971874277)
INSERT [dbo].[Agents] ([ID], [TypeID], [TypeName], [Name], [Email], [Phone], [Logotype], [Address], [Priority], [Director], [INN], [KPP]) VALUES (83, 4, N'ОАО', N'ВодГор', N'tvetkova.robert@sorokin.com', N'(35222) 73-72-16', N'\agents\agent_125.png', N'265653, Калужская область, город Ступино, шоссе Гоголя, 89', 72, N'Фаина Фёдоровна Филиппова', 4463113470, 899603778)
INSERT [dbo].[Agents] ([ID], [TypeID], [TypeName], [Name], [Email], [Phone], [Logotype], [Address], [Priority], [Director], [INN], [KPP]) VALUES (84, 4, N'ОАО', N'ТяжРадиоУралПроф', N'liliy62@grisina.ru', N'+7 (922) 885-66-15', N'\agents\agent_88.png', N'521087, Орловская область, город Егорьевск, шоссе Ладыгина, 14', NULL, N'София Алексеевна Мухина', 5688533246, 401535045)
INSERT [dbo].[Agents] ([ID], [TypeID], [TypeName], [Name], [Email], [Phone], [Logotype], [Address], [Priority], [Director], [INN], [KPP]) VALUES (85, 4, N'ОАО', N'ГаражЛофт', N'lydmila.belyeva@karpov.ru', N'(495) 427-55-66', N'\agents\agent_108.png', N'294596, Мурманская область, город Шаховская, пр. Домодедовская, 88', 335, N'Клавдия Фёдоровна Кудряшова', 2816939574, 754741128)
INSERT [dbo].[Agents] ([ID], [TypeID], [TypeName], [Name], [Email], [Phone], [Logotype], [Address], [Priority], [Director], [INN], [KPP]) VALUES (86, 4, N'ОАО', N'ITСтройАлмаз', N'fokin.eduard@samoilov.com', N'8-800-185-78-91', N'\agents\agent_83.png', N'361730, Костромская область, город Волоколамск, шоссе Славы, 36', 159, N'Алексеева Валериан Андреевич', 7689065648, 456612755)
INSERT [dbo].[Agents] ([ID], [TypeID], [TypeName], [Name], [Email], [Phone], [Logotype], [Address], [Priority], [Director], [INN], [KPP]) VALUES (87, 5, N'ООО', N'Асбоцемент', N'antonin19@panfilov.ru', N'8-800-211-16-23', N'\agents\agent_34.png', N'030119, Курганская область, город Дмитров, пер. Славы, 47', 273, N'Никитинаа Антонина Андреевна', 1261407459, 745921890)
INSERT [dbo].[Agents] ([ID], [TypeID], [TypeName], [Name], [Email], [Phone], [Logotype], [Address], [Priority], [Director], [INN], [KPP]) VALUES (88, 1, N'ЗАО', N'ТекстильУралАвтоОпт', N'hkononova@pavlova.ru', N'(35222) 98-76-54', NULL, N'028936, Магаданская область, город Видное, ул. Гагарина, 54', NULL, N'Алина Сергеевна Дьячковаа', 3930950057, 678529397)
INSERT [dbo].[Agents] ([ID], [TypeID], [TypeName], [Name], [Email], [Phone], [Logotype], [Address], [Priority], [Director], [INN], [KPP]) VALUES (89, 5, N'ООО', N'Компания КрепЦемент', N'rusakov.efim@nikiforov.ru', N'(812) 963-77-87', N'\agents\agent_50.png', N'423477, Мурманская область, город Кашира, бульвар Домодедовская, 61', NULL, N'Екатерина Львовна Суворова', 3025099903, 606083992)
INSERT [dbo].[Agents] ([ID], [TypeID], [TypeName], [Name], [Email], [Phone], [Logotype], [Address], [Priority], [Director], [INN], [KPP]) VALUES (90, 4, N'ОАО', N'КазаньТекстиль', N'osimonova@andreeva.com', N'(35222) 86-74-21', N'\agents\agent_47.png', N'231891, Челябинская область, город Шатура, бульвар Ладыгина, 40', 156, N'Александров Бронислав Максимович', 4584384019, 149680499)
INSERT [dbo].[Agents] ([ID], [TypeID], [TypeName], [Name], [Email], [Phone], [Logotype], [Address], [Priority], [Director], [INN], [KPP]) VALUES (91, 4, N'ОАО', N'КазЮпитерТомск', N'tgavrilov@frolov.ru', N'+7 (922) 772-33-58', N'\agents\agent_60.png', N'393450, Тульская область, город Кашира, пр. 1905 года, 47', 244, N'Рафаил Андреевич Копылов', 9201745524, 510248846)
INSERT [dbo].[Agents] ([ID], [TypeID], [TypeName], [Name], [Email], [Phone], [Logotype], [Address], [Priority], [Director], [INN], [KPP]) VALUES (92, 3, N'МФО', N'Бух', N'belova.vikentii@konstantinova.net', N'+7 (922) 375-49-21', N'\agents\agent_78.png', N'409600, Новгородская область, город Ногинск, пл. Гагарина, 68', NULL, N'Татьяна Сергеевна Королёваа', 1953785418, 122905583)
INSERT [dbo].[Agents] ([ID], [TypeID], [TypeName], [Name], [Email], [Phone], [Logotype], [Address], [Priority], [Director], [INN], [KPP]) VALUES (93, 6, N'ПАО', N'Радио', N'rtretykova@kozlov.ru', N'8-800-897-32-78', N'\agents\agent_43.png', N'798718, Ленинградская область, город Пушкино, бульвар Балканская, 37', NULL, N'Эмма Андреевна Колесникова', 9077613654, 657690787)
INSERT [dbo].[Agents] ([ID], [TypeID], [TypeName], [Name], [Email], [Phone], [Logotype], [Address], [Priority], [Director], [INN], [KPP]) VALUES (94, 1, N'ЗАО', N'Креп', N'savina.dominika@belousova.com', N'(495) 217-46-29', N'\agents\agent_39.png', N'336489, Калининградская область, город Можайск, наб. Славы, 35', NULL, N'Назар Алексеевич Григорьева', 4880732317, 258673591)
INSERT [dbo].[Agents] ([ID], [TypeID], [TypeName], [Name], [Email], [Phone], [Logotype], [Address], [Priority], [Director], [INN], [KPP]) VALUES (95, 4, N'ОАО', N'Мобайл', N'dsiryev@dementeva.com', N'8-800-618-73-37', N'\agents\agent_107.png', N'606703, Амурская область, город Чехов, пл. Будапештсткая, 91', NULL, N'Екатерина Сергеевна Бобылёва', 7803888520, 885703265)
INSERT [dbo].[Agents] ([ID], [TypeID], [TypeName], [Name], [Email], [Phone], [Logotype], [Address], [Priority], [Director], [INN], [KPP]) VALUES (96, 2, N'МКК', N'CибБашкирТекстиль', N'vzimina@zdanova.com', N'(495) 285-78-38', N'\agents\agent_69.png', N'429540, Мурманская область, город Воскресенск, пл. Славы, 36', 218, N'Григорий Владимирович Елисеева', 7392007090, 576103661)
INSERT [dbo].[Agents] ([ID], [TypeID], [TypeName], [Name], [Email], [Phone], [Logotype], [Address], [Priority], [Director], [INN], [KPP]) VALUES (97, 2, N'МКК', N'МеталТекстильЛифтТрест', N'muravev.trofim@sazonov.net', N'(812) 753-96-76', N'\agents\agent_86.png', N'786287, Свердловская область, город Волоколамск, пер. Будапештсткая, 72', NULL, N'Одинцов Назар Борисович', 2971553297, 821859486)
INSERT [dbo].[Agents] ([ID], [TypeID], [TypeName], [Name], [Email], [Phone], [Logotype], [Address], [Priority], [Director], [INN], [KPP]) VALUES (98, 6, N'ПАО', N'ОрионТомскТех', N'faina.tikonova@veselov.com', N'+7 (922) 542-89-15', N'\agents\agent_119.png', N'738763, Курская область, город Егорьевск, спуск Чехова, 66', 73, N'Георгий Александрович Лукин', 9351493429, 583041591)
INSERT [dbo].[Agents] ([ID], [TypeID], [TypeName], [Name], [Email], [Phone], [Logotype], [Address], [Priority], [Director], [INN], [KPP]) VALUES (99, 6, N'ПАО', N'ЖелДорДизайнМетизТраст', N'lnikitina@kulikova.com', N'(812) 123-63-47', NULL, N'170549, Сахалинская область, город Видное, проезд Космонавтов, 89', NULL, N'Игорь Львович Агафонова', 7669116841, 906390137)
INSERT [dbo].[Agents] ([ID], [TypeID], [TypeName], [Name], [Email], [Phone], [Logotype], [Address], [Priority], [Director], [INN], [KPP]) VALUES (100, 4, N'ОАО', N'БухМясМоторПром', N'varvara49@savin.ru', N'(35222) 83-23-59', N'\agents\agent_95.png', N'677498, Костромская область, город Зарайск, спуск Славы, 59', 158, N'Нина Дмитриевна Черноваа', 7377410338, 592041317)
GO
INSERT [dbo].[Agents] ([ID], [TypeID], [TypeName], [Name], [Email], [Phone], [Logotype], [Address], [Priority], [Director], [INN], [KPP]) VALUES (102, 1, NULL, N'Test', N'test-agent@mail.ru', N'+88005553535', NULL, N'Пушкина 15', 22, N'Иванов Иван Иванович', 13123123, 54345345)
SET IDENTITY_INSERT [dbo].[Agents] OFF
GO
SET IDENTITY_INSERT [dbo].[ChangePriorityHistory] ON 

INSERT [dbo].[ChangePriorityHistory] ([ID], [Date], [AgentID], [Priority]) VALUES (1, CAST(N'2021-12-14' AS Date), 0, 0)
SET IDENTITY_INSERT [dbo].[ChangePriorityHistory] OFF
GO
SET IDENTITY_INSERT [dbo].[ProductSale] ON 

INSERT [dbo].[ProductSale] ([ID], [ProductID], [ProductName], [AgentID], [AgentName], [DateOfRelease], [CountOfProduct]) VALUES (1, 10, N'Попрыгунчик для кошечек 2604', 90, N'КазаньТекстиль', CAST(N'2010-06-21T00:00:00.000' AS DateTime), 7)
INSERT [dbo].[ProductSale] ([ID], [ProductID], [ProductName], [AgentID], [AgentName], [DateOfRelease], [CountOfProduct]) VALUES (2, 23, N'Попрыгунчик для собачек 5754', 70, N'Компания ФинансСервис', CAST(N'2016-02-17T00:00:00.000' AS DateTime), 18)
INSERT [dbo].[ProductSale] ([ID], [ProductID], [ProductName], [AgentID], [AgentName], [DateOfRelease], [CountOfProduct]) VALUES (3, 24, N'Попрыгунчик для собачек 4485', 38, N'РемГаражЛифт', CAST(N'2012-11-07T00:00:00.000' AS DateTime), 9)
INSERT [dbo].[ProductSale] ([ID], [ProductID], [ProductName], [AgentID], [AgentName], [DateOfRelease], [CountOfProduct]) VALUES (4, 46, N'Попрыгун 6412', 93, N'Радио', CAST(N'2019-06-01T00:00:00.000' AS DateTime), 5)
INSERT [dbo].[ProductSale] ([ID], [ProductID], [ProductName], [AgentID], [AgentName], [DateOfRelease], [CountOfProduct]) VALUES (5, 21, N'Попрыгунчик детский красный 3839', 61, N'Орион', CAST(N'2014-06-11T00:00:00.000' AS DateTime), 11)
INSERT [dbo].[ProductSale] ([ID], [ProductID], [ProductName], [AgentID], [AgentName], [DateOfRelease], [CountOfProduct]) VALUES (6, 1, N'Попрыгунчик детский красный 1289', 29, N'РемСантехОмскБанк', CAST(N'2012-08-12T00:00:00.000' AS DateTime), 12)
INSERT [dbo].[ProductSale] ([ID], [ProductID], [ProductName], [AgentID], [AgentName], [DateOfRelease], [CountOfProduct]) VALUES (7, 35, N'Попрыгунчик детский красный 1740', 21, N'Газ', CAST(N'2012-09-26T00:00:00.000' AS DateTime), 16)
INSERT [dbo].[ProductSale] ([ID], [ProductID], [ProductName], [AgentID], [AgentName], [DateOfRelease], [CountOfProduct]) VALUES (8, 17, N'Попрыгунчик детский розовый 1657', 38, N'РемГаражЛифт', CAST(N'2018-02-28T00:00:00.000' AS DateTime), 3)
INSERT [dbo].[ProductSale] ([ID], [ProductID], [ProductName], [AgentID], [AgentName], [DateOfRelease], [CountOfProduct]) VALUES (9, 2, N'Попрыгунчик детский желтый 6678', 96, N'CибБашкирТекстиль', CAST(N'2018-09-15T00:00:00.000' AS DateTime), 6)
INSERT [dbo].[ProductSale] ([ID], [ProductID], [ProductName], [AgentID], [AgentName], [DateOfRelease], [CountOfProduct]) VALUES (10, 12, N'Попрыгунчик детский желтый 6051', 33, N'Компания МясДизайнДизайн', CAST(N'2011-08-27T00:00:00.000' AS DateTime), 10)
INSERT [dbo].[ProductSale] ([ID], [ProductID], [ProductName], [AgentID], [AgentName], [DateOfRelease], [CountOfProduct]) VALUES (11, 42, N'Попрыгунчик детский красный 1972', 25, N'Компания Гараж', CAST(N'2011-08-19T00:00:00.000' AS DateTime), 2)
INSERT [dbo].[ProductSale] ([ID], [ProductID], [ProductName], [AgentID], [AgentName], [DateOfRelease], [CountOfProduct]) VALUES (12, 45, N'Попрыгунчик детский розовый 6346', 38, N'РемГаражЛифт', CAST(N'2015-02-02T00:00:00.000' AS DateTime), 20)
INSERT [dbo].[ProductSale] ([ID], [ProductID], [ProductName], [AgentID], [AgentName], [DateOfRelease], [CountOfProduct]) VALUES (13, 48, N'Попрыгунчик для собачек 4529', 94, N'Креп', CAST(N'2011-07-01T00:00:00.000' AS DateTime), 14)
INSERT [dbo].[ProductSale] ([ID], [ProductID], [ProductName], [AgentID], [AgentName], [DateOfRelease], [CountOfProduct]) VALUES (14, 47, N'Попрыгунчик детский 1916', 40, N'ЮпитерЛенГараж-М', CAST(N'2013-12-23T00:00:00.000' AS DateTime), 8)
INSERT [dbo].[ProductSale] ([ID], [ProductID], [ProductName], [AgentID], [AgentName], [DateOfRelease], [CountOfProduct]) VALUES (15, 10, N'Попрыгунчик для кошечек 2604', 7, N'Тех', CAST(N'2017-11-11T00:00:00.000' AS DateTime), 10)
INSERT [dbo].[ProductSale] ([ID], [ProductID], [ProductName], [AgentID], [AgentName], [DateOfRelease], [CountOfProduct]) VALUES (16, 24, N'Попрыгунчик для собачек 4485', 35, N'МетизТехАвтоПроф', CAST(N'2021-04-15T00:00:00.000' AS DateTime), 14)
INSERT [dbo].[ProductSale] ([ID], [ProductID], [ProductName], [AgentID], [AgentName], [DateOfRelease], [CountOfProduct]) VALUES (17, 24, N'Попрыгунчик для собачек 4485', 37, N'ГазДизайнЖелДор', CAST(N'2021-06-22T00:00:00.000' AS DateTime), 6)
INSERT [dbo].[ProductSale] ([ID], [ProductID], [ProductName], [AgentID], [AgentName], [DateOfRelease], [CountOfProduct]) VALUES (18, 39, N'Попрыгунчик детский желтый 2582', 57, N'Рем', CAST(N'2013-07-11T00:00:00.000' AS DateTime), 12)
INSERT [dbo].[ProductSale] ([ID], [ProductID], [ProductName], [AgentID], [AgentName], [DateOfRelease], [CountOfProduct]) VALUES (19, 17, N'Попрыгунчик детский розовый 1657', 18, N'МясТрансМоторЛизинг', CAST(N'2016-08-13T00:00:00.000' AS DateTime), 7)
INSERT [dbo].[ProductSale] ([ID], [ProductID], [ProductName], [AgentID], [AgentName], [DateOfRelease], [CountOfProduct]) VALUES (20, 47, N'Попрыгунчик детский 1916', 21, N'Газ', CAST(N'2014-07-28T00:00:00.000' AS DateTime), 8)
INSERT [dbo].[ProductSale] ([ID], [ProductID], [ProductName], [AgentID], [AgentName], [DateOfRelease], [CountOfProduct]) VALUES (21, 14, N'Попрыгунчик для собачек 4387', 62, N'СтройГорНефть', CAST(N'2010-04-15T00:00:00.000' AS DateTime), 8)
INSERT [dbo].[ProductSale] ([ID], [ProductID], [ProductName], [AgentID], [AgentName], [DateOfRelease], [CountOfProduct]) VALUES (22, 14, N'Попрыгунчик для собачек 4387', 42, N'КазХоз', CAST(N'2017-10-12T00:00:00.000' AS DateTime), 8)
INSERT [dbo].[ProductSale] ([ID], [ProductID], [ProductName], [AgentID], [AgentName], [DateOfRelease], [CountOfProduct]) VALUES (23, 38, N'Шар 4124', 88, N'ТекстильУралАвтоОпт', CAST(N'2012-09-02T00:00:00.000' AS DateTime), 13)
INSERT [dbo].[ProductSale] ([ID], [ProductID], [ProductName], [AgentID], [AgentName], [DateOfRelease], [CountOfProduct]) VALUES (24, 17, N'Попрыгунчик детский розовый 1657', 91, N'КазЮпитерТомск', CAST(N'2015-08-08T00:00:00.000' AS DateTime), 14)
INSERT [dbo].[ProductSale] ([ID], [ProductID], [ProductName], [AgentID], [AgentName], [DateOfRelease], [CountOfProduct]) VALUES (25, 49, N'Попрыгунчик для собачек 4381', 5, N'Компания СервисРадиоГор', CAST(N'2012-05-25T00:00:00.000' AS DateTime), 15)
INSERT [dbo].[ProductSale] ([ID], [ProductID], [ProductName], [AgentID], [AgentName], [DateOfRelease], [CountOfProduct]) VALUES (26, 36, N'Попрыгунчик детский красный 5400', 30, N'ЭлектроМоторТрансСнос', CAST(N'2014-03-06T00:00:00.000' AS DateTime), 12)
INSERT [dbo].[ProductSale] ([ID], [ProductID], [ProductName], [AgentID], [AgentName], [DateOfRelease], [CountOfProduct]) VALUES (27, 16, N'Попрыгунчик детский красный 3240', 29, N'РемСантехОмскБанк', CAST(N'2016-05-18T00:00:00.000' AS DateTime), 6)
INSERT [dbo].[ProductSale] ([ID], [ProductID], [ProductName], [AgentID], [AgentName], [DateOfRelease], [CountOfProduct]) VALUES (28, 50, N'Попрыгунчик детский розовый 2694', 89, N'Компания КрепЦемент', CAST(N'2014-07-11T00:00:00.000' AS DateTime), 10)
INSERT [dbo].[ProductSale] ([ID], [ProductID], [ProductName], [AgentID], [AgentName], [DateOfRelease], [CountOfProduct]) VALUES (29, 45, N'Попрыгунчик детский розовый 6346', 63, N'Компания Хмель', CAST(N'2016-08-18T00:00:00.000' AS DateTime), 8)
INSERT [dbo].[ProductSale] ([ID], [ProductID], [ProductName], [AgentID], [AgentName], [DateOfRelease], [CountOfProduct]) VALUES (30, 4, N'Попрыгунчик для мальчиков 3929', 5, N'Компания СервисРадиоГор', CAST(N'2019-07-25T00:00:00.000' AS DateTime), 19)
INSERT [dbo].[ProductSale] ([ID], [ProductID], [ProductName], [AgentID], [AgentName], [DateOfRelease], [CountOfProduct]) VALUES (31, 40, N'Попрыгунчик детский 6029', 53, N'ВодГараж', CAST(N'2019-03-17T00:00:00.000' AS DateTime), 6)
INSERT [dbo].[ProductSale] ([ID], [ProductID], [ProductName], [AgentID], [AgentName], [DateOfRelease], [CountOfProduct]) VALUES (32, 20, N'Попрыгунчик для кошечек 3741', 47, N'Строй', CAST(N'2014-08-06T00:00:00.000' AS DateTime), 9)
INSERT [dbo].[ProductSale] ([ID], [ProductID], [ProductName], [AgentID], [AgentName], [DateOfRelease], [CountOfProduct]) VALUES (33, 27, N'Попрыгунчик для девочек 6849', 5, N'Компания СервисРадиоГор', CAST(N'2011-09-12T00:00:00.000' AS DateTime), 18)
INSERT [dbo].[ProductSale] ([ID], [ProductID], [ProductName], [AgentID], [AgentName], [DateOfRelease], [CountOfProduct]) VALUES (34, 14, N'Попрыгунчик для собачек 4387', 19, N'Монтаж', CAST(N'2011-08-28T00:00:00.000' AS DateTime), 11)
INSERT [dbo].[ProductSale] ([ID], [ProductID], [ProductName], [AgentID], [AgentName], [DateOfRelease], [CountOfProduct]) VALUES (35, 41, N'Попрыгун 2299', 63, N'Компания Хмель', CAST(N'2015-12-25T00:00:00.000' AS DateTime), 4)
INSERT [dbo].[ProductSale] ([ID], [ProductID], [ProductName], [AgentID], [AgentName], [DateOfRelease], [CountOfProduct]) VALUES (36, 1, N'Попрыгунчик детский красный 1289', 18, N'МясТрансМоторЛизинг', CAST(N'2016-02-25T00:00:00.000' AS DateTime), 8)
INSERT [dbo].[ProductSale] ([ID], [ProductID], [ProductName], [AgentID], [AgentName], [DateOfRelease], [CountOfProduct]) VALUES (37, 8, N'Попрыгунчик детский розовый 5376', 11, N'CибПивОмскСнаб', CAST(N'2017-06-07T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[ProductSale] ([ID], [ProductID], [ProductName], [AgentID], [AgentName], [DateOfRelease], [CountOfProduct]) VALUES (38, 38, N'Шар 4124', 96, N'CибБашкирТекстиль', CAST(N'2016-11-27T00:00:00.000' AS DateTime), 6)
INSERT [dbo].[ProductSale] ([ID], [ProductID], [ProductName], [AgentID], [AgentName], [DateOfRelease], [CountOfProduct]) VALUES (39, 18, N'Попрыгунчик детский красный 6591', 7, N'Тех', CAST(N'2012-03-12T00:00:00.000' AS DateTime), 18)
INSERT [dbo].[ProductSale] ([ID], [ProductID], [ProductName], [AgentID], [AgentName], [DateOfRelease], [CountOfProduct]) VALUES (40, 7, N'Попрыгунчик для мальчиков 5389', 59, N'Цемент', CAST(N'2018-06-13T00:00:00.000' AS DateTime), 18)
INSERT [dbo].[ProductSale] ([ID], [ProductID], [ProductName], [AgentID], [AgentName], [DateOfRelease], [CountOfProduct]) VALUES (41, 31, N'Попрыгунчик для собачек 3500', 30, N'ЭлектроМоторТрансСнос', CAST(N'2017-11-05T00:00:00.000' AS DateTime), 2)
INSERT [dbo].[ProductSale] ([ID], [ProductID], [ProductName], [AgentID], [AgentName], [DateOfRelease], [CountOfProduct]) VALUES (42, 38, N'Шар 4124', 16, N'Компания ТелекомХмельГаражПром', CAST(N'2016-02-26T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[ProductSale] ([ID], [ProductID], [ProductName], [AgentID], [AgentName], [DateOfRelease], [CountOfProduct]) VALUES (43, 29, N'Попрыгунчик для девочек 3389', 90, N'КазаньТекстиль', CAST(N'2010-06-20T00:00:00.000' AS DateTime), 8)
INSERT [dbo].[ProductSale] ([ID], [ProductID], [ProductName], [AgentID], [AgentName], [DateOfRelease], [CountOfProduct]) VALUES (44, 28, N'Попрыгунчик детский желтый 1371', 7, N'Тех', CAST(N'2015-06-23T00:00:00.000' AS DateTime), 12)
INSERT [dbo].[ProductSale] ([ID], [ProductID], [ProductName], [AgentID], [AgentName], [DateOfRelease], [CountOfProduct]) VALUES (45, 14, N'Попрыгунчик для собачек 4387', 33, N'Компания МясДизайнДизайн', CAST(N'2013-01-24T00:00:00.000' AS DateTime), 3)
INSERT [dbo].[ProductSale] ([ID], [ProductID], [ProductName], [AgentID], [AgentName], [DateOfRelease], [CountOfProduct]) VALUES (46, 13, N'Попрыгунчик для девочек 2311', 9, N'МясРеч', CAST(N'2015-02-28T00:00:00.000' AS DateTime), 5)
INSERT [dbo].[ProductSale] ([ID], [ProductID], [ProductName], [AgentID], [AgentName], [DateOfRelease], [CountOfProduct]) VALUES (47, 42, N'Попрыгунчик детский красный 1972', 18, N'МясТрансМоторЛизинг', CAST(N'2019-07-05T00:00:00.000' AS DateTime), 14)
INSERT [dbo].[ProductSale] ([ID], [ProductID], [ProductName], [AgentID], [AgentName], [DateOfRelease], [CountOfProduct]) VALUES (48, 40, N'Попрыгунчик детский 6029', 92, N'Бух', CAST(N'2014-03-06T00:00:00.000' AS DateTime), 6)
INSERT [dbo].[ProductSale] ([ID], [ProductID], [ProductName], [AgentID], [AgentName], [DateOfRelease], [CountOfProduct]) VALUES (49, 31, N'Попрыгунчик для собачек 3500', 94, N'Креп', CAST(N'2017-05-01T00:00:00.000' AS DateTime), 5)
INSERT [dbo].[ProductSale] ([ID], [ProductID], [ProductName], [AgentID], [AgentName], [DateOfRelease], [CountOfProduct]) VALUES (50, 26, N'Попрыгунчик для мальчиков 4791', 51, N'Компания Монтаж', CAST(N'2015-01-17T00:00:00.000' AS DateTime), 15)
INSERT [dbo].[ProductSale] ([ID], [ProductID], [ProductName], [AgentID], [AgentName], [DateOfRelease], [CountOfProduct]) VALUES (51, 15, N'Попрыгун 3016', 82, N'ФинансТелеТверь', CAST(N'2018-04-14T00:00:00.000' AS DateTime), 7)
INSERT [dbo].[ProductSale] ([ID], [ProductID], [ProductName], [AgentID], [AgentName], [DateOfRelease], [CountOfProduct]) VALUES (52, 18, N'Попрыгунчик детский красный 6591', 94, N'Креп', CAST(N'2014-12-12T00:00:00.000' AS DateTime), 14)
INSERT [dbo].[ProductSale] ([ID], [ProductID], [ProductName], [AgentID], [AgentName], [DateOfRelease], [CountOfProduct]) VALUES (53, 17, N'Попрыгунчик детский розовый 1657', 40, N'ЮпитерЛенГараж-М', CAST(N'2015-03-28T00:00:00.000' AS DateTime), 16)
INSERT [dbo].[ProductSale] ([ID], [ProductID], [ProductName], [AgentID], [AgentName], [DateOfRelease], [CountOfProduct]) VALUES (54, 41, N'Попрыгун 2299', 13, N'ТелеГлавВекторСбыт', CAST(N'2017-11-24T00:00:00.000' AS DateTime), 15)
INSERT [dbo].[ProductSale] ([ID], [ProductID], [ProductName], [AgentID], [AgentName], [DateOfRelease], [CountOfProduct]) VALUES (55, 46, N'Попрыгун 6412', 11, N'CибПивОмскСнаб', CAST(N'2019-06-27T00:00:00.000' AS DateTime), 10)
INSERT [dbo].[ProductSale] ([ID], [ProductID], [ProductName], [AgentID], [AgentName], [DateOfRelease], [CountOfProduct]) VALUES (56, 29, N'Попрыгунчик для девочек 3389', 87, N'Асбоцемент', CAST(N'2014-06-04T00:00:00.000' AS DateTime), 2)
INSERT [dbo].[ProductSale] ([ID], [ProductID], [ProductName], [AgentID], [AgentName], [DateOfRelease], [CountOfProduct]) VALUES (57, 43, N'Попрыгунчик детский 5117', 57, N'Рем', CAST(N'2019-03-18T00:00:00.000' AS DateTime), 11)
INSERT [dbo].[ProductSale] ([ID], [ProductID], [ProductName], [AgentID], [AgentName], [DateOfRelease], [CountOfProduct]) VALUES (58, 42, N'Попрыгунчик детский красный 1972', 13, N'ТелеГлавВекторСбыт', CAST(N'2015-09-12T00:00:00.000' AS DateTime), 8)
INSERT [dbo].[ProductSale] ([ID], [ProductID], [ProductName], [AgentID], [AgentName], [DateOfRelease], [CountOfProduct]) VALUES (59, 47, N'Попрыгунчик детский 1916', 59, N'Цемент', CAST(N'2012-01-02T00:00:00.000' AS DateTime), 13)
INSERT [dbo].[ProductSale] ([ID], [ProductID], [ProductName], [AgentID], [AgentName], [DateOfRelease], [CountOfProduct]) VALUES (60, 24, N'Попрыгунчик для собачек 4485', 9, N'МясРеч', CAST(N'2024-02-01T00:00:00.000' AS DateTime), 12)
INSERT [dbo].[ProductSale] ([ID], [ProductID], [ProductName], [AgentID], [AgentName], [DateOfRelease], [CountOfProduct]) VALUES (61, 33, N'Попрыгунчик для кошечек 4740', 24, N'Гор', CAST(N'2016-10-07T00:00:00.000' AS DateTime), 17)
INSERT [dbo].[ProductSale] ([ID], [ProductID], [ProductName], [AgentID], [AgentName], [DateOfRelease], [CountOfProduct]) VALUES (62, 4, N'Попрыгунчик для мальчиков 3929', 91, N'КазЮпитерТомск', CAST(N'2017-06-07T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[ProductSale] ([ID], [ProductID], [ProductName], [AgentID], [AgentName], [DateOfRelease], [CountOfProduct]) VALUES (63, 5, N'Попрыгунчик детский 2071', 47, N'Строй', CAST(N'2016-02-26T00:00:00.000' AS DateTime), 14)
INSERT [dbo].[ProductSale] ([ID], [ProductID], [ProductName], [AgentID], [AgentName], [DateOfRelease], [CountOfProduct]) VALUES (64, 2, N'Попрыгунчик детский желтый 6678', 47, N'Строй', CAST(N'2013-11-09T00:00:00.000' AS DateTime), 5)
INSERT [dbo].[ProductSale] ([ID], [ProductID], [ProductName], [AgentID], [AgentName], [DateOfRelease], [CountOfProduct]) VALUES (65, 40, N'Попрыгунчик детский 6029', 9, N'МясРеч', CAST(N'2015-07-01T00:00:00.000' AS DateTime), 14)
INSERT [dbo].[ProductSale] ([ID], [ProductID], [ProductName], [AgentID], [AgentName], [DateOfRelease], [CountOfProduct]) VALUES (66, 32, N'Попрыгун 6882', 58, N'СантехСеверЛенМашина', CAST(N'2015-08-27T00:00:00.000' AS DateTime), 6)
INSERT [dbo].[ProductSale] ([ID], [ProductID], [ProductName], [AgentID], [AgentName], [DateOfRelease], [CountOfProduct]) VALUES (67, 23, N'Попрыгунчик для собачек 5754', 59, N'Цемент', CAST(N'2013-08-27T00:00:00.000' AS DateTime), 15)
INSERT [dbo].[ProductSale] ([ID], [ProductID], [ProductName], [AgentID], [AgentName], [DateOfRelease], [CountOfProduct]) VALUES (68, 19, N'Попрыгунчик для девочек 1895', 61, N'Орион', CAST(N'2013-05-10T00:00:00.000' AS DateTime), 2)
INSERT [dbo].[ProductSale] ([ID], [ProductID], [ProductName], [AgentID], [AgentName], [DateOfRelease], [CountOfProduct]) VALUES (69, 24, N'Попрыгунчик для собачек 4485', 53, N'ВодГараж', CAST(N'2013-12-01T00:00:00.000' AS DateTime), 19)
INSERT [dbo].[ProductSale] ([ID], [ProductID], [ProductName], [AgentID], [AgentName], [DateOfRelease], [CountOfProduct]) VALUES (70, 15, N'Попрыгун 3016', 70, N'Компания ФинансСервис', CAST(N'2011-06-11T00:00:00.000' AS DateTime), 16)
INSERT [dbo].[ProductSale] ([ID], [ProductID], [ProductName], [AgentID], [AgentName], [DateOfRelease], [CountOfProduct]) VALUES (71, 2, N'Попрыгунчик детский желтый 6678', 25, N'Компания Гараж', CAST(N'2019-05-24T00:00:00.000' AS DateTime), 16)
INSERT [dbo].[ProductSale] ([ID], [ProductID], [ProductName], [AgentID], [AgentName], [DateOfRelease], [CountOfProduct]) VALUES (72, 46, N'Попрыгун 6412', 47, N'Строй', CAST(N'2017-04-02T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[ProductSale] ([ID], [ProductID], [ProductName], [AgentID], [AgentName], [DateOfRelease], [CountOfProduct]) VALUES (73, 3, N'Попрыгунчик детский 6888', 29, N'РемСантехОмскБанк', CAST(N'2013-04-08T00:00:00.000' AS DateTime), 10)
INSERT [dbo].[ProductSale] ([ID], [ProductID], [ProductName], [AgentID], [AgentName], [DateOfRelease], [CountOfProduct]) VALUES (74, 50, N'Попрыгунчик детский розовый 2694', 51, N'Компания Монтаж', CAST(N'2019-08-16T00:00:00.000' AS DateTime), 20)
INSERT [dbo].[ProductSale] ([ID], [ProductID], [ProductName], [AgentID], [AgentName], [DateOfRelease], [CountOfProduct]) VALUES (75, 46, N'Попрыгун 6412', 80, N'РосАвтоМонтаж', CAST(N'2011-12-26T00:00:00.000' AS DateTime), 5)
INSERT [dbo].[ProductSale] ([ID], [ProductID], [ProductName], [AgentID], [AgentName], [DateOfRelease], [CountOfProduct]) VALUES (76, 21, N'Попрыгунчик детский красный 3839', 25, N'Компания Гараж', CAST(N'2016-07-19T00:00:00.000' AS DateTime), 19)
INSERT [dbo].[ProductSale] ([ID], [ProductID], [ProductName], [AgentID], [AgentName], [DateOfRelease], [CountOfProduct]) VALUES (77, 44, N'Попрыгунчик детский розовый 5501', 19, N'Монтаж', CAST(N'2014-03-17T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[ProductSale] ([ID], [ProductID], [ProductName], [AgentID], [AgentName], [DateOfRelease], [CountOfProduct]) VALUES (78, 16, N'Попрыгунчик детский красный 3240', 12, N'ЦементАсбоцемент', CAST(N'2011-06-14T00:00:00.000' AS DateTime), 13)
INSERT [dbo].[ProductSale] ([ID], [ProductID], [ProductName], [AgentID], [AgentName], [DateOfRelease], [CountOfProduct]) VALUES (79, 29, N'Попрыгунчик для девочек 3389', 76, N'ЮпитерТяжОрионЭкспедиция', CAST(N'2017-05-20T00:00:00.000' AS DateTime), 13)
INSERT [dbo].[ProductSale] ([ID], [ProductID], [ProductName], [AgentID], [AgentName], [DateOfRelease], [CountOfProduct]) VALUES (80, 1, N'Попрыгунчик детский красный 1289', 53, N'ВодГараж', CAST(N'2010-04-13T00:00:00.000' AS DateTime), 6)
INSERT [dbo].[ProductSale] ([ID], [ProductID], [ProductName], [AgentID], [AgentName], [DateOfRelease], [CountOfProduct]) VALUES (81, 1, N'Попрыгунчик детский красный 1289', 12, N'ЦементАсбоцемент', CAST(N'2019-10-15T00:00:00.000' AS DateTime), 9)
INSERT [dbo].[ProductSale] ([ID], [ProductID], [ProductName], [AgentID], [AgentName], [DateOfRelease], [CountOfProduct]) VALUES (82, 43, N'Попрыгунчик детский 5117', 48, N'БашкирЮпитерТомск', CAST(N'2019-10-08T00:00:00.000' AS DateTime), 20)
INSERT [dbo].[ProductSale] ([ID], [ProductID], [ProductName], [AgentID], [AgentName], [DateOfRelease], [CountOfProduct]) VALUES (83, 21, N'Попрыгунчик детский красный 3839', 33, N'Компания МясДизайнДизайн', CAST(N'2018-04-08T00:00:00.000' AS DateTime), 8)
INSERT [dbo].[ProductSale] ([ID], [ProductID], [ProductName], [AgentID], [AgentName], [DateOfRelease], [CountOfProduct]) VALUES (84, 34, N'Шар 2243', 30, N'ЭлектроМоторТрансСнос', CAST(N'2012-06-14T00:00:00.000' AS DateTime), 2)
INSERT [dbo].[ProductSale] ([ID], [ProductID], [ProductName], [AgentID], [AgentName], [DateOfRelease], [CountOfProduct]) VALUES (85, 28, N'Попрыгунчик детский желтый 1371', 62, N'СтройГорНефть', CAST(N'2012-04-23T00:00:00.000' AS DateTime), 3)
INSERT [dbo].[ProductSale] ([ID], [ProductID], [ProductName], [AgentID], [AgentName], [DateOfRelease], [CountOfProduct]) VALUES (86, 27, N'Попрыгунчик для девочек 6849', 61, N'Орион', CAST(N'2015-08-17T00:00:00.000' AS DateTime), 6)
INSERT [dbo].[ProductSale] ([ID], [ProductID], [ProductName], [AgentID], [AgentName], [DateOfRelease], [CountOfProduct]) VALUES (87, 29, N'Попрыгунчик для девочек 3389', 51, N'Компания Монтаж', CAST(N'2016-09-14T00:00:00.000' AS DateTime), 7)
INSERT [dbo].[ProductSale] ([ID], [ProductID], [ProductName], [AgentID], [AgentName], [DateOfRelease], [CountOfProduct]) VALUES (88, 4, N'Попрыгунчик для мальчиков 3929', 6, N'ВодТверьХозМашина', CAST(N'2012-03-23T00:00:00.000' AS DateTime), 15)
INSERT [dbo].[ProductSale] ([ID], [ProductID], [ProductName], [AgentID], [AgentName], [DateOfRelease], [CountOfProduct]) VALUES (89, 38, N'Шар 4124', 55, N'БашкирФлотМотор-H', CAST(N'2010-11-17T00:00:00.000' AS DateTime), 5)
INSERT [dbo].[ProductSale] ([ID], [ProductID], [ProductName], [AgentID], [AgentName], [DateOfRelease], [CountOfProduct]) VALUES (90, 40, N'Попрыгунчик детский 6029', 37, N'ГазДизайнЖелДор', CAST(N'2016-11-17T00:00:00.000' AS DateTime), 13)
INSERT [dbo].[ProductSale] ([ID], [ProductID], [ProductName], [AgentID], [AgentName], [DateOfRelease], [CountOfProduct]) VALUES (91, 44, N'Попрыгунчик детский розовый 5501', 24, N'Гор', CAST(N'2010-05-03T00:00:00.000' AS DateTime), 19)
INSERT [dbo].[ProductSale] ([ID], [ProductID], [ProductName], [AgentID], [AgentName], [DateOfRelease], [CountOfProduct]) VALUES (92, 12, N'Попрыгунчик детский желтый 6051', 15, N'ЭлектроРемОрионЛизинг', CAST(N'2019-03-06T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[ProductSale] ([ID], [ProductID], [ProductName], [AgentID], [AgentName], [DateOfRelease], [CountOfProduct]) VALUES (93, 24, N'Попрыгунчик для собачек 4485', 16, N'Компания ТелекомХмельГаражПром', CAST(N'2017-10-14T00:00:00.000' AS DateTime), 20)
INSERT [dbo].[ProductSale] ([ID], [ProductID], [ProductName], [AgentID], [AgentName], [DateOfRelease], [CountOfProduct]) VALUES (94, 50, N'Попрыгунчик детский розовый 2694', 80, N'РосАвтоМонтаж', CAST(N'2017-02-08T00:00:00.000' AS DateTime), 3)
INSERT [dbo].[ProductSale] ([ID], [ProductID], [ProductName], [AgentID], [AgentName], [DateOfRelease], [CountOfProduct]) VALUES (95, 13, N'Попрыгунчик для девочек 2311', 25, N'Компания Гараж', CAST(N'2017-08-02T00:00:00.000' AS DateTime), 3)
INSERT [dbo].[ProductSale] ([ID], [ProductID], [ProductName], [AgentID], [AgentName], [DateOfRelease], [CountOfProduct]) VALUES (96, 8, N'Попрыгунчик детский розовый 5376', 82, N'ФинансТелеТверь', CAST(N'2017-03-09T00:00:00.000' AS DateTime), 18)
INSERT [dbo].[ProductSale] ([ID], [ProductID], [ProductName], [AgentID], [AgentName], [DateOfRelease], [CountOfProduct]) VALUES (97, 39, N'Попрыгунчик детский желтый 2582', 33, N'Компания МясДизайнДизайн', CAST(N'2017-11-13T00:00:00.000' AS DateTime), 18)
INSERT [dbo].[ProductSale] ([ID], [ProductID], [ProductName], [AgentID], [AgentName], [DateOfRelease], [CountOfProduct]) VALUES (98, 39, N'Попрыгунчик детский желтый 2582', 30, N'ЭлектроМоторТрансСнос', CAST(N'2015-12-02T00:00:00.000' AS DateTime), 19)
INSERT [dbo].[ProductSale] ([ID], [ProductID], [ProductName], [AgentID], [AgentName], [DateOfRelease], [CountOfProduct]) VALUES (99, 9, N'Попрыгунчик для мальчиков 3307', 27, N'ГлавITФлотПроф', CAST(N'2011-06-14T00:00:00.000' AS DateTime), 19)
GO
INSERT [dbo].[ProductSale] ([ID], [ProductID], [ProductName], [AgentID], [AgentName], [DateOfRelease], [CountOfProduct]) VALUES (100, 1, N'Попрыгунчик детский красный 1289', 63, N'Компания Хмель', CAST(N'2014-08-14T00:00:00.000' AS DateTime), 16)
SET IDENTITY_INSERT [dbo].[ProductSale] OFF
GO
SET IDENTITY_INSERT [dbo].[ProductsShort] ON 

INSERT [dbo].[ProductsShort] ([ID], [Name], [TypeID], [TypeName], [Article], [CountOfPeople], [FactoryNumber], [MinPrice]) VALUES (1, N'Попрыгунчик детский красный 1289', 3, N' Для маленьких деток', 82925345, 4, 10, 1919.0000)
INSERT [dbo].[ProductsShort] ([ID], [Name], [TypeID], [TypeName], [Article], [CountOfPeople], [FactoryNumber], [MinPrice]) VALUES (2, N'Попрыгунчик детский желтый 6678', 2, N' Для больших деток', 80007300, 2, 1, 1768.0000)
INSERT [dbo].[ProductsShort] ([ID], [Name], [TypeID], [TypeName], [Article], [CountOfPeople], [FactoryNumber], [MinPrice]) VALUES (3, N'Попрыгунчик детский 6888', 3, N' Для маленьких деток', 13875235, 4, 12, 1972.0000)
INSERT [dbo].[ProductsShort] ([ID], [Name], [TypeID], [TypeName], [Article], [CountOfPeople], [FactoryNumber], [MinPrice]) VALUES (4, N'Попрыгунчик для мальчиков 3929', 3, N' Для маленьких деток', 2158097, 1, 9, 255.0000)
INSERT [dbo].[ProductsShort] ([ID], [Name], [TypeID], [TypeName], [Article], [CountOfPeople], [FactoryNumber], [MinPrice]) VALUES (5, N'Попрыгунчик детский 2071', 3, N' Для маленьких деток', 3157982, 3, 6, 275.0000)
INSERT [dbo].[ProductsShort] ([ID], [Name], [TypeID], [TypeName], [Article], [CountOfPeople], [FactoryNumber], [MinPrice]) VALUES (6, N'Попрыгунчик для собачек 5096', 1, N' Взрослый', 67975083, 4, 9, 1465.0000)
INSERT [dbo].[ProductsShort] ([ID], [Name], [TypeID], [TypeName], [Article], [CountOfPeople], [FactoryNumber], [MinPrice]) VALUES (7, N'Попрыгунчик для мальчиков 5389', 1, N' Взрослый', 70873532, 3, 2, 1739.0000)
INSERT [dbo].[ProductsShort] ([ID], [Name], [TypeID], [TypeName], [Article], [CountOfPeople], [FactoryNumber], [MinPrice]) VALUES (8, N'Попрыгунчик детский розовый 5376', 3, N' Для маленьких деток', 74291677, 4, 6, 1889.0000)
INSERT [dbo].[ProductsShort] ([ID], [Name], [TypeID], [TypeName], [Article], [CountOfPeople], [FactoryNumber], [MinPrice]) VALUES (9, N'Попрыгунчик для мальчиков 3307', 5, N' Цифровой', 30269726, 4, 10, 1533.0000)
INSERT [dbo].[ProductsShort] ([ID], [Name], [TypeID], [TypeName], [Article], [CountOfPeople], [FactoryNumber], [MinPrice]) VALUES (10, N'Попрыгунчик для кошечек 2604', 3, N' Для маленьких деток', 11890154, 2, 7, 842.0000)
INSERT [dbo].[ProductsShort] ([ID], [Name], [TypeID], [TypeName], [Article], [CountOfPeople], [FactoryNumber], [MinPrice]) VALUES (11, N'Шар 6366', 1, N' Взрослый', 25514523, 4, 4, 1932.0000)
INSERT [dbo].[ProductsShort] ([ID], [Name], [TypeID], [TypeName], [Article], [CountOfPeople], [FactoryNumber], [MinPrice]) VALUES (12, N'Попрыгунчик детский желтый 6051', 5, N' Цифровой', 88211092, 4, 12, 727.0000)
INSERT [dbo].[ProductsShort] ([ID], [Name], [TypeID], [TypeName], [Article], [CountOfPeople], [FactoryNumber], [MinPrice]) VALUES (13, N'Попрыгунчик для девочек 2311', 1, N' Взрослый', 25262035, 4, 1, 1308.0000)
INSERT [dbo].[ProductsShort] ([ID], [Name], [TypeID], [TypeName], [Article], [CountOfPeople], [FactoryNumber], [MinPrice]) VALUES (14, N'Попрыгунчик для собачек 4387', 4, N' Упругий', 89607276, 3, 8, 912.0000)
INSERT [dbo].[ProductsShort] ([ID], [Name], [TypeID], [TypeName], [Article], [CountOfPeople], [FactoryNumber], [MinPrice]) VALUES (15, N'Попрыгун 3016', 5, N' Цифровой', 74919447, 1, 12, 615.0000)
INSERT [dbo].[ProductsShort] ([ID], [Name], [TypeID], [TypeName], [Article], [CountOfPeople], [FactoryNumber], [MinPrice]) VALUES (16, N'Попрыгунчик детский красный 3240', 2, N' Для больших деток', 88098604, 3, 8, 882.0000)
INSERT [dbo].[ProductsShort] ([ID], [Name], [TypeID], [TypeName], [Article], [CountOfPeople], [FactoryNumber], [MinPrice]) VALUES (17, N'Попрыгунчик детский розовый 1657', 3, N' Для маленьких деток', 86558177, 4, 3, 662.0000)
INSERT [dbo].[ProductsShort] ([ID], [Name], [TypeID], [TypeName], [Article], [CountOfPeople], [FactoryNumber], [MinPrice]) VALUES (18, N'Попрыгунчик детский красный 6591', 1, N' Взрослый', 79704172, 5, 7, 592.0000)
INSERT [dbo].[ProductsShort] ([ID], [Name], [TypeID], [TypeName], [Article], [CountOfPeople], [FactoryNumber], [MinPrice]) VALUES (19, N'Попрыгунчик для девочек 1895', 5, N' Цифровой', 54983244, 4, 4, 1586.0000)
INSERT [dbo].[ProductsShort] ([ID], [Name], [TypeID], [TypeName], [Article], [CountOfPeople], [FactoryNumber], [MinPrice]) VALUES (20, N'Попрыгунчик для кошечек 3741', 1, N' Взрослый', 43987093, 5, 4, 1668.0000)
INSERT [dbo].[ProductsShort] ([ID], [Name], [TypeID], [TypeName], [Article], [CountOfPeople], [FactoryNumber], [MinPrice]) VALUES (21, N'Попрыгунчик детский красный 3839', 2, N' Для больших деток', 26655484, 5, 2, 1921.0000)
INSERT [dbo].[ProductsShort] ([ID], [Name], [TypeID], [TypeName], [Article], [CountOfPeople], [FactoryNumber], [MinPrice]) VALUES (22, N'Попрыгунчик детский красный 4969', 3, N' Для маленьких деток', 10614909, 5, 12, 913.0000)
INSERT [dbo].[ProductsShort] ([ID], [Name], [TypeID], [TypeName], [Article], [CountOfPeople], [FactoryNumber], [MinPrice]) VALUES (23, N'Попрыгунчик для собачек 5754', 5, N' Цифровой', 79018408, 2, 8, 633.0000)
INSERT [dbo].[ProductsShort] ([ID], [Name], [TypeID], [TypeName], [Article], [CountOfPeople], [FactoryNumber], [MinPrice]) VALUES (24, N'Попрыгунчик для собачек 4485', 1, N' Взрослый', 33440129, 2, 12, 1995.0000)
INSERT [dbo].[ProductsShort] ([ID], [Name], [TypeID], [TypeName], [Article], [CountOfPeople], [FactoryNumber], [MinPrice]) VALUES (25, N'Попрыгунчик для девочек 1656', 5, N' Цифровой', 22217580, 5, 6, 1494.0000)
INSERT [dbo].[ProductsShort] ([ID], [Name], [TypeID], [TypeName], [Article], [CountOfPeople], [FactoryNumber], [MinPrice]) VALUES (26, N'Попрыгунчик для мальчиков 4791', 2, N' Для больших деток', 45540528, 3, 11, 1260.0000)
INSERT [dbo].[ProductsShort] ([ID], [Name], [TypeID], [TypeName], [Article], [CountOfPeople], [FactoryNumber], [MinPrice]) VALUES (27, N'Попрыгунчик для девочек 6849', 1, N' Взрослый', 10084400, 1, 11, 933.0000)
INSERT [dbo].[ProductsShort] ([ID], [Name], [TypeID], [TypeName], [Article], [CountOfPeople], [FactoryNumber], [MinPrice]) VALUES (28, N'Попрыгунчик детский желтый 1371', 5, N' Цифровой', 85514178, 3, 7, 252.0000)
INSERT [dbo].[ProductsShort] ([ID], [Name], [TypeID], [TypeName], [Article], [CountOfPeople], [FactoryNumber], [MinPrice]) VALUES (29, N'Попрыгунчик для девочек 3389', 1, N' Взрослый', 26434211, 3, 10, 597.0000)
INSERT [dbo].[ProductsShort] ([ID], [Name], [TypeID], [TypeName], [Article], [CountOfPeople], [FactoryNumber], [MinPrice]) VALUES (30, N'Попрыгунчик детский розовый 5197', 5, N' Цифровой', 89612317, 1, 3, 1948.0000)
INSERT [dbo].[ProductsShort] ([ID], [Name], [TypeID], [TypeName], [Article], [CountOfPeople], [FactoryNumber], [MinPrice]) VALUES (31, N'Попрыгунчик для собачек 3500', 2, N' Для больших деток', 79994924, 2, 9, 1142.0000)
INSERT [dbo].[ProductsShort] ([ID], [Name], [TypeID], [TypeName], [Article], [CountOfPeople], [FactoryNumber], [MinPrice]) VALUES (32, N'Попрыгун 6882', 4, N' Упругий', 12732041, 1, 6, 809.0000)
INSERT [dbo].[ProductsShort] ([ID], [Name], [TypeID], [TypeName], [Article], [CountOfPeople], [FactoryNumber], [MinPrice]) VALUES (33, N'Попрыгунчик для кошечек 4740', 4, N' Упругий', 80698285, 1, 6, 1973.0000)
INSERT [dbo].[ProductsShort] ([ID], [Name], [TypeID], [TypeName], [Article], [CountOfPeople], [FactoryNumber], [MinPrice]) VALUES (34, N'Шар 2243', 1, N' Взрослый', 42536654, 3, 12, 1247.0000)
INSERT [dbo].[ProductsShort] ([ID], [Name], [TypeID], [TypeName], [Article], [CountOfPeople], [FactoryNumber], [MinPrice]) VALUES (35, N'Попрыгунчик детский красный 1740', 1, N' Взрослый', 43330133, 5, 3, 1749.0000)
INSERT [dbo].[ProductsShort] ([ID], [Name], [TypeID], [TypeName], [Article], [CountOfPeople], [FactoryNumber], [MinPrice]) VALUES (36, N'Попрыгунчик детский красный 5400', 1, N' Взрослый', 68237918, 4, 5, 1570.0000)
INSERT [dbo].[ProductsShort] ([ID], [Name], [TypeID], [TypeName], [Article], [CountOfPeople], [FactoryNumber], [MinPrice]) VALUES (37, N'Попрыгунчик для девочек 1560', 3, N' Для маленьких деток', 47378395, 5, 6, 235.0000)
INSERT [dbo].[ProductsShort] ([ID], [Name], [TypeID], [TypeName], [Article], [CountOfPeople], [FactoryNumber], [MinPrice]) VALUES (38, N'Шар 4124', 5, N' Цифровой', 39025230, 5, 8, 1160.0000)
INSERT [dbo].[ProductsShort] ([ID], [Name], [TypeID], [TypeName], [Article], [CountOfPeople], [FactoryNumber], [MinPrice]) VALUES (39, N'Попрыгунчик детский желтый 2582', 1, N' Взрослый', 32125209, 3, 11, 1730.0000)
INSERT [dbo].[ProductsShort] ([ID], [Name], [TypeID], [TypeName], [Article], [CountOfPeople], [FactoryNumber], [MinPrice]) VALUES (40, N'Попрыгунчик детский 6029', 2, N' Для больших деток', 69184347, 3, 7, 419.0000)
INSERT [dbo].[ProductsShort] ([ID], [Name], [TypeID], [TypeName], [Article], [CountOfPeople], [FactoryNumber], [MinPrice]) VALUES (41, N'Попрыгун 2299', 1, N' Взрослый', 34750945, 2, 2, 1688.0000)
INSERT [dbo].[ProductsShort] ([ID], [Name], [TypeID], [TypeName], [Article], [CountOfPeople], [FactoryNumber], [MinPrice]) VALUES (42, N'Попрыгунчик детский красный 1972', 2, N' Для больших деток', 59509797, 1, 7, 794.0000)
INSERT [dbo].[ProductsShort] ([ID], [Name], [TypeID], [TypeName], [Article], [CountOfPeople], [FactoryNumber], [MinPrice]) VALUES (43, N'Попрыгунчик детский 5117', 2, N' Для больших деток', 80875656, 3, 12, 338.0000)
INSERT [dbo].[ProductsShort] ([ID], [Name], [TypeID], [TypeName], [Article], [CountOfPeople], [FactoryNumber], [MinPrice]) VALUES (44, N'Попрыгунчик детский розовый 5501', 1, N' Взрослый', 25409940, 2, 7, 652.0000)
INSERT [dbo].[ProductsShort] ([ID], [Name], [TypeID], [TypeName], [Article], [CountOfPeople], [FactoryNumber], [MinPrice]) VALUES (45, N'Попрыгунчик детский розовый 6346', 5, N' Цифровой', 30282346, 1, 10, 1024.0000)
INSERT [dbo].[ProductsShort] ([ID], [Name], [TypeID], [TypeName], [Article], [CountOfPeople], [FactoryNumber], [MinPrice]) VALUES (46, N'Попрыгун 6412', 2, N' Для больших деток', 28152672, 2, 9, 523.0000)
INSERT [dbo].[ProductsShort] ([ID], [Name], [TypeID], [TypeName], [Article], [CountOfPeople], [FactoryNumber], [MinPrice]) VALUES (47, N'Попрыгунчик детский 1916', 1, N' Взрослый', 73345857, 5, 8, 832.0000)
INSERT [dbo].[ProductsShort] ([ID], [Name], [TypeID], [TypeName], [Article], [CountOfPeople], [FactoryNumber], [MinPrice]) VALUES (48, N'Попрыгунчик для собачек 4529', 2, N' Для больших деток', 81713527, 3, 6, 1923.0000)
INSERT [dbo].[ProductsShort] ([ID], [Name], [TypeID], [TypeName], [Article], [CountOfPeople], [FactoryNumber], [MinPrice]) VALUES (49, N'Попрыгунчик для собачек 4381', 5, N' Цифровой', 27301447, 2, 5, 1234.0000)
INSERT [dbo].[ProductsShort] ([ID], [Name], [TypeID], [TypeName], [Article], [CountOfPeople], [FactoryNumber], [MinPrice]) VALUES (50, N'Попрыгунчик детский розовый 2694', 2, N' Для больших деток', 13340356, 4, 6, 1691.0000)
SET IDENTITY_INSERT [dbo].[ProductsShort] OFF
GO
SET IDENTITY_INSERT [dbo].[TypeOfAgents] ON 

INSERT [dbo].[TypeOfAgents] ([ID], [Name]) VALUES (1, N'ЗАО')
INSERT [dbo].[TypeOfAgents] ([ID], [Name]) VALUES (2, N'МКК')
INSERT [dbo].[TypeOfAgents] ([ID], [Name]) VALUES (3, N'МФО')
INSERT [dbo].[TypeOfAgents] ([ID], [Name]) VALUES (4, N'ОАО')
INSERT [dbo].[TypeOfAgents] ([ID], [Name]) VALUES (5, N'ООО')
INSERT [dbo].[TypeOfAgents] ([ID], [Name]) VALUES (6, N'ПАО')
SET IDENTITY_INSERT [dbo].[TypeOfAgents] OFF
GO
SET IDENTITY_INSERT [dbo].[TypeOfProducts] ON 

INSERT [dbo].[TypeOfProducts] ([ID], [Name]) VALUES (1, N' Взрослый')
INSERT [dbo].[TypeOfProducts] ([ID], [Name]) VALUES (2, N' Для больших деток')
INSERT [dbo].[TypeOfProducts] ([ID], [Name]) VALUES (3, N' Для маленьких деток')
INSERT [dbo].[TypeOfProducts] ([ID], [Name]) VALUES (4, N' Упругий')
INSERT [dbo].[TypeOfProducts] ([ID], [Name]) VALUES (5, N' Цифровой')
SET IDENTITY_INSERT [dbo].[TypeOfProducts] OFF
GO
ALTER TABLE [dbo].[Agents]  WITH CHECK ADD  CONSTRAINT [FK_Agents_TypeOfAgents] FOREIGN KEY([TypeID])
REFERENCES [dbo].[TypeOfAgents] ([ID])
GO
ALTER TABLE [dbo].[Agents] CHECK CONSTRAINT [FK_Agents_TypeOfAgents]
GO
ALTER TABLE [dbo].[ProductSale]  WITH CHECK ADD  CONSTRAINT [FK_ProductSale_Agents] FOREIGN KEY([AgentID])
REFERENCES [dbo].[Agents] ([ID])
GO
ALTER TABLE [dbo].[ProductSale] CHECK CONSTRAINT [FK_ProductSale_Agents]
GO
ALTER TABLE [dbo].[ProductSale]  WITH CHECK ADD  CONSTRAINT [FK_ProductSale_ProductsShort] FOREIGN KEY([ProductID])
REFERENCES [dbo].[ProductsShort] ([ID])
GO
ALTER TABLE [dbo].[ProductSale] CHECK CONSTRAINT [FK_ProductSale_ProductsShort]
GO
ALTER TABLE [dbo].[ProductsShort]  WITH CHECK ADD  CONSTRAINT [FK_ProductsShort_TypeOfProducts] FOREIGN KEY([TypeID])
REFERENCES [dbo].[TypeOfProducts] ([ID])
GO
ALTER TABLE [dbo].[ProductsShort] CHECK CONSTRAINT [FK_ProductsShort_TypeOfProducts]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[16] 2[17] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Agents_1"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 3765
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'VW_AgentDetails'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'VW_AgentDetails'
GO
USE [master]
GO
ALTER DATABASE [user2] SET  READ_WRITE 
GO
