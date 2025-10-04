"""
  You are working as a data analyst at a tech company called 'TechGuru Inc.' that specializes in software development and data science solutions.
  The HR department has tasked you with analyzing the salaries of employees. Your goal is to identify employees who earn above the average salary
  for their respective job title but are not among the top 3 earners within their job title. 
  Consider the sum of base_pay, overtime_pay and other_pay as total salary. 


  - In case multiple employees have same total salary then ranked them based on higher base pay. 
  - Sort the output by total salary in descending order.

 

Table: employee 
+-------------+-------------+
| COLUMN_NAME | DATA_TYPE   |
+-------------+-------------+
| emp_id      | int         |
| emp_name    | varchar(20) |
| job_title   | varchar(20) |
+-------------+-------------+
Table: salary 
+--------------+-----------+
| COLUMN_NAME  | DATA_TYPE |
+--------------+-----------+
| emp_id       | int       |
| base_pay     | int       |
| other_pay    | int       |
| overtime_pay | int       |
+--------------+-----------+
  
  """

with cte1 as (
  select 
    a.emp_id,
    a.emp_name,
    a.job_title,
    b.base_pay,
    b.other_pay,
    b.overtime_pay
  from employee as a 
  left join salary as b 
  on a.emp_id = b.emp_id 
 ),

  -- In above first we join both the table on emp_id column (pk)
  -- "I have used left join here becuase i want to consider all employees but we can also use inner join where it will return like all employees
  -- whoes present also in salary table ( Matching data only from both the table)."
 
 cte2 as (
 select 
   	emp_name
 	  ,job_title
    ,(sum(base_pay) + sum(overtime_pay) + sum(other_pay)) as total_sal
	  ,sum(base_pay)  as base_pay  
from cte1
 group by emp_name,job_title
),

  -- IN above cte we create a one more column for total salary of emplyee
  -- then we created a aggregated view for each employee there base salary, total saalry 
  
cte3 as (
select 
    *
	  ,row_number()over(partition by job_title order by total_sal desc) as sal_rank 
  	,avg(total_sal)over(partition by job_title) as avg_sal
from cte2
 )

  -- "In baove cte we have added two column which is salary rank based on their job title & total salary they earn & seconf one is average salary 
  -- based on job_title ."
  -- So, we get the data like employee name, base salary, total salary & department avg. salary
  
 
select 
 	  emp_name,
    job_title,
    total_sal,
    base_pay,
    avg_sal
from cte3
where 
    sal_rank > 3
and total_sal > avg_sal
order by total_sal desc ;

  -- "Finally we filter the employees whose earning more than their departmental avg salary but also applied one maore check which is the employee 
  -- not lies between in top 3 emplyees whoes earning more in their department (departmental top 3 )"
  -- 
