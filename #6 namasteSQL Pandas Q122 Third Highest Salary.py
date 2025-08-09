







import pandas as pd 

#print(employees_df)

df1 = employees_df.groupby(['department_id'])['employee_id'].count()

employees_df['sal_rank'] = employees_df.groupby(['department_id'])['salary'].rank(method = 'first', ascending = False)

df2 = employees_df[['department_id', 'salary', 'sal_rank']].reset_index(drop = True)
df3 = df2[df2['sal_rank']==3]

final_df = pd.merge(left = df1, right = df3, how = 'left', left_on = 'department_id', right_on = 'department_id')

final_df = final_df[['department_id', 'salary']]

print(final_df)

