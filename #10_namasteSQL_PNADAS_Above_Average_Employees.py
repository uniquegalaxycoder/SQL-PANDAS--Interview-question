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

df['total_salary'] = df['base_pay']+df['other_pay']+df['overtime_pay']
df1 = df[['emp_id','emp_name','job_title','base_pay','total_salary']]

df1['sal_rank'] = df1.groupby('job_title')['total_salary'].rank(method = "first", ascending = False)

df1['avg_sal'] = df1.groupby('job_title')['total_salary'].transform('mean')

df1= df1.sort_values(by = ['job_title','sal_rank'], ascending = True)

df2 = df1[(df1['total_salary'] > df1['avg_sal']) & (df1['sal_rank'] > 3 )].reset_index(drop=True)
df2 = df2[['emp_name','job_title','total_salary','base_pay','avg_sal']].sort_values(by = ['total_salary'], ascending = False).reset_index(drop=True)

print(df2)

#print(employee_df)
#print(salary_df)
