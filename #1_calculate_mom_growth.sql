-- Q. You have given a sales table that holds monthly total sales You have to write a query to calculate the month-on-month sales growth percentage


create table Sales (
	Month_no int ,
	Month varchar(100) ,
	sales int 
);

drop Table sales;

insert into sales ( month_no, Month, sales) values(1, 'Jan', 100);
insert into sales ( month_no, Month, sales) values(2, 'Feb', 120);
insert into sales ( month_no, Month, sales) values(3, 'March', 150);
insert into sales ( month_no, Month, sales) values(4, 'Apr', 180);
insert into sales ( month_no, Month, sales) values(5, 'May', 200);
insert into sales ( month_no, Month, sales) values(6, 'June', 250);
insert into sales ( month_no, Month, sales) values(7, 'July', 300);
insert into sales ( month_no, Month, sales) values(8, 'Aug', 400);

select * from sales ; 

with cte1 as (
select 
	month_no,
	month,
	sales,
	lag(sales)over(order by month_no asc) as preveious_sales
from sales
)

select 
	month,
	sales,
	isnull(preveious_sales,0) as last_month_sales,
	concat(round(((sales - preveious_sales)*100/ preveious_sales),2),' %') as sales_growth
from cte1
