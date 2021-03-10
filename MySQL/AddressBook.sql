
//UC 1

CREATE DATABASE addressbook_service;
USE addressbook_service;

SELECT DATABASE();
+---------------------+
| DATABASE()          |
+---------------------+
| addressbook_service |
+---------------------+


//UC 2

CREATE TABLE addressbook
( 
 first_name VARCHAR(25) NOT NULL,
 last_name VARCHAR(25) NOT NULL,
 address VARCHAR(50) NOT NULL,
 city VARCHAR(50) NOT NULL,
 state VARCHAR(50) NOT NULL,
 zipcode VARCHAR(50) NOT NULL,
 phone VARCHAR(20) NOT NULL,
 email VARCHAR(100) NOT NULL
);

//UC 3

INSERT INTO addressbook VALUES 
('Ram','Chavan ','Bawada','Kolhapur','Maharashtra','700075','9898989898','ram@gmail.com'),
('Aritra','Biranje ','Udyannagar','Kolhapur','Maharashtra','655423','8787878787','aritra@gmail.com'), 
('Prakash','Gupta','Warana','Kolhapur','Maharashtra','700062','9876987623','prakash@gmail.com');

//UC 4


UPDATE addressbook SET city = 'Pune' WHERE first_name = 'Ram';

//UC 5

DELETE FROM addressbook WHERE first_name = 'Ram';

//UC 6

SELECT * FROM addressbook WHERE city = 'Kolhapur';
+------------+-----------+------------+----------+-------------+---------+------------+-------------------+
| first_name | last_name | address    | city     | state       | zipcode | 	phone	  | 	email         |
+------------+-----------+------------+----------+-------------+---------+------------+-------------------+
| Aritra     | Biranje   | Udyannagar | Kolhapur | Maharashtra | 655423  | 8787878787 | aritra@gmail.com  |
| Prakash    | Gupta     | Warana     | Kolhapur | Maharashtra | 700062  | 9876987623 | prakash@gmail.com |
+------------+-----------+------------+----------+-------------+---------+------------+-------------------+


SELECT * FROM addressbook WHERE state = 'Maharashtra';
+------------+-----------+------------+----------+-------------+---------+------------+-------------------+
| first_name | last_name | address    | city     | state       | zipcode |   phone    |     email         |
+------------+-----------+------------+----------+-------------+---------+------------+-------------------+
| Aritra     | Biranje   | Udyannagar | Kolhapur | Maharashtra | 655423  | 8787878787 | aritra@gmail.com  |
| Prakash    | Gupta     | Warana     | Kolhapur | Maharashtra | 700062  | 9876987623 | prakash@gmail.com |
+------------+-----------+------------+----------+-------------+---------+------------+-------------------+


//UC 7

SELECT city,COUNT(city) FROM addressbook GROUP BY city;
+----------+-------------+
| city     | COUNT(city) |
+----------+-------------+
| Kolhapur |           2 |
+----------+-------------+

SELECT state,COUNT(state) FROM addresbook GROUP BY state;

//UC 8

INSERT INTO addressbook VALUES('Rohan', 'Patil', 'Pachgaoa', 'Sangali', 'Karnataka', '700075', '9898989898', 'rohan@gmail.com');
SELECT * FROM addressbook WHERE city = 'Sangali' ORDER BY first_name; 

+------------+-----------+----------+---------+-----------+---------+------------+-----------------+
| first_name | last_name | address  | city    | state     | zipcode | phone      | email           |
+------------+-----------+----------+---------+-----------+---------+------------+-----------------+
| Rohan      | Patil     | Pachgaoa | Sangali | Karnataka | 700075  | 9898989898 | rohan@gmail.com |
+------------+-----------+----------+---------+-----------+---------+------------+-----------------+


//UC 9

ALTER TABLE addressbook ADD type VARCHAR(25);

//UC 10

INSERT INTO addressbook VALUES ('Sneha','Gupta','Sector 5','Waranasi','UP','700024','9887656234','sneha@gmail.com','Family'); 
SELECT type, COUNT(type) FROM addressbook GROUP BY type;


+--------+-------------+
| type   | COUNT(type) |
+--------+-------------+
| NULL   |           0 |
| Family |           1 |
+--------+-------------+


//UC 11

INSERT INTO addressbook VALUES                 
('Mohan','Kapur','Hawa Mahal','Jaipur','Rajsthan','766156','7617987816','mohan@gmail.com','Friend'),                           
('Subham','Pande','Ennore','Chennai','Tamil Nadu','799816','8716735622','subham@gmail.com','Family'); 
SELECT type, COUNT(type) FROM addressbook GROUP BY type;


+--------+-------------+
| type   | COUNT(type) |
+--------+-------------+
| NULL   |           0 |
| Family |           2 |
| Friend |           1 |
+--------+-------------+

//UC 12

ER Diagram 

//UC 13

CREATE TABLE AdressBook (addressbook_name VARCHAR(100) NOT NULL PRIMARY KEY, type VARCHAR(100) NOT NULL);

INSERT INTO AdressBook VALUES ('Book 1', 'Family'), ('Book 2', 'Friend'), ('Book 3', 'NULL');

CREATE TABLE Contacts
(person_id INT NOT NULL PRIMARY KEY,
 addressbook_name VARCHAR(100) REFERENCES AdressBook(addressbook_name),
 first_name VARCHAR(100) NOT NULL,
 last_name VARCHAR(100) NOT NULL
);

INSERT INTO Contacts VALUES
(1, 'NULL', 'Vinayak', 'Chavan'),
(2, 'NULL', 'Sham', 'Solanki'),
(3, 'NULL', 'Prakash', 'Maran'),
(4, 'Family', 'Sneha', 'Gupta'),
(5, 'Family', 'Subham', 'Roy'),
(6, 'Friend', 'Debashish', 'mallya');

CREATE TABLE Contact_details
(person_id INT REFERENCES Contacts(person_id),
 phone VARCHAR(20) NOT NULL,
 email VARCHAR(100) NOT NULL
);

INSERT INTO Contact_details VALUES
(1, '9898989898', 'Vinayak@gmail.com'),
(2, '8787878787', 'Sham@gmail.com'),
(3, '9876987623', 'Prakash@gmail.com'),
(4, '9887656234', 'sneha@gmail.com'),
(5, '8716735622', 'subham@gmail.com'),
(6, '7617987816', 'debashish@gmail.com');


CREATE TABLE Address(
person_id    INT REFERENCES Contacts(person_id),
street  VARCHAR(50) NOT NULL,
city  VARCHAR(50) NOT NULL,
state  VARCHAR(50) NOT NULL,
zipcode  VARCHAR(50) NOT NULL);

INSERT INTO Address VALUES
(1, 'Sensowa', 'Jorhat', 'Assam', '700075'),
(2, 'Hoskote', 'Bangalore', 'Karnataka', '655423'),
(3, 'Vypin', 'Kochi', 'keral', '700062'),
(4, 'Dharavi', 'Munbai', 'Maharashtra', '700024'),
(5, 'Chhehatra', 'Amritsar', 'Punjab', '799816'),
(6, 'Avadi', 'Chennai', 'Tamilnadu', '766156');
