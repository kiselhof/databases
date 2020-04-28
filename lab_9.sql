/*Lab 9
Проектування користувальницьких функцій (user defined function). Робота з SQL курсором (cursor).*/

 
--1.Розробити і перевірити скалярну (scalar) функцію, що повертає загальну вартість книг, виданих в певному році.
DROP FUNCTION dbo.sum_price_of_year
GO

CREATE FUNCTION 
sum_price_of_year ( @y INT)
RETURNS money
AS
BEGIN
DECLARE @s INT
SET @s=(SELECT SUM(Price)
FROM Books
WHERE YEAR(Date_)=@y)
RETURN (@s)
END
GO

DECLARE @sum INT
SET @sum=dbo.sum_price_of_year(2000)
SELECT @sum
GO


--2.Розробити і перевірити табличну (inline) функцію, яка повертає список книг, виданих в певному році.
CREATE FUNCTION titles_of_year
(@yr INT)
RETURNS TABLE
AS
RETURN (SELECT Title FROM Books WHERE YEAR(Date_)=@yr)

SELECT * FROM titles_of_year(2000)

--3.Розробити і перевірити функцію типу multi - statement, яка буде:
--a.приймати в якості вхідного параметра рядок, що містить список назв видавництв, розділених символом ';';
--b.виділяти з цього рядка назву видавництва;
--c.формувати нумерований список назв видавництв.

CREATE FUNCTION numeric_list_publishments(@MYstr NVARCHAR(200))
RETURNS @List TABLE(ind_num INT IDENTITY(1,1), publish NVARCHAR(200))
AS
BEGIN
	INSERT INTO @List
		SELECT STRING_SPLIT(@MYstr, ';')
	RETURN
END

SELECT *FROM numeric_list_publishments('BHV С.-Петербург;Русская редакция;Вильямс')


--2.Виконати набір операцій по роботі з SQL курсором:




DECLARE my_cursor CURSOR GLOBAL SCROLL --a.оголосити курсор;
FOR SELECT 
	Title FROM Books		--b.використовувати змінну для оголошення курсору;

OPEN my_cursor;		--c.відкрити курсор;

DECLARE @ABC CURSOR
SET @ABC=my_cursor	--d. переприсвоіти курсор іншій змінній;

FETCH NEXT FROM my_cursor	--e.виконати вибірку даних з курсору;
WHILE @@FETCH_STATUS=0
BEGIN
--next--
FETCH NEXT FROM my_cursor
END;


CLOSE my_cursor;		--f.закрити курсор;
DEALLOCATE my_cursor;	--g.звільнити курсор.


--3.Розробити курсор для виведення списку книг виданих в певному році.

DECLARE 
    @yr AS INT=2000;

DECLARE cursor_list_books_byYear CURSOR GLOBAL SCROLL 
FOR SELECT 
        Title
    FROM 
        Books 
	WHERE YEAR(Date_)=@yr;

OPEN cursor_list_books_year;

FETCH NEXT FROM cursor_list_books_year INTO
	@titles
WHILE @@FETCH_STATUS=0 AND @yr=YEAR(Date_) FROM Books
	BEGIN
		FETCH NEXT FROM cursor_list_books_year
	END;

CLOSE cursor_list_books_byYear;
DEALLOCATE cursor_list_books_byYear;