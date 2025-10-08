"""
  Write an SQL query to find the course names where the average score (calculated only for students who have scored less than 70 in at least one course) is greater than 70. Sort the result by the average score in descending order.

 

Table: students
+-------------+------------+
| COLUMN_NAME | DATA_TYPE  |
+-------------+------------+
| student_id  | int        |
| course_name | VARCHAR(10)|
| score       | int        |
+-------------+------------+

  """

select 
    course_name,
    avg(score) as avg_score
from students
where 
  student_id in (
	          select 
              distinct student_id 
            from students 
            where score < 70 
)
group by 
  course_name
having
  avg(score) > 70
order by 
  avg(score) desc ;


