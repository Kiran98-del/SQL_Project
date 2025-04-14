---- Answer to objective question 4

WITH engagement AS (
  SELECT 
    p.user_id,
    COUNT(l.user_id) AS likes,
    COUNT(c.id) AS comments
  FROM 
    photos p
  LEFT JOIN 
    likes l ON p.id = l.photo_id
  LEFT JOIN 
    comments c ON p.id = c.photo_id
  GROUP BY 
    p.user_id
),
total_engagement AS (
  SELECT 
    user_id,
    likes + comments AS total_engagement
  FROM 
    engagement
)
SELECT 
  u.username,
  te.total_engagement,
  DENSE_RANK() OVER (ORDER BY te.total_engagement DESC) AS engagement_rank
FROM 
  total_engagement te
JOIN 
  users u ON te.user_id = u.id
ORDER BY 
  engagement_rank;