'''
designation (role) within the organization for each year.

The task is to track how the designations of employees have changed over the year. Specifically, you are required to identify the following changes:

Promoted: If an employee's designation has changed (e.g., from Trainee to Developer, or from Developer to Manager).
Resigned: If an employee was present in 2020 but has left the company by 2021.
New Hire: If an employee was hired in 2021 but was not present in 2020.

Assume that employees can only be promoted and cannot be demoted.

 

Table: employees
+-------------+----------+
| COLUMN_NAME | DATA_TYPE|
+-------------+----------+
| emp_id      | int      |
| year        | int      | 
| designation | date     |
+-------------+----------+
'''

import pandas as pd 

df = {
  "emp_id" : [1,2,3,4,5,6,1,2,3,5,6,7],
  "year" :[2020, 2020, 2020, 2020, 2020, 2020, 2021, 2021, 2021, 2021, 2021, 2021],
  "designation" : ['Trainee', 'Developer', 'Developer', 'Manager', 'Trainee', 'Developer', 'Developer', 'Developer', 'Manager', 'Trainee', 'Developer', 'Manager']
}

employees = pd.DataFrame(df)


#print(employees_df)

df1 = employees_df[employees_df['year']==2020].reset_index(drop = True)
df2 = employees_df[employees_df['year']==2021].reset_index(drop = True)

df3 = pd.merge(left = df1, right = df2, how = 'outer', on = 'emp_id').reset_index(drop = True)

df3['year_y'] = pd.to_numeric(df3['year_y'], errors = 'coerce')

df3['comments'] = df3.apply( lambda x :
	"Promoted" if (
      		(
             pd.notna(x['year_x']) & (x['designation_x'] == "Trainee")  & 
             pd.notna(x['year_y']) & (x['designation_y'] == "Developer") 
            ) 	| 
      		(
             pd.notna(x['year_x']) & (x['designation_x'] == "Developer") & 
             pd.notna(x['year_y']) & (x['designation_y'] == "Manager") 
            )
	) else "Resigned" if (pd.notna(x['year_x']) & pd.isna(x['year_y'])
    ) else "New hire" if ( pd.isna(x['year_x']) & pd.notna(x['year_y'])
    ) else None
    , axis= 1 )

df3 = df3[['emp_id', 'comments']]
df4 = df3[pd.notna(df3['comments'])].reset_index(drop=True)
print(df4)
