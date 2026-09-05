-- Q1. What is a Common Table Expression (CTE), and how does it improve SQL query readability?

/*Ans CTE COMMON TABLE EXPRESSION is used for storing result on temporary basis it starts using 
with . It is mainly used for dividing complex queries into small and understandable.
It improves SQL query readability by converting complex query into small queries.
it is also help in debugging the query easily.*/

-- Q2. Why are some views updatable while others are read-only? Explain with an example.
/*Ans A view is a virtual table created for result basis .
A view is generally updatable only if the query is simple involving a single table not using
any operations.
If there are some restriction in the view then that view cannot be updated it will only be
readable.
Example :
Create view*/ 
/*CREATE VIEW employee_view AS
SELECT emp_id, name, salary
FROM employees;*/

-- simple view based on one table

/*UPDATE employee_view
SET salary = 35000
WHERE emp_id = 1;*/

-- Read-Only View

 /*CREATE VIEW department_salary as
SELECT department, AVG(salary) AS avg_salary
FROM employees
GROUP BY department;*/


-- Q3. What advantages do stored procedures offer compared to writing raw SQL queries repeatedly?
/*Reusability – A stored procedure can be created once and executed multiple times using CALL.
Saves time – We don't need to write the same SQL query again and again.
Reduces code duplication – The same logic is stored in one place.
Improves security – Users can be given permission to execute a procedure without giving direct access to the underlying tables.
Easy maintenance – If the logic needs to change, we can update the procedure in one place.*/

-- Q4. What is the purpose of triggers in a database? Mention one use case where a trigger is essential.
/*A trigger is a database object that automatically executes an action when a specific event such as INSERT, UPDATE, or DELETE occurs on a table.
Purpose of Triggers:
To automatically perform actions when data changes.
To maintain data consistency.
To keep an audit/history record.
To enforce certain business rules.*/

-- Q5. Explain the need for data modelling and normalization when designing a database.
/*Data Modelling is the process of designing how data will be stored,
 organized, and related in a database.

Normalization is the process of organizing data into separate tables to
reduce duplicate data and improve data consistency.

Reduce data duplication – Avoid storing the same information repeatedly.
Maintain data consistency – Changes made to data remain accurate across the database.
Improve database structure – Data is organized into logical tables.
Establish relationships – Helps define relationships between tables using keys.
Prevent data anomalies – Reduces problems during INSERT, UPDATE, and DELETE.*/

use da_may ;
CREATE TABLE Products(
ProductID INT primary key,
ProductName varchar(100),
Category varchar(50),
Price decimal(10,2)
);

INSERT INTO Products VALUES
(1,'KEYBOARD','ELECTRONICS',1200),
(2,'MOUSE','ELECTRONICS',800),
(3,'DESK','FURNITURE',2500),
(4,'CHAIR','FURNITURE',5500);


CREATE TABLE Sales(
SalesID INT primary KEY,
ProductID INT,
Quantity INT ,
SaleDate DATE,
foreign key (ProductID) References Products (ProductID)
);

INSERT INTO Sales VALUES
(1,1,4,'2024-01-05'),
(2,2,10,'2024-01-06'),
(3,3,2,'2024-01-10'),
(4,4,1,'2024-01-11');

SELECT * FROM PRODUCTS;
SELECT * FROM SALES;

-- QUESTIONS
-- Q6. Write a CTE to calculate the total revenue for each product.
-- (Revenues = Price × Quantity), and return only products where  revenue > 3000.

with product_rev as 
(select p.productID , p.price ,s.quantity, sum(p.price * s.quantity) as total_rev from products p 
inner join sales as s on s.productID = p.productID
group by p.productID , p.price , s.quantity
)
select productID , total_rev from product_rev where total_rev > 3000;

-- Q7. Create a view named vw_CategorySummary that shows:
-- Category, TotalProducts, AveragePrice.

create view vw_CategorySummary as 
select category , count(ProductID) as totalProduct , avg(price) as AvgPrice
from products 
group by category;

select * from vw_categorysummary;

-- Q8. Create an updatable view containing ProductID, ProductName, and Price. 
-- Then update the price of ProductID = 1 using the view.
 
create view vw_updatable as
select ProductID , ProductName , Price 
from products;

select * from vw_updatable;

-- UPDATABLE VIEW 
UPDATE vw_updatable 
SET price = 1900
where ProductID = 1;

-- 9. Create a stored procedure that accepts a category name and returns all products belonging to that 
-- category.

delimiter //
Create procedure category_name (IN cat_name varchar(50))
begin 
select  productname , productID 
from products
where category = cat_name;
END //
delimiter ;

call category_name ('ElECTRONICS');
call category_name ('FURNITURE');

-- Q10. Create an AFTER DELETE trigger on the  table 
-- ProductArchive timestamp. Products table that archives deleted product rows into a new 
-- . The archive should store ProductID, ProductName, Category, Price, and DeletedAt.

Create table ProductArchieve(
ProductID INT,
ProductName VARCHAR(50),
Category VARCHAR(50),
Price DECIMAL(10.2),
DeletedAT TIMESTAMP);

-- DELETE AFTER TRIGGER
DELIMITER //
CREATE TRIGGER AFTER_PRODUCT_DELETE
AFTER DELETE ON PRODUCTS
FOR EACH ROW
BEGIN
INSERT INTO ProductArchieve
(ProductID , ProductName ,Category , Price , DeletedAt)
values
(OLD.ProductID , OLD.ProductName , OLD.category , OLD.price , current_timestamp);
END//
DELIMITER //

DELETE FROM Sales
WHERE ProductID = 1;

DELETE FROM PRODUCTS 
WHERE PRODUCTID = 1;

SELECT * FROM ProductArchieve;




 