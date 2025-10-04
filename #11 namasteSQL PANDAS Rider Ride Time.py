"""
You are working with Zomato, a food delivery platform, and you need to analyze the performance of Zomato riders in terms of the time they spend delivering orders each day. Given the pickup and delivery times for each order, your task is to calculate the duration of time spent by each rider on deliveries each day.  Order the output by rider id and ride date.

 

Table:orders 
+---------------+-----------+
| COLUMN_NAME   | DATA_TYPE |
+---------------+-----------+
| rider_id      | int       |
| order_id      | int       |
| pickup_time   | datetime  |
| delivery_time | datetime  |
+---------------+-----------+

"""

import pandas as pd

df = orders_df[(orders_df['pickup_time'].dt.date) == (orders_df['delivery_time'].dt.date)]

df['ride_date'] = df['pickup_time'].dt.date

df['time_diff'] = (df['delivery_time'] - df['pickup_time']).dt.total_seconds()/60

df= df[['rider_id', 'ride_date', 'time_diff']]



df1 = orders_df[(orders_df['pickup_time'].dt.date) != (orders_df['delivery_time'].dt.date)]

df1['ride_date'] = df1['pickup_time'].dt.date

df1['time_diff'] = (pd.to_datetime(df1['delivery_time'].dt.strftime('%Y-%m-%d 00:00:00')) - df1['pickup_time']).dt.total_seconds()/60

df1 = df1[['rider_id', 'ride_date', 'time_diff']]


df2 = orders_df[(orders_df['pickup_time'].dt.date) != (orders_df['delivery_time'].dt.date)]

df2['ride_date'] = df2['delivery_time'].dt.date

df2['time_diff'] = (df2['delivery_time'] - pd.to_datetime(df2['delivery_time'].dt.strftime('%Y-%m-%d 00:00:00'))).dt.total_seconds()/60

df2 = df2[['rider_id', 'ride_date', 'time_diff']]


final_df1 = pd.concat([df, df1, df2])

final_df1 = final_df1[final_df1['time_diff']!= 0].groupby( ['rider_id', 'ride_date'] ).agg(
	                                        total_ride_time = ( 'time_diff', lambda x : round( x.sum() ) ) ).reset_index()

final_df1 = final_df1.sort_values(by = ['rider_id','ride_date'], ascending = True).reset_index(drop=True)

print(final_df1)
