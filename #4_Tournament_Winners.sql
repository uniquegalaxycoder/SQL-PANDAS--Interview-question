-- Write a query  to find the winner in each group
-- The winner in each group is the player who scored the maximum total points within the group. In the case of a tie
--the loweest player_id wins

-- match table
select * from matches;

-- player table
select * from players ;

-- creating a common table expression  
with cte1 as (	
select 
	first_player as player_id,
	first_score as score
from matches 
union all 
select 
	second_player as player_id,
	second_score as  score
from matches
),

-- In the above cte (cte1), in the matches table, we have 1st player & 2nd player id in two different columns & also the score column is two different.
-- we created a union logic for unpivoting the table based on player ID & he's score
	

	
final_score as (
select 
	b.group_id,
	a.player_id,
	sum(score) as total_score
from cte1 as a 
inner join players as b 
on b.player_id = a.player_id
group by b.group_id,a.player_id
),

-- In the above cte ( final_score ), we have joined the players & matches tables on player ID columns.
-- aggregated score based on group ID & player ID
	
	
cte3 as (
select * 
, rank()over(partition by group_id order by total_score desc, player_id asc ) as score_rank
from final_score
)

-- In the above cte (cte3), we have used the rank function to assign a score rank based on the max score in each group ID, & also we have applied one more logic in 
-- rank assigning, if the rank is tied, then assign rank on the lowest player ID.

select 
	* 
from cte3 
where score_rank = 1

-- in abov code we filltering the output 
