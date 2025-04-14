---- Answer to objective question 10

SELECT 
  u.id,
  u.username,
  COALESCE(likes_count, 0) AS total_likes,
  COALESCE(comments_count, 0) AS total_comments,
  COALESCE(tags_count, 0) AS total_tags
FROM 
  users u
  LEFT JOIN (
    SELECT 
      user_id, 
      COUNT(*) AS likes_count
    FROM 
      likes
    GROUP BY 
      user_id
  ) AS likes ON u.id = likes.user_id
  LEFT JOIN (
    SELECT 
      user_id, 
      COUNT(*) AS comments_count
    FROM 
      comments
    GROUP BY 
      user_id
  ) AS comments ON u.id = comments.user_id
  LEFT JOIN (
    SELECT 
      p.user_id, 
      COUNT(*) AS tags_count
    FROM 
      photos p
    JOIN 
      photo_tags pt ON p.id = pt.photo_id
    GROUP BY 
      p.user_id
  ) AS tags ON u.id = tags.user_id;
