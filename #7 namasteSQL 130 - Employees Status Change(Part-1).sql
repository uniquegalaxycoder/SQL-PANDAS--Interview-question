"""
You work in the Human Resources (HR) department of a growing company that tracks the status of its employees year over year. The company needs to analyze employee status changes between two consecutive years: 2020 and 2021.

The company's HR system has two separate tables of employees for the years 2020 and 2021, which include each employee's unique identifier (emp_id) and their corresponding designation (role) within the organization.

The task is to track how the designations of employees have changed over the year. Specifically, you are required to identify the following changes:

Promoted: If an employee's designation has changed (e.g., from Trainee to Developer, or from Developer to Manager).
Resigned: If an employee was present in 2020 but left the company by 2021.
New Hire: If an employee was hired in 2021 but was not present in 2020.

Assume that employees can only be promoted and cannot be demoted.

create table emp_2020 (
  emp_id int,
  designation varchar(30)
)
insert all 
INTO EMP_2020 (EMP_ID, DESIGNATION) VALUES(1,'Trainee'),
INTO EMP_2020 (EMP_ID, DESIGNATION) VALUES(2,'Developer'),
INTO EMP_2020 (EMP_ID, DESIGNATION) VALUES(3,'Developer'),
INTO EMP_2020 (EMP_ID, DESIGNATION) VALUES(4,'Manager'),
INTO EMP_2020 (EMP_ID, DESIGNATION) VALUES(5,'Trainee'),
INTO EMP_2020 (EMP_ID, DESIGNATION) VALUES(2,'Developer')
select * from dual ;


create table emp_2021 (
  emp_id int,
  designation varchar(30)
)
insert all 
INTO EMP_2020 (EMP_ID, DESIGNATION) VALUES(1,'Developer'),
INTO EMP_2020 (EMP_ID, DESIGNATION) VALUES(2,'Developer'),
INTO EMP_2020 (EMP_ID, DESIGNATION) VALUES(3,'Manager'),
INTO EMP_2020 (EMP_ID, DESIGNATION) VALUES(5,'Trainee'),
INTO EMP_2020 (EMP_ID, DESIGNATION) VALUES(6,'Developer')
INTO EMP_2020 (EMP_ID, DESIGNATION) VALUES(7,'Manager')
select * from dual ;  


select * from emp_2020
select * from emp_2021
"""



with cte1 as (
select 
  a.emp_id as emp_id20,
  a.designation as designation20,
  b.emp_id as emp_id21,
  b.designation as designation21
from emp_2020 as a 
left join emp_2021 as b 
on a.emp_id = b.emp_id 
  
union 
  
select 
  a.emp_id as emp_id20,
  a.designation as designation20,
  b.emp_id as emp_id21,
  b.designation as designation21
from emp_2020 as a 
right join emp_2021 as b 
on a.emp_id = b.emp_id   
)

	
select
	COALESCE(emp_id20, emp_id21) as emp_id,
  	changes as comments
from (
select 
	*,
    case 
    	when ( designation20 = 'Trainee' and designation21 = 'Developer') or ( designation20 = 'Developer' and designation21 = 'Manager') then "Promoted"
       	when ( designation20 is not null and designation21 is null ) then "Resigned"
        when ( designation20 is null and designation21 is not null ) then "New Hire"
    end as Changes    
from cte1
) as t 
where changes is not null
