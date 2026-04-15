Create database Subqueries;

Use Subqueries;

Create table Employee (
Emp_id INT PRIMARY KEY,
Name VARCHAR(100),
Department_id VARCHAR(100),
Salary INT
);

Select * from Employee;

INSERT into Employee (Emp_ID,Name,Department_ID,Salary) VALUES
(101,'Abhishek','D01',62000),
(102,'Shubham','D01',58000),
(103,'Priya','D02',67000),
(104,'Rohit','D02',64000),
(105,'Neha','D03',72000),
(106,'Aman','D03',55000),
(107,'Ravi','D04',60000),
(108,'Sneha','D04',75000),
(109,'Kiran','D05',70000),
(110,'Tanuja','D05',65000);


Create table Department (
Department_id VARCHAR PRIMARY KEY,
Department_name VARCHAR(100),
Location VARCHAR(100)
);

ALTER TABLE Department
MODIFY Department_id VARCHAR(100);

INSERT into Department (Department_id,Department_name,Location) VALUES
('D01','Sales','Mumbai'),
('D02','Marketing','Delhi'),
('D03','Finance','Pune'),
('D04','HR','Bengaluru'),
('D05','IT','Hyderabad');

Select * from Department;


Create table Sales (
Sale_id INT PRIMARY KEY,
Emp_id INT,
Sale_amount INT,
Sale_date date);

Select * from Sales;

INSERT INTO Sales (sale_id,emp_id,sale_amount,sale_date) values
(201,101,4500,'2025-01-05'),
(202,102,7800,'2025-01-10'),
(203,103,6700,'2025-01-14'),
(204,104,12000,'2025-01-20'),
(205,105,9800,'2025-02-02'),
(206,106,10500,'2025-02-05'),
(207,107,3200,'2025-02-09'),
(208,108,5100,'2025-02-15'),
(209,109,3900,'2025-02-20'),
(210,110,7200,'2025-03-01');

-- Retrieve the names of employees who earn more than the average salary of all employees. --
select * from employee;
select avg(salary) from employee;

Select Name, Salary
from Employee
where salary > (select avg(salary) from employee);

-- Find the employees who belong to the department with the highest average salary. --

Select Name, Salary, Department_ID
from Employee
where Department_ID = (
Select Department_ID
from Employee
GROUP BY department_id
ORDER BY AVG(salary) DESC
Limit 1
);


-- List all employees who have made at least one sale. --

SELECT DISTINCT emp_id FROM Sales;

SELECT name, emp_id 
FROM Employee 
WHERE emp_id IN (SELECT DISTINCT emp_id FROM Sales);


-- Find the employee with the highest sale amount. -- 

Select max(sale_amount) from Sales;

select name
from Employee
where Emp_id = (SELECT emp_id 
FROM Sales 
WHERE sale_amount = (SELECT MAX(sale_amount) FROM Sales)
);


-- Retrieve the names of employees whose salaries are higher than Shubham’s salary. -- 

SELECT salary FROM Employee WHERE name = 'Shubham';

Select Name, salary
from employee
where Salary >(SELECT salary FROM Employee WHERE name = 'Shubham')
order by Salary desc;

-- Find employees who work in the same department as Abhishek. --

select department_id
from Employee
where name ='Abhishek';

select Name, department_id
from Employee
where department_id = (select department_id
from Employee
where name ='Abhishek');

-- List departments that have at least one employee earning more than ₹60,000 --

SELECT department_name
FROM Department
WHERE department_id IN (
SELECT DISTINCT department_id
FROM Employee
WHERE salary > 60000
);

-- Find the department name of the employee who made the highest sale. --

Select max(sale_amount) from Sales;

Select Department_name
from Department
where department_id=(SELECT department_id 
FROM Employee 
WHERE emp_id = (SELECT emp_id FROM Sales 
WHERE sale_amount = (SELECT MAX(sale_amount) FROM Sales)));

-- Retrieve employees who have made sales greater than the average sale amount --

Select avg(sale_amount) from Sales;

Select name
from Employee
where emp_id in (
SELECT emp_id 
FROM Sales 
WHERE sale_amount > (Select avg(sale_amount) from Sales));
    

-- Find the total sales made by employees who earn more than the average salary --

SELECT SUM(sale_amount) AS total_sales_by_high_earners
FROM Sales
WHERE emp_id IN (
SELECT emp_id 
FROM Employee 
WHERE salary > (SELECT AVG(salary) FROM Employee));


-- Find employees who have not made any sales. --

SELECT name 
FROM Employee 
WHERE emp_id NOT IN (SELECT DISTINCT emp_id FROM Sales);

-- List departments where the average salary is above ₹55,000. --

SELECT department_name
FROM Department
WHERE department_id IN (
SELECT department_id
FROM Employee
GROUP BY department_id
HAVING AVG(salary) > 55000
);


-- Retrieve department names where the total sales exceed ₹10,000. -- 

SELECT department_name
FROM Department
WHERE department_id IN (
SELECT e.department_id
FROM Employee e
JOIN Sales s ON e.emp_id = s.emp_id
GROUP BY e.department_id
HAVING SUM(s.sale_amount) > 10000
);

-- Find the employee who has made the second-highest sale. --

SELECT name 
FROM Employee 
WHERE emp_id = (
SELECT emp_id 
FROM Sales 
ORDER BY sale_amount DESC 
LIMIT 1 OFFSET 1
);

-- Retrieve the names of employees whose salary is greater than the highest sale amount recorded --

SELECT name 
FROM Employee 
WHERE salary > (SELECT MAX(sale_amount) FROM Sales);

-- Thank You -- 
















