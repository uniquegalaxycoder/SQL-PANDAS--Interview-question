"""
  Amazon is expanding their pharmacy business to new cities every year. You are given a table of business operations where you have information about cities
  where Amazon is doing operations along with the business date information.
  
  Write a SQL to find year wise number of new cities added to the business, display the output in increasing order of year.

 

Table: business_operations
+---------------+-----------+
| COLUMN_NAME   | DATA_TYPE |
+---------------+-----------+
| business_date | date      |
| city_id       | int       |
+---------------+-----------+
  """

with cte as (
select 
  	city_id,
  	min(year(business_date)) as business_year
  from business_operations 
  group by city_id
 )
 
 select 
 	business_year,
    count(city_id) as total_new_city
 from cte
 group by business_year ;

