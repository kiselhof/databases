/*������������  ��������������� ������ (������� �'�������, inner join, left join, right join, self join, subquery, correlated subquery, exists, not exist, union)*/
/*1.������� �������� ��������� �������: ����� �����, ����, ����� �����������. 
��������������� ������� �'�������, ������������ where.*/

SELECT Title, Price, Publishment.publishment FROM Books, Publishment WHERE Books.id_publishment=Publishment.id_publishment;


/*2.������� �������� ��������� �������: ����� �����, ����� �������. ��������������� ������� �'�������, ������������ inner join.*/
SELECT Title, Categories.category FROM Books, Categories WHERE Books.id_category=Categories.id_categories;

/*3.������� �������� ��������� �������: ����� �����, ����, ����� �����������, ������.*/
SELECT Title, Price, Publishment.publishment, Format_ FROM Books, Publishment WHERE Publishment.publishment = publishment.publishment;

/*4.������� �������� ��������� �������: ����, ��������, ����� �����, ����� �����������. Գ���� �� ������ � ����������.*/
SELECT Themes.theme, Categories.category, Title, Publishment.publishment 
FROM Books, Themes, Categories, Publishment
WHERE Themes.theme = Themes.theme AND Categories.category = Categories.category AND Publishment.publishment = publishment.publishment
ORDER BY Themes.theme, Categories.category; 

/*5.������� ����� ����������� 'BHV', ����� ���� 2000 �*/
SELECT Title, Publishment.publishment FROM Books, Publishment
WHERE Publishment.publishment like 'BHV' AND (Year(Date_) >= 2000);

/*6.������� �������� ������� ������� �� ����� ���� �������. Գ���� �� ��������� ������� �������.*/
SELECT SUM(Pages) as 'Sum', category
FROM Books, Categories
GROUP BY category
ORDER BY SUM(Pages) DESC;

/*7.������� ������� ������� ���� �� ��� '������������ ��' � ������� 'Linux'.*/
SELECT AVG(Price), Themes.theme, Categories.category
FROM Books, Themes, Categories
WHERE Themes.theme like '%������������ ��%' 
		OR Categories.category like '%Linux%';


/*8.������� �� ��� ������������� ���������. ��������������� ������� �'�������, ������������ where.*/
SELECT * FROM Books, Themes, Publishment, Categories
WHERE Books.id_publishment = Publishment.id_publishment
	AND Books.id_category = Categories.id_categories
	AND Books.id_theme = Themes.id_theme

/*9.������� �� ��� ������������� ���������. ��������������� ������� �'�������, ������������ inner join*/.
SELECT Title,Themes.theme, Publishment.publishment, Categories.category
FROM (((Books
	INNER JOIN Themes ON Books.id_theme=Themes.id_theme)
	INNER JOIN Publishment ON Books.id_publishment=Publishment.id_publishment)
	INNER JOIN Categories ON Books.id_category=Categories.id_categories);

/*10.������� �� ��� ������������� ���������. ��������������� ������ �'�������, ������������ left join / rigth join.*/
SELECT Title, Themes.theme, Publishment.publishment, Categories.category
FROM (((Books
	LEFT JOIN Themes ON Books.id_theme=Themes.id_theme)
	LEFT JOIN Publishment ON Books.id_publishment=Publishment.id_publishment)
	LEFT JOIN Categories ON Books.id_category=Categories.id_categories);

/*11.������� ���� ����, �� ����� �������� ������� �������. ��������������� ������'������� � ����� (self join).*/
SELECT A.Title AS Title_1, B.Title AS Title_2, A.Pages
FROM Books A,  Books B
WHERE A.Title <> B.Title
	AND A.Pages = B.Pages
ORDER BY A.Pages;

/*12.������� ����� ����, �� ����� �������� ����. ��������������� ������'������� � ����� (self join).*/
select a.price, a.Title, b.Title, c.Title 
from books a 
join books b on a.price=b.price 
join books c on b.price=c.price

/*13.������� �� ����� ������� 'C ++'. ��������������� �������� (Subquery) .*/
SELECT * FROM Books, Categories
WHERE Categories.category IN
	(SELECT category FROM Categories WHERE category LIKE '%�++%')

/*14.������� ����� ����������� 'BHV', ����� ���� 2000 � ��������������� �������� (Subquery) .*/
SELECT * FROM Books, Publishment
WHERE Publishment.publishment IN
	(SELECT publishment FROM Publishment WHERE publishment LIKE '%BHV%')
	AND YEAR(Date_) >= 2000

/*15.������� ������ ����������, � ���� ����� ���� �������� 400 �������. ��������������� ���'���� �������� (correlated subquery).*/
SELECT * FROM Publishment main WHERE 400<
(SELECT SUM(Pages) FROM Books WHERE Publishment=main.publishment)

/*16.������� ������ �������� �� ����� ����� 3-� ����. ��������������� ���'���� �������� (correlated subquery).*/
SELECT Categories.category FROM Books, Categories
GROUP BY Categories.category HAVING Categories.category =
	(SELECT category FROM Categories GROUP BY category HAVING COUNT(category)>3)

/*17.������� ������ ���� ����������� 'BHV', ���� � ������ � ���� � ���� ����� ����� �����������. ��������������� exists.*/
SELECT * FROM Books, Publishment 
WHERE Publishment.publishment like '%BHV%' 
	AND EXISTS (SELECT * FROM Books WHERE publishment like '%BHV%')

/*18.������� ������ ���� ����������� 'BHV', ���� � ������ ���� ����� ����� ����� �����������. ��������������� not  exists.*/
SELECT * FROM Books B
WHERE NOT EXISTS (SELECT P.publishment FROM Publishment P WHERE B.id_publishment=p.id_publishment AND p.publishment LIKE '%BHV%')

/*19.������� ����������� ��������� ������ ���� ��� � ��������. ��������������� union.*/
SELECT theme FROM Themes
UNION 
SELECT category from Categories
ORDER BY 1 ASC

/*20.������� ����������� � ���������� ������� ��������� ������  ������ ��� ���� ���� (�� �� ������������) � ��������. ��������������� union.*/
SELECT SUBSTRING(Title, 1, CHARINDEX(' ',Title)) FROM Books
UNION
SELECT SUBSTRING(category, 1, CHARINDEX(' ',category)) FROM Categories 
ORDER BY 1 DESC