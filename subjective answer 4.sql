---- Answer to subjective question 4
---- Engagement by Time of Day
SELECT 
    HOUR(p.created_dat) AS hour_of_day,
    COUNT(DISTINCT p.id) AS photos_uploaded,
    COUNT(DISTINCT c.id) AS comments_made,
    COUNT(DISTINCT l.user_id) AS unique_likes
FROM photos p
LEFT JOIN comments c ON p.id = c.photo_id
LEFT JOIN likes l ON p.id = l.photo_id
GROUP BY hour_of_day
ORDER BY hour_of_day;

---- Engagement by Day of the Week

SELECT 
    DAYOFWEEK(p.created_dat) AS day_of_week,
    COUNT(DISTINCT p.id) AS photos_uploaded,
    COUNT(DISTINCT c.id) AS comments_made,
    COUNT(DISTINCT l.user_id) AS unique_likes
FROM photos p
LEFT JOIN comments c ON p.id = c.photo_id
LEFT JOIN likes l ON p.id = l.photo_id
GROUP BY day_of_week
ORDER BY day_of_week;

---- Top Engaged Users Based on Likes and Comments

SELECT 
    u.username,
    COUNT(DISTINCT l.photo_id) AS photos_liked,
    COUNT(DISTINCT c.photo_id) AS photos_commented_on
FROM users u
LEFT JOIN likes l ON u.id = l.user_id
LEFT JOIN comments c ON u.id = c.user_id
GROUP BY u.id
ORDER BY photos_liked DESC, photos_commented_on DESC;

---- Most Popular Tags

SELECT 
    t.tag_name,
    COUNT(DISTINCT pt.photo_id) AS tag_count
FROM tags t
JOIN photo_tags pt ON t.id = pt.tag_id
GROUP BY t.id
ORDER BY tag_count DESC;

---- Engagement Based on Photos (Likes and Comments)

SELECT 
    p.id AS photo_id,
    p.image_url,
    COUNT(DISTINCT l.user_id) AS total_likes,
    COUNT(DISTINCT c.id) AS total_comments
FROM photos p
LEFT JOIN likes l ON p.id = l.photo_id
LEFT JOIN comments c ON p.id = c.photo_id
GROUP BY p.id
ORDER BY total_likes DESC, total_comments DESC;
