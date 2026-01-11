-- SQL Advent Calendar - Day 6
-- Title: Ski Resort Snowfall Rankings
-- Difficulty: hard
--
-- Question:
-- Buddy is planning a winter getaway and wants to rank ski resorts by annual snowfall. Can you help him bucket these ski resorts into quartiles?
--
-- Buddy is planning a winter getaway and wants to rank ski resorts by annual snowfall. Can you help him bucket these ski resorts into quartiles?
--

-- Table Schema:
-- Table: resort_monthly_snowfall
--   resort_id: INT
--   resort_name: VARCHAR
--   snow_month: INT
--   snowfall_inches: DECIMAL
--

-- My Solution:

with resort_info as (select resort_name,
          sum(snowfall_inches) as resort_snowfall 
from resort_monthly_snowfall
group by resort_name),
    total_snowfall as (
select sum(resort_snowfall) as sum_snowfall
from resort_info)
select resort_name, 
  resort_snowfall, 
  resort_snowfall/sum_snowfall as percentage,
  ntile(4) over (order by resort_snowfall/sum_snowfall) as rown
from resort_info
cross join total_snowfall
