create database project;
use project;
show tables;
select * from books;
select * from customers;
select * from orders;

-- Query 1 : Retrive all the books in the "fiction" genre
select * from books 
where genre = 'Fiction';

-- Query 2 :  Find the books published after the year 1950
select * from books 
where published_year > 1950;

-- Query 3 : List all the customers from Canada
select * from customers 
where country = 'Canada';

-- Query 4 : Show orders placed in November 2023 
select * from orders 
where order_date between '2023-11-01' and '2023-11-30';

-- Query 5 : Retrieve the total stocks of books available
select sum(stock) as total_stock 
from books; 

-- Query 6 : Find the details of most expensive books 
select * from
books where price=(select max(price) from books);

-- Query 7 : Show all the customers who ordered more than 1 quantity of books
select * from orders 
where quantity > 1;

-- Query 8 : Retrieve all the customers where the total_amount exceeds $20
select * from orders 
where total_amount > 20;

-- Query 9 : List all genres available  in the books table 
select distinct genre from books;

-- Query 10 : Find the books with the lowest stock
select * from books
order by stock asc limit 1;

-- Query 11 : Calculate Total_revenue generated from all orders  
select sum(total_amount) as total_revenue from orders ;

-- ADVANCE QUERIES 
-- Query 1 :  Retrieve the total number of books sold for each genre 
select * from books; -- book id
select * from orders; -- book_id  
select b.genre , sum(o.quantity) from books as b
inner join orders as o on o.book_id = b.book_id 
group by b.genre;

-- Query 2 : Find the Average price  of books in the "Fantasy" genre
select avg(price) as Average_price from books
where genre = 'Fantasy';


-- Query 3 : List all customers who have placed atleast 2 orders
select customer_id , count(*) as order_count  from orders
group by customer_id
having count(*) >=2;

-- Query 4 : Find the most frequently ordered books
select book_id , count(order_id) as order_count
from orders
group by book_id
order by order_count desc; 

-- Query 5 : Show the top 3 most expensive books of 'Fantasy' genre
select * from books
where genre = 'fantasy'
order by price 
limit 3;

-- Query 6 : Retrieve the total quantity of books sold by each author 
select b.author ,sum(o.quantity) as total_qty from orders as o 
join books as b on b.book_id = o.book_id 
group by b.author;

-- Query 7 : List the cities where customers who spent over $30 are located 
select * from customers;
select * from orders;
select * from books;
select  distinct  c.city , sum(o.total_amount) as total_spent from orders as o
join customers as c on c.CUSTOMER_ID = o.CUSTOMER_ID
group by c.city 
having sum(o.total_amount) > 30;

-- Query 8 : Find the customers who spent the most on orders
select c.customer_id , c.name , sum(o.total_amount) as total_spent from orders as o
join customers as c on c.customer_id = o.customer_id 
group by customer_id , c.name 
order by total_spent desc; 

-- Query 9 : Calculate the stock remaining after fulfilling all orders
select b.title , b.book_id , b.stock , coalesce(sum(o.quantity),0) as order_qty ,
b.stock - coalesce(sum(o.quantity),0) as remaining_qty
from books as b 
left join orders as o on b.book_id = o.book_id
group by b.book_id ,b.title , b.stock;
