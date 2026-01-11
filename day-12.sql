-- SQL Advent Calendar - Day 12
-- Title: North Pole Network Most Active Users
-- Difficulty: hard
--
-- Question:
-- The North Pole Network wants to see who's the most active in the holiday chat each day. Write a query to count how many messages each user sent, then find the most active user(s) each day. If multiple users tie for first place, return all of them.
--
-- The North Pole Network wants to see who's the most active in the holiday chat each day. Write a query to count how many messages each user sent, then find the most active user(s) each day. If multiple users tie for first place, return all of them.
--

-- Table Schema:
-- Table: npn_users
--   user_id: INT
--   user_name: VARCHAR
--
-- Table: npn_messages
--   message_id: INT
--   sender_id: INT
--   sent_at: TIMESTAMP
--

-- My Solution:

WITH DailyUserCounts AS (
    -- Step 1: Count messages for each user on each day
    SELECT
        DATE(sent_at) AS message_date,
        sender_id,
        COUNT(*) AS message_count
    FROM
        npn_messages
    GROUP BY
        DATE(sent_at), sender_id
),
RankedDailyActivity AS (
    -- Step 2: Rank users by message count for each day
    SELECT
        message_date,
        sender_id,
        message_count,
        RANK() OVER (PARTITION BY message_date ORDER BY message_count DESC) AS rank_num
    FROM
        DailyUserCounts
)
-- Step 3: Select the top-ranked users (rank 1) and join for names
SELECT
    r.message_date,
    u.user_name,
    r.message_count
FROM
    RankedDailyActivity r
JOIN
    npn_users u ON r.sender_id = u.user_id
WHERE
    r.rank_num = 1
ORDER BY
    r.message_date;
