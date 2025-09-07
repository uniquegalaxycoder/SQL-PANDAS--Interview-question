create table booking_table (
    booking_id varchar(10),
    booking_date date,
    user_id varchar(10),
    line_of_business varchar(20)
);

insert into booking_table (booking_id, booking_date, user_id, line_of_business) values
('b1',  '2022-03-23', 'u1', 'Flight'),
('b2',  '2022-03-27', 'u2', 'Flight'),
('b3',  '2022-03-28', 'u1', 'Hotel'),
('b4',  '2022-03-31', 'u4', 'Flight'),
('b5',  '2022-04-02', 'u1', 'Hotel'),
('b6',  '2022-04-02', 'u2', 'Flight'),
('b7',  '2022-04-06', 'u5', 'Flight'),
('b8',  '2022-04-06', 'u6', 'Hotel'),
('b9',  '2022-04-06', 'u2', 'Flight'),
('b10', '2022-04-10', 'u1', 'Flight'),
('b11', '2022-04-12', 'u4', 'Flight'),
('b12', '2022-04-16', 'u1', 'Flight'),
('b13', '2022-04-19', 'u2', 'Flight'),
('b14', '2022-04-20', 'u5', 'Hotel'),
('b15', '2022-04-22', 'u6', 'Flight'),
('b16', '2022-04-26', 'u4', 'Hotel'),
('b17', '2022-04-28', 'u2', 'Hotel'),
('b18', '2022-04-30', 'u1', 'Hotel'),
('b19', '2022-05-04', 'u4', 'Hotel'),
('b20', '2022-05-06', 'u1', 'Flight');

create table user_table (
    user_id varchar(10),
    segment varchar(10)
);

insert into user_table (user_id, segment) values
('u1', 's1'),
('u2', 's1'),
('u3', 's1'),
('u4', 's2'),
('u5', 's2'),
('u6', 's3'),
('u7', 's3'),
('u8', 's3'),
('u9', 's3'),
('u10', 's3');

select * from booking_table;
select * from user_table;

-- Q1. write a query to find total users & total users booked flight in april 2022 month with respective each segment.

with cte1 as (
select 
	users.user_id as user_user_id,
	users.segment,
	booking.booking_id,
	booking.booking_date,
	booking.user_id,
	booking.line_of_business
from user_table as users
left join booking_table as booking
on users.user_id = booking.user_id
)

select 
	segment,
	count(distinct user_user_id) as total_users,
	count(distinct case when ((booking_date between '2022-04-01' and '2022-04-30') and line_of_business = 'Flight') then user_id end) as user_booked_flight_apr2022
from cte1
group by segment;



-- Q2. Write a query to identify users whoes first booking was hotel booking

with cte1 as (
	select 
	users.user_id as user_user_id,
	users.segment,
	booking.booking_id,
	booking.booking_date,
	booking.user_id,
	booking.line_of_business
from user_table as users
left join booking_table as booking
on users.user_id = booking.user_id 
)

select 
	user_user_id,
	booking_date,
	line_of_business,
	segment
from (
select
	user_user_id,
	booking_date,
	line_of_business,
	segment,
	dense_rank()over(partition by user_id order by booking_date asc) as rn
from cte1
) as table1
where rn = 1
and line_of_business = 'Hotel' ;



-- Q3.	Write a query to calculate the days between 1st booking & last booking of the users with users_id = 1

with cte1 as (
	select 
	users.user_id as user_user_id,
	users.segment,
	booking.booking_id,
	booking.booking_date,
	booking.user_id,
	booking.line_of_business
from user_table as users
left join booking_table as booking
on users.user_id = booking.user_id 
)

select 
	user_user_id,
	datediff( day, min(booking_date), max(booking_date)) as date_diff_first_last_booking
from cte1
where user_user_id = 'u1'
group by user_user_id


  

-- Q4. write a query to count then number of flight and hotel bookings in each of the segments for the year 2022

with cte1 as (
	select 
	users.user_id as user_user_id,
	users.segment,
	booking.booking_id,
	booking.booking_date,
	booking.user_id,
	booking.line_of_business
from user_table as users
inner join booking_table as booking
on users.user_id = booking.user_id 
)

select 
	segment,
	count( distinct case when year(booking_date) = 2022 and line_of_business = 'flight' then booking_id end ) as "Total Flight Bookings",
	count( distinct case when year(booking_date) = 2022 and line_of_business = 'Hotel' then booking_id end ) as "Total Hotel Bookings"
from cte1
group by segment ;




-- Q5. find, for each segment, the user who made then earlist bookings in april 2022, and also return how many total bookings that users made in April 2022.

with cte1 as (
	select 
	users.user_id as user_user_id,
	users.segment,
	booking.booking_id,
	booking.booking_date,
	booking.user_id,
	booking.line_of_business
from user_table as users
inner join booking_table as booking
on users.user_id = booking.user_id 
),

cte2 as (
select 
	segment,
	user_user_id
from (
select 
	segment,
	user_user_id,
	row_number()over(partition by segment order by booking_date asc, booking_id asc) as rn
from cte1
where month(booking_date) = 4) as tb1
where rn = 1
),

cte3 as (
select 
	user_user_id, 
	count(case when month(booking_date)=4 then booking_id end) as total_apr_booking
from cte1
group by user_user_id
)

select 
	a.segment,
	a.user_user_id,
	b.total_apr_booking
from cte2 as a left join cte3 as b 
on a.user_user_id = b.user_user_id
