USE [master]
GO
/****** Object:  Database [ExpenseTracker]    Script Date: 4/21/2025 11:17:20 PM ******/
CREATE DATABASE [ExpenseTracker]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'ExpenseTracker', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\ExpenseTracker.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'ExpenseTracker_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\ExpenseTracker_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [ExpenseTracker] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [ExpenseTracker].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [ExpenseTracker] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [ExpenseTracker] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [ExpenseTracker] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [ExpenseTracker] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [ExpenseTracker] SET ARITHABORT OFF 
GO
ALTER DATABASE [ExpenseTracker] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [ExpenseTracker] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [ExpenseTracker] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [ExpenseTracker] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [ExpenseTracker] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [ExpenseTracker] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [ExpenseTracker] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [ExpenseTracker] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [ExpenseTracker] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [ExpenseTracker] SET  DISABLE_BROKER 
GO
ALTER DATABASE [ExpenseTracker] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [ExpenseTracker] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [ExpenseTracker] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [ExpenseTracker] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [ExpenseTracker] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [ExpenseTracker] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [ExpenseTracker] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [ExpenseTracker] SET RECOVERY FULL 
GO
ALTER DATABASE [ExpenseTracker] SET  MULTI_USER 
GO
ALTER DATABASE [ExpenseTracker] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [ExpenseTracker] SET DB_CHAINING OFF 
GO
ALTER DATABASE [ExpenseTracker] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [ExpenseTracker] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [ExpenseTracker] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [ExpenseTracker] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'ExpenseTracker', N'ON'
GO
ALTER DATABASE [ExpenseTracker] SET QUERY_STORE = ON
GO
ALTER DATABASE [ExpenseTracker] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [ExpenseTracker]
GO
/****** Object:  Table [dbo].[Expenses]    Script Date: 4/21/2025 11:17:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Expenses](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[date] [date] NOT NULL,
	[description] [nvarchar](255) NOT NULL,
	[category] [nvarchar](50) NOT NULL,
	[amount] [float] NOT NULL,
	[username] [nvarchar](100) NOT NULL,
	[updated_at] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserAudit]    Script Date: 4/21/2025 11:17:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserAudit](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[username] [nvarchar](50) NOT NULL,
	[deleted_at] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 4/21/2025 11:17:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[username] [nvarchar](50) NOT NULL,
	[role] [nvarchar](100) NOT NULL,
	[password] [varbinary](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Expenses] ADD  DEFAULT ('system') FOR [username]
GO
ALTER TABLE [dbo].[Expenses] ADD  DEFAULT (getdate()) FOR [updated_at]
GO
ALTER TABLE [dbo].[Users] ADD  DEFAULT ('user') FOR [role]
GO
/****** Object:  StoredProcedure [dbo].[AddExpense]    Script Date: 4/21/2025 11:17:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AddExpense]
    @date DATE,
    @description NVARCHAR(255),
    @category NVARCHAR(50),
    @amount FLOAT,
    @username NVARCHAR(50)
AS
BEGIN
    INSERT INTO Expenses (date, description, category, amount, username)
    VALUES (@date, @description, @category, @amount, @username);
END;
GO
/****** Object:  StoredProcedure [dbo].[DeleteExpense]    Script Date: 4/21/2025 11:17:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DeleteExpense]
    @ExpenseID INT,
    @Username NVARCHAR(50)
AS
BEGIN
    DELETE FROM Expenses
    WHERE id = @ExpenseID AND username = @Username;
END
GO
/****** Object:  StoredProcedure [dbo].[DeleteUserAndExpenses]    Script Date: 4/21/2025 11:17:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DeleteUserAndExpenses]
    @username NVARCHAR(50)
AS
BEGIN
    DELETE FROM Expenses WHERE username = @username;
    DELETE FROM Users WHERE username = @username;
END
GO
/****** Object:  StoredProcedure [dbo].[GetAllExpenses]    Script Date: 4/21/2025 11:17:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetAllExpenses]
AS
BEGIN
    SELECT * FROM Expenses ORDER BY date DESC, id DESC;
END
GO
/****** Object:  StoredProcedure [dbo].[GetExpensesByUser]    Script Date: 4/21/2025 11:17:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetExpensesByUser]
    @username NVARCHAR(50)
AS
BEGIN
    SELECT * FROM Expenses
    WHERE username = @username
    ORDER BY date DESC, id DESC;
END;
GO
USE [master]
GO
ALTER DATABASE [ExpenseTracker] SET  READ_WRITE 
GO
