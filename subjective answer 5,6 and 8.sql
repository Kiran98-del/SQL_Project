---- Answer to subjective question 5,6 and 8

SELECT 
    u.id AS user_id,
    u.username,
    COUNT(DISTINCT p.id) AS photos_uploaded,
    COUNT(DISTINCT l.user_id) AS total_likes,
    COUNT(DISTINCT c.id) AS total_comments,
    -- Get unique follower count for each user
    (SELECT COUNT(DISTINCT f.follower_id)
     FROM follows f
     WHERE f.followee_id = u.id) AS followers_count,
    -- Calculate engagement rate as total interactions divided by follower count
    (COUNT(DISTINCT l.user_id) + COUNT(DISTINCT c.id)) / 
    (SELECT COUNT(DISTINCT f.follower_id)
     FROM follows f
     WHERE f.followee_id = u.id) AS engagement_rate
FROM users u
LEFT JOIN photos p ON u.id = p.user_id
LEFT JOIN likes l ON p.id = l.photo_id
LEFT JOIN comments c ON p.id = c.photo_id
GROUP BY u.id
ORDER BY engagement_rate DESC;

