"""
You are provided with a table that lists various product categories, each containing a comma-separated list of products. Your task is to write a SQL query to count the number of products in each category. Sort the result by product count.

Tables: categories
+-------------+-------------+
| COLUMN_NAME | DATA_TYPE   |
+-------------+-------------+
| category    | varchar(15) |
| products    | varchar(30) |
+-------------+-------------+



"""

import pandas as pd

df = categories_df
df['product_count'] = categories_df['products'].apply( lambda x : len(x.split(",") if x else 0) )
df = df[['category','product_count']].sort_values(by=['product_count'], ascending = True).reset_index(drop= True)
print(df)

