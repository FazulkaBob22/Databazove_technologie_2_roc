CREATE TABLE dim_customer(
    id_customer INT PRIMARY KEY,
    CustomerName VARCHAR(50),
    ContactName VARCHAR(50),
    Address VARCHAR(50),
    City VARCHAR(20),
    PostalCode VARCHAR(10),
    Country VARCHAR(15)
);
CREATE TABLE dim_date(
    id_date INT PRIMARY KEY,
    Date DATETIME,
    Day INT,
    Week INT,
    Month INT,
    Year
);
CREATE TABLE dim_employee(
    LastName VARCHAR(15),
    FirstName VARCHAR(15),
    BirthDate DATETIME,
    Photo VARCHAR(25),
    Notes VARCHAR(1024)
);
CREATE TABLE dim_supplier(
    id_supplier INT PRIMARY KEY,
    SupplierName VARCHAR(50),
    ContactName VARCHAR(50),
    Address VARCHAR(50),
    City VARCHAR(20),
    PostalCode VARCHAR(10),
    Country VARCHAR(15),
    Phone VARCHAR(15)
);
CREATE TABLE dim_product(
    id_product INT PRIMARY KEY,
    ProductName VARCHAR(50),
    Unit VARCHAR(25)
);
CREATE TABLE dim_category(
    id_category INT PRIMARY KEY,
    CategoryName VARCHAR(25),
    Description VARCHAR(255)
);
CREATE TABLE fact_order(
    idfact_order INT PRIMARY,
    Price DECIMAL(10,0),
    Quantity INT(11),
    dim_customer_id_customer INT NOT NULL,
    dim_date_id_date INT NOT NULL,
    dim_employee_id_employee INT NOT NULL,
    dim_supplier_id_supplier INT NOT NULL,
    dim_product_id_product INT NOT NULL,
    dim_category_id_category INT NOT NULL,

    FOREIGN KEY(dim_customer_id_customer)
    REFERENCES dim_customer(id_customer),

    FOREIGN KEY(dim_date_id_date)
    REFERENCES dim_date(id_date),

    FOREIGN KEY(dim_employee_id_employee)
    REFERENCES dim_employee(id_employee),
    FOREIGN KEY(dim_supplier_id_supplier)
    REFERENCES dim_supplier(id_supplier),
    FOREIGN KEY(dim_product_id_product)
    REFERENCES dim_product(id_product),
    FOREIGN KEY(dim_category_id_category)
    REFERENCES dim_category(id_category)

)