"""
  You are provided with a table that lists various product categories, each containing a comma-separated list of products. 
  Your task is to write a SQL query to count the number of products in each category. Sort the result by product count.

 

Tables: categories
+-------------+-------------+
| COLUMN_NAME | DATA_TYPE   |
+-------------+-------------+
| category    | varchar(15) |
| products    | varchar(30) |
+-------------+-------------+

data :

+-------------+-------------------------------+
| Categoty    | Products                      |
+-------------+-------------------------------+
| Electronic  | Battery, Laptop, Mobile, Bulb |
| Furniture   | Chair, Dine-Table             |
| Clothing    | T-Shirt                       |
| Groceries   | Rice, VegitableOil, seeds     |
+-------------+-------------------------------+

  
"""

select 
	category,
    length(products) - length(replace(products, ',',''))+1 as count
from categories
order by length(products) - length(replace(products, ',',''))+1 asc;

