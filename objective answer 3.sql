---- Answer to objective question 3

SELECT 
  AVG(tag_count) AS average_tags_per_post
FROM 
  (
    SELECT 
      p.id, 
      COUNT(pt.tag_id) AS tag_count
    FROM 
      photos p
    LEFT JOIN 
      photo_tags pt ON p.id = pt.photo_id
    GROUP BY 
      p.id
  ) AS subquery;