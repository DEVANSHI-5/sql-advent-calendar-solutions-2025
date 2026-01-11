-- SQL Advent Calendar - Day 7
-- Title: Snowflake Types Count
-- Difficulty: easy
--
-- Question:
-- Frosty wants to know how many unique snowflake types were recorded on the December 24th, 2025 storm. Can you help him?
--
-- Frosty wants to know how many unique snowflake types were recorded on the December 24th, 2025 storm. Can you help him?
--

-- Table Schema:
-- Table: snowfall_log
--   flake_id: INT
--   flake_type: VARCHAR
--   fall_time: TIMESTAMP
--

-- My Solution:

SELECT count(distinct(flake_type)) FROM snowfall_log
WHERE fall_time BETWEEN '2025-12-24 00:00:00' AND '2025-12-25 00:00:00'
