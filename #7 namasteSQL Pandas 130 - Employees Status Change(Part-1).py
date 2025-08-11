"""
You work in the Human Resources (HR) department of a growing company that tracks the status of its employees year over year. The company needs to analyze employee status changes between two consecutive years: 2020 and 2021.

The company's HR system has two separate tables of employees for the years 2020 and 2021, which include each employee's unique identifier (emp_id) and their corresponding designation (role) within the organization.

The task is to track how the designations of employees have changed over the year. Specifically, you are required to identify the following changes:

Promoted: If an employee's designation has changed (e.g., from Trainee to Developer, or from Developer to Manager).
Resigned: If an employee was present in 2020 but left the company by 2021.
New Hire: If an employee was hired in 2021 but was not present in 2020.

Assume that employees can only be promoted and cannot be demoted.

emp_2020_ = {
  "emp_id" : [1,2,3,4,5,6],
  "designation" : ['Trainee', 'Developer', 'Developer', 'Manager', 'Trainee', 'Developer' ]
}

emp_2021_ =  {
  "emp_id" : [1,2,3,5,6,7],
  "designation" : ['Developer', 'Developer', 'Manager', 'Trainee', 'Developer', 'Manager' ]
}

emp_2020_df = pd.DataFrame(emp_2020_)
emp_2021_df = pd.DataFrame(emp_2021_)

print(emp_2020_df)
print(emp_2021_df)


Table: emp_2020 
+-------------+----------+
| COLUMN_NAME | DATA_TYPE|
+-------------+----------+
| emp_id      | int      |
| designation | date     |
+-------------+----------+

Table: emp_2021
+-------------+----------+
| COLUMN_NAME | DATA_TYPE|
+-------------+----------+
| emp_id      | int      |
| designation | date     |
+-------------+----------+

Output:- 

   emp_id   comment
0       1  Promoted
1       3  Promoted
2       4  Resigned
3       7  New Hire


"""




import pandas as pd

#print(emp_2020_df)
#print(emp_2021_df)

df = pd.merge(left = emp_2020_df, right = emp_2021_df, how = 'outer', on = 'emp_id').reset_index(drop = True)

df['comments'] = df.apply(
  	lambda x: "Promotion" if ( 
      ( (x['designation_x']== "Trainee") & (x['designation_y']== "Developer") ) | ( (x['designation_x']== "Developer") & (x['designation_y']== "Manager") )
    ) 
  	else "Resigned" if ( (pd.notna(x['designation_x']) ) & ( pd.isna(x['designation_y']) )
    )
  	else "New Hire" if ( (pd.isna(x['designation_x']) ) & ( pd.notna(x['designation_y']) )
    ) else None, 
  axis=1
)

df1 = df[pd.notna(df['comments'])][['emp_id', 'comments']].reset_index(drop=True)
print(df1)
