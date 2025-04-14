---- Answer to objective question 6

WITH engagement AS (
  SELECT 
    p.user_id,
    p.id AS post_id,
    COUNT(l.user_id) AS likes,
    COUNT(c.id) AS comments
  FROM 
    photos p
  LEFT JOIN 
    likes l ON p.id = l.photo_id
  LEFT JOIN 
    comments c ON p.id = c.photo_id
  GROUP BY 
    p.user_id, p.id
),
average_engagement AS (
  SELECT 
    user_id,
    AVG(likes + comments) AS average_engagement
  FROM 
    engagement
  GROUP BY 
    user_id
)
SELECT 
  u.username,
  ae.average_engagement
FROM 
  average_engagement ae
JOIN 
  users u ON ae.user_id = u.id
ORDER BY 
  ae.average_engagement DESC;