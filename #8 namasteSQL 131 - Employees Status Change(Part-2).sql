
-- You work in the Human Resources (HR) department of a growing company that tracks the status of its employees year over year. 
-- The company needs to analyze employee status changes between two consecutive years: 2020 and 2021.

-- The company's HR system has two separate records of employees for the years 2020 and 2021 in the same table, which include each employee's unique identifier (emp_id) and their corresponding designation (role) within the organization for each year.

-- The task is to track how the designations of employees have changed over the year. Specifically, you are required to identify the following changes:

-- Promoted: If an employee's designation has changed (e.g., from Trainee to Developer, or from Developer to Manager).
-- Resigned: If an employee was present in 2020 but left the company by 2021.
-- New Hire: If an employee was hired in 2021 but was not present in 2020.

-- Assume that employees can only be promoted and cannot be demoted.

 

--Table: employees
--+-------------+----------+
--| COLUMN_NAME | DATA_TYPE|
--+-------------+----------+
--| emp_id      | int      |
--| year        | int      | 
--| designation | date     |
--+-------------+----------+

-- Output
--+--------+----------+
--| emp_id | comment  |
--+--------+----------+
--|      1 | Promoted |
--|      3 | Promoted |
--|      4 | Resigned |
--|      7 | New Hire |
--+--------+----------+

create table employees (
  emp_id int,
  year int,
  designation varchar(20)
) 

insert all 
into employees ( emp_id, year, designation) values( 1, 2020, "Trainee" ),
into employees ( emp_id, year, designation) values( 2, 2020, "Developer" ),
into employees ( emp_id, year, designation) values( 3, 2020, "Developer" ),
into employees ( emp_id, year, designation) values( 4, 2020, "Manager" ),
into employees ( emp_id, year, designation) values( 5, 2020, "Trainee" ),
into employees ( emp_id, year, designation) values( 6, 2020, "Developer" ),
into employees ( emp_id, year, designation) values( 1, 2021, "Developer" ),
into employees ( emp_id, year, designation) values( 2, 2021, "Developer" ),
into employees ( emp_id, year, designation) values( 3, 2021, "Manager" ),
into employees ( emp_id, year, designation) values( 5, 2021, "Trainee" ),
into employees ( emp_id, year, designation) values( 6, 2021, "Developer" ),
into employees ( emp_id, year, designation) values( 7, 2021, "Manager" )
select * from dual ;


with cte1 as (
select 
  emp_id,
  max(case when year = 2020 then year end ) as year_20,
  max(case when year = 2020 then designation end ) as designation_20,
  max(case when year = 2021 then year end ) as year_21,
  max(case when year = 2021 then designation end ) as designation_21
from employees 
group by emp_id
)
select 
	*
from (
select 
	emp_id,
    case 
    	when (
            (
              ( year_20 is not null and designation_20 = 'Trainee') and ( year_21 is not null and designation_21 = 'Developer')
            ) or 
            (
              ( year_20 is not null and designation_20 = 'Developer') and ( year_21 is not null and designation_21 = 'Manager')
            )
          )then "Promoted"
      when ( year_20 is not null and year_21 is null ) then "Resigned"
      when ( year_20 is null and year_21 is not null ) then "New Hire"
     end as comments   
from cte1 ) as t 
where comments is not null
