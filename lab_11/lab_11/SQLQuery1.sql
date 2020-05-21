-- БД  студентов (факультет – специальность – группа – студент). 
CREATE DATABASE [students]

CREATE TABLE Faculty(
id_faculty INT NOT NULL PRIMARY KEY,
faculty_name NVARCHAR(MAX) NOT NULL);

CREATE TABLE Speciality(
id_speciality INT NOT NULL PRIMARY KEY,
id_faculty INT NOT NULL,
spec_name NVARCHAR(MAX) NOT NULL,
FOREIGN KEY (id_faculty) REFERENCES Faculty (id_faculty) ON UPDATE CASCADE ON DELETE CASCADE);

CREATE TABLE AcademicGroup(
id_speciality INT NOT NULL,
id_group INT NOT NULL PRIMARY KEY,
group_numb INT NOT NULL,
FOREIGN KEY (id_speciality) REFERENCES Speciality (id_speciality) ON UPDATE CASCADE ON DELETE CASCADE);

CREATE TABLE Student
(stud_name NVARCHAR(max) NOT NULL,
 id_group INT NOT NULL,
 FOREIGN KEY (id_group) REFERENCES AcademicGroup (id_group) ON UPDATE CASCADE ON DELETE CASCADE);
