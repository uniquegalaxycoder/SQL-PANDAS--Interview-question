"""
You have a table called gap_sales. Write an SQL query to find the total sales for each category in each store for the Q2(April-June) of  2023. 
Return the store ID, category name, and total sales for each category in each store. Sort the result by total sales in ascending order.

 

Tables: gap_sales
+-------------+-------------+
| COLUMN_NAME | DATA_TYPE   |
+-------------+-------------+
| sale_id     | int         |
| store_id    | int         |
| sale_date   | date        |
| category    | varchar(10) |
| total_sales | int         |
+-------------+-------------+
"""

with 
cte1 as (
  select 
	  sale_id,
    store_id,
    sale_date,
    category,
    total_sales
  from gap_sales
  WHERE QUARTER(sale_date) = 2
)

SELECT
	  STORE_ID,
    CATEGORY,
    SUM(TOTAL_SALES) AS TOTAL_SALES
FROM 
	CTE1
GROUP BY STORE_ID,
    CATEGORY
ORDER BY SUM(TOTAL_SALES) ASC

