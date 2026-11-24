\set ON_ERROR_STOP on    

CREATE SCHEMA IF NOT EXISTS gold;

--DIM_USER

CREATE TABLE IF NOT EXISTS gold.dim_user(
    user_id INT NOT NULL UNIQUE,
    gender CHAR(1) NOT NULL CHECK (gender IN ('M','F')),
    zip_code VARCHAR(10),
    age_group VARCHAR(20) NOT NULL,
    occupation VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS gold.dim_movie(
    movie_id INT NOT NULL UNIQUE,
    title VARCHAR(200),
    release_year INT,
    genre_name VARCHAR(200) NOT NULL  -- vsetky zanre budu v jednom riadku
);

CREATE TABLE IF NOT EXISTS gold.dim_date(
    date_id INT PRIMARY KEY,
    rated_at DATE NOT NULL UNIQUE,
    day INT NOT NULL,
    month INT NOT NULL,
    year INT NOT NULL,
    day_of_week INT NOT NULL,
    day_name VARCHAR(10),
    week INT NOT NULL,
    month_name VARCHAR(10),
    quarter INT NOT NULL
);

CREATE TABLE IF NOT EXISTS gold.dim_time(
    time_id INT PRIMARY KEY,
    rated_time TIME NOT NULL UNIQUE,
    hour INT NOT NULL,
    minute INT NOT NULL,
    second INT NOT NULL,
    time_of_day VARCHAR(10) NOT NULL
);

CREATE TABLE IF NOT EXISTS gold.fact_rating(
    rating_id INT PRIMARY KEY,
    user_id INT NOT NULL REFERENCES gold.dim_user (user_id),
    movie_id INT NOT NULL REFERENCES gold.dim_movie (movie_id),
    date_id INT NOT NULL REFERENCES gold.dim_date (date_id),
    time_id INT NOT NULL REFERENCES gold.dim_time (time_id),
    rating NUMERIC(2,1) NOT NULL CHECK (rating BETWEEN 1 AND 5),
    rating_count INT NOT NULL,   -- pocet vsetkch hodnoteni filmu
    rating_percentage INT NOT NULL -- hodnotenie v percentach
);


-- indexy na cudzie kluce v tabulke, postgre nevytvara automaticky

CREATE INDEX ON gold.fact_rating(user_id);
CREATE INDEX ON gold.fact_rating(movie_id);
CREATE INDEX ON gold.fact_rating(date_id);
CREATE INDEX ON gold.fact_rating(time_id);

-- -h localhost -p 5432 -U postgres -d movielens_elt2 -f 3_transform.sql

BEGIN;

TRUNCATE gold.fact_rating,
gold.dim_user,
gold.dim_movie,
gold.dim_date,
gold.dim_time ;   -- v pripade autoincremmentu treba pouzit RESTART IDENTITY

INSERT INTO gold.dim_user(
    user_id,
    gender,
    zip_code,
    age_group,
    occupation
)
SELECT u.user_id, u.gender, u.zip_code, COALESCE(a.age_group_name, 'unknown'),COALESCE(o.occupation_name, 'unknown')
FROM silver.stg_users u 
LEFT JOIN silver.stg_age_groups a ON a.age_group_id = u.age
LEFT JOIN silver.stg_occupations o ON o.occupation_id = u.occupation_id
ORDER BY u.user_id;

INSERT INTO gold.dim_movie(
    movie_id,
    title,
    release_year,
    genre_name
)
SELECT m.movie_id, m.title, m.release_year, COALESCE(g.genre_name, 'unknown')
FROM silver.stg_movies m   
LEFT JOIN (
    SELECT gm.movie_id, STRING_AGG(
        g.name, ', '
        ORDER BY g.name 
    ) AS genre_name
    FROM silver.stg_genres_movies gm   
    JOIN silver.stg_genres g ON g.genre_id = gm.genre_id
    GROUP BY gm.movie_id)
    g on g.movie_id = m.movie_id
    ORDER BY m.movie_id;

INSERT INTO gold.dim_date(
    date_id,
    rated_at,
    day,
    month,
    year,
    day_of_week,
    day_name,
    week,
    month_name,
    quarter
)
SELECT 
    TO_CHAR(gs.d, 'YYYYMMDD')::INT AS date_id,
    gs.d AS rated_at,
    EXTRACT(DAY FROM gs.d)::INT AS day,
    EXTRACT(MONTH FROM gs.d)::INT AS month,
    EXTRACT(YEAR FROM gs.d)::INT AS year,
    EXTRACT(ISODOW FROM gs.d)::INT AS day_of_week,
    TRIM(TO_CHAR(gs.d, 'Day')) AS day_name,
    EXTRACT(WEEK FROM gs.d)::INT AS week,
    TRIM(TO_CHAR(gs.d, 'Month')) AS month_name,
    EXTRACT(QUARTER FROM gs.d)::INT AS quarter
FROM (
    SELECT DISTINCT
        rated_at::DATE AS d
    FROM silver.stg_ratings
) AS gs
ORDER BY gs.d;


INSERT INTO gold.dim_time(
    time_id,
    rated_time,
    hour,
    minute,
    second,
    time_of_day
)
SELECT gs.sec AS time_id,
MAKE_TIME(
    (gs.sec / 3600)::INT,
    ((gs.sec % 3600)/60)::INT,
    (gs.sec % 60)::DOUBLE PRECISION
) AS rated_time,
(gs.sec / 3600)::INT AS hour,
    ((gs.sec % 3600) / 60)::INT AS minute,
    (gs.sec % 60)::INT AS second,
    CASE
        WHEN (gs.sec / 3600) < 12 THEN 'Morning'
        WHEN (gs.sec / 3600) < 18 THEN 'Afternoon'
        ELSE 'Evening'
    END AS time_of_day
FROM (
    SELECT DISTINCT
        EXTRACT(HOUR FROM rated_at)::INT * 3600
        + EXTRACT(MINUTE FROM rated_at)::INT * 60
        + FLOOR(EXTRACT(SECOND FROM rated_at))::INT AS sec
    FROM silver.stg_ratings
) AS gs
ORDER BY gs.sec;

INSERT INTO gold.fact_rating (
    rating_id,
    user_id,
    movie_id,
    date_id,
    time_id,
    rating,
    rating_count,
    rating_percentage
)
SELECT
    r.rating_id,
    r.user_id,
    r.movie_id,
    TO_CHAR(r.rated_at::DATE, 'YYYYMMDD')::INT,
    EXTRACT(HOUR FROM r.rated_at)::INT * 3600
        + EXTRACT(MINUTE FROM r.rated_at)::INT * 60
        + FLOOR(EXTRACT(SECOND FROM r.rated_at))::INT,
    r.rating,
    COUNT(*) OVER (PARTITION BY r.movie_id),
    r.rating * 20
FROM silver.stg_ratings r;


COMMIT;


SELECT COUNT(*) FROM gold.dim_user;
SELECT COUNT(*) FROM gold.dim_movie;
SELECT COUNT(*) FROM gold.dim_date;
SELECT COUNT(*) FROM gold.dim_time;
SELECT COUNT(*) FROM gold.fact_rating;

SELECT *
FROM gold.fact_rating
LIMIT 10;