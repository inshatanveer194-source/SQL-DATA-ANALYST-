use employee1;
create database employee1;
create table EmployeeDataset1(
Emp_id int,
EmpName varchar(20),
Department_id int,
Salary int
);
ALTER TABLE EmployeeDataset1
MODIFY Department_id VARCHAR(10);

insert into EmployeeDataset1 
(Emp_id , EmpName , Department_id , Salary)
values
(101 , "Abhishek" , "D01" , 62000),
(102 , "Shubham" , "D01" , 58000),
(103 , "Priya" , "D02" , 67000),
(104 , "Rohit" , "D02" , 64000),
(105 , "Neha" , "D03" , 72000),
(106,"Aman", "D03", 55000),
(107,"Ravi","D04",60000),
(108,"Sneha","D04",75000),
(109,"Kiran","D05",70000),
(110,"Tanuja","D05",65000);

select * from employeedataset1;

create table DepartmentDataset1(
Department_id varchar(10),
DepartmentName varchar(10),
Location varchar(10)
);

insert into DepartmentDataset1
(Department_id , DepartmentName , Location)
values
("D01" , "SALES" , "MUMBAI"),
("D02" , "MARKETING"  , "DELHI"),
("D03" , "FINANCE" , "PUNE"),
("D04" , "HR" , "BENGALURU"),
("D05" , "IT" , "HYDERABAD");

SELECT * FROM DEPARTMENTDATASET1;

create table SalesDataset1(
Sales_id INT ,
Emp_id INT , 
Sales_amt INT , 
Sales_date date
);

select * FROM SALESDATASET1;
INSERT INTO SALESDATASET1
(Sales_id ,Emp_id  ,Sales_amt  ,Sales_date)
VALUES 
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

SELECT * FROM SALESDATASET1;

-- QUESTIONS 
-- Basic Level
-- 1.Retrieve the names of employees who earn more than the average salary of all employees.
select avg(salary) from employeedataset1; -- 64800 
select Empname  from employeedataset1 
where salary >(select avg(salary) from employeedataset1);

-- 2.Find the employees who belong to the department with the highest average salary.
select max(salary) from employeedataset1;
select EmpName , department_id from employeedataset1
where salary = (select max(salary) as highest_salary from employeedataset1);

-- 3.List all employees who have made at least one sale.
select * from salesdataset1;
select distinct e.empname , s.sales_amt from employeedataset1 as e
inner join salesdataset1 as s on s.emp_id = e.emp_id;

-- 4.Find the employee with the highest sale amount.
select max(sales_amt) from salesdataset1; -- 12000 
select e.empname , s.sales_amt from employeedataset1 as e
inner join salesdataset1 as s on s.emp_id = e.emp_id
where s.sales_amt = (select max(sales_amt) from salesdataset1); 

-- 5.Retrieve the names of employees whose salaries are higher than Shubham’s salary.
select salary from employeedataset1 where Empname = 'Shubham'; -- 58000
select EmpName from employeedataset1 
where salary >
(select salary from employeedataset1 where Empname = 'Shubham');  

-- Intermediate Level
-- 1.Find employees who work in the same department as Abhishek.
select e.empname , d.department_id , d.departmentname from employeedataset1 as e
inner join departmentdataset1 as d on d.department_id = e.department_id
where e.department_id = 
(select department_id from employeedataset1 where empname = 'abhishek');

-- 2.List departments that have at least one employee earning more than ₹60,000.
select distinct e.empname , e.salary , d.departmentname from employeedataset1 as e
inner join departmentdataset1 as d on d.department_id = e.department_id
where e.salary > 60000;

-- 3.Find the department name of the employee who made the highest sale.
select  d.departmentname from employeedataset1 as e
inner join departmentdataset1 as d on d.department_id = e.department_id
inner join salesdataset1 as s on s.emp_id = e.emp_id
where s.sales_amt = (select max(sales_amt) as highest_sale from salesdataset1);

-- 4.Retrieve employees who have made sales greater than the average sale amount.
select avg(sales_amt) from salesdataset1;-- 7070
select empname from employeedataset1 as e 
inner join salesdataset1 as s on s.emp_id = e.emp_id
where s.sales_amt > ( select avg(sales_amt) from salesdataset1);
 
-- 5.Find the total sales made by employees who earn more than the average salary
select sum(s.sales_amt) as total_sales from employeedataset1 as e
inner join salesdataset1 as s on s.emp_id = e.emp_id
where e.salary > (select avg(salary) avg_salary from salesdataset1);

-- Advanced Level
-- 1.Find employees who have not made any sales.
select empname from employeedataset1 as e
left join salesdataset1 as s on s.emp_id = e.emp_id
where e.emp_id is null;


-- 2.List departments where the average salary is above ₹55,000.
select d.departmentname , avg(e.salary) as avg_salary from employeedataset1 as e
inner join departmentdataset1 as d on d.department_id = e.department_id 
group by d.departmentname 
having avg_salary > 55000;

-- 3.Retrieve department names where the total sales exceed ₹10,000. 
select d.departmentname , sum(s.sales_amt) as total_sales from employeedataset1 as e
inner join departmentdataset1 as d on d.department_id = e.department_id
inner join salesdataset1 as s on s.emp_id = e.emp_id
group by d.departmentname
having total_sales > 10000;


-- 4.Find the employee who has made the second-highest sale.
select e.empname , s.sales_amt from employeedataset1 as e
inner join salesdataset1 as s on s.emp_id = e.emp_id 
where s.sales_amt = 
(select sales_amt from salesdataset1 order by sales_amt desc limit 1 offset 1);


-- 5.Retrieve the names of employees whose salary is greater than the highest sale amount recorded
select max(sales_amt) from salesdataset1; -- 12000 
select e.empname , e.salary from employeedataset1 as e
inner join salesdataset1 as s on s.emp_id = e.emp_id 
where e.salary > (select max(sales_amt) as highest_sales_Amt from salesdataset1);


























select * from employeedataset1;
select * from departmentdataset1;
select * from salesdataset1;