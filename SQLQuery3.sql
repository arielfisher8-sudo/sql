--Movie Recommendation Database

create table Movies (movie varchar(100), genre varchar(100))

create table Actors (actorName varchar(100), movie varchar(100), )

create table Users (userName varchar(100),movieName Varchar(100), rating int, actorName varchar(100), actorRating int)

;
drop table users

WITH MovieRatings as (
    SELECT
        m.movie,
        AVG(u.rating) AS avg_rating,
        m.genre
    FROM Movies m
    JOIN Users u
        ON m.movie = u.movieName
    GROUP BY  m.movie,m.genre
),
RankedMovies AS (
    SELECT
        
        MovieRatings.movie mov,
        avg_rating,
        MovieRatings.genre gen,
        RANK() OVER (
            PARTITION BY movies.genre
            ORDER BY avg_rating DESC
        ) AS ranking
        FROM MovieRatings
        inner join movies on MovieRatings.movie=movies.movie
        
    
)
SELECT
    gen,    
    avg_rating,
    mov
FROM RankedMovies
where ranking=1
;

with avgRating as (select actorName as AName, avg(actorRating) as avgRate from users 
group by actorName)
select top (1)  AName,avgRate 
from avgRating
order by avgRate desc



insert into Movies 
values ('Batman','action'), ('superman', 'action'),('forest Gump','Drama'),('good Will Hunting', 'Drama')

insert into Users (userName,moviename,rating)
values ('Ariel', 'Batman', 100), ('Boris','Batman',50), ('charles','superman',90), ('bob','forest gump', 80),('chandler','forest gump',100), ('Beavis', 'good will hunting',100)

insert into Users (userName,moviename,rating)
values ('Ariel', 'Heman', 100)

INSERT INTO Users (actorname, actorRating) VALUES
('Tom Hanks', 95),
('Meryl Streep', 98),
('Leonardo DiCaprio', 94),
('Denzel Washington', 96),
('Scarlett Johansson', 88),
('Viola Davis', 97),
('Robert Downey Jr.', 91),
('Morgan Freeman', 95),
('Florence Pugh', 89),
('Cillian Murphy', 93),
('Tom Hanks', 85),
('marlon Brando', 99),
('marlon Brando', 100);

select top 1 userName, count (rating) as countno from Users 
group by userName order by count(rating) desc 