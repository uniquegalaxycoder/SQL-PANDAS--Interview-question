--Assume you're --given two tables containing data about Facebook Pages and their respective likes (as in "Like a Facebook Page").

--Write a query to return the IDs of the Facebook pages that have zero likes.
--The output should be sorted in ascending order based on the page IDs.

create table pages (
  page_id	integer primary key  
  page_name	varchar(255)
);

insert into pages values 
  (20001, "SQL Solutions"),
  (20045, "Brain Exercises"),
  (20701, "Tips for Data Analysts")
;

create table page_likes (
  user_id integer,
  page_id integer,
  liked_date datetime
  foreign key (page_id) references pages(page_id)
);

insert into page_likes values 
  (111, 20001, '2022-04-08 00:00:00'),
  (121, 20045, '2022-03-12 00:00:00'),
  (156, 20001, '2022-07-25 00:00:00');


--> Solution :

with cte1 as (
select
  a.page_id,
  a.page_name,
  b.user_id,
  b.liked_date
from pages a left join page_likes b 
on a.page_id = b.page_id
)

select 
  a.page_id
from (
select 
  page_id,
  count(liked_date) as total_like
from cte1 
group by page_id
) a 
where total_like = 0
order by page_id asc ;

