USE master
DROP DATABASE [lab_5]
CREATE DataBase [lab_5]

USE [lab_5]

CREATE TABLE Publishment
(id_publishment INT NOT NULL PRIMARY KEY,
publishment NVARCHAR(50)
)

CREATE TABLE Themes
(
id_theme INT NOT NULL PRIMARY KEY,
theme NVARCHAR(50)
)

CREATE TABLE Categories
(
id_categories INT NOT NULL PRIMARY KEY,
category  NVARCHAR(50)
)

CREATE TABLE Books
(
Num INT NOT NULL PRIMARY KEY,
Code INT NOT NULL,
New CHAR(3) NOT NULL CHECK(New in ('Yes', 'No')),
Title NVARCHAR(100) NOT NULL,
Price MONEY NULL,
Pages INT,
Format_ NVARCHAR(12),
Date_ DATE,
Edition INT DEFAULT 5000,
id_publishment INT,
id_theme INT,
id_category INT,
FOREIGN KEY (id_publishment) REFERENCES Publishment (id_publishment) ON UPDATE CASCADE ON DELETE NO ACTION,
FOREIGN KEY (id_category) REFERENCES Categories (id_categories) ON UPDATE CASCADE ON DELETE NO ACTION,

)

USE master

USE [lab_5]

INSERT INTO Publishment VALUES (1,'BHV С.-Петербург');
INSERT INTO Publishment VALUES (2,'Русская редакция');
INSERT INTO Publishment VALUES (3,'Вильямс');
INSERT INTO Publishment VALUES (4,'Питер');
INSERT INTO Publishment VALUES (5,'МикроАрт');
INSERT INTO Publishment VALUES (6,'DiaSoft');

INSERT INTO Themes VALUES (1,'Использование ПК в целом');
INSERT INTO Themes VALUES (2,'Операционные системы');
INSERT INTO Themes VALUES (3,'Программирование');
INSERT INTO Themes VALUES (4,'Фантастика');

INSERT INTO Categories VALUES (1,'Учебники');
INSERT INTO Categories VALUES (2,'Аппаратные средства ПК');
INSERT INTO Categories VALUES (3,'Защита и безопасность ПК');
INSERT INTO Categories VALUES (4,'Другие книги');
INSERT INTO Categories VALUES (6,'Linux');


INSERT INTO Books VALUES (2,5110,'No','Аппаратные средства мультимедия. Видеосистема РС',15.51,400,'070х100/016','2000-7-24',default,2,3,2);
INSERT INTO Books VALUES (8,4985,'No','Освой самостоятельно модернизацию и ремонт ПК за 24 часа, 2-е изд.',18.90,288,'070х100/016','2000-7-7',default,2,1,3);
INSERT INTO Books VALUES (9,5141,'No','Структуры данных и алгоритмы.',37.80,384,'070х100/016','1994-9-29',8000,1 ,3,7);
INSERT INTO Books VALUES (20,5127,'Yes','Автоматизация инженерно- графических работ',11.58,256,'070х100/016','2013-6-15',default,4,2,6);
INSERT INTO Books VALUES (31,5110,'No','Аппаратные средства мультимедия. Видеосистема РС',15.51,400,'070х100/016','2004-7-24',8000,1,1,1);
INSERT INTO Books VALUES (46,5199,'No','Железо IBM 2001.',30.07,368,'070х100/016','2010-12-2',default,5,1,1);
INSERT INTO Books VALUES (50,3851,'Yes','Защита информации и безопасность компьютерных систем',26.00,480,'084х108/016','2013-2-4',10000,6,1,3);
INSERT INTO Books VALUES (58,3932,'No','Как превратить персональный компьютер в измерительный комплекс',12.21,144,'060х088/016','1999-6-9',default,7,1,4);
INSERT INTO Books VALUES (59,4713,'No','Microsoft Plug- ins. Встраиваемые приложения для музыкальных программ',11.41,144,'070х100/016','2000-2-22',default,7,1,4);
INSERT INTO Books VALUES (175,5217,'No','Windows МЕ. Новейшие версии программ',16.57,320,'070х100/016','2000-8-25',default,8,2,5);
INSERT INTO Books VALUES (176,4829,'No','Windows 2000 Professional шаг за шагом с СD',27.25,320,'070х100/016','2000-4-28',default,3,2,5);
INSERT INTO Books VALUES (188,5170,'No','Linux Русские версии',24.43,346,'070х100/016','2008-9-29',default,7,2,6);
INSERT INTO Books VALUES (191,8602,'No','Операционная система UNIX',11.70,395,'084х100/016','1997-5-5',8000,1,2,7);
INSERT INTO Books VALUES (203,4443,'No','Ответы на актуальные вопросы по OS/2 Warp',11.00,352,'060х084/016','1996-3-20',10000,6,2,8);
INSERT INTO Books VALUES (206,5176,'No','Windows Ме. Спутник пользователя',12.79,306,NULL,'2011-10-10',default,2,2,8);
INSERT INTO Books VALUES (209,5462,'No','Язык программирования С++. Лекции и упражнения',29.00,656,'084х108/016','2003-12-12',10000,6,3,9);
INSERT INTO Books VALUES (5534,532,'No','Язык программирования С. Лекции и упражнения',29.00,432,'084х108/016','2000-7-12',10000,6,3,3);
INSERT INTO Books VALUES (220,4687,'No','Эффективное использование C++.50 рекомендаций по улучшению ваших программ и проектов',17.60,240,'070х100/016','2000-2-3',default,7,3,9);

/*1.Вивести значення наступних колонок: назва книги, ціна, назва видавництва. 
Використовувати внутрішнє з'єднання, застосовуючи where.*/

SELECT Title, Price, Publishment.publishment FROM Books, Publishment WHERE Books.id_publishment=Publishment.id_publishment;


/*2.Вивести значення наступних колонок: назва книги, назва категорії. Використовувати внутрішнє з'єднання, застосовуючи inner join.*/
SELECT Title, Categories.category FROM Books, Categories WHERE Books.id_category=Categories.id_categories;

/*3.Вивести значення наступних колонок: назва книги, ціна, назва видавництво, формат.*/
SELECT Title, Price, Publishment.publishment, Format_ FROM Books, Publishment WHERE Publishment.publishment = publishment.publishment;

/*4.Вивести значення наступних колонок: тема, категорія, назва книги, назва видавництво. Фільтр за темами і категоріями.*/
SELECT Themes.theme, Categories.category, Title, Publishment.publishment 
FROM Books, Themes, Categories, Publishment
WHERE Themes.theme = Themes.theme AND Categories.category = Categories.category AND Publishment.publishment = publishment.publishment
ORDER BY Themes.theme, Categories.category; 

/*5.Вивести книги видавництва 'BHV', видані після 2000 р*/
SELECT Title, Publishment.publishment FROM Books, Publishment
WHERE Publishment.publishment like 'BHV' AND (Year(Date_) >= 2000);

/*6.Вивести загальну кількість сторінок по кожній назві категорії. Фільтр за спаданням кількості сторінок.*/
SELECT SUM(Pages) as 'Sum', category
FROM Books, Categories
GROUP BY category
ORDER BY SUM(Pages) DESC;

/*7.Вивести середню вартість книг по темі 'Використання ПК' і категорії 'Linux'.*/
SELECT AVG(Price), Themes.theme, Categories.category
FROM Books, Themes, Categories
WHERE Themes.theme like '%Використання ПК%' 
		OR Categories.category like '%Linux%';


/*8.Вивести всі дані універсального відношення. Використовувати внутрішнє з'єднання, застосовуючи where.*/
SELECT * FROM Books, Themes, Publishment, Categories
WHERE Books.id_publishment = Publishment.id_publishment
	AND Books.id_category = Categories.id_categories
	AND Books.id_theme = Themes.id_theme

/*9.Вивести всі дані універсального відношення. Використовувати внутрішнє з'єднання, застосовуючи inner join*/.
SELECT Title,Themes.theme, Publishment.publishment, Categories.category
FROM (((Books
	INNER JOIN Themes ON Books.id_theme=Themes.id_theme)
	INNER JOIN Publishment ON Books.id_publishment=Publishment.id_publishment)
	INNER JOIN Categories ON Books.id_category=Categories.id_categories);

/*10.Вивести всі дані універсального відношення. Використовувати зовнішнє з'єднання, застосовуючи left join / rigth join.*/
SELECT Title, Themes.theme, Publishment.publishment, Categories.category
FROM (((Books
	LEFT JOIN Themes ON Books.id_theme=Themes.id_theme)
	LEFT JOIN Publishment ON Books.id_publishment=Publishment.id_publishment)
	LEFT JOIN Categories ON Books.id_category=Categories.id_categories);

/*11.Вивести пари книг, що мають однакову кількість сторінок. Використовувати самооб'єднання і аліаси (self join).*/
SELECT A.Title AS Title_1, B.Title AS Title_2, A.Pages
FROM Books A,  Books B
WHERE A.Title <> B.Title
	AND A.Pages = B.Pages
ORDER BY A.Pages;

/*12.Вивести тріади книг, що мають однакову ціну. Використовувати самооб'єднання і аліаси (self join).*/
select a.price, a.Title, b.Title, c.Title 
from books a 
join books b on a.price=b.price 
join books c on b.price=c.price

/*13.Вивести всі книги категорії 'C ++'. використовувати підзапити (Subquery) .*/
SELECT * FROM Books, Categories
WHERE Categories.category IN
	(SELECT category FROM Categories WHERE category LIKE '%С++%')

/*14.Вивести книги видавництва 'BHV', видані після 2000 р Використовувати підзапити (Subquery) .*/
SELECT * FROM Books, Publishment
WHERE Publishment.publishment IN
	(SELECT publishment FROM Publishment WHERE publishment LIKE '%BHV%')
	AND YEAR(Date_) >= 2000

/*15.Вивести список видавництв, у яких розмір книг перевищує 400 сторінок. Використовувати пов'язані підзапити (correlated subquery).*/
SELECT * FROM Publishment main WHERE 400<
(SELECT SUM(Pages) FROM Books WHERE Publishment=main.publishment)

/*16.Вивести список категорій за якими більше 3-х книг. Використовувати пов'язані підзапити (correlated subquery).*/
SELECT Categories.category FROM Books, Categories
GROUP BY Categories.category HAVING Categories.category =
	(SELECT category FROM Categories GROUP BY category HAVING COUNT(category)>3)

/*17.Вивести список книг видавництва 'BHV', якщо в списку є хоча б одна книга цього видавництва. Використовувати exists.*/
SELECT * FROM Books, Publishment 
WHERE Publishment.publishment like '%BHV%' 
	AND EXISTS (SELECT * FROM Books WHERE publishment like '%BHV%')

/*18.Вивести список книг видавництва 'BHV', якщо в списку немає жодної книги цього видавництва. використовувати not  exists.*/
SELECT * FROM Books B
WHERE NOT EXISTS (SELECT P.publishment FROM Publishment P WHERE B.id_publishment=p.id_publishment AND p.publishment LIKE '%BHV%')

/*19.Вивести відсортоване загальний список назв тем і категорій. Використовувати union.*/
SELECT theme FROM Themes
UNION 
SELECT category from Categories
ORDER BY 1 ASC

/*20.Вивести відсортоване в зворотному порядку загальний список  перших слів назв книг (що не повторюються) і категорій. Використовувати union.*/
SELECT SUBSTRING(Title, 1, CHARINDEX(' ',Title)) FROM Books
UNION
SELECT SUBSTRING(category, 1, CHARINDEX(' ',category)) FROM Categories 
ORDER BY 1 DESC
