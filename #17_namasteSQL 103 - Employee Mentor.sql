"""
  You are given a table Employees that contains information about employees in a company. Each employee might have been mentored by another employee. 
  Your task is to find the names of all employees who were not mentored by the employee with id = 3.

Table: employees 
+-------------+-------------+
| COLUMN_NAME | DATA_TYPE   |
+-------------+-------------+
| id          | int         |    
| name        | varchar(10) |
| mentor_id   | int         |
+-------------+-------------+
  
  """

select 
 	  name
 from (
 		select 
 			id,
    		name,
    		coalesce(mentor_id,0) as mentor_id
 from employees 
 )as e 
 where e.mentor_id <> 3 ;





