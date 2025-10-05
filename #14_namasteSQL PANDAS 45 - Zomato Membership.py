"""
Zomato is planning to offer a premium membership to customers who have placed multiple orders in a single day.

Your task is to write a SQL to find those customers who have placed multiple orders in a single day at least once , total order value generate by those customers and order value generated only by those orders, display the results in ascending order of total order value.

 

Table: orders (primary key : order_id)
+---------------+-------------+
| COLUMN_NAME   | DATA_TYPE   |
+---------------+-------------+
| customer_name | varchar(20) |
| order_date    | datetime    |
| order_id      | int         |
| order_value   | int         |
+---------------+-------------+
"""

import pandas as pd

#here we have cast the date column from timestamp to date format.
orders_df['order_date'] = orders_df['order_date'].dt.date

#here we have created one df for the total order value & order count for each customer 
df = orders_df.groupby(['customer_name','order_date']).agg(
				total_ord_value = ('order_value', lambda x : x.sum()),
  				total_ord = ('order_id', lambda y : y.count())
			).reset_index()

#here we have calculated total order value for each customer who has ordered multiple times in a single day from df table
df1 = df.groupby(['customer_name']).agg(
			total_ords_value =( 'total_ord_value', lambda a : a.loc[df.loc[a.index,'total_ord']> 1].sum() ) ).reset_index()


# Here we have filtered the data for those customers who have ordered > 0 from previous df1
df1 = df1[df1['total_ords_value']>0]

#here we have created another df to calculate the total orders value for each customers.
df2 = orders_df.groupby('customer_name').agg(
		total_value = ('order_value', lambda b : b.sum())).reset_index()

#here we have joined both df's ( df1 & df2 ) on customers column condition
final_df = pd.merge(left = df1, right = df2, left_on = 'customer_name', right_on = 'customer_name', how = 'left').reset_index(drop=True)

#here we have selected those columns only required in the output table
final_df = final_df[['customer_name', 'total_value', 'total_ords_value']]
print(final_df)


