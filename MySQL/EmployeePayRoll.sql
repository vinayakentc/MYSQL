//UC 1

CREATE DATABASE payroll_service;
Query OK, 1 row affected

show databases;
+--------------------+
| Database           |
+--------------------+
| information_schema |
| mysql              |
| payroll_service    |
| performance_schema |
| register           |
| sakila             |
| sys                |
| world              |
+--------------------+

USE payroll_service;
Database changed

SELECT DATABASE();
+-----------------+
| DATABASE()      |
+-----------------+
| payroll_service |
+-----------------+


//UC 2

CREATE TABLE employee_payroll 
(
  id    INT unsigned NOT NULL AUTO_INCREMENT,
  name  VARCHAR(150) NOT NULL,
  salary  DOUBLE NOT NULL,
  start   DATE NOT NULL,
  PRIMARY KEY   (id)
);

DESCRIBE employee_payroll;

+--------+--------------+------+-----+---------+----------------+
| Field  | Type         | Null | Key | Default | Extra          |
+--------+--------------+------+-----+---------+----------------+
| id     | int unsigned | NO   | PRI | NULL    | auto_increment |
| name   | varchar(150) | NO   |     | NULL    |                |
| salary | double       | NO   |     | NULL    |                |
| start  | date         | NO   |     | NULL    |                |
+--------+--------------+------+-----+---------+----------------+

//UC 3

INSERT INTO employee_payroll(name, salary, start) VALUES
 ('Vinayak', 50000, '2020-11-04'),
 ('Girish', 60000, '2020-07-05'),
 ('Bhopale', 70000, '2020-01-14');

 //UC 4

 SELECT * FROM employee_payroll;

+----+---------+--------+------------+
| id | name    | salary | start      |
+----+---------+--------+------------+
|  1 | Vinayak |  50000 | 2020-11-04 |
|  2 | Girish  |  60000 | 2020-07-05 |
|  3 | Bhopale |  70000 | 2020-01-14 |
+----+---------+--------+------------+

//UC 5 

SELECT salary FROM employee_payroll
  WHERE name = 'Vinayak';

+--------+
| salary |
+--------+
|  50000 |
+--------+

SELECT * FROM employee_payroll 
  WHERE start BETWEEN CAST('2020-01-01' AS DATE) AND DATE(NOW());

+----+---------+--------+------------+
| id | name    | salary | start      |
+----+---------+--------+------------+
|  1 | Vinayak |  50000 | 2020-11-04 |
|  2 | Girish  |  60000 | 2020-07-05 |
|  3 | Bhopale |  70000 | 2020-01-14 |
+----+---------+--------+------------+


//UC 6
ALTER TABLE employee_payroll ADD gender CHAR(1) AFTER name;

UPDATE employee_payroll SET gender = 'M' WHERE name = 'Vinayak' OR name = 'Girish';
UPDATE employee_payroll SET gender = 'F' WHERE name = 'Bhopale';


//UC 7

SELECT gender, AVG(salary) FROM employee_payroll GROUP BY gender;
+--------+-------------+
| gender | AVG(salary) |
+--------+-------------+
| M      |       55000 |
| F      |       70000 |
+--------+-------------+

SELECT gender, COUNT(name) FROM employee_payroll GROUP BY gender;
+--------+-------------+
| gender | COUNT(name) |
+--------+-------------+
| M      |           2 |
| F      |           1 |
+--------+-------------+

SELECT gender, SUM(salary) FROM employee_payroll GROUP BY gender;
+--------+-------------+
| gender | SUM(salary) |
+--------+-------------+
| M      |      110000 |
| F      |       70000 |
+--------+-------------+

//UC 8

ALTER TABLE employee_payroll ADD phone_number VARCHAR(250) AFTER name;
ALTER TABLE employee_payroll ADD address VARCHAR(250) AFTER phone_number;
ALTER TABLE employee_payroll ADD department VARCHAR(150) NOT NULL AFTER address;
ALTER TABLE employee_payroll ALTER address SET DEFAULT 'TBD';
DESCRIBE employee_payroll;

+--------------+--------------+------+-----+---------+----------------+
| Field        | Type         | Null | Key | Default | Extra          |
+--------------+--------------+------+-----+---------+----------------+
| id           | int unsigned | NO   | PRI | NULL    | auto_increment |
| name         | varchar(150) | NO   |     | NULL    |                |
| phone_number | varchar(250) | YES  |     | NULL    |                |
| address      | varchar(250) | YES  |     | TBD     |                |
| department   | varchar(150) | NO   |     | NULL    |                |
| gender       | char(1)      | YES  |     | NULL    |                |
| salary       | double       | NO   |     | NULL    |                |
| start        | date         | NO   |     | NULL    |                |
+--------------+--------------+------+-----+---------+----------------+

//UC 9

ALTER TABLE employee_payroll RENAME COLUMN salary TO basic_pay;
ALTER TABLE employee_payroll ADD deductions DOUBLE NOT NULL AFTER basic_pay;
ALTER TABLE employee_payroll ADD taxable_pay DOUBLE NOT NULL AFTER deductions;
ALTER TABLE employee_payroll ADD tax DOUBLE NOT NULL AFTER taxable_pay;
ALTER TABLE employee_payroll ADD net_pay DOUBLE NOT NULL AFTER tax;
SELECT * FROM employee_payroll;

+----+---------+--------------+---------+------------+--------+-----------+------------+-------------+------+---------+------------+
| id | name    | phone_number | address | department | gender | basic_pay | deductions | taxable_pay | tax  | net_pay | start      |
+----+---------+--------------+---------+------------+--------+-----------+------------+-------------+------+---------+------------+
|  1 | Vinayak | NULL         | NULL    |            | M      |     50000 |		0 	   |      0 	 |   0  |    0 	  | 2020-11-04 |
|  2 | Girish  | NULL         | NULL    |            | M      |     60000 |		0 	   |      0      |   0  |    0    | 2020-07-05 |
|  3 | Bhopale | NULL         | NULL    | Sales      | F      |     70000 |		0 	   |      0      |   0  |    0    | 2020-01-14 |
|  4 | Bhopale | NULL         | TBD     | Marketing  | F      |     55000 |    2000    |    53000    | 1000 |   52000 | 2021-01-03 |
+----+---------+--------------+---------+------------+--------+-----------+------------+-------------+------+---------+------------+

//UC 10

UPDATE employee_payroll SET department = 'Sales' WHERE name = 'Bhopale';
INSERT INTO employee_payroll ( name, department, gender, basic_pay, deductions, taxable_pay, tax, net_pay, start) VALUES ('Bhopale', 'Marketing', 'F', 55000, 2000, 53000, 1000, 52000, '2021-01-03');
SELECT * FROM employee_payroll WHERE name = 'Bhopale';
+----+---------+--------------+---------+------------+--------+-----------+------------+-------------+------+---------+------------+
| id | name    | phone_number | address | department | gender | basic_pay | deductions | taxable_pay | tax  |net_pay | start      |
+----+---------+--------------+---------+------------+--------+-----------+------------+-------------+------+---------+------------+
|  3 | Bhopale | NULL         | NULL    | Sales      | F      |     70000 |          0 |           0 |    0 |	0 	 | 2020-01-14 |
|  4 | Bhopale | NULL         | TBD     | Marketing  | F      |     55000 |       2000 |       53000 | 1000 |  52000 | 2021-01-03 |
+----+---------+--------------+---------+------------+--------+-----------+------------+-------------+------+---------+------------+

//UC 11

CREATE TABLE company ( company_id INT PRIMARY KEY, company_name VARCHAR(150) NOT NULL );

CREATE TABLE employee 					
(
 id 		INT unsigned NOT NULL AUTO_INCREMENT PRIMARY KEY,
 company_id 	INT REFERENCES company(company_id),
 name           VARCHAR(200) NOT NULL,
 phone_number 	VARCHAR(25) NOT NULL,
 address 	VARCHAR(50) NOT NULL DEFAULT 'TBD',
 gender 	CHAR(1) NOT NULL
);

CREATE TABLE payroll
(
 id 	INT REFERENCES employee(id),
 basic_pay 	DOUBLE NOT NULL,
 deductions 	DOUBLE NOT NULL,
 taxable_pay 	DOUBLE NOT NULL,
 tax 		DOUBLE NOT NULL,
 net_pay 	DOUBLE NOT NULL
);

CREATE TABLE department
(
 dept_id 	INT PRIMARY KEY,
 dept_name 	VARCHAR(100) NOT NULL
);

CREATE TABLE employee_department
(
 emp_id 	INT REFERENCES employee(id),
 dept_id 	INT REFERENCES department(dept_id)
);

//UC 12

INSERT INTO company VALUES 
(1, "Samsung");

INSERT INTO employee(company_id, name, phone_number, address, gender) VALUES 					
(1, 'Prashant', '9898989898', 'Mumbai', 'M' ),
(1, 'Manoj', '7865786523', 'Pune', 'M' ),
(1, 'Radhika', '9976765436', 'Kolhapur', 'F' );

INSERT INTO payroll VALUES 					
(1,50000,1000,49000,500,48500),
(2,60000,3000,57000,1500,55500),
(3,55000,2000,53000,1000,52000);

INSERT INTO department VALUES
(1,'Sales'),
(2,'Marketing'),
(3,'IT');

INSERT INTO employee_department VALUES
(1,3),
(2,3),
(3,1),
(3,2);








