CREATE TABLE dim_users (
    id_users INT AUTO_INCREMENT PRIMARY KEY,
    age INT,
    gender CHAR(1),
    zip_code VARCHAR(255),
    age_group VARCHAR(45),
    occupation VARCHAR(255)
);

CREATE TABLE dim_movies (
    id_movies INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255),
    release_year CHAR(4),
    tags VARCHAR(4000)
);

CREATE TABLE dim_date (
    id_date INT AUTO_INCREMENT PRIMARY KEY,
    date DATE NOT NULL,
    day INT NOT NULL,
    week INT NOT NULL,
    month INT NOT NULL,
    year INT NOT NULL
);

CREATE TABLE dim_genre (
    id_genre INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

CREATE TABLE fact_rating (
    id_rating INT AUTO_INCREMENT PRIMARY KEY,
    rating INT(11) NOT NULL,
    dim_users_id_users INT NOT NULL,
    dim_date_id_date INT NOT NULL,
    dim_movies_id_movies INT NOT NULL,

        FOREIGN KEY (dim_users_id_users)
        REFERENCES dim_users(id_users),

        FOREIGN KEY (dim_date_id_date)
        REFERENCES dim_date(id_date),

    
        FOREIGN KEY (dim_movies_id_movies)
        REFERENCES dim_movies(id_movies)
);

CREATE TABLE bridge_movie_genre (
    dim_movies_id_movies INT NOT NULL,
    dim_genre_id_genre INT NOT NULL,

    PRIMARY KEY (dim_movies_id_movies, dim_genre_id_genre),

        FOREIGN KEY (dim_movies_id_movies)
        REFERENCES dim_movies(id_movies),

        FOREIGN KEY (dim_genre_id_genre)
        REFERENCES dim_genre(id_genre)
);