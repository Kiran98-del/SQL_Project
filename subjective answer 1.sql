---- Answer to subjective question 1

SELECT 
    u.id AS user_id, 
    u.username, 
    COUNT(DISTINCT p.id) AS photo_count,  -- Count unique photos uploaded by the user
    COUNT(DISTINCT c.id) AS comment_count,  -- Count unique comments made by the user
    COUNT(DISTINCT l.photo_id) AS like_count,  -- Count unique photo likes for the user's photos
    (SELECT COUNT(*) FROM follows f WHERE f.follower_id = u.id) AS followers_count,  -- Count followers of the user
    (SELECT COUNT(*) FROM follows f WHERE f.followee_id = u.id) AS following_count   -- Count the users the user is following
FROM 
    users u
LEFT JOIN 
    photos p ON u.id = p.user_id  -- Join photos to count photos uploaded by the user
LEFT JOIN 
    comments c ON p.id = c.photo_id  -- Join comments to count comments on the user's photos
LEFT JOIN 
    likes l ON p.id = l.photo_id  -- Join likes to count likes on the user's photos
GROUP BY 
    u.id
ORDER BY 
    photo_count DESC, comment_count DESC, like_count DESC, followers_count DESC;



