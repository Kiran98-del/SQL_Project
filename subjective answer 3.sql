---- Answer to subjective question 3

SELECT t.tag_name, 
       COUNT(DISTINCT l.user_id) AS likes_count, 
       COUNT(DISTINCT c.user_id) AS comments_count,
       COUNT(DISTINCT pt.photo_id) AS photos_count
FROM tags t
LEFT JOIN photo_tags pt ON t.id = pt.tag_id
LEFT JOIN likes l ON pt.photo_id = l.photo_id
LEFT JOIN comments c ON pt.photo_id = c.photo_id
GROUP BY t.tag_name
ORDER BY likes_count DESC, comments_count DESC;
