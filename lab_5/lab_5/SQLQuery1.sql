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

INSERT INTO Publishment VALUES (1,'BHV �.-���������');
INSERT INTO Publishment VALUES (2,'������� ��������');
INSERT INTO Publishment VALUES (3,'�������');
INSERT INTO Publishment VALUES (4,'�����');
INSERT INTO Publishment VALUES (5,'��������');
INSERT INTO Publishment VALUES (6,'DiaSoft');

INSERT INTO Themes VALUES (1,'������������� �� � �����');
INSERT INTO Themes VALUES (2,'������������ �������');
INSERT INTO Themes VALUES (3,'����������������');
INSERT INTO Themes VALUES (4,'����������');

INSERT INTO Categories VALUES (1,'��������');
INSERT INTO Categories VALUES (2,'���������� �������� ��');
INSERT INTO Categories VALUES (3,'������ � ������������ ��');
INSERT INTO Categories VALUES (4,'������ �����');
INSERT INTO Categories VALUES (6,'Linux');


INSERT INTO Books VALUES (2,5110,'No','���������� �������� �����������. ������������ ��',15.51,400,'070�100/016','2000-7-24',default,2,3,2);
INSERT INTO Books VALUES (8,4985,'No','����� �������������� ������������ � ������ �� �� 24 ����, 2-� ���.',18.90,288,'070�100/016','2000-7-7',default,2,1,3);
INSERT INTO Books VALUES (9,5141,'No','��������� ������ � ���������.',37.80,384,'070�100/016','1994-9-29',8000,1 ,3,7);
INSERT INTO Books VALUES (20,5127,'Yes','������������� ���������- ����������� �����',11.58,256,'070�100/016','2013-6-15',default,4,2,6);
INSERT INTO Books VALUES (31,5110,'No','���������� �������� �����������. ������������ ��',15.51,400,'070�100/016','2004-7-24',8000,1,1,1);
INSERT INTO Books VALUES (46,5199,'No','������ IBM 2001.',30.07,368,'070�100/016','2010-12-2',default,5,1,1);
INSERT INTO Books VALUES (50,3851,'Yes','������ ���������� � ������������ ������������ ������',26.00,480,'084�108/016','2013-2-4',10000,6,1,3);
INSERT INTO Books VALUES (58,3932,'No','��� ���������� ������������ ��������� � ������������� ��������',12.21,144,'060�088/016','1999-6-9',default,7,1,4);
INSERT INTO Books VALUES (59,4713,'No','Microsoft Plug- ins. ������������ ���������� ��� ����������� ��������',11.41,144,'070�100/016','2000-2-22',default,7,1,4);
INSERT INTO Books VALUES (175,5217,'No','Windows ��. �������� ������ ��������',16.57,320,'070�100/016','2000-8-25',default,8,2,5);
INSERT INTO Books VALUES (176,4829,'No','Windows 2000 Professional ��� �� ����� � �D',27.25,320,'070�100/016','2000-4-28',default,3,2,5);
INSERT INTO Books VALUES (188,5170,'No','Linux ������� ������',24.43,346,'070�100/016','2008-9-29',default,7,2,6);
INSERT INTO Books VALUES (191,8602,'No','������������ ������� UNIX',11.70,395,'084�100/016','1997-5-5',8000,1,2,7);
INSERT INTO Books VALUES (203,4443,'No','������ �� ���������� ������� �� OS/2 Warp',11.00,352,'060�084/016','1996-3-20',10000,6,2,8);
INSERT INTO Books VALUES (206,5176,'No','Windows ��. ������� ������������',12.79,306,NULL,'2011-10-10',default,2,2,8);
INSERT INTO Books VALUES (209,5462,'No','���� ���������������� �++. ������ � ����������',29.00,656,'084�108/016','2003-12-12',10000,6,3,9);
INSERT INTO Books VALUES (5534,532,'No','���� ���������������� �. ������ � ����������',29.00,432,'084�108/016','2000-7-12',10000,6,3,3);
INSERT INTO Books VALUES (220,4687,'No','����������� ������������� C++.50 ������������ �� ��������� ����� �������� � ��������',17.60,240,'070�100/016','2000-2-3',default,7,3,9);