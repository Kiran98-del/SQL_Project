---- Answer to objective question 12

WITH hashtag_likes AS (
  SELECT 
    t.tag_name,
    AVG(l.count) AS avg_likes
  FROM 
    tags t
    JOIN photo_tags pt ON t.id = pt.tag_id
    JOIN (
      SELECT 
        photo_id, 
        COUNT(*) AS count
      FROM 
        likes
      GROUP BY 
        photo_id
    ) l ON pt.photo_id = l.photo_id
  GROUP BY 
    t.tag_name
)
SELECT 
  tag_name,
  avg_likes,
  DENSE_RANK() OVER (ORDER BY avg_likes DESC) AS rnk
FROM 
  hashtag_likes
ORDER BY 
  rnk;