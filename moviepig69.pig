ratings = LOAD '/root/input/u.data' USING PigStorage('\t') AS (user_id:int, movie_id:int, rating:int, time:int);
group_ratings = GROUP ratings BY movie_id;
avg_ratings = FOREACH group_ratings GENERATE group as movie_id, AVG(ratings.rating) as avg_rating , COUNT(ratings.rating) as count_rating;
avg_ratings = FILTER avg_ratings BY count_rating >= 10;

movies = LOAD '/root/input/u.item' USING PigStorage('|') AS (movie_id:int, movie_name:chararray);

group_movies = GROUP  movies BY movie_id;
words = FOREACH movies GENERATE  flatten(TOKENIZE(movie_name,' ') as word;



word_group = GROUP words BY word;


word_count = FOREACH word_group GENERATE group, COUNT(words) as cnt;


word_count_sorted = ORDER word_count BY cnt DESC;


top10 = LIMIT word_count_sorted 10;
DUMP top10;
