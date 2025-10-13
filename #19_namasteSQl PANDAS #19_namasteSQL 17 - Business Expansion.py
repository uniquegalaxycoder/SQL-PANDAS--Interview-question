"""
Amazon is expanding their pharmacy business to new cities every year. You are given a table of business operations where you have information about cities where Amazon is doing operations along with the business date information.

Write a SQL to find year wise number of new cities added to the business, display the output in increasing order of year.

 

Table: business_operations
+---------------+-----------+
| COLUMN_NAME   | DATA_TYPE |
+---------------+-----------+
| business_date | date      |
| city_id       | int       |
+---------------+-----------+
"""

import pandas as pd

business_operations_df = business_operations_df.groupby(['city_id']).agg(
		year = ('business_date', lambda x : x.min())
).reset_index()

business_operations_df['business_year'] = business_operations_df['year'].dt.year

df = business_operations_df.groupby('business_year').agg(total_new_city = ('city_id', lambda x : x.count())).reset_index()

print(df)
