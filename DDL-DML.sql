/*
This sql file contains creation and manipulation of a few databases to handle specific
situations and usecases. The focus of this file is to explore the DDL commands with a few
other sql concepts to 
*/

USE SQL_Fundamentals;

-- >>>>> QUERY PS 1 >>>>> -- 
/* 
Create a Horse table with the following columns, data types, and constraints. 
NULL is allowed unless 'not NULL' is explicitly stated.
ID - integer with range 0 to 65 thousand, auto increment, primary key
RegisteredName - variable-length string with max 15 chars
Breed - variable-length string with max 20 chars, must be one of the following: 
Egyptian Arab, Holsteiner, Quarter Horse, Paint, Saddlebred
Height - number with 3 significant digits and 1 decimal place, must be ≥ 10.0 and ≤ 20.0
BirthDate - date, must be ≥ Jan 1, 2015
 */

-- Drop an existing table with the same name if exists to avoid duplicate tables error.
DROP TABLE IF EXISTS Horse;

CREATE TABLE Horse (
    ID SMALLINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    RegisteredName VARCHAR(15),
    Breed VARCHAR(20) CHECK (Breed IN ('Egyptian Arab' , 'Holsteiner',
        'Quarter Horse',
        'Paint',
        'Saddlebred')),
    Height DECIMAL(3 , 1 ) CHECK (20.0 >= Height >= 10.0),
    BirthDate DATE CHECK (BirthDate >= '2015-01-01')
);

/*
EXPLANATION: 
>> The ID column is an auto-incrementing integer that starts at 0 
and can go up to 65,535 (the maximum value for an unsigned 16-bit small integer).
>> The RegisteredName column is a string with a maximum length of 15 characters and cannot be null.
>> The Breed column is a string with a maximum length of 20 characters that that checks if the values belong
to one of five options: Egyptian Arab, Holsteiner, Quarter Horse, Paint, or Saddlebred. It cannot be null.
>> The Height column is a decimal number with a maximum of 4 digits, one of which is after the decimal point. 
It must be between 10.0 and 20.0 (inclusive), and it cannot be null.
The BirthDate column is a date that cannot be null and must be on or after January 1, 2015.
*/

-- >>>>> QUERY PS 2 >>>>> --
/*
Insert the following data into the Horse table:

RegisteredName			Breed			Height			BirthDate
Babe				Quarter Horse		15.3			2015-02-10
Independence		  Holsteiner		16.0			2017-03-13
Ellie				  Saddlebred		15.0			2016-12-22
NULL				 Egyptian Arab		14.9			2019-10-12
*/
INSERT INTO Horse (RegisteredName, Breed, Height, BirthDate)
VALUES ('Babe', 'Quarter Horse', 15.3, '2015-02-10'),
    ('Independence', 'Holsteiner', 16.0, '2017-03-13'),
    ('Ellie', 'Saddlebred', 15.0, '2016-12-22'),
    (NULL, 'Egyptian Arab', 14.9, '2019-10-12');
    
-- >>>>> QUERY PS 3 >>>>> --
/*
Make the following updates:

Change the height to 15.6 for horse with ID 2.
Change the registered name to Lady Luck and birth date to May 1, 2015 for horse with ID 4.
Change every horse breed to NULL for horses born on or after December 22, 2016.
*/

UPDATE Horse SET Height = 15.6
WHERE ID = 2;

UPDATE Horse SET RegisteredName = 'Lady Luck', BirthDate = '2015-05-01'
WHERE ID = 4;

UPDATE Horse SET Breed = NULL
WHERE BirthDate >= CAST('2016-12-22' as Date);

-- >>>>> QUERY PS 4 >>>>> --
/*Delete the following rows:

Horse with ID 5.
All horses with breed Holsteiner or Paint.
All horses born before March 13, 2013.

*/

DELETE FROM Horse WHERE ID = 5;

DELETE FROM Horse WHERE Breed = 'Holsteiner' or Breed = 'Paint';

DELETE FROM Horse WHERE BirthDate < CAST('2013-03-13' as Date);

-- >>>>> QUERY PS 5 >>>>> --
/*
Write a SELECT statement to select the registered name, height, and birth date for only horses 
that have a height between 15.0 and 16.0 (inclusive) or have a birth date on or after January 1, 2020.
*/

SELECT RegisteredName, Height, BirthDate
FROM Horse
WHERE Height BETWEEN 15.0 AND 16.0 OR
BirthDate >= CAST('2020-01-01' as DATE);

/*
The Movie table has the following columns:

ID - positive integer
Title - variable-length string
Genre - variable-length string
RatingCode - variable-length string
Year - integer
Write ALTER statements to make the following modifications to the Movie table:

Add a Producer column with VARCHAR data type (max 50 chars).
Remove the Genre column.
Change the Year column's name to ReleaseYear, and change the data type to SMALLINT.
*/

ALTER TABLE Movie ADD Producer VARCHAR(50);
ALTER TABLE Movie DROP COLUMN Genre;
ALTER TABLE Movie CHANGE COLUMN Year ReleaseYear DATE;
ALTER TABLE Movie MODIFY COLUMN ReleaseYear SMALLINT;

-- >>>>> QUERY PS 6 >>>>> --
/*
Two tables are created:
Horse with columns:
ID - integer, primary key
RegisteredName - variable-length string
Student with columns:

ID - integer, primary key
FirstName - variable-length string
LastName - variable-length string
Create the LessonSchedule table with columns:

HorseID - integer with range 0 to 65 thousand, not NULL, partial primary key, foreign key references Horse(ID)
StudentID - integer with range 0 to 65 thousand, foreign key references Student(ID)
LessonDateTime - date/time, not NULL, partial primary key
If a row is deleted from Horse, the rows with the same horse ID should be deleted from LessonSchedule automatically.
If a row is deleted from Student, the same student IDs should be set to NULL in LessonSchedule automatically.
*/


CREATE TABLE LessonSchedule
(
HorseID smallint UNSIGNED NOT NULL,
StudentID smallint UNSIGNED,
LessonDateTime DATETIME NOT NULL,
PRIMARY KEY(HorseID, LessonDateTime),
FOREIGN KEY (HorseID) REFERENCES Horse(ID) ON DELETE CASCADE,
FOREIGN KEY (StudentID) REFERENCES Student(ID) ON DELETE SET NULL
);


-- >>>>> QUERY PS 7 >>>>> --
/*
Create a Student table with the following column names, data types, and constraints:
ID - integer with range 0 to 65 thousand, auto increment, primary key
FirstName - variable-length string with max 20 chars, not NULL
LastName - variable-length string with max 30 chars, not NULL
Street - variable-length string with max 50 chars, not NULL
City - variable-length string with max 20 chars, not NULL
State - fixed-length string of 2 chars, not NULL, default "TX"
Zip - integer with range 0 to 16 million, not NULL
Phone - fixed-length string of 10 chars, not NULL
Email - variable-length string with max 30 chars, must be unique
*/
DROP TABLE IF EXISTS Student;
CREATE TABLE Student
(
ID smallint UNSIGNED AUTO_INCREMENT PRIMARY KEY,
FirstName VARCHAR(20) NOT NULL,
LastName VARCHAR(30) NOT NULL,
Street VARCHAR(50) NOT NULL,
City VARCHAR(20) NOT NULL,
State CHAR(2) NOT NULL DEFAULT 'TX',
Zip mediumint unsigned NOT NULL,
Phone CHAR(10) NOT NULL,
Email VARCHAR(30) UNIQUE);

/*
EXPLANATION: 
>> This creates a table called "Student" with the specified columns and constraints. 
>> The ID column is set to auto-increment and serve as the primary key. 
>> The FirstName, LastName, Street, City, Zip, Phone columns are set to not allow NULL values. 
>> The State column has a default value of "TX".
>> Since the range for minimum and maximum UNSIGNED values equals 0 and 16777215 respectively, 
it suits to be the perfect data type for our Zip column.
*/
