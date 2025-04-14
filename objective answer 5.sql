---- Answer to objective question 5

WITH follower_counts AS (
  SELECT 
    followee_id AS user_id,
    COUNT(follower_id) AS follower_count
  FROM 
    follows
  GROUP BY 
    followee_id
),
following_counts AS (
  SELECT 
    follower_id AS user_id,
    COUNT(followee_id) AS following_count
  FROM 
    follows
  GROUP BY 
    follower_id
)
SELECT 
  u.username,
  COALESCE(fc.follower_count, 0) AS follower_count,
  COALESCE(fic.following_count, 0) AS following_count
FROM 
  users u
  LEFT JOIN follower_counts fc ON u.id = fc.user_id
  LEFT JOIN following_counts fic ON u.id = fic.user_id
ORDER BY 
  fc.follower_count DESC, 
  fic.following_count DESC;