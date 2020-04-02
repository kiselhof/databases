/*Проектування  багатотабличних запитів (внутрішнє з'єднання, inner join, left join, right join, self join, subquery, correlated subquery, exists, not exist, union)*/
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