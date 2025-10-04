"""
You are working as a data analyst at a tech company called "TechGuru Inc." that specializes in software development and data science solutions. The HR department has tasked you with analyzing the salaries of employees. Your goal is to identify employees who earn above the average salary for their respective job title but are not among the top 3 earners within their job title. Consider the sum of base_pay, overtime_pay and other_pay as total salary. 


In case multiple employees have same total salary then ranked them based on higher base pay. Sort the output by total salary in descending order.

 

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

import pandas as pd

df = pd.merge(left = employee_df, right = salary_df, how = 'inner', left_on = 'emp_id', right_on = 'emp_id').reset_index(drop=True)
 # here we joined both table

df['total_salary'] = df['base_pay'] + df['other_pay'] + df['overtime_pay']
 # Here we added one column for total salary

df1 = df[['emp_id','emp_name','job_title','base_pay','total_salary']]
 # here we select only required columns from "df" table

df1['sal_rank'] = df1.groupby('job_title')['total_salary'].rank(method = "first", ascending = False)
 # here we added salary rank column( window function ) [ row_number() ] for assigning a salary rank bewtween the department. 
 # Partitioned by job_title & rank on salary descending

   # NOTE : here we have used row_number() function becuase 
      # * If we used rank function here then rank fucnction will skip the rank when same salary, then it will cause the O/P
      # * If we used dense_rank fuction then Desne Rank fucnction has not skip rank but assigne same rank number when same salary, then it will cause O/P. 

df1['avg_sal'] = df1.groupby('job_title')['total_salary'].transform('mean')
 # here we added one more column for finding deaprtmental avg. salary ( by window function) 
 # -- partitioned by job_title & mean(avg) salary 

df1= df1.sort_values(by = ['job_title','sal_rank'], ascending = True)
 # Here we sort the table


df2 = df1[(df1['total_salary'] > df1['avg_sal']) & (df1['sal_rank'] > 3 )].reset_index(drop=True)
 # Here we have filterout the result by given conditon :
  # Employees whoes earning more than departmental average salary but lies in Top 3 employyes whoe salary ranked <= 3.  

df2 = df2[['emp_name','job_title','total_salary','base_pay','avg_sal']].sort_values(by = ['total_salary'], ascending = False).reset_index(drop=True)
 # Here we select only required column & sort the data as per given in question.

print(df2)

#print(employee_df)
#print(salary_df)
