ratings = LOAD '/root/input/u.data' USING PigStorage('\t') AS (user_id:int, movie_id:int, rating:int, time:int);
group_ratings = GROUP ratings BY movie_id;
avg_ratings = FOREACH group_ratings GENERATE group as movie_id, AVG(ratings.rating) as avg_rating , COUNT(ratings.rating) as count_rating;
avg_ratings = FILTER avg_ratings BY count_rating >= 10;

movies = LOAD '/root/input/u.item' USING PigStorage('|') AS (movie_id:int, movie_name:chararray);

m_name = FOREACH movies GENERATE SUBSTRING(movie_name, 1, (int)SIZE(movie_name)) as name;

B = foreach movies generate flatten(TOKENIZE((movies:chararray)$0)) as word;
C = filter B by word matches '(.+)';
D = foreach C generate flatten(TOKENIZE(REPLACE(word,'','|'), '|')) as letter;
E = group D by letter;
F = foreach E generate COUNT(D), group;
joined = JOIN E BY movie_id, movies BY movie_id;
dataset = FOREACH joined GENERATE movies::movie_name as movie_name, avg_ratings::avg_rating as avg_rating, E;
ordered = ORDER dataset BY E desc;
top10 = LIMIT ordered 10;
DUMP top10;
