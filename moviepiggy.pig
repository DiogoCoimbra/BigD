atings = LOAD '/root/input/u.data' USING PigStorage('\t') AS (user_id:int, movie_id:int, rating:int, time:int);
group_ratings = GROUP ratings BY movie_id;
avg_ratings = FOREACH group_ratings GENERATE group as movie_id, AVG(ratings.rating) as avg_rating , COUNT(ratings.rating) as count_rating;
avg_ratings = FILTER avg_ratings BY count_rating >= 10;

movies = LOAD '/root/input/u.item' USING PigStorage('|') AS (movie_id:int, movie_name:chararray);

joined = JOIN avg_ratings BY movie_id, movies BY movie_id;
dataset = FOREACH joined GENERATE movies::movie_name as movie_name, avg_ratings::avg_rating as avg_rating;
words = FOREACH input_lines GENERATE FLATTEN(TOKENIZE(movies)) AS word;
filtered_words = FILTER words BY word MATCHES ‘\\w+’;
word_groups = GROUP filtered_words BY word;
word_count = FOREACH word_groups GENERATE COUNT(filtered_words) AS count, group AS word;
ordered_word_count = ORDER word_count BY count DESC;
DUMP ordered_word_count;

