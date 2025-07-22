Create Database Employee_db;
Use Employee_db;


CREATE TABLE employee (
    Emp_name VARCHAR(100),
    department VARCHAR(100),
    salary DECIMAL(10,2)
);

INSERT INTO employee (Emp_name, department, salary) values
('Rajesh','IT',45000),('Suresh','IT',45000);

INSERT INTO employee select * from employee;

select * from employee;

create table employee_new as select * from employee;

select * from employee_new;

SELECT ROW_NUMBER() OVER (partition by Emp_name,DEPARTMENT, SALARY ORDER BY Emp_name) as rn,e.*   FROM
employee e;


ALTER TABLE employee ADD COLUMN emp_id INT AUTO_INCREMENT PRIMARY KEY;

ALTER TABLE employee DROP PRIMARY KEY;


ALTER TABLE employee MODIFY emp_id INT;

ALTER TABLE employee DROP COLUMN emp_id;


describe employee ;

select * FROM employee ;

ALTER TABLE employee ADD COLUMN emp_id INT AUTO_INCREMENT PRIMARY KEY AFTER Emp_name;


SELECT * FROM employee ;

update employee set salary=58900 where emp_id=3;


SELECT *
FROM employee
WHERE salary = (
    SELECT MAX(salary)
    FROM employee
    WHERE salary < (
        SELECT MAX(salary) FROM employee
    )
);



select * from (
SELECT emp_id, Emp_name, salary,
           DENSE_RANK() OVER (ORDER BY salary DESC) AS ranks
    FROM employee )a
    where ranks=1;
    


SELECT *
FROM employee
WHERE salary = (
    SELECT MAX(salary)
    FROM employee
    WHERE salary < (
        SELECT MAX(salary)
        FROM employee
        WHERE salary < (
            SELECT MAX(salary)
            FROM employee
        )
    )
);



ALTER TABLE employee
ADD COLUMN created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP;

SELECT * FROM employee;

DROP PROCEDURE IF EXISTS GetLastNEmployees;



DELIMITER $$

CREATE PROCEDURE GetLastNEmployees(IN num INT)
BEGIN
    SELECT *
    FROM (
        SELECT *
        FROM employee
        ORDER BY created_at DESC, emp_id DESC
        LIMIT num
    ) AS sub
    ORDER BY created_at ASC, emp_id ASC;
END $$

DELIMITER ;

CALL GetLastNEmployees(5);

DELIMITER $$
CREATE PROCEDURE GetSalary()
BEGIN
SELECT * FROM employee_new;
END$$
DELIMITER ;

CALL GetSalary();

DELETE FROM employee where EMP_ID IN(
select EMP_ID from (
select row_number() over (partition by Emp_name order by Emp_name) as Rn,Emp_name,emp_id from employee)a
 where RN<>1
 ) ;
 
 WITH duplicates AS (
  SELECT *,
         ROW_NUMBER() OVER (PARTITION BY Emp_name ORDER BY emp_id) AS rn
  FROM employee
)
DELETE FROM employee
WHERE emp_id IN (
  SELECT emp_id FROM duplicates WHERE rn > 1
);

select * from employee;

