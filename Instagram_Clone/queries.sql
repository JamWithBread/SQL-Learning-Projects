-- Find the earliest data that a user joined

SELECT DATE_FORMAT(MIN(created_at), "%D %M %Y") AS earliest_date FROM users;

-- Find the email of the earliest users

SELECT email, DATE_FORMAT(created_at,"%D %M %Y") AS created 
FROM users 
WHERE created_at  = (SELECT MIN(created_at) FROM users);

-- Find how many users joined by month

SELECT DATE_FORMAT(created_at, "%M") AS month,
COUNT(*) AS count 
FROM users
GROUP BY MONTH(created_at);

-- Count the number of users with yahoo emails

SELECT COUNT(*) as yahoo_users FROM users WHERE email LIKE '%@yahoo.com';

-- Get total number of users for each email host

SELECT CASE
    WHEN email LIKE '%@yahoo.com' THEN 'yahoo'
    WHEN email LIKE '%@hotmail.com' THEN 'hotmail'
    WHEN email LIKE '%@gmail.com' THEN 'gmail'
    ELSE 'other'
    end AS provider,
    COUNT(*) AS total_users  
FROM users
GROUP BY provider
ORDER BY total_users DESC;
        
