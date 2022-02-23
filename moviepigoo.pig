ratings = LOAD '/root/input/u.data' USING PigStorage('\t') AS (user_id:int, movie_id:int, rating:int, time:int);
group_ratings = GROUP ratings BY movie_id;
avg_ratings = FOREACH group_ratings GENERATE group as movie_id, AVG(ratings.rating) as avg_rating , COUNT(ratings.rating) as count_rating;
avg_ratings = FILTER avg_ratings BY count_rating >= 10;

movies = LOAD '/root/input/u.item' USING PigStorage('|') AS (movie_id:int, movie_name:chararray);
group_moviename = GROUP movie_name BY movie_id;
movie_leng = FOREACH group_moviename GENERATE group as movie_id, SIZE(movies.movie_name) as count_moviename;
joined = JOIN avg_ratings BY movie_id, movies BY movie_id;
dataset = FOREACH joined GENERATE group group_moviename as movie_name, avg_ratings::avg_rating as avg_rating;


DUMP dataset;

