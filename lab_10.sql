/*ЛР №10 
Проектування таблиць з використанням призначених для користувача типів даних 
(user defined data types), замовчувань (defaults) і правил(rules).
 */
 DROP TYPE stud_mark;
--1.Створити користувальницький тип даних для зберігання оцінки учня на основі стандартного типу tinyint з можливістю використання порожніх значень.
CREATE TYPE stud_mark  
FROM TINYINT NULL;
GO
--DROP TABLE Student;
CREATE TABLE Student(id_stud INT PRIMARY KEY, 
						name_ NVARCHAR(MAX));
GO
--2.Створити об'єкт-замовчування (default) зі значенням 3.
CREATE DEFAULT stud_mark_def AS 3;
GO
--3.Зв'язати об'єкт-замовчування з призначеним для користувача типом даних для оцінки.
sp_bindefault stud_mark_def, stud_mark;
GO
--4.Отримати інформацію про призначений для користувача тип даних.
 SELECT 'stud_mark' FROM  systypes;
 sp_help 'stud_mark';

--5.Створити об'єкт-правило (rule): a> = 1 і a <= 5 і зв'язати його з призначеним для користувача типом даних для оцінки.
CREATE RULE range_rule  
AS 
@range>= 1 AND @range<=5; 
GO

sp_bindrule @rulename = range_rule,
     @objname = stud_mark,
	 @futureonly =  NULL;	/*NULL - the new rule is bound to any columns of the user-defined data type that
								currently have no rule or that are using the existing rule of the user-defined
								data type.*/
GO

--6.Створити таблицю "Успішність студента", використовуючи новий тип даних. У таблиці повинні бути оцінки студента з кількох предметів.

CREATE TABLE Discipline(id_disc INT PRIMARY KEY,
						mark stud_mark, discipline NVARCHAR(40));
GO
--DROP TABLE Discipline;

CREATE TABLE Success_stud(id_stud INT, id_disc INT,
							FOREIGN KEY (id_stud) REFERENCES Student(id_stud) ON UPDATE CASCADE ON DELETE CASCADE,
							FOREIGN KEY (id_disc) REFERENCES Discipline(id_disc) ON UPDATE CASCADE ON DELETE CASCADE,);
GO
--DROP TABLE Success_stud;
--7.Скасувати всі прив'язки і видалити з бази даних тип даних користувача, замовчування і правило.

sp_unbindefault stud_mark_def;
sp_droptype 'stud_mark'; --can't, it is being referenced 
sp_unbindrule 'stud_mark';
DROP TYPE stud_mark; --can't, it being referenced
DROP DEFAULT stud_mark_def; --can't, it is bound
DROP RULE range_rule; -- can't,it is bound
