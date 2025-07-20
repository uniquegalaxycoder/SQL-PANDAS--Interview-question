-- write a query  to find the winner in each group
-- the winner in each group is the player who scoped the maximum total points within the group. In the case of a tie
--the loweest player_id wins


select * from matches;

select * from players ;

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
cte3 as (
select * 
, rank()over(partition by group_id order by total_score desc, player_id asc ) as score_rank
from final_score
)

select 
	* 
from cte3 
where score_rank = 1