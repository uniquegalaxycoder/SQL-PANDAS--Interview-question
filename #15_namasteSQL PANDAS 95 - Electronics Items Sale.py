"""
You have a table called electronic_items. Write an SQL query to find the average price of electronic items in each category, considering only categories where the average price 
exceeds 500 and at least 20 total quantity of items is available. Additionally, only include items with a warranty period of 12 months or more. Return the category name along with
the average price of items in that category. Order the result by average price (round to 2 decimal places) in descending order.

 

Tables: electronic_items
+-----------------+--------------+
| COLUMN_NAME     | DATA_TYPE    |
+-----------------+--------------+
| item_id         | int          |
| item_name       | varchar(20)  |
| category        | varchar(15)  |
| price           | decimal(5,1) |
| quantity        | int          |
| warranty_months | int          |
+-----------------+--------------+
"""

import pandas as pd

# Below line has filtering the data according to given condtion
electronic_items_df = electronic_items_df[(electronic_items_df['quantity']>=20) & (electronic_items_df['warranty_months']>=12)].reset_index(drop=True)

# Here we have aggragated the data based on category wise avg price
electronic_items_df = electronic_items_df.groupby(['category']).agg(
	avg_price = ('price', lambda x : x.sum())
).reset_index()

# here we have filtered the data where avg price exceeds 500.
df = electronic_items_df[electronic_items_df['avg_price'] >= 500 ].reset_index(drop=True)

print(df)





