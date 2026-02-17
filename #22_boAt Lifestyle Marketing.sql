"""
boAt Lifestyle is focusing on influencer marketing to build and scale their brand. They want to partner with power creators for their upcoming campaigns. 
The creators should satisfy below conditions to qualify:

1- They should have 100k+ followers on at least 2 social media platforms and
2- They should have at least 50k+ views on their latest YouTube video.

Write an SQL to get creator id and name satisfying above conditions.

Table: creators
+-------------+-------------+
| COLUMN_NAME | DATA_TYPE   |
+-------------+-------------+
| id          | int         |
| name        | varchar(10) |
| followers   | int         |
| platform    | varchar(10) |
+-------------+-------------+

Table: youtube_videos
+--------------+-----------+
| COLUMN_NAME  | DATA_TYPE |
+--------------+-----------+
| id           | int       |
| creator_id   | int       |
| publish_date | date      |
| views        | int       |
+--------------+-----------+

"""

with cte1 as (
select 
	id as creator_id,
	name
from creators
where followers > 100000
group by id, name
having count(platform) >= 2 
) ,


cte2 as (
select
	creator_id,
	views 
from (
	select 
	creator_id,
	row_number()over(partition by creator_id order by publish_date desc ) as ranks,
	views 
from youtube_videos
) as table_1 
where ranks = 1 and views >= 50000 
)

select 
	a.creator_id,
	a.name
from cte1 as a 
join cte2 as b 
on a.creator_id = b.creator_id ;


