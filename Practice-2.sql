Create Database Department;
Use department;

Create Table Employees (
ID INT PRIMARY KEY,
Emp_name VARCHAR(50),
Salary Decimal (10,2),
Emails VARCHAR(70),
Manager_id INT,
Department_id INT
);

SELECT * FROM Employees;

INSERT INTO Employees (ID,Emp_name,Salary,Emails,Manager_id,Department_id) VALUES
(001,'Jhon',55000,'jhon01@mail.com',01,1),
(002,'Jersy',15000,'jersy@mail.com',02,2), 
(003,'Suresh',35000,'suresh@mail.com',03,3), 
(004,'Kumar',20000,'kumar@mail.com',04,4), 
(005,'Jonny',10000,'jonny@mail.com',05,5), 
(006,'Ramesh',55000,'Ramesh@mail.com',06,6), 
(007,'Naresh',35000,'naresh@mail.com',07,7), 
(008,'Root',15000,'root@mail.com',08,8), 
(009,'Jason',5000,'jason@mail.com',09,9), 
(0010,'Ravi',70000,'ravi@mail.com',10,10),
(0011,'Jhon',55000,'jhon01@mail.com',NULL,11),
(0012,'Jersy',15000,'jersy@mail.com',012,12), 
(0013,'Suresh',35000,'suresh@mail.com',NULL,13);  

##############################################################################

Select MAX(Salary) AS Second_Highest_Salary
FROM Employees
WHERE Salary<(Select MAX(Salary) FROM Employees);

EXPLAIN
Select MAX(Salary) AS THIRD_Highest_Salary
FROM Employees
WHERE Salary<(Select MAX(Salary) FROM Employees
WHERE Salary <(Select MAX(Salary) FROM Employees));

####################################################################################

Select Emails, COUNT(*) From Employees
GROUP BY Emails
HAVING COUNT(*)>1;


INSERT INTO Employees (ID,Emp_name,Salary,Emails,Manager_id,Department_id) VALUES
(0014,'Jhon',55000,'jhon01@mail.com',014,14),
(0015,'Jersy',15000,'jersy@mail.com',015,15), 
(0016,'Suresh',35000,'suresh@mail.com',NULL,16), 
(0017,'Kumar',20000,'kumar@mail.com',017,17), 
(0018,'Jonny',10000,NULL,018,18), 
(0019,'Ramesh',55000,'Ramesh@mail.com',019,19), 
(0020,'Naresh',35000,'naresh@mail.com',020,20), 
(0021,'Root',15000,NUll,021,21);


SELECT * FROM Employees;

###################################################################################

Select * FROM Employees
WHERE Emails IS NULL;

Select * FROM Employees
WHERE Manager_id IS NULL;

SELECT * FROM(
Select 
ID,
Emp_name,
Salary,
Department_id,
RANK() OVER (ORDER BY Salary DESC) AS rnk
FROM Employees) AS ranked
WHERE rnk <=3;

#####################################################################################################

CREATE TABLE sales (
Prodect_id INT Primary Key,
Prodect_name VARCHAR(50),
Total_amount INT,
Customer_id INT,
Order_id INT,
Sale_date DATE
);

SELECT * FROM sales;

INSERT INTO Sales (Prodect_id,Prodect_name,Total_amount,Customer_id,Order_id,Sale_date) VALUES 
(01,'Samsung S22 ULTRA',120000,01,101,'2025-01-17'),
(02,'Samsung S21 ULTRA',110000,02,102,'2025-01-28'),
(03,'APPLE MACBOOK PRO',250000,03,101,'2025-02-15'),
(04,'REALME 8',18000,04,104,'2025-01-26'),
(05,'IPHONE 15 PROMAX',150000,05,105,'2025-03-13'),
(06,'ONIDA TV',35000,06,106,'2025-03-29'),
(07,'SAMSUNG AC',45000,07,107,'2025-04-20'),
(08,'OPPO A7',12000,08,108,'2025-06-06');


SELECT 
Sale_date,
Total_amount,
SUM(Total_amount) OVER (ORDER BY Sale_date) AS Running_total
FROM Sales;

#####################################################################################################

CREATE TABLE Customer(
Customer_id INT PRIMARY KEY,
Customer_name VARCHAR(50),
Product_name VARCHAR(50),
Order_id INT,
Total_amount int
);

SELECT * FROM Customer;


INSERT INTO Customer (Customer_id,Customer_name,Product_name,Order_id,Total_amount) Values
(102,'Ravi','Samsung S21 ULTRA',102,110000),
(101,'Ramesh','APPLE MACBOOK',101,250000),
(104,'Sarvesh','Realme 8',104,18000),
(106,'Sam','ONIDA TV',106,35000),
(108,'Lilly','OPPO A7',108,12000);


SELECT Customer_id, Customer_name
FROM Customer c
JOIN Sales s ON c.Customer_id = s.Customer_id
GROUP BY c.Customer_id, c.Customer_name
HAVING COUNT(s.order_id) > 3;


#############################################################################################












