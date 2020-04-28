
 /*ЛР №8 
Проектування і перевірка тригерів (trigger), що активізуються при додаванні (insert), виправленні (update) і видаленні (delete) даних.
 */
--Реалізувати набір тригерів, що реалізують такі ділові правила:

--1.Кількість тем може бути в діапазоні від 5 до 10.
DROP TRIGGER themes_amount 
GO

CREATE TRIGGER themes_amount ON Themes
FOR INSERT, DELETE
AS
DECLARE @n AS int
SELECT @n=COUNT(*) FROM Themes
IF (@n>10)
BEGIN
RAISERROR ('Число тем больше допустимого',16, 10)
ROLLBACK TRANSACTION 
END
IF(@n<5)
BEGIN
RAISERROR ('Число тем меньше допустимого',16, 10)
ROLLBACK TRANSACTION 
END



--2.Новинкою може бути тільки книга видана в поточному році.

DROP TRIGGER release_year
GO

CREATE TRIGGER release_year ON Books
FOR INSERT, UPDATE
AS
DECLARE @yr_ AS INT
SELECT @yr_=YEAR(Date_) FROM Books
IF (@yr_<>YEAR(GETDATE()))
BEGIN
RAISERROR ('Год не должен отличаться от текущего',16, 10)
ROLLBACK TRANSACTION 
END


--3.Книга з кількістю сторінок до 100 не може коштувати більше 10 $, до 200 - 20 $, до 300 - 3 0 $.
DROP TRIGGER cost_on_pages 
GO

CREATE TRIGGER cost_on_pages ON Books
FOR INSERT, UPDATE
AS
DECLARE @pages AS INT, @price AS INT
SELECT @pages=Pages, @price=Price FROM Books
IF (@pages<100 AND @price>10) OR (@pages BETWEEN 101 AND 200 AND @price>20) OR (@pages BETWEEN 201 AND 300 AND @price>30)
BEGIN
RAISERROR ('Цена не соответствует количеству страниц',16, 10)
ROLLBACK TRANSACTION 
END


--4.Видавництво "BHV" не випускає книги накладом меншим 5000, а видавництво Diasoft - 10000.
DROP TRIGGER publ_VS_edition 
GO
CREATE TRIGGER publ_VS_edition  ON Books
FOR INSERT, UPDATE
AS
DECLARE @publ AS NVARCHAR, @edition AS INT
SELECT @publ=publishment, @edition=Edition FROM Publishment, Books
IF (@publ LIKE '%BHV%' AND @edition<5000) OR (@publ LIKE '%Diasoft%' AND @edition<10000)
BEGIN
RAISERROR ('Издатель не выпускает в таком маленьком тираже',16, 10)
ROLLBACK TRANSACTION 
END


--5.Книги з однаковим кодом повинні мати однакові дані. !!!!!!!!!!!!!!!!!!!!

DROP TRIGGER t5
GO

CREATE TRIGGER t5 ON books
for INSERT, UPDATE
AS
declare @damo as int=2,
@dcode as int,
@dnove as int,
@dname as int,
@dpric as int,
@dpage as int,
@dsize as int,
@drele as int,
@dedit as int,
@dpubl as int,
@dtopic as int,
@dcateg as int
select @dcode=count(code) from Booksgroup by Code
select @dnove=count(New) from Booksgroup by Code having count(Code)=@damo
select @dname=count(Title) from Booksgroup by Code having count(Code)=@damo
select @dpric=count(price) from Booksgroup by Code having count(Code)=@damo
select @dpage=count(pages) from Booksgroup by Code having count(Code)=@damo
select @dsize=count(Format_) from Booksgroup by Code having count(Code)=@damo
select @drele=count(Date_) from Booksgroup by Code having count(Code)=@damo
select @dedit=count(edition) from Booksgroup by Code having count(Code)=@damo
select @dpubl=count(id_publishment) from Booksgroup by Code having count(Code)=@damo
select @dtopic=count(id_theme) from Booksgroup by Code having count(Code)=@damo
select @dcateg=count(id_category) from Booksgroup by Code having count(Code)=@damo
if (@damo=@dcode or @damo<>@dnove) or
(@damo=@dcode or @damo<>@dname) or
(@damo=@dcode or @damo<>@dpric) or
(@damo=@dcode or @damo<>@dpage) or
(@damo=@dcode or @damo<>@dsize) or
(@damo=@dcode or @damo<>@drele) or
(@damo=@dcode or @damo<>@dedit) or
(@damo=@dcode or @damo<>@dpubl) or
(@damo=@dcode or @damo<>@dtopic) or
(@damo=@dcode or @damo<>@dcateg)
begin 
RAISERROR ('Данные не совпадают',16, 10)
rollback transaction
end
GO



--6.При спробі видалення книги видається інформація про кількість рядків, що видаляються. Якщо користувач не "dbo", то видалення забороняється.
DROP TRIGGER t6 ;
GO

CREATE TRIGGER t6 ON Books
FOR DELETE 
AS
SELECT COUNT(*) FROM deleted;
IF (IS_ROLEMEMBER('db_owner') = 0)
BEGIN
RAISERROR('DELETE NOR ALLOWED', 16, 1)
ROLLBACK
END;


--7.Користувач "dbo" не має права змінювати ціну книги.
DROP TRIGGER t7 ;
GO
CREATE TRIGGER t7 ON Books
FOR UPDATE
AS BEGIN IF UPDATE (Price) AND (IS_ROLEMEMBER('db_owner') =0)
	BEGIN
		RAISERROR('DELETE NOR ALLOWED', 16, 1)
		ROLLBACK
	END
END;

--8.Видавництва ДМК і Еком підручники не видають.
DROP TRIGGER publ_VS_categ ;

CREATE TRIGGER publ_VS_categ  ON Books
FOR INSERT, UPDATE
AS
DECLARE @publ1 AS INT=7,
		@publ2 AS INT=9,
		@publ AS INT,
		@category1 AS INT=1,
		@category AS INT
SELECT @category=id_category, @publ=id_publishment FROM Books
IF (@publ=@publ1 AND @category=@category1) OR
	(@publ=@publ2 AND @category=@category1)
BEGIN
RAISERROR ('Издатель не выпускает эту категорию',16, 10)
ROLLBACK TRANSACTION 
END





--10.видавництво BHV не випускає книги формату 60х88/16.
DROP TRIGGER publ_VS_format  
GO

CREATE TRIGGER publ_VS_format  ON Books
FOR INSERT, UPDATE
AS
DECLARE @publ AS INT,
		@publ1 AS INT=1,
		@format AS NVARCHAR(12),
		@format1 AS NVARCHAR(12)='60х88/16'
SELECT @format=Format_ FROM Books WHERE id_publishment=@publ1
IF (@publ=@publ1 AND @format=@format1)
BEGIN
RAISERROR ('Издатель не печатет в таком формате',16, 10)
ROLLBACK TRANSACTION 
END;