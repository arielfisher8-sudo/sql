--Social Media System
create table comments( contents varchar(max), userName varchar(100), originalPostID int )
create table posts ( postID int, contents varchar(MAX) , userName varchar(100), likes int   )
create table userActivity (userName varchar(100), dateActive date)


SELECT top 3
    p.username, 
    SUM(p.likes) + (COUNT(c.originalPostID) * 3.5) AS Total_Popularity_Score
FROM 
    Posts p
LEFT JOIN 
    Comments c ON p.postID = c.originalPostID
GROUP BY 
    p.username
ORDER BY 
    Total_Popularity_Score DESC

select top 3 postID, sum(likes) + count (originalpostID)*3.5 AS Total_Popularity_Score
from posts
join comments on posts.postID = comments.originalPostID
group by postID
order by Total_Popularity_Score

INSERT INTO UserActivity (username, dateActive)
VALUES 
    ('tech_guru88', '2026-01-12'),
    ('pixel_artist', '2026-02-28'),
    ('code_ninja', '2026-03-15'),
    ('data_wizard', '2026-04-02'),
    ('cyber_scout', '2026-05-19'),
    ('coffee_coder', '2026-06-10'),
    ('lunar_explorer', '2026-06-18'),
    ('alpha_tester', '2026-06-19'),
    ('beta_reader', '2026-06-20'),
    ('delta_flyer', '2026-06-21'),
    ('echo_location', '2026-06-21'),
    ('gamma_ray', '2026-06-21');

select dateactive, count(dateactive)
from userActivity
group by dateactive


