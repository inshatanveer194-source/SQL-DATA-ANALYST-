SHOW DATABASES;
USE DA_MAY;
CREATE TABLE student_performance(
student_id int primary key,
name varchar(30),
course varchar(30),
score int , 
attendance int , 
mentor varchar(30),
join_date date ,
city varchar(20)
);

insert into student_performance
(student_id , name , course , score , attendance , mentor , join_date , city )
values
(101,"Aarav Mehta","Data Science",88,92,"Dr Sharma",'2023-06-12','Mumbai'),
(102,"Riya Singh","Data Science",76,85,"Dr sharma",'2023-07-01','delhi'),
(103,"Kabir Khanna","Python",91,96,"Ms nasir",'2023-06-20','mumbai'),
(104,"Tanvi Patel","SQL",84,89,"Mr iyer",'2023-05-30','bengaluru'),
(105,"Ayesha Khan","Python",67,81,"Ms nasir",'2023-07-10' , 'hyderabad'),
(106,"Dev Sharma","SQL",73,78,'Ms Iyer','2023-05-28','pune'),
(107,"Arjun Verma","Tableau",95,98,'Ms Kapoor','2023-06-15','delhi'),
(108,"Meera Pilai","Tableau",82,87,'Ms Kapoor','2023-06-18','kochi'),
(109,"Nikhil Rao","Data Science",79,82,'Dr Sharma','2023-07-05', 'chennai'),
(110,"Priya Desai","SQL",92,94,'Mr Iyer','2023-05-27','bengaluru'),
(111,"Siddharth Jain","Python",85,90,'Ms Nair','2023-07-02','mumbai'),
(112,"Sneha kulkarni","Tableau",74,83,'Ms Kapoor' , '2023-06-10' , 'pune'),
(113,"Rohan Gupta","SQL",89,91,'Mr Iyer' , '2023-05-25' , 'delhi'),
(114,"Ishita Joshi","Data Science",93,97,'Dr sharma' , '2023-06-25','bengaluru'),
(115,"Yujraj Rao","Python",71,84,"Ms Nair",'2023-07-12',"hyderabad");

select * from student_performance ;

-- Question 1 : Create a ranking of students based on score (highest first).
select student_id , name , course,score, 
rank()over(order by score desc) as student_ranking from student_performance;

-- Question 2 : Show each student's score and the previous student’s score (based on score order).
SELECT name,score,
LAG(score) OVER (ORDER BY score) AS previous_score
FROM student_performance;


-- Question 3 : Convert all student names to uppercase and extract the month name from join_date.
select upper(name)as student_name,
monthname(join_date) as month_name 
from student_performance;

-- Question 4 : Show each student's name and the next student’s attendance (ordered by attendance).
SELECT name,LEAD(attendance) 
OVER (ORDER BY attendance) AS next_attendance
FROM student_performance;

-- Question 5 : Assign students into 4 performance groups using NTILE().
select student_id , name , score , 
ntile(4) over() as students_category from student_performance;

-- Question 6 : For each course, assign a row number based on attendance (highest first).
select student_id , name , course ,
row_number() over (order by attendance desc ) as rownumber from student_performance;

-- Question 7 : Calculate the number of days each student has been enrolled (from join_date to today).
-- (Assume current date = '2025-01-01')
SELECT 
    name,
    DATEDIFF('2025-01-01', join_date) AS enrolled_days
FROM student_performance;


-- Question 8 : Format join_date as “Month Year” (e.g., “June 2023”).
select date_format(join_date , '%M , %Y' ) as month_year
from student_performance;


-- Question 9 : Replace the city ‘Mumbai’ with ‘MUM’ for display purposes.
SELECT REPLACE(
           REPLACE(city, 'mumbai', 'MUM'),
           'Mumbai', 'MUM'
       ) AS new_city
FROM student_performance;

-- Question 10 : For each course, find the highest score using FIRST_VALUE()
select course , 
FIRST_VALUE(score)
over(partition by course order by score desc) as highest_marks from student_performance;
