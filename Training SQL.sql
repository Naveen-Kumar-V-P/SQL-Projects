create database Training ;
USE Training ;

CREATE TABLE Department (
	DEPT_ID INT Primary Key,
    DEPT_Name Varchar(20),
    Location Varchar(20)
    
);

CREATE TABLE Employees (
	EMP_ID CHAR(20) Primary Key,
    EMP_Name Varchar(40),
    Status CHAR(1),
	Dept_id INT,
    Hire_Date DATE,
    foreign key (Dept_id) references Department(DEPT_ID)

);

Create Table Projects (
	proj_id INT Primary Key,
    Proj_Name VARCHAR(30),
    Start_Date DATE
    );
    
Create Table Employee_Projects (
	emp_id CHAR(20),
    proj_id INT,
    role VARCHAR(60),
    PRIMARY KEY (EMP_ID, proj_id),
    FOREIGN KEY (EMP_ID) REFERENCES Employees(EMP_ID),
    FOREIGN KEY (proj_id) REFERENCES Projects(proj_id)
);

########### INSTERTING RECORDS ################

INSERT INTO Department (DEPT_ID, DEPT_NAME, Location) VALUES
(1, 'HR', 'New York'),
(2, 'IT', 'San Francisco'),
(3, 'Finance', 'Chicago'),
(4, 'Marketing', 'Los Angeles'),
(5, 'Operations', 'Boston'),
(6, 'Sales', 'Miami'),
(7, 'R&D', 'Seattle'),
(8, 'Legal', 'Dallas'),
(9, 'Support', 'Houston'),
(10, 'Training', 'Denver'),
(11, 'Quality Assurance','Portland'),
(12, 'Customer Service', 'Austin'),
(13, 'Product Design', 'San Diego'),
(14, 'Data Analytics', 'Atlanta'),
(15, 'Security', 'Phoenix');


INSERT INTO Employees (EMP_ID, EMP_NAME, Status, Dept_id, Hire_Date) VALUES
('1234567890', 'John Smith', 'A', 1, '2023-01-15'),
('1234567891', 'Emma Johnson', 'I', 2, '2022-06-20'),
('1234567892', 'Michael Brown', 'A', 3, '2021-09-10'),
('1234567893', 'Sarah Davis', 'I', 4, '2023-03-05'),
('1234567894', 'David Wilson', 'A', 5, '2020-11-12'),
('1234567895', 'Laura Taylor', 'I', 6, '2022-12-01'),
('1234567896', 'James Anderson', 'A', 7, '2021-04-25'),
('1234567897', 'Emily Thomas', 'I', 8, '2023-07-19'),
('1234567898', 'Robert Jackson', 'A', 9, '2020-02-14'),
('1234567899', 'Lisa White', 'I', 10, '2022-08-30'),
('1234567900', 'Alex Chen', 'A', 2, '2021-03-15'),
('1234567901', 'Maria Garcia', 'A', 2, '2022-01-20'),
('1234567902', 'Kevin Lee', 'I', 3, '2020-07-10'),
('1234567903', 'Sophie Martin', 'A', 4, '2023-02-28'),
('1234567904', 'Ryan Clark', 'A', 11, '2021-11-05'),
('1234567905', 'Nina Patel', 'I', 12, '2022-09-18'),
('1234567906', 'Carlos Rodriguez', 'A', 13, '2021-06-12'),
('1234567907', 'Amanda Foster', 'A', 14, '2023-01-08'),
('1234567908', 'Jake Thompson', 'I', 15, '2020-12-03'),
('1234567909', 'Isabella Wong', 'A', NULL, '2023-05-15'),
('1234567910', 'Ethan Davis', 'A', NULL, '2023-06-20'),
('1234567911', 'Grace Kim', 'I', 2, '2021-08-14'),
('1234567912', 'Lucas Miller', 'A', 7, '2022-04-02'),
('1234567913', 'Zoe Johnson', 'A', 1, '2020-10-25'),
('1234567914', 'Mason Scott', 'I', NULL, '2023-03-12');


INSERT INTO Projects (proj_id, Proj_Name, Start_Date) VALUES
(101, 'ERP Upgrade', '2023-01-01'),
(102, 'Website Redesign', '2023-02-15'),
(103, 'Budget Analysis', '2023-03-10'),
(104, 'Ad Campaign', '2023-04-20'),
(105, 'Supply Chain', '2023-05-05'),
(106, 'CRM Integration', '2023-06-12'),
(107, 'AI Research', '2023-07-01'),
(108, 'Compliance Audit', '2023-08-15'),
(109, 'Helpdesk System', '2023-09-10'),
(110, 'Training Portal', '2023-10-01'),
(111, 'Mobile App Dev', '2023-11-15'),
(112, 'Data Migration', '2023-12-01'),
(113, 'Security Upgrade', '2024-01-10'),
(114, 'Cloud Migration', '2024-02-05'),
(115, 'Performance Opt', '2024-03-01'),
(116, 'UI/UX Redesign', '2024-03-15'),
(117, 'API Development', '2024-04-01'),
(118, 'Testing Framework', '2024-04-20'),
(119, 'Documentation', '2024-05-01'),
(120, 'Legacy System', '2024-05-15');

INSERT INTO Employee_Projects (EMP_ID, proj_id, role) VALUES
('1234567890', 101, 'HR Manager'),
('1234567891', 102, 'Lead Developer'),
('1234567892', 103, 'Analyst'),
('1234567893', 104, 'Marketing Lead'),
('1234567894', 105, 'Operations Head'),
('1234567895', 106, 'Sales Coordinator'),
('1234567896', 107, 'Researcher'),
('1234567897', 108, 'Legal Advisor'),
('1234567898', 109, 'Support Lead'),
('1234567899', 110, 'Trainer'),
('1234567890', 111, 'Project Manager'),
('1234567890', 112, 'Stakeholder'),
('1234567891', 113, 'Senior Developer'),
('1234567891', 114, 'Tech Lead'),
('1234567892', 115, 'Business Analyst'),
('1234567900', 102, 'Developer'),
('1234567900', 116, 'Frontend Developer'),
('1234567901', 117, 'Backend Developer'),
('1234567902', 103, 'Financial Analyst'),
('1234567903', 118, 'Marketing Specialist'),
('1234567904', 119, 'QA Engineer'),
('1234567905', 120, 'Customer Support'),
('1234567906', 116, 'UI Designer'),
('1234567907', 115, 'Data Scientist'),
('1234567908', 113, 'Security Analyst'),
('1234567911', 114, 'DevOps Engineer'),
('1234567912', 107, 'Research Scientist'),
('1234567913', 111, 'HR Coordinator');


#################### INNER JOIN ####################

Select 
e.EMP_ID,
e.EMP_NAME,
e.Status,
d.DEPT_NAME,
d.Location
FROM Employees e
INNER JOIN Department d ON e.Dept_id = d.DEPT_ID
ORDER BY e.EMP_NAME;

############## LEFT JOIN #############

Select 
e.EMP_NAME,
e.EMP_ID,
e.Status,
COALESCE (d.Dept_Name,'NO Department') as DEPT_NAME,
COALESCE (d.Location,'NOT Assigned') as Location
FROM Employees e
LEFT JOIN Department d ON e.dept_id = d.DEPT_ID
ORDER BY e.EMP_NAME;

############## LEFT JOIN WITH NULL CHECK #############

Select 
e.EMP_ID,
e.EMP_NAME,
e.Status,
e.Hire_Date
FROM Employees e
LEFT JOIN Department d ON e.Dept_id = d.DEPT_ID
WHERE d.DEPT_ID IS NULL
ORDER BY e.Hire_Date;

###################### RIGHT JOIN ####################

SELECT 
    d.DEPT_ID,
    d.DEPT_NAME,
    d.Location
FROM Employees e
RIGHT JOIN Department d ON e.Dept_id = d.DEPT_ID
WHERE e.EMP_ID IS NULL
ORDER BY d.DEPT_NAME;

###################### RIGHT JOIN WITH NULL CHECK ####################

SELECT 
    d.DEPT_ID,
    d.DEPT_NAME,
    d.Location
FROM Employees e
RIGHT JOIN Department d ON e.Dept_id = d.DEPT_ID
WHERE e.Emp_id IS NULL
ORDER BY d.DEPT_NAME;

################# FULL OUTER JOIN (MYSQL DOESN'T SUPPORT FULL JOIN, WE CAN USE UNION') ##################

SELECT 
    e.EMP_ID,
    e.EMP_NAME,
    d.DEPT_NAME,
    d.Location,
    CASE 
        WHEN e.EMP_ID IS NULL THEN 'Department without employees'
        WHEN d.DEPT_ID IS NULL THEN 'Employee without department'
        ELSE 'Matched'
    END as match_status
FROM Employees e
LEFT JOIN Department d ON e.Dept_id = d.DEPT_ID
UNION
SELECT 
    e.EMP_ID,
    e.EMP_NAME,
    d.DEPT_NAME,
    d.Location,
    CASE 
        WHEN e.EMP_ID IS NULL THEN 'Department without employees'
        WHEN d.DEPT_ID IS NULL THEN 'Employee without department'
        ELSE 'Matched'
    END as match_status
FROM Employees e
RIGHT JOIN Department d ON e.Dept_id = d.DEPT_ID
WHERE e.EMP_ID IS NULL;

###################################################################################################

CREATE TABLE Employee_Salary (
    emp_id CHAR(10) PRIMARY KEY,
    base_salary DECIMAL(10,2),
    bonus DECIMAL(8,2) DEFAULT 0,
    effective_date DATE,
    FOREIGN KEY (emp_id) REFERENCES Employees(emp_id)
);


INSERT INTO Employee_Salary (emp_id, base_salary, bonus, effective_date) VALUES
('1234567890', 75000.00, 5000.00, '2023-01-15'),
('1234567891', 95000.00, 8000.00, '2022-06-20'),
('1234567892', 85000.00, 6000.00, '2021-09-10'),
('1234567893', 70000.00, 4000.00, '2023-03-05'),
('1234567894', 90000.00, 7000.00, '2020-11-12'),
('1234567895', 65000.00, 3000.00, '2022-12-01'),
('1234567896', 110000.00, 12000.00, '2021-04-25'),
('1234567897', 100000.00, 10000.00, '2023-07-19'),
('1234567898', 60000.00, 2500.00, '2020-02-14'),
('1234567899', 55000.00, 2000.00, '2022-08-30'),
('1234567900', 80000.00, 5500.00, '2021-03-15'),
('1234567901', 82000.00, 6000.00, '2022-01-20'),
('1234567904', 72000.00, 4500.00, '2021-11-05'),
('1234567906', 78000.00, 5000.00, '2021-06-12'),
('1234567907', 105000.00, 11000.00, '2023-01-08');



#################### COMPLEX JOIN #######################

SELECT 
    e.EMP_NAME as employee_name,
    d.DEPT_NAME,
    p.Proj_name,
    ep.role,
    p.Start_Date,
    COALESCE(es.base_salary, 0) as salary
FROM Employees e
LEFT JOIN Department d ON e.Dept_id = d.DEPT_ID
LEFT JOIN Employee_Projects ep ON e.EMP_ID = ep.emp_id
LEFT JOIN Projects p ON ep.proj_id = p.proj_id
LEFT JOIN Employee_Salary es ON e.EMP_ID = es.emp_id
WHERE e.Status = 'A'
ORDER BY e.EMP_NAME, p.Start_Date;

####################### SELF JOIN #############################

SELECT 
    e1.EMP_NAME as employee1,
    e2.EMP_NAME employee2,
    d.DEPT_NAME
FROM Employees e1
JOIN Employees e2 ON e1.Dept_id = e2.Dept_id AND e1.EMP_ID < e2.emp_id
JOIN Department d ON e1.Dept_id = d.DEPT_ID
WHERE e1.Status = 'A' AND e2.Status = 'A'
ORDER BY d.DEPT_NAME, e1.EMP_NAME;

############################################################################################################################################################################

############## FUNCTIONS #################

use training;

DELIMITER $$
CREATE PROCEDURE GetDepartmentSummary(IN dept_id INT)
BEGIN
    SELECT 
        d.dept_name,
        d.location,
        COUNT(e.emp_id) as total_employees,
        SUM(CASE WHEN e.status = 'A' THEN 1 ELSE 0 END) as active_employees,
        SUM(CASE WHEN e.status = 'I' THEN 1 ELSE 0 END) as inactive_employees,
        AVG(COALESCE(es.base_salary, 0)) as avg_salary,
        MAX(COALESCE(es.base_salary, 0)) as max_salary,
        MIN(COALESCE(es.base_salary, 0)) as min_salary
    FROM Departments d
    LEFT JOIN Employees e ON d.dept_id = e.dept_id
    LEFT JOIN Employee_Salary es ON e.emp_id = es.emp_id
    WHERE d.dept_id = dept_id
    GROUP BY d.dept_id, d.dept_name, d.location;
END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE AddNewEmployee(
    IN p_emp_id CHAR(10),
    IN p_name VARCHAR(15),
    IN p_status CHAR(1),
    IN p_dept_id INT,
    IN p_hire_date DATE,
    OUT p_result VARCHAR(100)
)
BEGIN
    DECLARE dept_exists INT DEFAULT 0;
    DECLARE emp_exists INT DEFAULT 0;
    
    
    SELECT COUNT(*) INTO emp_exists FROM Employees WHERE emp_id = p_emp_id;
    IF emp_exists > 0 THEN
        SET p_result = 'Error: Employee ID already exists';
    ELSE
        IF p_dept_id IS NOT NULL THEN
            SELECT COUNT(*) INTO dept_exists FROM Departments WHERE dept_id = p_dept_id;
            IF dept_exists = 0 THEN
                SET p_result = 'Error: Department does not exist';
            ELSE
                INSERT INTO Employees (emp_id, name, status, dept_id, hire_date)
                VALUES (p_emp_id, p_name, p_status, p_dept_id, p_hire_date);
                SET p_result = 'Success: Employee added successfully';
            END IF;
        ELSE
            INSERT INTO Employees (emp_id, name, status, dept_id, hire_date)
            VALUES (p_emp_id, p_name, p_status, p_dept_id, p_hire_date);
            SET p_result = 'Success: Employee added without department';
        END IF;
    END IF;
END$$
DELIMITER ;


DELIMITER $$
CREATE PROCEDURE UpdateEmployeeStatus(
    IN p_emp_id CHAR(10),
    IN p_new_status CHAR(1),
    OUT p_result VARCHAR(100)
)
BEGIN
    DECLARE old_status CHAR(1);
    DECLARE emp_name VARCHAR(15);
    DECLARE emp_exists INT DEFAULT 0;
    
    SELECT COUNT(*) INTO emp_exists FROM Employees WHERE emp_id = p_emp_id;
    
    IF emp_exists = 0 THEN
        SET p_result = 'Error: Employee not found';
    ELSE
        SELECT status, name INTO old_status, emp_name FROM Employees WHERE emp_id = p_emp_id;
        
        UPDATE Employees SET status = p_new_status WHERE emp_id = p_emp_id;
        
       
        INSERT INTO students_log (student_name) 
        VALUES (CONCAT('Status changed for ', emp_name, ' from ', old_status, ' to ', p_new_status));
        
        SET p_result = CONCAT('Success: Status updated for ', emp_name);
    END IF;
END$$
DELIMITER ;


DELIMITER $$
CREATE PROCEDURE GetEmployeeDetails(IN p_emp_id CHAR(10))
BEGIN
    SELECT 
        e.emp_id,
        e.name,
        e.status,
        CASE e.status WHEN 'A' THEN 'Active' ELSE 'Inactive' END as status_desc,
        e.hire_date,
        CalculateYearsOfService(e.hire_date) as years_of_service,
        COALESCE(d.dept_name, 'No Department') as department,
        COALESCE(d.location, 'Not Assigned') as location,
        COALESCE(es.base_salary, 0) as base_salary,
        COALESCE(es.bonus, 0) as bonus,
        CalculateTotalCompensation(e.emp_id) as total_compensation,
        GetEmployeeProjectCount(e.emp_id) as project_count
    FROM Employees e
    LEFT JOIN Departments d ON e.dept_id = d.dept_id
    LEFT JOIN Employee_Salary es ON e.emp_id = es.emp_id
    WHERE e.emp_id = p_emp_id;
    
    
    SELECT 
        p.proj_name,
        ep.role,
        p.start_date
    FROM Employee_Projects ep
    JOIN Projects p ON ep.proj_id = p.proj_id
    WHERE ep.emp_id = p_emp_id
    ORDER BY p.start_date;
END$$
DELIMITER ;

CALL GetDepartmentSummary(2);

CALL AddNewEmployee('1234567920', 'Test User', 'A', 1, '2024-01-01', @result);
SELECT @result;

CALL GetEmployeeDetails('1234567890');

EXPLAIN
Select * FROM employees e
WHERE EXISTS (Select 1 FROM Department d
WHERE e.Dept_id = d.DEPT_ID );

create index DEPT_ID ON department (DEPT_ID);

Describe employees;

EXPLAIN
SELECT 
    e.EMP_ID,
    e.EMP_NAME,
    e.Status,
    e.Dept_id,
    e.Hire_Date
	FROM Employees e
    JOIN department d ON e.Dept_id = d.DEPT_ID
    JOIN employee_projects ep ON e.EMP_ID = ep.emp_id
    JOIN Projects p ON ep.proj_id = p.proj_id
    JOIN Employee_Salary es ON e.EMP_ID = es.emp_id
    WHERE e.Status= 'A'
    ORDER BY e.EMP_NAME,p.Start_Date;
    
    
Create index Status ON Employees (Status);

