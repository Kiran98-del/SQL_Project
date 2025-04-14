use ig_clone;

---- Answer to objective question 2
WITH user_activity AS (
  SELECT 
    u.id,
    COUNT(DISTINCT p.id) AS num_posts,
    COUNT(DISTINCT l.photo_id) AS num_likes,
    COUNT(DISTINCT c.id) AS num_comments
  FROM 
    users u
  LEFT JOIN 
    photos p ON u.id = p.user_id
  LEFT JOIN 
    likes l ON u.id = l.user_id
  LEFT JOIN 
    comments c ON u.id = c.user_id
  GROUP BY 
    u.id
)
SELECT 
  num_posts,
  num_likes,
  num_comments,
  COUNT(*) AS num_users
FROM 
  user_activity
GROUP BY 
  num_posts, num_likes, num_comments
ORDER BY 
  num_users DESC;


