ratings = LOAD '/root/input/u.data' USING PigStorage('\t') AS (user_id:int, movie_id:int, rating:int, time:int);
group_ratings = GROUP ratings BY movie_id;
avg_ratings = FOREACH group_ratings GENERATE group as movie_id, AVG(ratings.rating) as avg_rating , COUNT(ratings.rating) as count_rating;
avg_ratings = FILTER avg_ratings BY count_rating >= 10;

movies = LOAD '/root/input/u.item' USING PigStorage('|') AS (movie_id:int, movie_name:chararray);

group_movies = GROUP  movies BY movie_id;
m_name = FOREACH group_movies GENERATE group as movie_id,  SIZE(movies.movie_name, ' ') as m_name;

joined = JOIN m_name BY movie_id, movies BY movie_id;
dataset = FOREACH joined GENERATE movies::movie_id , m_name::m_name as m_name, movies::movie_name as movie_name;
ordered = ORDER dataset BY m_name desc;
top10 = LIMIT ordered 10;
DUMP top10;
