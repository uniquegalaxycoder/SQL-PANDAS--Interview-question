--Assume you're --given two tables containing data about Facebook Pages and their respective likes (as in "Like a Facebook Page").

--Write a query to return the IDs of the Facebook pages that have zero likes.
--The output should be sorted in ascending order based on the page IDs.

create table pages (
  page_id	integer primary key  
  page_name	varchar(255)
);

insert into pages values (
  (20001, "SQL Solutions"),
  (20045, "Brain Exercises"),
  (20701, "Tips for Data Analysts")
);

create table page_likes (
  user_id integer,
  page_id integer 
