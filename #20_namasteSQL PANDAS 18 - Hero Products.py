"""
Flipkart an ecommerce company wants to find out its top most selling product by quantity in each category. In case of a tie when quantities sold are same for more than 1 product, then we need to give preference to the product with higher sales value.

Display category and product in output with category in ascending order.

 

Table: orders
+-------------+-------------+
| COLUMN_NAME | DATA_TYPE   |
+-------------+-------------+
| category    | varchar(10) |
| order_id    | int         |
| product_id  | varchar(20) |
| quantity    | int         |
| unit_price  | int         |
+-------------+-------------+
"""

import pandas as pd

orders_df['total_sold'] = round((orders_df['unit_price'] * orders_df['quantity']))

orders_df = orders_df.groupby(['category','product_id']).agg(
		            total_quntity = ('quantity', lambda x : x.sum()),
                total_sale = ('total_sold', lambda y : y.sum()) 
          ).reset_index()


sort_df = orders_df.sort_values(
		                by = ['category', 'total_quntity','total_sale'],
  		              ascending = [True, False, False]
          )
sort_df['ranks'] = sort_df.groupby('category')['total_sale'].cumcount() + 1

sort_df = sort_df[sort_df['ranks']==1]

df = sort_df[['category','product_id']].reset_index(drop=True)

print(df)


