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



import pandas as pd 

#print(employees_df)

df1 = employees_df.groupby(['department_id'])['employee_id'].count()

employees_df['sal_rank'] = employees_df.groupby(['department_id'])['salary'].rank(method = 'first', ascending = False)

df2 = employees_df[['department_id', 'salary', 'sal_rank']].reset_index(drop = True)
df3 = df2[df2['sal_rank']==3]

final_df = pd.merge(left = df1, right = df3, how = 'left', left_on = 'department_id', right_on = 'department_id')

final_df = final_df[['department_id', 'salary']]

print(final_df)

