

CREATE TABLE employee (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    department VARCHAR(30),
    salary DECIMAL(10,2),
    manager_id INT,
    hire_date DATE
);

CREATE TABLE departments (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(30),
    location VARCHAR(30)
);

INSERT INTO employee VALUES
(1, 'Ravi', 'IT', 75000, NULL, '2020-01-15'),
(2, 'Priya', 'IT', 65000, 1, '2020-03-20'),
(3, 'Kumar', 'HR', 55000, NULL, '2019-05-10'),
(4, 'Deepa', 'IT', 70000, 1, '2021-01-05'),
(5, 'Arjun', 'Finance', 60000, NULL, '2020-08-12'),
(6, 'Meera', 'HR', 52000, 3, '2021-02-28'),
(7, 'Siva', 'Finance', 58000, 5, '2020-11-15'),
(8, 'Lakshmi', 'IT', 68000, 1, '2019-12-01');

INSERT INTO departments VALUES
(1, 'IT', 'Chennai'),
(2, 'HR', 'Mumbai'),
(3, 'Finance', 'Bangalore');

############### SIMPLE QUERY #####################

SELECT emp_name, salary
FROM employee 
WHERE salary > (
    SELECT AVG(salary) FROM employee
);

################# MULTI VALUE SUBQUERY ####################

SELECT emp_name, department
FROM employee
WHERE department IN (
    SELECT dept_name 
    FROM departments 
    WHERE location = 'Chennai'
);

################# CORRELATED SUBQUERY ###################

SELECT emp_name, department, salary
FROM employee e1
WHERE salary = (
    SELECT MAX(salary)
    FROM employee e2
    WHERE e2.department = e1.department
);

################## COMPLEX CORRELATED SUBQUERY #################

SELECT 
    emp_name, 
    department, 
    salary,
    (SELECT AVG(salary) 
     FROM employee e2 
     WHERE e2.department = e1.department) as dept_avg
FROM employee e1
WHERE salary > (
    SELECT AVG(salary)
    FROM employee e2
    WHERE e2.department = e1.department
);

################## EXIST #########################

SELECT emp_name, department
FROM employee e1
WHERE EXISTS (
    SELECT 1 
    FROM employee e2 
    WHERE e2.manager_id = e1.emp_id
);

################# NOT EXIST ######################

SELECT emp_name, department, salary
FROM employee e1
WHERE NOT EXISTS (
    SELECT 1
    FROM employee e2
    WHERE e2.manager_id = e1.emp_id
);

################### MULTILEVEL CORRELATED QUERY ###################

SELECT emp_name, department, salary
FROM employee e1
WHERE (
    SELECT COUNT(DISTINCT salary)
    FROM employee e2
    WHERE e2.department = e1.department
    AND e2.salary > e1.salary
) = 1;

######################## CORRELATEDD QUERY WITH AGGRIGATION #################

SELECT 
    emp_name,
    department,
    salary,
    (SELECT COUNT(*) 
     FROM employee e2 
     WHERE e2.department = e1.department) as dept_size,
    (SELECT COUNT(*) + 1
     FROM employee e2
     WHERE e2.department = e1.department 
     AND e2.salary > e1.salary) as salary_rank,
    salary - (SELECT AVG(salary) 
              FROM employee e2 
              WHERE e2.department = e1.department) as diff_from_avg
FROM employee e1
ORDER BY department, salary DESC;

##################### Slow - Correlated subquery ####################

SELECT emp_name, salary
FROM employee e1
WHERE salary > (
    SELECT AVG(salary) 
    FROM employee e2 
    WHERE e2.department = e1.department
);

#################### Fast - Window function alternative #####################
SELECT emp_name, salary
FROM (
    SELECT 
        emp_name, 
        salary,
        department,
        AVG(salary) OVER (PARTITION BY department) as dept_avg
    FROM employee
) t
WHERE salary > dept_avg;

####################
