"""
  Flipkart an ecommerce company wants to find out its top most selling product by quantity in each category. In case of a tie when quantities sold are same 
  for more than 1 product, then we need to give preference to the product with higher sales value.

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

with cte as (
select  
	category,
    product_id  ,
    sum(quantity) as total_quatity,
    sum(unit_price * quantity ) as total_price
from orders
group by category,product_id  
)
select 
	category,
    product_id
from (
select 
	*,
    row_number()over(partition by category order by total_quatity desc , total_price desc) as ranks 
from cte
) as a 
where ranks = 1 ;



