---- Answer to subjective question 2

SELECT u.id, u.username
FROM users u
LEFT JOIN photos p ON u.id = p.user_id AND p.created_dat >= NOW() - INTERVAL 30 DAY
LEFT JOIN comments c ON u.id = c.user_id AND c.created_at >= NOW() - INTERVAL 30 DAY
LEFT JOIN likes l ON u.id = l.user_id AND l.created_at >= NOW() - INTERVAL 30 DAY
LEFT JOIN follows f ON u.id = f.follower_id AND f.created_at >= NOW() - INTERVAL 30 DAY
WHERE p.id IS NULL AND c.id IS NULL AND l.user_id IS NULL AND f.follower_id IS NULL;
