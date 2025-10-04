"""
You are working with Zomato, a food delivery platform, and you need to analyze the performance of Zomato riders in terms of the time they spend delivering orders each day.
Given the pickup and delivery times for each order, your task is to calculate the duration of time spent by each rider on deliveries each day.  O
rder the output by rider id and ride date.

 
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

  
with 
cte1 as (
  select 
  	order_id
  	,rider_id
  	,cast(pickup_time as date) as ride_date
  	,timestampdiff(minute, pickup_time, delivery_time) as time_diff
  from orders
  where cast(pickup_time as date) = cast(delivery_time as date)
),

""" IN above cte1 we have find the time differance between pickup_time & delivery_time by timestampdiff function.
    then filter the data for same day pickup & delivery date """

  
cte2 as (  
  select 
  	order_id
  	,rider_id
  	,cast(pickup_time as date ) as ride_date
  	,timestampdiff(minute, pickup_time, cast(delivery_time as date)) as time_diff
  from orders
 	where cast(pickup_time as date) != cast(delivery_time as date)
),

  """ IN above CTE2 we have filter the data where pickup date is not same as delivery date. """

cte3 as (
  select 
  	order_id
  	,rider_id
  	,cast(delivery_time as date) as ride_date
  	,timestampdiff(minute,cast(delivery_time as date), delivery_time) as time_diff
  from orders	
	where cast(pickup_time as date) != cast(delivery_time as date)
),

  """ In above CTE3 we have find the time differance between the delivery date & delivery time where pickup time & delivery time not equal. """

cte4 as (
  select rider_id, ride_date, time_diff from cte1 
  union all 
  select rider_id, ride_date, time_diff from cte2
  union all 
  select rider_id, ride_date, tie_diff from cte3
)

  """ IN cte4 we have appending the data by union all """
  
  select 
  	rider_id,
    ride_date,
    sum(time_diff) as total_ride
  from cte
  where time_diff != 0
  group by rider_id, ride_date
  order by rider_id asc, ride_date asc


""" here we have aggregated the total ride time on each rider_id & ride date & also we have filterout that rides which is delivery time differance is 0"""
