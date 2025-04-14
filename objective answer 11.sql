---- Answer to objective question 11

WITH monthly_engagement AS (
  SELECT 
    u.id,
    u.username,
    YEAR(l.created_at) AS year,
    MONTH(l.created_at) AS month,
    COALESCE(l.likes_count, 0) + COALESCE(c.comments_count, 0) AS total_engagement
  FROM 
    users u
    LEFT JOIN (
      SELECT 
        user_id, 
        COUNT(*) AS likes_count,
        created_at
      FROM 
        likes
      GROUP BY 
        user_id, created_at
    ) AS l ON u.id = l.user_id
    LEFT JOIN (
      SELECT 
        user_id, 
        COUNT(*) AS comments_count,
        created_at
      FROM 
        comments
      GROUP BY 
        user_id, created_at
    ) AS c ON u.id = c.user_id
)
SELECT 
  id,
  username,
  year,
  month,
  total_engagement,
  DENSE_RANK() OVER (PARTITION BY year, month ORDER BY total_engagement DESC) AS engagement_rank
FROM 
  monthly_engagement
  where
  year is not null and month is not null
ORDER BY 
  year, month, engagement_rank;