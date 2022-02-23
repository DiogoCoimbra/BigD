ratings = LOAD '/root/input/u.data' USING PigStorage('\t') AS (user_id:int, movie_id:int, rating:int, time:int);
group_ratings = GROUP ratings BY movie_id;
avg_ratings = FOREACH group_ratings GENERATE group as movie_id, AVG(ratings.rating) as avg_rating , COUNT(ratings.rating) as count_rating;
avg_ratings = FILTER avg_ratings BY count_rating >= 10;

movies = LOAD '/root/input/u.item' USING PigStorage('|') AS (movie_id:int, movie_name:chararray);

group_movies = GROUP movies BY movie_id, flatten(TOKENIZE((movie_name)$0));
count_movies = FOREACH group_movies GENERATE group as movie_id, count(movies.movie_name) as t1;
dataset = FOREACH count_movies GENERATE movies::movie_id , movies::movie_name, t1;

top10 = LIMIT dataset 10;
DUMP top10;
