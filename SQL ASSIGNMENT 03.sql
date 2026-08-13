USE DUMMY;
SHOW TABLES;
SELECT * FROM CUSTOMERS;
SELECT * FROM ORDERS;
SELECT * FROM PAYMENTSS;
SELECT * FROM EMPLOYEES;

-- QUESTIONS  
-- Question 1. Retrieve all customers who have placed at least one order.
SELECT * FROM CUSTOMERS AS C INNER JOIN  ORDERS AS O ON C.CUSTOMER_ID = O.CUSTOMER_ID;

-- Question 2. Retrieve all customers and their orders, including customers who have not placed any orders.
SELECT * FROM CUSTOMERS AS C LEFT JOIN ORDERS AS O ON C.CUSTOMER_ID = O.CUSTOMER_ID;

-- Question 3. Retrieve all orders and their corresponding customers, including orders placed by unknown 
-- customers.
SELECT * FROM CUSTOMERS AS C RIGHT JOIN ORDERS AS O ON C.CUSTOMER_ID = O.CUSTOMER_ID;

-- Question 4. Display all customers and orders, whether matched or not.
SELECT * FROM CUSTOMERS AS C LEFT JOIN ORDERS AS O ON C.CUSTOMER_ID = O.CUSTOMER_ID
UNION
SELECT * FROM CUSTOMERS AS C RIGHT JOIN ORDERS AS O ON C.CUSTOMER_ID = O.CUSTOMER_ID;

-- Question 5. Find customers who have not placed any orders.
SELECT * FROM CUSTOMERS AS C LEFT JOIN ORDERS AS O ON C.CUSTOMER_ID = O.CUSTOMER_ID 
WHERE O.ORDER_ID IS NULL ;

-- Question 6. Retrieve customers who made payments but did not place any orders.
SELECT DISTINCT C.CUSTOMER_ID , C.CUSTOMER_NAME FROM CUSTOMERS AS C 
INNER JOIN PAYMENTSS AS P ON C.CUSTOMER_ID = P.CUSTOMER_ID
LEFT JOIN ORDERS AS O ON C.CUSTOMER_ID = O.CUSTOMER_ID
WHERE O.CUSTOMER_ID IS NULL ;

-- Question 7. Generate a list of all possible combinations between Customers and Orders.
SELECT * FROM CUSTOMERS CROSS JOIN ORDERS;

-- Question 8. Show all customers along with order and payment amounts in one table.
SELECT  C.CUSTOMER_ID ,C.CUSTOMER_NAME , O.ORDER_ID , P.AMOUNT 
FROM CUSTOMERS AS C LEFT JOIN ORDERS AS O ON C.CUSTOMER_ID = O.CUSTOMER_ID 
LEFT JOIN PAYMENTSS AS P ON C.CUSTOMER_ID = P.CUSTOMER_ID;

-- Question 9. Retrieve all customers who have both placed orders and made payments.
SELECT C.CUSTOMER_NAME , O.ORDER_id , P.AMOUNT
FROM CUSTOMERS AS C INNER JOIN ORDERS AS O ON  C.CUSTOMER_ID = O.CUSTOMER_ID
INNER JOIN PAYMENTSS AS P ON C.CUSTOMER_ID = P.CUSTOMER_ID ;


