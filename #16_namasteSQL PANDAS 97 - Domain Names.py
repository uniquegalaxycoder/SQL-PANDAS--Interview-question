"""
  Write an SQL query to extract the domain names from email addresses stored in the Customers table.

 

Tables: Customers
+-------------+-------------+
| COLUMN_NAME | DATA_TYPE   |
+-------------+-------------+
| CustomerID  | int         |
| Email       | varchar(25) |
+-------------+-------------+
  """

import pandas as pd

customers_df['domain'] = customers_df['Email'].str.split('@').str[1]

customers_df = customers_df[['Email','domain']]

print(customers_df)
