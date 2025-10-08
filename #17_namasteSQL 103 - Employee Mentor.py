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

import pandas as pd

employees_df['mentor_id'] = employees_df['mentor_id'].fillna(0)

employees_df = employees_df[employees_df['mentor_id'] != 3]

employees_df = employees_df[['name']].reset_index(drop=True)

print(employees_df)
