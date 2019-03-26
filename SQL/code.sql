--1.
Select *
 from survey
 limit 10;

--2. 
SELECT question,
   COUNT(DISTINCT user_id)
FROM survey
GROUP BY 1;

--4. TAbles
SELECT *
FROM quiz
LIMIT 5;

SELECT *
FROM home_try_on
LIMIT 5;

SELECT *
FROM purchase
LIMIT 5;

--5. build table
Select q.user_id, 
h.user_id is not null as 'is_home_try_on',
h.number_of_pairs,
p.user_id is not null as 'is_purchase' 
From quiz as 'q'
Left join home_try_on as 'h'
	on q.user_id = h.user_id
left join purchase as 'p'
	on h.user_id = p.user_id
limit 10;


--6. conversion rates
With funnels as (
  Select Distinct q.user_id, 
    h.user_id IS NOT NULL AS 'is_home_try_on',
    h.number_of_pairs,
    p.user_id IS NOT NULL AS 'is_purchase' 
  From quiz as 'q'
  Left join home_try_on as 'h'
    on q.user_id = h.user_id
  left join purchase as 'p'
    on p.user_id = q.user_id)
SELECT COUNT(*) AS 'num_quiz', 
	sum(is_home_try_on) as 'num_try_on', 
	sum(is_purchase) as 'num_purchased',
	1.0 * SUM(is_home_try_on) / COUNT(user_id) as 'Quiz to Try On',
	1.0 * SUM(is_purchase) / SUM(is_home_try_on) as 'Try On to purchase'
From funnels;

--6. Conversion rates - number of pairs
With funnels as (
  Select q.user_id, 
    h.user_id IS NOT NULL AS 'is_home_try_on',
    h.number_of_pairs,
    p.user_id IS NOT NULL AS 'is_purchase' 
  From quiz as 'q'
  Left join home_try_on as 'h'
    on q.user_id = h.user_id
  left join purchase as 'p'
    on p.user_id = q.user_id)
SELECT number_of_pairs, COUNT(*) AS 'num_quiz', 
	sum(is_home_try_on) as 'num_try_on', 
	sum(is_purchase) as 'num_purchased',
	1.0 * SUM(is_home_try_on) / COUNT(user_id) as 'Quiz to Try On',
	1.0 * SUM(is_purchase) / SUM(is_home_try_on) as 'Try On to purchase'
From funnels
group by number_of_pairs
order by number_of_pairs;

--7. Popular Styles

Select style, Count(*)
From quiz
group by style;

Select fit, Count(*)
From quiz
group by fit;

Select shape, Count(*)
From quiz
group by shape;

Select color, Count(*)
From quiz
group by color;


--7. Popular Model
Select  model_name, 
	Count(Distinct User_id)
From purchase
group by model_name;

