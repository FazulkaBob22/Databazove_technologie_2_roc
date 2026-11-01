CREATE TABLE dim_genre(
    iddim_genre INT PRIMARY KEY,
    name VARCHAR(120) NOT NULL
);
CREATE TABLE dim_track(
    iddim_track INT PRIMARY KEY,
    name VARCHAR(200) NOT NULL,
    composer VARCHAR(220) NOT NULL,
    album VARCHAR(255) NOT NULL,
    length_mill INT NOT NULL,
    genre VARCHAR(120)
);
CREATE TABLE dim_customer(
    iddim_customer INT PRIMARY KEY,
    first_name VARCHAR(40) NOT NULL,
    last_name VARCHAR(20) NOT NULL,
    company VARCHAR(80),
    address VARCHAR(70),
    city VARCHAR(40),
    state VARCHAR(40),
    country VARCHAR(40),
    phone VARCHAR(24),
    email VARCHAR(60) NOT NULL,
    fax VARCHAR(24)
);
CREATE TABLE dim_employee(
    iddim_employee INT PRIMARY KEY,
    first_name VARCHAR(20) NOT NULL,
    last_name VARCHAR(20) NOT NULL,
    title VARCHAR(30),
    reports_to INT,
    birth_date TIMESTAMP,
    hire_date TIMESTAMP,
    address VARCHAR(70),
    city VARCHAR(40),
    state VARCHAR(40),
    country VARCHAR(40),
    phone VARCHAR(24),
    email VARCHAR(60)
);
CREATE TABLE dim_date(
    iddim_date INT PRIMARY KEY,
    date DATE NOT NULL,
    day INT NOT NULL,
    week INT NOT NULL,
    month INT NOT NULL,
    year INT NOT NULL
);
CREATE TABLE fact_sales(
    idfact_sales INT PRIMARY KEY,
    unit_price DECIMAL(10,2) NOT NULL,
    quantity INT NOT NULL,
    revenue DECIMAL(10,2) NOT NULL,
    dim_track_iddim_track INT NOT NULL,
    dim_date_iddim_date INT NOT NULL,
    dim_employee_iddim_employee INT NOT NULL,
    dim_customer_iddim_customer INT NOT NULL,

    FOREIGN KEY(dim_track_iddim_track)
    REFERENCES dim_track(iddim_track),

    FOREIGN KEY(dim_date_iddim_date)
    REFERENCES dim_date(iddim_date),

    FOREIGN KEY(dim_employee_iddim_employee)
    REFERENCES dim_employee(iddim_employee),

    FOREIGN KEY(dim_customer_iddim_customer)
    REFERENCES dim_customer(iddim_customer)
);
