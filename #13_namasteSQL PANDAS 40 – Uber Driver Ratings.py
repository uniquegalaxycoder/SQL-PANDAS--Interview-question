"""
Suppose you are a data analyst working for ride-sharing platform Uber. Uber is interested in analyzing the performance of drivers based on their ratings and
wants to categorize them into different performance tiers. 

Write an SQL query to categorize drivers equally into three performance tiers (Top, Middle, and Bottom) based on their average ratings. 
Drivers with the highest average ratings should be placed in the top tier, drivers with ratings below the top tier but above the bottom tier should be placed
in the middle tier, and drivers with the lowest average ratings should be placed in the bottom tier. Sort the output in decreasing order of average rating.

 

Table : driver_ratings
+-------------+--------------+
| COLUMN_NAME | DATA_TYPE    |
+-------------+--------------+
| driver_id   | int          |
| avg_rating  | decimal(3,2) |
+-------------+--------------+

"""

import pandas as pd

# Sort and assign to df
df = driver_ratings_df.sort_values(by='avg_rating', ascending=True)  # no inplace

# Create NTILE buckets (1–3)
df['ntile_3'] = pd.qcut(df['avg_rating'], q=3, labels=False) + 1

# Map status based on bucket
df['status'] = df['ntile_3'].apply(
    lambda x: 'Top' if x == 1 else ('Middle' if x == 2 else 'Bottom')
)

# Select columns and restore original order
df = df[['driver_id', 'avg_rating', 'status']].sort_index()

print(df)

print(df)
