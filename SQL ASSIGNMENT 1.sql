-- Q1. Create a New Database and  Table for Employees
-- Task: Create a new database named and Create a table named with the following columns:
CREATE DATABASE company_db;
use company_db;

-- Q2. Insert Data into Employees Table
-- Task: Insert the following sample records into the table.
create table employees(
employee_id  INT PRIMARY KEY,
first_name VARCHAR(50),
last_name VARCHAR(50),
department VARCHAR(50),
salary INT,
hire_date DATE
);
INSERT INTO employees
(employee_id , first_name , last_name , department , salary , hire_date )
values
(101 ,"Amit", "Sharma" , "HR" , 50000 , '2020-01-15'),
(102 , "Ria" , "Kapoor" , "Sales" , 75000 , '2019-03-22'),
(103 , "Raj" , "Mehta" , "IT" , 90000 , '2018-07-11'),
(104 , "Neha" , "Verma" , "IT" , 85000 , '2021-09-11'),
(105 , "Arjun" , "Singh" , "Finance" , 60000 , '2022-02-10');

-- Q3. Display All Employee Records Sorted by Salary (Lowest to Highest)
SELECT * FROM employees ORDER BY salary ASC;

-- Q4. Show Employees Sorted by Department (A–Z) and Salary (High → Low)
SELECT * FROM employees ORDER BY department ASC , Salary DESC;

-- Q5. List All Employees in the IT Department, Ordered by Hire Date (Newest First)
SELECT * FROM employees where department = "IT"
ORDER BY hire_date DESC ;

-- Q6. Create and Populate a Sales Table 
CREATE TABLE Sale(
Sale_id INT PRIMARY KEY,
Customer_name VARCHAR(10),
Amount INT , 
Sale_date DATE 
);
INSERT INTO Sale 
(Sale_id , Customer_name , Amount , Sale_date)
Values
(1 , "Aditi" , 1500 , '2024-08-01'),
(2 , "Rohan" , 2200 , '2024-08-03'),
(3, "Aditi" , 3500 , '2024-09-05'),
(4 , "Meena" , 2700 , '2024-09-15'),
(5 , "Rohan" , 4500 , '2024-09-25');

-- Q7. Display All Sales Records Sorted by Amount (Highest → Lowest)
SELECT * FROM Sale ORDER BY Amount DESC ; 

-- Q8. Show All Sales Made by Customer “Aditi”
SELECT * FROM Sale where Customer_name = "Aditi";

-- Q9. What is the Difference Between a Primary Key and a Foreign Key? 
-- Ans 9 : Primary key are the unique primary id which contains the unique data NULL  value is not allowed.One table 
-- contains only 1 Primary key in the dataset duplicates are not allowed.
-- Foreign key tells the relationship between two tables duplicates are allowed NULL value is allowed. One table can 
-- contain more than 1 Foreign key in the dataset.

-- Q10. What Are Constraints in SQL and Why Are They Used?
-- ANS 10 : Constraints are the rules applied to tables and columns to ensure that valid data enter into the tables and 
-- columns for get accuracy and consistency in the data . eg NOT NULL , UNIQUE , CHECK etc.
