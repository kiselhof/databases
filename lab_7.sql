/*ЛР №7 
Проектування і перевірка збережених процедур (stored procedure): 
без параметрів, з вхідними параметрами, з вхідними параметрами за замовчуванням, з вихідними параметрами
*/

--1.Вивести значення наступних колонок: назва книги, ціна, назва видавництва, формат.
CREATE PROCEDURE procedure_1
AS 
	SELECT Title, Price, P.publishment, Format_ 
		FROM Books B JOIN Publishment P on B.id_publishment = P.id_publishment;

procedure_1;


--2.Вивести значення наступних колонок: тема, категорія, назва книги, назва видавництва. Фільтр по темам і категоріям.
CREATE PROCEDURE procedure_2
AS 
	SELECT T.theme, C.category, Title, P.publishment
		FROM Books B JOIN Themes T on B.id_theme=T.id_theme
					JOIN Categories C on B.id_category = C.id_categories
					JOIN Publishment P on B.id_publishment = P.id_publishment
		ORDER BY T.theme, C.category;

procedure_2;



--3.Вивести книги видавництва 'BHV', видані після 2000 р
CREATE PROCEDURE procedure_3
AS
	SELECT Title, publishment 
	FROM Books, Publishment 
	WHERE Publishment.publishment LIKE '%BHV%' AND YEAR(Date_) >= 2000;

procedure_3;


--4.Вивести загальну кількість сторінок по кожній назві категорії. Фільтр за спаданням / зростанням кількості сторінок.

CREATE PROCEDURE procedure_4
AS
	SELECT SUM(Pages) AS 'sum_pages', Categories.category
	FROM Books, Categories
	GROUP BY Categories.category;
procedure_4;

--5.Вивести середню вартість книг по темі 'Використання ПК' і категорії 'Linux'.
CREATE PROCEDURE procedure_5
AS
	SELECT AVG(Price) AS 'avg_price', Themes.theme, Categories.category
	FROM Books, Themes, Categories
	WHERE theme LIKE '%Использование ПК%' AND category LIKE '%Linux%'
	GROUP BY Themes.theme, Categories.category;

procedure_5;



--6.Вивести всі дані універсального відносини.
CREATE PROCEDURE procedure_6
AS 
	SELECT *
		FROM Books B JOIN Themes T on B.id_theme=T.id_theme
					JOIN Categories C on B.id_category = C.id_categories
					JOIN Publishment P on B.id_publishment = P.id_publishment;
procedure_6;



--7.Вивести пари книг, що мають однакову кількість сторінок.
CREATE PROCEDURE procedure_7
AS
	SELECT a.Title, a.Pages, b.Title, b.Pages
		FROM Books a, Books b
		WHERE a.Pages = b.Pages
			AND a.Title<>b.Title;
procedure_7;

--8.Вивести тріади книг, що мають однакову ціну.
CREATE PROCEDURE procedure_8
AS
	SELECT a.Title, a.Pages, c.Title, b.Title, b.Pages, c.Pages
		FROM Books a 
		JOIN Books b ON a.Pages = b.Pages AND a.Title<>b.Title
		JOIN Books c ON b.Pages = c.Pages AND b.Title<>c.Title AND a.Title<>c.Title;
procedure_8;

--9.Вивести всі книги категорії 'C ++'.
CREATE PROCEDURE procedure_9
@c VARCHAR(30)
AS
	SELECT Title, Categories.category
		FROM Books, Categories
			WHERE category LIKE @c;

procedure_9 '%C ++%';



--10.Вивести список видавництв, у яких розмір книг перевищує 400 сторінок.
CREATE PROCEDURE procedure_10
@page_number SMALLINT
AS
	SELECT publishment, Pages
		FROM Publishment, Books
			GROUP BY publishment, Pages
			HAVING SUM(Pages) > @page_number
			;

procedure_10 400;


--11.Вивести список категорій за якими більше 3-х книг.
CREATE PROCEDURE procedure_11
@titles_number SMALLINT = 3,
@out SMALLINT OUTPUT
AS
	SELECT category, Title
		FROM Categories, Books
			GROUP BY category
			HAVING @out=COUNT(category)>@titles_number;


--12.Вивести список книг видавництва 'BHV', якщо в списку є хоча б одна книга цього видавництва.
CREATE PROCEDURE procedure_12
@publ VARCHAR(30) = '%BHV%'
AS
	SELECT publishment, Title
		FROM Publishment, Books
		WHERE publishment LIKE @publ
		GROUP BY publishment, Title
		HAVING COUNT(Title) >=1;
		
--OR another variant
DROP PROCEDURE procedure_12;
CREATE PROCEDURE procedure_12
@publ VARCHAR(30) = '%BHV%'
AS
	SELECT publishment, Title
		FROM Publishment, Books
		WHERE publishment LIKE @publ
			AND EXISTS(SELECT publishment, Title FROM Publishment, Books WHERE publishment LIKE @publ);

procedure_12;

--13.Вивести список книг видавництва 'BHV', якщо в списку немає жодної книги цього видавництва.
--misunderstandable, sorry

--14.Вивести відсортоване загальний список назв тем і категорій.
CREATE PROCEDURE procedure_14
AS
	SELECT theme, publishment
		FROM Themes, Publishment
		ORDER BY theme, publishment ASC;

procedure_14;


--15.Вивести відсортоване в зворотному порядку загальний список неповторяющихся перших слів назв книг і категорій.
CREATE PROCEDURE procedure_15
AS
	SELECT SUBSTRING(Title,1, CHARINDEX(' ', Title)) FROM Books
	UNION
	SELECT	SUBSTRING(category, 1, CHARINDEX(' ', category)) FROM Categories
		ORDER BY 1 DESC;

procedure_15;
 