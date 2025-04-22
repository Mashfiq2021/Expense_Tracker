
ALTER TABLE Users ALTER COLUMN password VARBINARY(255);

ALTER TABLE Users ADD password_binary VARBINARY(255);
UPDATE Users SET password_binary = CONVERT(VARBINARY(255), password);
ALTER TABLE Users DROP COLUMN password;
EXEC sp_rename 'Users.password_binary', 'password', 'COLUMN';


CREATE PROCEDURE AddExpense
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

CREATE PROCEDURE GetExpensesByUser
    @username NVARCHAR(50)
AS
BEGIN
    SELECT * FROM Expenses
    WHERE username = @username
    ORDER BY date DESC, id DESC;
END;

CREATE PROCEDURE GetAllExpenses
AS
BEGIN
    SELECT * FROM Expenses ORDER BY date DESC, id DESC;
END

/*How to call these from Python (with pyodbc):*/
cursor.execute("EXEC AddExpense ?, ?, ?, ?, ?",
               (date, description, category, amount, username))
conn.commit()	

/*Example to fetch using GetExpensesByUser: */

df = pd.read_sql("EXEC GetExpensesByUser ?", conn, params=[username])