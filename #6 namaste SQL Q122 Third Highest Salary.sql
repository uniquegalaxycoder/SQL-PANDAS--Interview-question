'''
Q.122. You are working with an employee database where each employee has a department ID and a salary. Your task is to find the third highest salary in each department. 
If there is no third highest salary in a department, then the query should return salary as null for that department. Sort the output by department id.

Assume that none of the employees have same salary in a particular department.

Table: employees 
+---------------+----------+
| COLUMN_NAME   | DATA_TYPE|
+---------------+----------+
| employee_id   | int      |
| department_id | int      |
| salary        | int      |
+---------------+----------+

Required Output :
+---------------+----------------------+
| department_id | third_highest_salary |
+---------------+----------------------+
|             1 |                 3000 |
|             2 |                 NULL |
|             3 |                 3500 |
|             4 |                 NULL |
|             5 |                 4200 |
+---------------+----------------------+  
'''

with cte1 as (
select 
  * 
from (
  select 
      department_id,
      salary,
      rank() over(partition by department_id order by salary desc ) as 'sal_rank'
	from employees
) as t 
where sal_rank = 3
),

cte2 as (
  select 
  	department_id,
  	count(*) as total
  from employees
  group by department_id
)

select 
	cte2.department_id,
    cte1.salary
from cte2
left join cte1
on cte2.department_id = cte1.department_id
order by cte2.department_id asc ;

