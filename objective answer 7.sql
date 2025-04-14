---- Answer to objective question 7

SELECT 
  u.id,
  u.username
FROM 
  users u
WHERE 
  u.id NOT IN (SELECT user_id FROM likes);




