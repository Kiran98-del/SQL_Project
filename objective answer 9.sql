---- Answer to objective question 9

SELECT 
  SUM((likes - avg_likes) * (comments - avg_comments)) / 
  SQRT(SUM(POWER(likes - avg_likes, 2)) * SUM(POWER(comments - avg_comments, 2))) AS correlation_coefficient
FROM (
  SELECT 
    COUNT(CASE WHEN l.user_id IS NOT NULL THEN 1 END) AS likes,
    COUNT(CASE WHEN c.id IS NOT NULL THEN 1 END) AS comments,
    (SELECT AVG(likes) FROM (
      SELECT COUNT(CASE WHEN l.user_id IS NOT NULL THEN 1 END) AS likes
      FROM photos p
      LEFT JOIN likes l ON p.id = l.photo_id
      GROUP BY p.user_id
    ) AS subquery) AS avg_likes,
    (SELECT AVG(comments) FROM (
      SELECT COUNT(CASE WHEN c.id IS NOT NULL THEN 1 END) AS comments
      FROM photos p
      LEFT JOIN comments c ON p.id = c.photo_id
      GROUP BY p.user_id
    ) AS subquery) AS avg_comments
  FROM 
    photos p
  LEFT JOIN 
    likes l ON p.id = l.photo_id
  LEFT JOIN 
    comments c ON p.id = c.photo_id
  GROUP BY 
    p.user_id
) AS subquery;
