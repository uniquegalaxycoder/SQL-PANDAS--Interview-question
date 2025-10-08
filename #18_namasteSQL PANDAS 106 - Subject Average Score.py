"""
Write an SQL query to find the course names where the average score (calculated only for students who have scored less than 70 in at least one course) is greater than 70.
Sort the result by the average score in descending order.

 

Table: students
+-------------+------------+
| COLUMN_NAME | DATA_TYPE  |
+-------------+------------+
| student_id  | int        |
| course_name | VARCHAR(10)|
| score       | int        |
+-------------+------------+
"""

import pandas as pd

# Here we have first created a numpy array for student id's whoes score < 70 
df = students_df.loc[students_df['score'] < 70, 'student_id'].unique() #[ 1 3 5 8 ]

# Here we have filter the data based on student id whoes present in array which is created. 
students_df = students_df[students_df['student_id'].isin(df)]

# Here we aggregated the data, avg sore on course
students_df = students_df.groupby(['course_name']).agg(avg_score  = ('score', lambda x : x.mean()))

# Here we filterout the data as per given condtion, course name whoes avg score is > 70
students_df = students_df[students_df['avg_score'] > 70 ].reset_index().sort_values(by = ['avg_score'], ascending = False)
 
print(students_df)


