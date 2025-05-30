USE [ExpenseTracker]
GO
/****** Object:  Table [dbo].[Expenses]    Script Date: 4/7/2025 8:51:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Expenses](
	[id] [int] IDENTITY(1,1) NOT NULL,
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
/****** Object:  Table [dbo].[Users]    Script Date: 4/7/2025 8:51:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[id] [int] IDENTITY(1,1) NOT NULL,
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
/****** Object:  StoredProcedure [dbo].[AddExpense]    Script Date: 4/7/2025 8:51:09 PM ******/
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
/****** Object:  StoredProcedure [dbo].[GetAllExpenses]    Script Date: 4/7/2025 8:51:09 PM ******/
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
/****** Object:  StoredProcedure [dbo].[GetExpensesByUser]    Script Date: 4/7/2025 8:51:09 PM ******/
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
