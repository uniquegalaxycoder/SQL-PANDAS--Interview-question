"""
  Q.Find employees whose salary is above the average salary of their department but below the company wide average.
  
"""

import pandas as pd

employee_data = {
    "emp_id": [ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13],
    "salary": [ 95000.00, 87000.50, 92000.75, 110000.00, 105500.25, 102000.00,
                99000.00, 97000.80, 78000.00, 72000.40, 76000.00,
                68000.00, 71000.00
              ],
    "department": [ "Data Science", "Data Science", "Data Science",
                    "AI Engineering", "AI Engineering",
                    "ML Engineering", "ML Engineering", "ML Engineering",
                    "Data Analyst", "Data Analyst", "Data Analyst",
                    "Strategy", "Strategy"
                  ]
}

df = pd.DataFrame(employee_data)
#df.head()

df["department_avg_salary"] = round(df.groupby('department')['salary'].transform('mean')) 
# SQL-> avg(salary)over(partition by department) as department_avg_salary 

df['Comapny_avg_salary'] = round(df['salary'].mean())
# SQL -> avg(salary) over()  as total_company_avg__salary
#df.head()

df = df[(df['salary'] > df['department_avg_salary']) & (df["salary"] < df["Comapny_avg_salary"]) ].reset_index(drop=True)
# sQL -> where salary > department_avg_salary and salary < Comapny_avg_salary
df

"""
  Output =>
    +--------+--------------+----------+-----------------------+----------------------+
    | emp_id | department   | salary   | department_avg_salary | Comapny_avg_salary   |
    +--------+--------------+----------+-----------------------+----------------------+
    |      9 | Data Analyst | 78000.00 |           75333       |                88654 |
    |     11 | Data Analyst | 76000.00 |           75333       |                88654 |
    |     13 | Strategy     | 71000.00 |           69500       |                88654 |
    +--------+--------------+----------+-----------------------+----------------------+
"""

