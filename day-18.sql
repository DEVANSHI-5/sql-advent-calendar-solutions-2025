-- SQL Advent Calendar - Day 18
-- Title: 12 Days of Data - Progress Tracking
-- Difficulty: hard
--
-- Question:
-- Over the 12 days of her data challenge, Data Dawn tracked her daily quiz scores across different subjects. Can you find each subject's first and last recorded score to see how much she improved?
--
-- Over the 12 days of her data challenge, Data Dawn tracked her daily quiz scores across different subjects. Can you find each subject's first and last recorded score to see how much she improved?
--

-- Table Schema:
-- Table: daily_quiz_scores
--   subject: VARCHAR
--   quiz_date: DATE
--   score: INTEGER
--

-- My Solution:

WITH RankedScores AS (
    SELECT
        subject,
        score,
        ROW_NUMBER() OVER (PARTITION BY subject ORDER BY quiz_date ASC) as first_rank,
        ROW_NUMBER() OVER (PARTITION BY subject ORDER BY quiz_date DESC) as last_rank
    FROM
        daily_quiz_scores
)
SELECT
    t1.subject,
    t1.score AS first_score,
    t2.score AS last_score,
    (t2.score - t1.score) AS improvement
FROM
    RankedScores t1
JOIN
    RankedScores t2 ON t1.subject = t2.subject
WHERE
    t1.first_rank = 1 AND t2.last_rank = 1;
