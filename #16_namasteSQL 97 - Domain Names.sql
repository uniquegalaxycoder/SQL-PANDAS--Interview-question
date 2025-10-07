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

select
	  email,
    substring_index(email,'@',-1) as domain_name
from customers;
