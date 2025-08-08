"""
Q.14 from NamasteSQL Coding : 

Write a query to find workaholics employees.  Workaholics employees are those who satisfy at least one of the given criterions:
Condition's :  
  1- Worked for more than 8 hours a day for at least 3 days in a week. 
  2- worked for more than 10 hours a day for at least 2 days in a week. 

You are given the login and logout timings of all the employees for a given week. Write a SQL to find all the workaholic
employees along with the criterion that they are satisfying (1,2 or both), display it in the order of increasing employee id.


  Table: employees
+-------------+-----------+
| COLUMN_NAME | DATA_TYPE |
+-------------+-----------+
| emp_id      | int       |
| login       | datetime  |
| logout      | datetime  |
+-------------+-----------+

"""




with 
cte1 as (
select *, 
	time(login) as login_time,
    time(logout) as logout_time,
  	week(login) as week,
  	timestampdiff(HOUR, time(login), time(logout)) as working_hrs
from employees
),
 
 cte2 as (
 select 
 	*,
    case when (working_hrs >= 8 ) then 1 end as work_8hr,
	case when working_hrs >= 10 then 1 end  as work_10hr
from cte1
),

cte3 as (
select 
	emp_id,
    count(case when work_8hr = 1 then work_8hr end) as total_days_work_8hrs,
    count(case when work_10hr = 1 then work_10hr end) as total_days_work_10hrs
from cte2
group by emp_id
)

select 
	emp_id, 
	case 
    	when ( total_days_work_8hrs >= 3 and total_days_work_10hrs >= 2 ) then "both" 
        when ( total_days_work_8hrs >= 3 ) then 1
        when ( total_days_work_10hrs >= 2 ) then 2
    end as criterian
from  cte3
