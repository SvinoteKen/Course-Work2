USE [master]
GO
/****** Object:  Database [School]    Script Date: 02.12.2021 19:05:23 ******/
CREATE DATABASE [School]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'School', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\School.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'School_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\School_log.ldf' , SIZE = 73728KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [School] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [School].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [School] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [School] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [School] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [School] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [School] SET ARITHABORT OFF 
GO
ALTER DATABASE [School] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [School] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [School] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [School] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [School] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [School] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [School] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [School] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [School] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [School] SET  DISABLE_BROKER 
GO
ALTER DATABASE [School] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [School] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [School] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [School] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [School] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [School] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [School] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [School] SET RECOVERY FULL 
GO
ALTER DATABASE [School] SET  MULTI_USER 
GO
ALTER DATABASE [School] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [School] SET DB_CHAINING OFF 
GO
ALTER DATABASE [School] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [School] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [School] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [School] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'School', N'ON'
GO
ALTER DATABASE [School] SET QUERY_STORE = OFF
GO
USE [School]
GO
/****** Object:  Table [dbo].[Performance]    Script Date: 02.12.2021 19:05:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Performance](
	[ID_Perf] [int] IDENTITY(1,1) NOT NULL,
	[Pupil] [int] NULL,
	[Grade] [int] NULL,
	[Lesson] [int] NOT NULL,
	[Period] [int] NOT NULL,
	[Class] [int] NOT NULL,
 CONSTRAINT [PK_Performance] PRIMARY KEY CLUSTERED 
(
	[ID_Perf] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Pupils]    Script Date: 02.12.2021 19:05:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Pupils](
	[ID_Pupil] [int] IDENTITY(1,1) NOT NULL,
	[FullName] [nchar](30) NOT NULL,
	[BirthDate] [date] NOT NULL,
	[Years] [int] NOT NULL,
	[Class] [int] NOT NULL,
	[District] [nchar](15) NULL,
	[Social] [nchar](30) NULL,
	[Phone] [nchar](20) NULL,
	[DateOfReceipt] [date] NULL,
	[DateOfDisposal] [date] NULL,
	[Parent] [nchar](30) NULL,
	[PhoneParent] [nchar](15) NULL,
 CONSTRAINT [PK_Pupils] PRIMARY KEY CLUSTERED 
(
	[ID_Pupil] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Subject]    Script Date: 02.12.2021 19:05:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Subject](
	[ID_Subject] [int] NOT NULL,
	[Name] [nchar](20) NOT NULL,
 CONSTRAINT [PK_Lessons] PRIMARY KEY CLUSTERED 
(
	[ID_Subject] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[MinGrade2]    Script Date: 02.12.2021 19:05:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[MinGrade2]
AS
SELECT        TOP (100) PERCENT MIN(dbo.Performance.Grade) AS [Мин Оценка], dbo.Pupils.ID_Pupil, dbo.Subject.ID_Subject
FROM            dbo.Pupils INNER JOIN
                         dbo.Performance ON dbo.Pupils.ID_Pupil = dbo.Performance.Pupil INNER JOIN
                         dbo.Subject ON dbo.Performance.Lesson = dbo.Subject.ID_Subject
GROUP BY dbo.Pupils.ID_Pupil, dbo.Subject.ID_Subject
GO
/****** Object:  Table [dbo].[Class]    Script Date: 02.12.2021 19:05:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Class](
	[ID_Class] [int] NOT NULL,
	[Class] [int] NOT NULL,
	[SchoolYear] [int] NOT NULL,
	[ClassTeacher] [int] NOT NULL,
 CONSTRAINT [PK_Class] PRIMARY KEY CLUSTERED 
(
	[ID_Class] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[MinGrade]    Script Date: 02.12.2021 19:05:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[MinGrade]
AS
SELECT        TOP (100) PERCENT MIN(dbo.Performance.Grade) AS [Мин Оценка], dbo.Pupils.ID_Pupil, dbo.Class.ID_Class
FROM            dbo.Performance INNER JOIN
                         dbo.Pupils ON dbo.Performance.Pupil = dbo.Pupils.ID_Pupil INNER JOIN
                         dbo.Class ON dbo.Performance.Class = dbo.Class.ID_Class AND dbo.Pupils.Class = dbo.Class.ID_Class
GROUP BY dbo.Pupils.ID_Pupil, dbo.Class.ID_Class
GO
/****** Object:  View [dbo].[PerfomanceClass]    Script Date: 02.12.2021 19:05:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[PerfomanceClass]
AS
SELECT        dbo.Class.Class, CASE WHEN dbo.MinGrade.[Мин Оценка] = 2 THEN COUNT(dbo.MinGrade.ID_Pupil) END AS Низкий, CASE WHEN dbo.MinGrade.[Мин Оценка] = 3 THEN COUNT(dbo.MinGrade.ID_Pupil) END AS Средний, 
                         CASE WHEN dbo.MinGrade.[Мин Оценка] = 4 THEN COUNT(dbo.MinGrade.ID_Pupil) END AS Достаточный, CASE WHEN dbo.MinGrade.[Мин Оценка] = 5 THEN COUNT(dbo.MinGrade.ID_Pupil) END AS Высокий
FROM            dbo.MinGrade INNER JOIN
                         dbo.Class ON dbo.MinGrade.ID_Class = dbo.Class.ID_Class
GROUP BY dbo.MinGrade.[Мин Оценка], dbo.Class.Class
GO
/****** Object:  Table [dbo].[Period]    Script Date: 02.12.2021 19:05:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Period](
	[ID_Period] [int] NOT NULL,
	[Name] [nchar](20) NOT NULL,
 CONSTRAINT [PK_Period] PRIMARY KEY CLUSTERED 
(
	[ID_Period] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[PerfomancePupil]    Script Date: 02.12.2021 19:05:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[PerfomancePupil]
AS
SELECT        dbo.Pupils.FullName AS Учащийся, dbo.Performance.Grade AS Оценка, dbo.Subject.Name AS Предмет, Period_1.Name AS Период, dbo.Performance.Pupil
FROM            dbo.Class INNER JOIN
                         dbo.Performance ON dbo.Class.ID_Class = dbo.Performance.Class INNER JOIN
                         dbo.Period AS Period_1 ON dbo.Performance.Period = Period_1.ID_Period INNER JOIN
                         dbo.Subject ON dbo.Performance.Lesson = dbo.Subject.ID_Subject INNER JOIN
                         dbo.Pupils ON dbo.Performance.Pupil = dbo.Pupils.ID_Pupil
GO
/****** Object:  View [dbo].[PerfomanceSubject]    Script Date: 02.12.2021 19:05:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[PerfomanceSubject]
AS
SELECT        dbo.Subject.ID_Subject, CASE WHEN dbo.MinGrade2.[Мин Оценка] = 2 THEN COUNT(dbo.MinGrade2.ID_Pupil) END AS Низкий, CASE WHEN dbo.MinGrade2.[Мин Оценка] = 3 THEN COUNT(dbo.MinGrade2.ID_Pupil) 
                         END AS Средний, CASE WHEN dbo.MinGrade2.[Мин Оценка] = 4 THEN COUNT(dbo.MinGrade2.ID_Pupil) END AS Достаточный, CASE WHEN dbo.MinGrade2.[Мин Оценка] = 5 THEN COUNT(dbo.MinGrade2.ID_Pupil) 
                         END AS Высокий
FROM            dbo.MinGrade2 INNER JOIN
                         dbo.Subject ON dbo.MinGrade2.ID_Subject = dbo.Subject.ID_Subject
GROUP BY dbo.MinGrade2.[Мин Оценка], dbo.Subject.ID_Subject
GO
/****** Object:  View [dbo].[PerfomanceView]    Script Date: 02.12.2021 19:05:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[PerfomanceView]
AS
SELECT        dbo.Performance.ID_Perf, dbo.Pupils.FullName AS Учащийся, dbo.Performance.Grade AS Оценка, dbo.Subject.Name AS Предмет, dbo.Period.Name AS Период, dbo.Class.Class AS Класс
FROM            dbo.Performance INNER JOIN
                         dbo.Pupils ON dbo.Performance.Pupil = dbo.Pupils.ID_Pupil INNER JOIN
                         dbo.Subject ON dbo.Performance.Lesson = dbo.Subject.ID_Subject INNER JOIN
                         dbo.Period ON dbo.Performance.Period = dbo.Period.ID_Period INNER JOIN
                         dbo.Class ON dbo.Performance.Class = dbo.Class.ID_Class AND dbo.Pupils.Class = dbo.Class.ID_Class
GO
/****** Object:  Table [dbo].[Day]    Script Date: 02.12.2021 19:05:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Day](
	[ID_Day] [int] NOT NULL,
	[Day] [nchar](15) NULL,
 CONSTRAINT [PK_Day] PRIMARY KEY CLUSTERED 
(
	[ID_Day] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Events]    Script Date: 02.12.2021 19:05:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Events](
	[ID_Event] [int] IDENTITY(1,1) NOT NULL,
	[Post] [int] NOT NULL,
	[Importance] [nchar](20) NULL,
	[Term] [nchar](20) NOT NULL,
	[Place] [nchar](20) NOT NULL,
	[Information] [nchar](100) NOT NULL,
	[Type] [int] NOT NULL,
	[Mark] [bit] NULL,
 CONSTRAINT [PK_Event] PRIMARY KEY CLUSTERED 
(
	[ID_Event] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Schedule]    Script Date: 02.12.2021 19:05:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Schedule](
	[ID_Sched] [int] IDENTITY(1,1) NOT NULL,
	[Class] [int] NOT NULL,
	[Day] [int] NOT NULL,
	[Teacher] [int] NOT NULL,
	[Subjest] [int] NOT NULL,
	[Lesson] [int] NULL,
 CONSTRAINT [PK_Schedule] PRIMARY KEY CLUSTERED 
(
	[ID_Sched] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Teachers]    Script Date: 02.12.2021 19:05:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Teachers](
	[ID_Teach] [int] IDENTITY(1,1) NOT NULL,
	[FullName] [nchar](30) NOT NULL,
	[Post] [nchar](30) NOT NULL,
	[Rank] [nchar](10) NOT NULL,
	[BirthDate] [date] NOT NULL,
	[Years] [int] NOT NULL,
	[Experience] [int] NOT NULL,
	[YearOfCertification] [int] NULL,
	[YearOfCourses] [int] NULL,
	[Phone] [nchar](20) NULL,
	[Email] [nchar](35) NULL,
	[Load] [float] NULL,
	[VacationFrom] [date] NULL,
	[VacationTo] [date] NULL,
	[SickFrom] [date] NULL,
	[SickTo] [date] NULL,
 CONSTRAINT [PK_Teachers] PRIMARY KEY CLUSTERED 
(
	[ID_Teach] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TypeEvent]    Script Date: 02.12.2021 19:05:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TypeEvent](
	[ID_Type] [int] NOT NULL,
	[TypeName] [nchar](10) NULL,
 CONSTRAINT [PK_TypeEvent] PRIMARY KEY CLUSTERED 
(
	[ID_Type] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[Class] ([ID_Class], [Class], [SchoolYear], [ClassTeacher]) VALUES (1, 5, 2002, 1)
INSERT [dbo].[Class] ([ID_Class], [Class], [SchoolYear], [ClassTeacher]) VALUES (2, 6, 2002, 1)
INSERT [dbo].[Class] ([ID_Class], [Class], [SchoolYear], [ClassTeacher]) VALUES (3, 7, 2002, 1)
INSERT [dbo].[Class] ([ID_Class], [Class], [SchoolYear], [ClassTeacher]) VALUES (4, 8, 2002, 1)
INSERT [dbo].[Class] ([ID_Class], [Class], [SchoolYear], [ClassTeacher]) VALUES (5, 9, 2002, 1)
INSERT [dbo].[Class] ([ID_Class], [Class], [SchoolYear], [ClassTeacher]) VALUES (6, 10, 2002, 1)
INSERT [dbo].[Class] ([ID_Class], [Class], [SchoolYear], [ClassTeacher]) VALUES (7, 11, 2002, 1)
GO
INSERT [dbo].[Day] ([ID_Day], [Day]) VALUES (1, N'Понедельник    ')
INSERT [dbo].[Day] ([ID_Day], [Day]) VALUES (2, N'Вторник        ')
INSERT [dbo].[Day] ([ID_Day], [Day]) VALUES (3, N'Среда          ')
INSERT [dbo].[Day] ([ID_Day], [Day]) VALUES (4, N'Четверг        ')
INSERT [dbo].[Day] ([ID_Day], [Day]) VALUES (5, N'Пятница        ')
GO
SET IDENTITY_INSERT [dbo].[Events] ON 

INSERT [dbo].[Events] ([ID_Event], [Post], [Importance], [Term], [Place], [Information], [Type], [Mark]) VALUES (4, 1, N'Очень важно         ', N'4 дня               ', N'Актовый зал         ', N'Организовать праздник "День Школы"                                                                  ', 1, 0)
INSERT [dbo].[Events] ([ID_Event], [Post], [Importance], [Term], [Place], [Information], [Type], [Mark]) VALUES (5, 1, N'Срочно              ', N'в течении 5 дней    ', N'Школа               ', N'Пройти аттестацию                                                                                   ', 1, 0)
SET IDENTITY_INSERT [dbo].[Events] OFF
GO
SET IDENTITY_INSERT [dbo].[Performance] ON 

INSERT [dbo].[Performance] ([ID_Perf], [Pupil], [Grade], [Lesson], [Period], [Class]) VALUES (2, 5, 5, 3, 1, 1)
INSERT [dbo].[Performance] ([ID_Perf], [Pupil], [Grade], [Lesson], [Period], [Class]) VALUES (3, 5, 4, 2, 1, 1)
INSERT [dbo].[Performance] ([ID_Perf], [Pupil], [Grade], [Lesson], [Period], [Class]) VALUES (4, 7, 3, 1, 1, 1)
INSERT [dbo].[Performance] ([ID_Perf], [Pupil], [Grade], [Lesson], [Period], [Class]) VALUES (5, 7, 3, 2, 1, 1)
INSERT [dbo].[Performance] ([ID_Perf], [Pupil], [Grade], [Lesson], [Period], [Class]) VALUES (6, 8, 5, 1, 1, 1)
INSERT [dbo].[Performance] ([ID_Perf], [Pupil], [Grade], [Lesson], [Period], [Class]) VALUES (8, 9, 4, 3, 1, 2)
INSERT [dbo].[Performance] ([ID_Perf], [Pupil], [Grade], [Lesson], [Period], [Class]) VALUES (9, 8, 4, 1, 2, 1)
INSERT [dbo].[Performance] ([ID_Perf], [Pupil], [Grade], [Lesson], [Period], [Class]) VALUES (10, 7, 5, 2, 2, 1)
INSERT [dbo].[Performance] ([ID_Perf], [Pupil], [Grade], [Lesson], [Period], [Class]) VALUES (11, 9, 3, 3, 2, 2)
INSERT [dbo].[Performance] ([ID_Perf], [Pupil], [Grade], [Lesson], [Period], [Class]) VALUES (12, 10, 2, 1, 1, 2)
INSERT [dbo].[Performance] ([ID_Perf], [Pupil], [Grade], [Lesson], [Period], [Class]) VALUES (14, 10, 4, 2, 2, 2)
INSERT [dbo].[Performance] ([ID_Perf], [Pupil], [Grade], [Lesson], [Period], [Class]) VALUES (16, 11, 5, 3, 1, 2)
INSERT [dbo].[Performance] ([ID_Perf], [Pupil], [Grade], [Lesson], [Period], [Class]) VALUES (17, 11, 5, 2, 2, 3)
INSERT [dbo].[Performance] ([ID_Perf], [Pupil], [Grade], [Lesson], [Period], [Class]) VALUES (23, 5, 5, 4, 1, 1)
INSERT [dbo].[Performance] ([ID_Perf], [Pupil], [Grade], [Lesson], [Period], [Class]) VALUES (24, 5, 5, 1, 1, 1)
INSERT [dbo].[Performance] ([ID_Perf], [Pupil], [Grade], [Lesson], [Period], [Class]) VALUES (25, 5, 4, 5, 1, 1)
INSERT [dbo].[Performance] ([ID_Perf], [Pupil], [Grade], [Lesson], [Period], [Class]) VALUES (26, 5, 5, 6, 1, 1)
INSERT [dbo].[Performance] ([ID_Perf], [Pupil], [Grade], [Lesson], [Period], [Class]) VALUES (27, 5, 5, 1, 2, 1)
INSERT [dbo].[Performance] ([ID_Perf], [Pupil], [Grade], [Lesson], [Period], [Class]) VALUES (28, 5, 4, 2, 2, 1)
INSERT [dbo].[Performance] ([ID_Perf], [Pupil], [Grade], [Lesson], [Period], [Class]) VALUES (29, 5, 5, 3, 2, 1)
INSERT [dbo].[Performance] ([ID_Perf], [Pupil], [Grade], [Lesson], [Period], [Class]) VALUES (30, 5, 5, 4, 2, 1)
INSERT [dbo].[Performance] ([ID_Perf], [Pupil], [Grade], [Lesson], [Period], [Class]) VALUES (31, 5, 5, 5, 2, 1)
INSERT [dbo].[Performance] ([ID_Perf], [Pupil], [Grade], [Lesson], [Period], [Class]) VALUES (32, 5, 5, 6, 2, 1)
INSERT [dbo].[Performance] ([ID_Perf], [Pupil], [Grade], [Lesson], [Period], [Class]) VALUES (33, 7, 4, 1, 2, 1)
INSERT [dbo].[Performance] ([ID_Perf], [Pupil], [Grade], [Lesson], [Period], [Class]) VALUES (34, 7, 4, 3, 1, 1)
INSERT [dbo].[Performance] ([ID_Perf], [Pupil], [Grade], [Lesson], [Period], [Class]) VALUES (35, 7, 4, 3, 2, 1)
INSERT [dbo].[Performance] ([ID_Perf], [Pupil], [Grade], [Lesson], [Period], [Class]) VALUES (36, 7, 4, 4, 1, 1)
INSERT [dbo].[Performance] ([ID_Perf], [Pupil], [Grade], [Lesson], [Period], [Class]) VALUES (37, 7, 4, 4, 2, 1)
INSERT [dbo].[Performance] ([ID_Perf], [Pupil], [Grade], [Lesson], [Period], [Class]) VALUES (38, 7, 5, 5, 1, 1)
INSERT [dbo].[Performance] ([ID_Perf], [Pupil], [Grade], [Lesson], [Period], [Class]) VALUES (39, 7, 5, 5, 2, 1)
INSERT [dbo].[Performance] ([ID_Perf], [Pupil], [Grade], [Lesson], [Period], [Class]) VALUES (40, 7, 3, 6, 1, 1)
INSERT [dbo].[Performance] ([ID_Perf], [Pupil], [Grade], [Lesson], [Period], [Class]) VALUES (41, 7, 3, 6, 2, 1)
INSERT [dbo].[Performance] ([ID_Perf], [Pupil], [Grade], [Lesson], [Period], [Class]) VALUES (42, 8, 4, 1, 1, 1)
INSERT [dbo].[Performance] ([ID_Perf], [Pupil], [Grade], [Lesson], [Period], [Class]) VALUES (43, 8, 4, 2, 1, 1)
INSERT [dbo].[Performance] ([ID_Perf], [Pupil], [Grade], [Lesson], [Period], [Class]) VALUES (44, 8, 5, 2, 2, 1)
INSERT [dbo].[Performance] ([ID_Perf], [Pupil], [Grade], [Lesson], [Period], [Class]) VALUES (45, 8, 4, 3, 1, 1)
INSERT [dbo].[Performance] ([ID_Perf], [Pupil], [Grade], [Lesson], [Period], [Class]) VALUES (46, 8, 4, 3, 2, 1)
INSERT [dbo].[Performance] ([ID_Perf], [Pupil], [Grade], [Lesson], [Period], [Class]) VALUES (47, 8, 5, 4, 1, 1)
INSERT [dbo].[Performance] ([ID_Perf], [Pupil], [Grade], [Lesson], [Period], [Class]) VALUES (48, 8, 5, 4, 2, 1)
INSERT [dbo].[Performance] ([ID_Perf], [Pupil], [Grade], [Lesson], [Period], [Class]) VALUES (49, 8, 5, 5, 1, 1)
INSERT [dbo].[Performance] ([ID_Perf], [Pupil], [Grade], [Lesson], [Period], [Class]) VALUES (50, 8, 5, 5, 2, 1)
INSERT [dbo].[Performance] ([ID_Perf], [Pupil], [Grade], [Lesson], [Period], [Class]) VALUES (51, 8, 5, 6, 1, 1)
INSERT [dbo].[Performance] ([ID_Perf], [Pupil], [Grade], [Lesson], [Period], [Class]) VALUES (52, 8, 5, 6, 2, 1)
INSERT [dbo].[Performance] ([ID_Perf], [Pupil], [Grade], [Lesson], [Period], [Class]) VALUES (53, 9, 4, 1, 1, 1)
INSERT [dbo].[Performance] ([ID_Perf], [Pupil], [Grade], [Lesson], [Period], [Class]) VALUES (54, 9, 4, 1, 2, 1)
INSERT [dbo].[Performance] ([ID_Perf], [Pupil], [Grade], [Lesson], [Period], [Class]) VALUES (55, 9, 5, 2, 1, 1)
INSERT [dbo].[Performance] ([ID_Perf], [Pupil], [Grade], [Lesson], [Period], [Class]) VALUES (56, 9, 5, 2, 2, 1)
INSERT [dbo].[Performance] ([ID_Perf], [Pupil], [Grade], [Lesson], [Period], [Class]) VALUES (57, 9, 4, 4, 1, 1)
INSERT [dbo].[Performance] ([ID_Perf], [Pupil], [Grade], [Lesson], [Period], [Class]) VALUES (58, 9, 4, 1, 1, 2)
INSERT [dbo].[Performance] ([ID_Perf], [Pupil], [Grade], [Lesson], [Period], [Class]) VALUES (59, 9, 4, 1, 2, 2)
INSERT [dbo].[Performance] ([ID_Perf], [Pupil], [Grade], [Lesson], [Period], [Class]) VALUES (60, 9, 5, 2, 1, 2)
INSERT [dbo].[Performance] ([ID_Perf], [Pupil], [Grade], [Lesson], [Period], [Class]) VALUES (61, 9, 5, 2, 2, 2)
INSERT [dbo].[Performance] ([ID_Perf], [Pupil], [Grade], [Lesson], [Period], [Class]) VALUES (62, 9, 5, 4, 1, 2)
INSERT [dbo].[Performance] ([ID_Perf], [Pupil], [Grade], [Lesson], [Period], [Class]) VALUES (63, 9, 5, 4, 2, 2)
INSERT [dbo].[Performance] ([ID_Perf], [Pupil], [Grade], [Lesson], [Period], [Class]) VALUES (64, 9, 4, 5, 1, 2)
INSERT [dbo].[Performance] ([ID_Perf], [Pupil], [Grade], [Lesson], [Period], [Class]) VALUES (65, 9, 5, 5, 2, 2)
INSERT [dbo].[Performance] ([ID_Perf], [Pupil], [Grade], [Lesson], [Period], [Class]) VALUES (66, 9, 5, 6, 1, 2)
INSERT [dbo].[Performance] ([ID_Perf], [Pupil], [Grade], [Lesson], [Period], [Class]) VALUES (67, 9, 5, 6, 2, 2)
INSERT [dbo].[Performance] ([ID_Perf], [Pupil], [Grade], [Lesson], [Period], [Class]) VALUES (68, 10, 4, 1, 2, 2)
INSERT [dbo].[Performance] ([ID_Perf], [Pupil], [Grade], [Lesson], [Period], [Class]) VALUES (69, 10, 4, 2, 1, 2)
INSERT [dbo].[Performance] ([ID_Perf], [Pupil], [Grade], [Lesson], [Period], [Class]) VALUES (70, 10, 4, 3, 1, 2)
INSERT [dbo].[Performance] ([ID_Perf], [Pupil], [Grade], [Lesson], [Period], [Class]) VALUES (71, 10, 4, 3, 2, 2)
INSERT [dbo].[Performance] ([ID_Perf], [Pupil], [Grade], [Lesson], [Period], [Class]) VALUES (72, 10, 5, 4, 1, 2)
INSERT [dbo].[Performance] ([ID_Perf], [Pupil], [Grade], [Lesson], [Period], [Class]) VALUES (73, 10, 5, 4, 2, 2)
INSERT [dbo].[Performance] ([ID_Perf], [Pupil], [Grade], [Lesson], [Period], [Class]) VALUES (74, 10, 5, 5, 1, 2)
INSERT [dbo].[Performance] ([ID_Perf], [Pupil], [Grade], [Lesson], [Period], [Class]) VALUES (75, 10, 5, 5, 2, 2)
INSERT [dbo].[Performance] ([ID_Perf], [Pupil], [Grade], [Lesson], [Period], [Class]) VALUES (76, 10, 3, 6, 1, 2)
INSERT [dbo].[Performance] ([ID_Perf], [Pupil], [Grade], [Lesson], [Period], [Class]) VALUES (77, 10, 4, 6, 2, 2)
INSERT [dbo].[Performance] ([ID_Perf], [Pupil], [Grade], [Lesson], [Period], [Class]) VALUES (78, 11, 5, 3, 2, 2)
INSERT [dbo].[Performance] ([ID_Perf], [Pupil], [Grade], [Lesson], [Period], [Class]) VALUES (79, 11, 5, 1, 1, 2)
INSERT [dbo].[Performance] ([ID_Perf], [Pupil], [Grade], [Lesson], [Period], [Class]) VALUES (80, 11, 5, 1, 2, 2)
INSERT [dbo].[Performance] ([ID_Perf], [Pupil], [Grade], [Lesson], [Period], [Class]) VALUES (81, 11, 5, 2, 1, 2)
INSERT [dbo].[Performance] ([ID_Perf], [Pupil], [Grade], [Lesson], [Period], [Class]) VALUES (82, 11, 5, 2, 2, 2)
INSERT [dbo].[Performance] ([ID_Perf], [Pupil], [Grade], [Lesson], [Period], [Class]) VALUES (83, 11, 5, 4, 1, 2)
INSERT [dbo].[Performance] ([ID_Perf], [Pupil], [Grade], [Lesson], [Period], [Class]) VALUES (84, 11, 5, 4, 2, 2)
INSERT [dbo].[Performance] ([ID_Perf], [Pupil], [Grade], [Lesson], [Period], [Class]) VALUES (85, 11, 5, 5, 1, 2)
INSERT [dbo].[Performance] ([ID_Perf], [Pupil], [Grade], [Lesson], [Period], [Class]) VALUES (86, 11, 5, 5, 2, 2)
INSERT [dbo].[Performance] ([ID_Perf], [Pupil], [Grade], [Lesson], [Period], [Class]) VALUES (87, 11, 5, 6, 1, 2)
INSERT [dbo].[Performance] ([ID_Perf], [Pupil], [Grade], [Lesson], [Period], [Class]) VALUES (88, 11, 5, 6, 2, 2)
INSERT [dbo].[Performance] ([ID_Perf], [Pupil], [Grade], [Lesson], [Period], [Class]) VALUES (89, 12, 4, 1, 1, 3)
INSERT [dbo].[Performance] ([ID_Perf], [Pupil], [Grade], [Lesson], [Period], [Class]) VALUES (90, 12, 4, 1, 2, 3)
INSERT [dbo].[Performance] ([ID_Perf], [Pupil], [Grade], [Lesson], [Period], [Class]) VALUES (91, 12, 4, 2, 1, 3)
INSERT [dbo].[Performance] ([ID_Perf], [Pupil], [Grade], [Lesson], [Period], [Class]) VALUES (92, 12, 4, 2, 2, 3)
INSERT [dbo].[Performance] ([ID_Perf], [Pupil], [Grade], [Lesson], [Period], [Class]) VALUES (93, 12, 4, 3, 1, 3)
INSERT [dbo].[Performance] ([ID_Perf], [Pupil], [Grade], [Lesson], [Period], [Class]) VALUES (94, 12, 4, 3, 2, 3)
INSERT [dbo].[Performance] ([ID_Perf], [Pupil], [Grade], [Lesson], [Period], [Class]) VALUES (95, 12, 4, 4, 1, 3)
INSERT [dbo].[Performance] ([ID_Perf], [Pupil], [Grade], [Lesson], [Period], [Class]) VALUES (96, 12, 4, 4, 2, 3)
INSERT [dbo].[Performance] ([ID_Perf], [Pupil], [Grade], [Lesson], [Period], [Class]) VALUES (97, 12, 4, 9, 1, 3)
INSERT [dbo].[Performance] ([ID_Perf], [Pupil], [Grade], [Lesson], [Period], [Class]) VALUES (98, 12, 4, 9, 2, 3)
INSERT [dbo].[Performance] ([ID_Perf], [Pupil], [Grade], [Lesson], [Period], [Class]) VALUES (99, 12, 4, 6, 1, 3)
INSERT [dbo].[Performance] ([ID_Perf], [Pupil], [Grade], [Lesson], [Period], [Class]) VALUES (100, 12, 4, 6, 2, 3)
INSERT [dbo].[Performance] ([ID_Perf], [Pupil], [Grade], [Lesson], [Period], [Class]) VALUES (101, 13, 5, 1, 1, 3)
INSERT [dbo].[Performance] ([ID_Perf], [Pupil], [Grade], [Lesson], [Period], [Class]) VALUES (102, 13, 5, 1, 2, 3)
INSERT [dbo].[Performance] ([ID_Perf], [Pupil], [Grade], [Lesson], [Period], [Class]) VALUES (103, 13, 4, 2, 1, 3)
INSERT [dbo].[Performance] ([ID_Perf], [Pupil], [Grade], [Lesson], [Period], [Class]) VALUES (104, 13, 4, 2, 2, 3)
INSERT [dbo].[Performance] ([ID_Perf], [Pupil], [Grade], [Lesson], [Period], [Class]) VALUES (105, 13, 5, 3, 1, 3)
INSERT [dbo].[Performance] ([ID_Perf], [Pupil], [Grade], [Lesson], [Period], [Class]) VALUES (106, 13, 5, 3, 2, 3)
INSERT [dbo].[Performance] ([ID_Perf], [Pupil], [Grade], [Lesson], [Period], [Class]) VALUES (107, 13, 5, 4, 1, 3)
INSERT [dbo].[Performance] ([ID_Perf], [Pupil], [Grade], [Lesson], [Period], [Class]) VALUES (108, 13, 5, 4, 2, 3)
GO
INSERT [dbo].[Performance] ([ID_Perf], [Pupil], [Grade], [Lesson], [Period], [Class]) VALUES (109, 13, 5, 9, 1, 3)
INSERT [dbo].[Performance] ([ID_Perf], [Pupil], [Grade], [Lesson], [Period], [Class]) VALUES (110, 13, 5, 9, 2, 3)
INSERT [dbo].[Performance] ([ID_Perf], [Pupil], [Grade], [Lesson], [Period], [Class]) VALUES (111, 13, 5, 6, 1, 3)
INSERT [dbo].[Performance] ([ID_Perf], [Pupil], [Grade], [Lesson], [Period], [Class]) VALUES (112, 13, 5, 6, 2, 3)
INSERT [dbo].[Performance] ([ID_Perf], [Pupil], [Grade], [Lesson], [Period], [Class]) VALUES (113, 14, 3, 1, 1, 3)
INSERT [dbo].[Performance] ([ID_Perf], [Pupil], [Grade], [Lesson], [Period], [Class]) VALUES (114, 14, 3, 1, 2, 3)
INSERT [dbo].[Performance] ([ID_Perf], [Pupil], [Grade], [Lesson], [Period], [Class]) VALUES (115, 14, 3, 2, 1, 3)
INSERT [dbo].[Performance] ([ID_Perf], [Pupil], [Grade], [Lesson], [Period], [Class]) VALUES (116, 14, 3, 2, 2, 3)
INSERT [dbo].[Performance] ([ID_Perf], [Pupil], [Grade], [Lesson], [Period], [Class]) VALUES (117, 14, 3, 3, 1, 3)
INSERT [dbo].[Performance] ([ID_Perf], [Pupil], [Grade], [Lesson], [Period], [Class]) VALUES (118, 14, 3, 3, 2, 3)
INSERT [dbo].[Performance] ([ID_Perf], [Pupil], [Grade], [Lesson], [Period], [Class]) VALUES (119, 14, 3, 4, 1, 3)
INSERT [dbo].[Performance] ([ID_Perf], [Pupil], [Grade], [Lesson], [Period], [Class]) VALUES (120, 14, 3, 4, 2, 3)
INSERT [dbo].[Performance] ([ID_Perf], [Pupil], [Grade], [Lesson], [Period], [Class]) VALUES (121, 14, 3, 6, 1, 3)
INSERT [dbo].[Performance] ([ID_Perf], [Pupil], [Grade], [Lesson], [Period], [Class]) VALUES (122, 14, 3, 6, 2, 3)
INSERT [dbo].[Performance] ([ID_Perf], [Pupil], [Grade], [Lesson], [Period], [Class]) VALUES (123, 14, 3, 9, 1, 3)
INSERT [dbo].[Performance] ([ID_Perf], [Pupil], [Grade], [Lesson], [Period], [Class]) VALUES (124, 14, 3, 9, 2, 3)
SET IDENTITY_INSERT [dbo].[Performance] OFF
GO
INSERT [dbo].[Period] ([ID_Period], [Name]) VALUES (1, N'1 семестр           ')
INSERT [dbo].[Period] ([ID_Period], [Name]) VALUES (2, N'2 семестр           ')
INSERT [dbo].[Period] ([ID_Period], [Name]) VALUES (3, N'3 семестр           ')
INSERT [dbo].[Period] ([ID_Period], [Name]) VALUES (4, N'4 семестр           ')
GO
SET IDENTITY_INSERT [dbo].[Pupils] ON 

INSERT [dbo].[Pupils] ([ID_Pupil], [FullName], [BirthDate], [Years], [Class], [District], [Social], [Phone], [DateOfReceipt], [DateOfDisposal], [Parent], [PhoneParent]) VALUES (5, N'Игнатова Марина Леонидовна    ', CAST(N'2011-02-12' AS Date), 10, 1, N'Будённовский   ', N'Многодетные                   ', N'071-553-80-50       ', CAST(N'2021-08-05' AS Date), CAST(N'1900-01-01' AS Date), N'Игнатов Николай Святославович ', N'071-409-54-02  ')
INSERT [dbo].[Pupils] ([ID_Pupil], [FullName], [BirthDate], [Years], [Class], [District], [Social], [Phone], [DateOfReceipt], [DateOfDisposal], [Parent], [PhoneParent]) VALUES (7, N'Журавлёв Давид Миронович      ', CAST(N'2011-01-24' AS Date), 10, 1, N'Ворошиловский  ', N'Дети-сироты                   ', N'071-206-29-82       ', CAST(N'2021-08-06' AS Date), CAST(N'1900-01-01' AS Date), N'                              ', N'               ')
INSERT [dbo].[Pupils] ([ID_Pupil], [FullName], [BirthDate], [Years], [Class], [District], [Social], [Phone], [DateOfReceipt], [DateOfDisposal], [Parent], [PhoneParent]) VALUES (8, N'Минаева Варвара Викторовна    ', CAST(N'2011-05-01' AS Date), 10, 1, N'Калининский    ', N'                              ', N'071- 276-24-62      ', CAST(N'2021-07-28' AS Date), CAST(N'1900-01-01' AS Date), N'Минаева Злата Матвеевна       ', N'071-520-29-26  ')
INSERT [dbo].[Pupils] ([ID_Pupil], [FullName], [BirthDate], [Years], [Class], [District], [Social], [Phone], [DateOfReceipt], [DateOfDisposal], [Parent], [PhoneParent]) VALUES (9, N'Чапко Ева Олеговна            ', CAST(N'2010-11-25' AS Date), 11, 2, N'Киевский       ', N'                              ', N'071-628-85-94       ', CAST(N'2021-08-25' AS Date), CAST(N'1900-01-01' AS Date), N'Чапко Авдей Александрович     ', N'071-279-66-17  ')
INSERT [dbo].[Pupils] ([ID_Pupil], [FullName], [BirthDate], [Years], [Class], [District], [Social], [Phone], [DateOfReceipt], [DateOfDisposal], [Parent], [PhoneParent]) VALUES (10, N'Русина Лиана Викторовна       ', CAST(N'2010-01-18' AS Date), 11, 2, N'Ленинский      ', N'Талантливые и одаренные       ', N'071-013-09-48       ', CAST(N'2021-06-14' AS Date), CAST(N'1900-01-01' AS Date), N'Русина Василиса Виталиевна    ', N'071-461-16-06  ')
INSERT [dbo].[Pupils] ([ID_Pupil], [FullName], [BirthDate], [Years], [Class], [District], [Social], [Phone], [DateOfReceipt], [DateOfDisposal], [Parent], [PhoneParent]) VALUES (11, N'Рзаева Ева Ермаковна          ', CAST(N'2010-04-05' AS Date), 11, 2, N'Петровский     ', N'Малообеспеченные              ', N'071-881-00-97       ', CAST(N'2021-07-20' AS Date), CAST(N'1900-01-01' AS Date), N'Рзаев Евлампий Вадимович      ', N'071-961-85-77  ')
INSERT [dbo].[Pupils] ([ID_Pupil], [FullName], [BirthDate], [Years], [Class], [District], [Social], [Phone], [DateOfReceipt], [DateOfDisposal], [Parent], [PhoneParent]) VALUES (12, N'Сочинский Данила Викторович   ', CAST(N'2009-07-08' AS Date), 12, 3, N'Киевский       ', N'                              ', N'071-036-17-24       ', CAST(N'2021-07-11' AS Date), CAST(N'1900-01-01' AS Date), N'Сочинская Мирослава Федоровна ', N'071-834-69-33  ')
INSERT [dbo].[Pupils] ([ID_Pupil], [FullName], [BirthDate], [Years], [Class], [District], [Social], [Phone], [DateOfReceipt], [DateOfDisposal], [Parent], [PhoneParent]) VALUES (13, N'Романов Соломон Геннадиевич   ', CAST(N'2009-11-25' AS Date), 12, 3, N'Калининский    ', N'                              ', N'071-108-86-40       ', CAST(N'2021-08-06' AS Date), CAST(N'1900-01-01' AS Date), N'Романова Майя Михайловна      ', N'071-624-88-62  ')
INSERT [dbo].[Pupils] ([ID_Pupil], [FullName], [BirthDate], [Years], [Class], [District], [Social], [Phone], [DateOfReceipt], [DateOfDisposal], [Parent], [PhoneParent]) VALUES (14, N'Аверин Иван Альбертович       ', CAST(N'2009-09-01' AS Date), 12, 3, N'Ворошиловский  ', N'Переселенец                   ', N'071-098-93-77       ', CAST(N'2002-01-27' AS Date), CAST(N'1900-01-01' AS Date), N'Аверин Евлампий Борисович     ', N'071- 327-29-57 ')
SET IDENTITY_INSERT [dbo].[Pupils] OFF
GO
SET IDENTITY_INSERT [dbo].[Schedule] ON 

INSERT [dbo].[Schedule] ([ID_Sched], [Class], [Day], [Teacher], [Subjest], [Lesson]) VALUES (1, 1, 1, 1, 1, 1)
INSERT [dbo].[Schedule] ([ID_Sched], [Class], [Day], [Teacher], [Subjest], [Lesson]) VALUES (2, 1, 1, 7, 2, 2)
INSERT [dbo].[Schedule] ([ID_Sched], [Class], [Day], [Teacher], [Subjest], [Lesson]) VALUES (3, 1, 1, 9, 3, 3)
INSERT [dbo].[Schedule] ([ID_Sched], [Class], [Day], [Teacher], [Subjest], [Lesson]) VALUES (9, 1, 1, 9, 3, 4)
INSERT [dbo].[Schedule] ([ID_Sched], [Class], [Day], [Teacher], [Subjest], [Lesson]) VALUES (10, 1, 2, 7, 2, 1)
INSERT [dbo].[Schedule] ([ID_Sched], [Class], [Day], [Teacher], [Subjest], [Lesson]) VALUES (11, 1, 2, 10, 5, 2)
INSERT [dbo].[Schedule] ([ID_Sched], [Class], [Day], [Teacher], [Subjest], [Lesson]) VALUES (12, 1, 2, 9, 3, 3)
INSERT [dbo].[Schedule] ([ID_Sched], [Class], [Day], [Teacher], [Subjest], [Lesson]) VALUES (13, 1, 2, 7, 4, 4)
INSERT [dbo].[Schedule] ([ID_Sched], [Class], [Day], [Teacher], [Subjest], [Lesson]) VALUES (14, 1, 3, 11, 6, 1)
INSERT [dbo].[Schedule] ([ID_Sched], [Class], [Day], [Teacher], [Subjest], [Lesson]) VALUES (15, 1, 3, 7, 2, 2)
INSERT [dbo].[Schedule] ([ID_Sched], [Class], [Day], [Teacher], [Subjest], [Lesson]) VALUES (16, 1, 3, 1, 1, 3)
INSERT [dbo].[Schedule] ([ID_Sched], [Class], [Day], [Teacher], [Subjest], [Lesson]) VALUES (17, 1, 3, 10, 5, 4)
INSERT [dbo].[Schedule] ([ID_Sched], [Class], [Day], [Teacher], [Subjest], [Lesson]) VALUES (18, 2, 1, 7, 2, 1)
INSERT [dbo].[Schedule] ([ID_Sched], [Class], [Day], [Teacher], [Subjest], [Lesson]) VALUES (19, 2, 1, 1, 1, 2)
INSERT [dbo].[Schedule] ([ID_Sched], [Class], [Day], [Teacher], [Subjest], [Lesson]) VALUES (20, 2, 1, 10, 5, 3)
INSERT [dbo].[Schedule] ([ID_Sched], [Class], [Day], [Teacher], [Subjest], [Lesson]) VALUES (21, 2, 1, 7, 4, 4)
INSERT [dbo].[Schedule] ([ID_Sched], [Class], [Day], [Teacher], [Subjest], [Lesson]) VALUES (22, 2, 2, 9, 3, 1)
INSERT [dbo].[Schedule] ([ID_Sched], [Class], [Day], [Teacher], [Subjest], [Lesson]) VALUES (23, 2, 2, 9, 3, 2)
INSERT [dbo].[Schedule] ([ID_Sched], [Class], [Day], [Teacher], [Subjest], [Lesson]) VALUES (24, 2, 2, 11, 6, 3)
INSERT [dbo].[Schedule] ([ID_Sched], [Class], [Day], [Teacher], [Subjest], [Lesson]) VALUES (25, 2, 2, 10, 5, 4)
INSERT [dbo].[Schedule] ([ID_Sched], [Class], [Day], [Teacher], [Subjest], [Lesson]) VALUES (26, 2, 3, 1, 1, 1)
INSERT [dbo].[Schedule] ([ID_Sched], [Class], [Day], [Teacher], [Subjest], [Lesson]) VALUES (27, 2, 3, 1, 1, 2)
INSERT [dbo].[Schedule] ([ID_Sched], [Class], [Day], [Teacher], [Subjest], [Lesson]) VALUES (28, 2, 3, 7, 2, 3)
INSERT [dbo].[Schedule] ([ID_Sched], [Class], [Day], [Teacher], [Subjest], [Lesson]) VALUES (29, 2, 3, 11, 6, 4)
INSERT [dbo].[Schedule] ([ID_Sched], [Class], [Day], [Teacher], [Subjest], [Lesson]) VALUES (30, 3, 1, 10, 5, 1)
INSERT [dbo].[Schedule] ([ID_Sched], [Class], [Day], [Teacher], [Subjest], [Lesson]) VALUES (31, 3, 1, 9, 3, 2)
INSERT [dbo].[Schedule] ([ID_Sched], [Class], [Day], [Teacher], [Subjest], [Lesson]) VALUES (32, 3, 1, 12, 9, 3)
INSERT [dbo].[Schedule] ([ID_Sched], [Class], [Day], [Teacher], [Subjest], [Lesson]) VALUES (33, 3, 1, 1, 1, 4)
INSERT [dbo].[Schedule] ([ID_Sched], [Class], [Day], [Teacher], [Subjest], [Lesson]) VALUES (34, 3, 1, 11, 6, 1)
INSERT [dbo].[Schedule] ([ID_Sched], [Class], [Day], [Teacher], [Subjest], [Lesson]) VALUES (35, 3, 2, 11, 6, 1)
INSERT [dbo].[Schedule] ([ID_Sched], [Class], [Day], [Teacher], [Subjest], [Lesson]) VALUES (36, 3, 2, 7, 2, 2)
INSERT [dbo].[Schedule] ([ID_Sched], [Class], [Day], [Teacher], [Subjest], [Lesson]) VALUES (37, 3, 2, 1, 1, 3)
INSERT [dbo].[Schedule] ([ID_Sched], [Class], [Day], [Teacher], [Subjest], [Lesson]) VALUES (38, 3, 2, 9, 3, 4)
INSERT [dbo].[Schedule] ([ID_Sched], [Class], [Day], [Teacher], [Subjest], [Lesson]) VALUES (39, 3, 3, 7, 4, 1)
INSERT [dbo].[Schedule] ([ID_Sched], [Class], [Day], [Teacher], [Subjest], [Lesson]) VALUES (40, 3, 3, 12, 9, 2)
INSERT [dbo].[Schedule] ([ID_Sched], [Class], [Day], [Teacher], [Subjest], [Lesson]) VALUES (41, 3, 3, 9, 3, 3)
INSERT [dbo].[Schedule] ([ID_Sched], [Class], [Day], [Teacher], [Subjest], [Lesson]) VALUES (42, 3, 3, 1, 1, 4)
SET IDENTITY_INSERT [dbo].[Schedule] OFF
GO
INSERT [dbo].[Subject] ([ID_Subject], [Name]) VALUES (1, N'Математика          ')
INSERT [dbo].[Subject] ([ID_Subject], [Name]) VALUES (2, N'Русский язык        ')
INSERT [dbo].[Subject] ([ID_Subject], [Name]) VALUES (3, N'Английский          ')
INSERT [dbo].[Subject] ([ID_Subject], [Name]) VALUES (4, N'Литература          ')
INSERT [dbo].[Subject] ([ID_Subject], [Name]) VALUES (5, N'Физра               ')
INSERT [dbo].[Subject] ([ID_Subject], [Name]) VALUES (6, N'История             ')
INSERT [dbo].[Subject] ([ID_Subject], [Name]) VALUES (7, N'Физика              ')
INSERT [dbo].[Subject] ([ID_Subject], [Name]) VALUES (8, N'Химия               ')
INSERT [dbo].[Subject] ([ID_Subject], [Name]) VALUES (9, N'География           ')
GO
SET IDENTITY_INSERT [dbo].[Teachers] ON 

INSERT [dbo].[Teachers] ([ID_Teach], [FullName], [Post], [Rank], [BirthDate], [Years], [Experience], [YearOfCertification], [YearOfCourses], [Phone], [Email], [Load], [VacationFrom], [VacationTo], [SickFrom], [SickTo]) VALUES (1, N'Маслова Меланья Кирилловна    ', N'Учитель математики            ', N'Высшая    ', CAST(N'1995-09-12' AS Date), 26, 5, 2019, 2020, N'071-315-76-52       ', N'queikebehauka-5117@yopmail.com     ', 3.5, CAST(N'2022-06-12' AS Date), CAST(N'2022-06-30' AS Date), CAST(N'2022-06-12' AS Date), CAST(N'2022-06-30' AS Date))
INSERT [dbo].[Teachers] ([ID_Teach], [FullName], [Post], [Rank], [BirthDate], [Years], [Experience], [YearOfCertification], [YearOfCourses], [Phone], [Email], [Load], [VacationFrom], [VacationTo], [SickFrom], [SickTo]) VALUES (6, N'Соловьев Петр Семенович       ', N'Учитель физики                ', N'Высшая    ', CAST(N'1993-10-12' AS Date), 28, 5, 2020, 2018, N'                    ', N'                                   ', 4, CAST(N'2021-10-26' AS Date), CAST(N'2021-11-27' AS Date), CAST(N'2021-10-26' AS Date), CAST(N'2021-11-27' AS Date))
INSERT [dbo].[Teachers] ([ID_Teach], [FullName], [Post], [Rank], [BirthDate], [Years], [Experience], [YearOfCertification], [YearOfCourses], [Phone], [Email], [Load], [VacationFrom], [VacationTo], [SickFrom], [SickTo]) VALUES (7, N'Денисова Кира Тарасовна       ', N'Учитель русского              ', N'Высшая    ', CAST(N'1991-08-16' AS Date), 31, 8, 2020, 2021, N'                    ', N'                                   ', 7, CAST(N'2021-10-26' AS Date), CAST(N'2021-10-27' AS Date), CAST(N'2021-10-26' AS Date), CAST(N'2021-10-27' AS Date))
INSERT [dbo].[Teachers] ([ID_Teach], [FullName], [Post], [Rank], [BirthDate], [Years], [Experience], [YearOfCertification], [YearOfCourses], [Phone], [Email], [Load], [VacationFrom], [VacationTo], [SickFrom], [SickTo]) VALUES (8, N'Наварская Берта Геннадиевна   ', N'Учитель химии                 ', N'Высшая    ', CAST(N'1982-10-27' AS Date), 39, 11, 2018, 20019, N'                    ', N'                                   ', 4, CAST(N'2021-10-27' AS Date), CAST(N'2021-11-28' AS Date), CAST(N'2021-10-27' AS Date), CAST(N'2021-11-28' AS Date))
INSERT [dbo].[Teachers] ([ID_Teach], [FullName], [Post], [Rank], [BirthDate], [Years], [Experience], [YearOfCertification], [YearOfCourses], [Phone], [Email], [Load], [VacationFrom], [VacationTo], [SickFrom], [SickTo]) VALUES (9, N'Панченко Инесса Петровна      ', N'Учитель английского           ', N'Высшая    ', CAST(N'1987-09-27' AS Date), 34, 12, 2020, 2019, N'                    ', N'                                   ', 5, CAST(N'2021-06-28' AS Date), CAST(N'2021-07-28' AS Date), CAST(N'2021-06-28' AS Date), CAST(N'2021-07-28' AS Date))
INSERT [dbo].[Teachers] ([ID_Teach], [FullName], [Post], [Rank], [BirthDate], [Years], [Experience], [YearOfCertification], [YearOfCourses], [Phone], [Email], [Load], [VacationFrom], [VacationTo], [SickFrom], [SickTo]) VALUES (10, N'Фомин Селиверст Павлович      ', N'Учитель физкультуры           ', N'Высшая    ', CAST(N'1977-11-14' AS Date), 44, 15, 2019, 2020, N'                    ', N'                                   ', 8, CAST(N'2021-07-27' AS Date), CAST(N'2021-08-08' AS Date), CAST(N'2021-07-27' AS Date), CAST(N'2021-08-08' AS Date))
INSERT [dbo].[Teachers] ([ID_Teach], [FullName], [Post], [Rank], [BirthDate], [Years], [Experience], [YearOfCertification], [YearOfCourses], [Phone], [Email], [Load], [VacationFrom], [VacationTo], [SickFrom], [SickTo]) VALUES (11, N'Ржевская Федосья Юрьевна      ', N'Учитель истории               ', N'Высшая    ', CAST(N'1983-07-23' AS Date), 38, 14, 2020, 2021, N'                    ', N'                                   ', 4, CAST(N'2021-07-23' AS Date), CAST(N'2021-08-05' AS Date), CAST(N'2021-07-23' AS Date), CAST(N'2021-08-05' AS Date))
INSERT [dbo].[Teachers] ([ID_Teach], [FullName], [Post], [Rank], [BirthDate], [Years], [Experience], [YearOfCertification], [YearOfCourses], [Phone], [Email], [Load], [VacationFrom], [VacationTo], [SickFrom], [SickTo]) VALUES (12, N'Воронин Мартьян Антонович     ', N'Учитель география             ', N'Высшая    ', CAST(N'1981-11-02' AS Date), 40, 16, 2019, 2020, N'                    ', N'                                   ', 6, CAST(N'2021-07-05' AS Date), CAST(N'2021-07-15' AS Date), CAST(N'2021-07-05' AS Date), CAST(N'2021-07-15' AS Date))
SET IDENTITY_INSERT [dbo].[Teachers] OFF
GO
INSERT [dbo].[TypeEvent] ([ID_Type], [TypeName]) VALUES (1, N'Задача    ')
INSERT [dbo].[TypeEvent] ([ID_Type], [TypeName]) VALUES (2, N'Событие   ')
GO
ALTER TABLE [dbo].[Class] ADD  CONSTRAINT [DF_Class_ClassTeacher]  DEFAULT ((1)) FOR [ClassTeacher]
GO
ALTER TABLE [dbo].[Events] ADD  CONSTRAINT [DF_Event_Type]  DEFAULT ((1)) FOR [Type]
GO
ALTER TABLE [dbo].[Events] ADD  CONSTRAINT [DF_Events_Mark]  DEFAULT ((0)) FOR [Mark]
GO
ALTER TABLE [dbo].[Class]  WITH CHECK ADD  CONSTRAINT [FK_ClassTeacher] FOREIGN KEY([ClassTeacher])
REFERENCES [dbo].[Teachers] ([ID_Teach])
ON DELETE SET DEFAULT
GO
ALTER TABLE [dbo].[Class] CHECK CONSTRAINT [FK_ClassTeacher]
GO
ALTER TABLE [dbo].[Events]  WITH CHECK ADD  CONSTRAINT [FK_Event_Teachers] FOREIGN KEY([Post])
REFERENCES [dbo].[Teachers] ([ID_Teach])
GO
ALTER TABLE [dbo].[Events] CHECK CONSTRAINT [FK_Event_Teachers]
GO
ALTER TABLE [dbo].[Events]  WITH CHECK ADD  CONSTRAINT [FK_Event_Type] FOREIGN KEY([Type])
REFERENCES [dbo].[TypeEvent] ([ID_Type])
GO
ALTER TABLE [dbo].[Events] CHECK CONSTRAINT [FK_Event_Type]
GO
ALTER TABLE [dbo].[Performance]  WITH CHECK ADD  CONSTRAINT [FK_Performance_Class] FOREIGN KEY([Class])
REFERENCES [dbo].[Class] ([ID_Class])
GO
ALTER TABLE [dbo].[Performance] CHECK CONSTRAINT [FK_Performance_Class]
GO
ALTER TABLE [dbo].[Performance]  WITH CHECK ADD  CONSTRAINT [FK_Performance_Lesson] FOREIGN KEY([Lesson])
REFERENCES [dbo].[Subject] ([ID_Subject])
GO
ALTER TABLE [dbo].[Performance] CHECK CONSTRAINT [FK_Performance_Lesson]
GO
ALTER TABLE [dbo].[Performance]  WITH CHECK ADD  CONSTRAINT [FK_Performance_Period] FOREIGN KEY([Period])
REFERENCES [dbo].[Period] ([ID_Period])
GO
ALTER TABLE [dbo].[Performance] CHECK CONSTRAINT [FK_Performance_Period]
GO
ALTER TABLE [dbo].[Performance]  WITH CHECK ADD  CONSTRAINT [FK_Performance_Pupil] FOREIGN KEY([Pupil])
REFERENCES [dbo].[Pupils] ([ID_Pupil])
GO
ALTER TABLE [dbo].[Performance] CHECK CONSTRAINT [FK_Performance_Pupil]
GO
ALTER TABLE [dbo].[Pupils]  WITH CHECK ADD  CONSTRAINT [FK_Pupils_Class] FOREIGN KEY([Class])
REFERENCES [dbo].[Class] ([ID_Class])
GO
ALTER TABLE [dbo].[Pupils] CHECK CONSTRAINT [FK_Pupils_Class]
GO
ALTER TABLE [dbo].[Schedule]  WITH CHECK ADD  CONSTRAINT [FK_Schedule_Class] FOREIGN KEY([Class])
REFERENCES [dbo].[Class] ([ID_Class])
GO
ALTER TABLE [dbo].[Schedule] CHECK CONSTRAINT [FK_Schedule_Class]
GO
ALTER TABLE [dbo].[Schedule]  WITH CHECK ADD  CONSTRAINT [FK_Schedule_Day] FOREIGN KEY([Day])
REFERENCES [dbo].[Day] ([ID_Day])
GO
ALTER TABLE [dbo].[Schedule] CHECK CONSTRAINT [FK_Schedule_Day]
GO
ALTER TABLE [dbo].[Schedule]  WITH CHECK ADD  CONSTRAINT [FK_Schedule_Subject] FOREIGN KEY([Subjest])
REFERENCES [dbo].[Subject] ([ID_Subject])
GO
ALTER TABLE [dbo].[Schedule] CHECK CONSTRAINT [FK_Schedule_Subject]
GO
ALTER TABLE [dbo].[Schedule]  WITH CHECK ADD  CONSTRAINT [FK_Schedule_Teacher] FOREIGN KEY([Teacher])
REFERENCES [dbo].[Teachers] ([ID_Teach])
GO
ALTER TABLE [dbo].[Schedule] CHECK CONSTRAINT [FK_Schedule_Teacher]
GO
ALTER TABLE [dbo].[Pupils]  WITH CHECK ADD  CONSTRAINT [CK_Receipt] CHECK  (([DateOfDisposal]=NULL OR [DateOfReceipt]<[DateOfDisposal]))
GO
ALTER TABLE [dbo].[Pupils] CHECK CONSTRAINT [CK_Receipt]
GO
ALTER TABLE [dbo].[Teachers]  WITH CHECK ADD  CONSTRAINT [CK_Sick] CHECK  (([SickFrom]<[SickTo]))
GO
ALTER TABLE [dbo].[Teachers] CHECK CONSTRAINT [CK_Sick]
GO
ALTER TABLE [dbo].[Teachers]  WITH CHECK ADD  CONSTRAINT [CK_Vacation] CHECK  (([VacationTo]>[VacationFrom]))
GO
ALTER TABLE [dbo].[Teachers] CHECK CONSTRAINT [CK_Vacation]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
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
         Begin Table = "Performance"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 228
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Pupils"
            Begin Extent = 
               Top = 2
               Left = 333
               Bottom = 132
               Right = 523
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Class"
            Begin Extent = 
               Top = 150
               Left = 623
               Bottom = 280
               Right = 813
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
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
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
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'MinGrade'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'MinGrade'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
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
         Begin Table = "Pupils"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 212
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Performance"
            Begin Extent = 
               Top = 6
               Left = 250
               Bottom = 136
               Right = 424
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Subject"
            Begin Extent = 
               Top = 6
               Left = 462
               Bottom = 102
               Right = 636
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
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
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
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'MinGrade2'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'MinGrade2'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
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
         Begin Table = "MinGrade"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 228
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Class"
            Begin Extent = 
               Top = 6
               Left = 494
               Bottom = 136
               Right = 684
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
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
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
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'PerfomanceClass'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'PerfomanceClass'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
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
         Begin Table = "Period_1"
            Begin Extent = 
               Top = 208
               Left = 145
               Bottom = 304
               Right = 319
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Subject"
            Begin Extent = 
               Top = 6
               Left = 465
               Bottom = 102
               Right = 639
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Class"
            Begin Extent = 
               Top = 155
               Left = 483
               Bottom = 285
               Right = 657
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Pupils"
            Begin Extent = 
               Top = 6
               Left = 250
               Bottom = 136
               Right = 424
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Performance"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 212
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
         Or = 1350
         Or = 1350
         Or = 13' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'PerfomancePupil'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'50
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'PerfomancePupil'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'PerfomancePupil'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
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
         Begin Table = "Subject"
            Begin Extent = 
               Top = 22
               Left = 411
               Bottom = 118
               Right = 585
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "MinGrade2"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 119
               Right = 212
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
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
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
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'PerfomanceSubject'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'PerfomanceSubject'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
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
         Begin Table = "Subject"
            Begin Extent = 
               Top = 212
               Left = 201
               Bottom = 308
               Right = 375
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Period"
            Begin Extent = 
               Top = 6
               Left = 674
               Bottom = 102
               Right = 848
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Class"
            Begin Extent = 
               Top = 157
               Left = 468
               Bottom = 287
               Right = 642
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Pupils"
            Begin Extent = 
               Top = 6
               Left = 250
               Bottom = 136
               Right = 424
            End
            DisplayFlags = 280
            TopColumn = 2
         End
         Begin Table = "Performance"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 212
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
         Or = 1350
         Or = 1350
         Or = 1350' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'PerfomanceView'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'PerfomanceView'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'PerfomanceView'
GO
USE [master]
GO
ALTER DATABASE [School] SET  READ_WRITE 
GO
