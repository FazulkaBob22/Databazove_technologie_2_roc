\set ON_ERROR_STOP on

CREATE SCHEMA IF NOT EXISTS silver;

CREATE OR REPLACE VIEW silver.stg_categories AS
SELECT
    TRIM(categoryid)::INT AS category_id,
    TRIM(categoryname) AS category_name,
    TRIM(description) AS description
FROM bronze.categories;

CREATE OR REPLACE VIEW silver.stg_customers AS
SELECT
    TRIM(customerid)::INT AS customer_id,
    TRIM(customername) AS customer_name,
    TRIM(contactname) AS contact_name,
    TRIM(address) AS address,
    TRIM(city) AS city,
    TRIM(postalcode) AS postal_code,
    TRIM(country) AS country
FROM bronze.customers;

CREATE OR REPLACE VIEW silver.stg_employees AS
SELECT
    TRIM(employeeid)::INT AS employee_id,
    TRIM(lastname) AS last_name,
    TRIM(firstname) AS first_name,
    TRIM(birthdate)::DATE AS birth_date,
    TRIM(photo) AS photo,
    TRIM(notes) AS notes
FROM bronze.employees;

CREATE OR REPLACE VIEW silver.stg_orderdetails AS
SELECT
    TRIM(orderdetailid)::INT AS order_detail_id,
    TRIM(orderid)::INT AS order_id,
    TRIM(productid)::INT AS product_id,
    TRIM(quantity)::INT AS quantity
FROM bronze.orderdetails;

CREATE OR REPLACE VIEW silver.stg_orders AS
SELECT
    TRIM(orderid)::INT AS order_id,
    TRIM(customerid)::INT AS customer_id,
    TRIM(employeeid)::INT AS employee_id,
    TRIM(orderdate)::DATE AS order_date,
    TRIM(shipperid)::INT AS shipper_id
FROM bronze.orders;

CREATE OR REPLACE VIEW silver.stg_products AS
SELECT
    TRIM(productid)::INT AS product_id,
    TRIM(productname) AS product_name,
    TRIM(supplierid)::INT AS supplier_id,
    TRIM(categoryid)::INT AS category_id,
    TRIM(unit) AS product_unit,
    TRIM(price)::NUMERIC(10,2) AS price
FROM bronze.products;

CREATE OR REPLACE VIEW silver.stg_shippers AS
SELECT
    TRIM(shipperid)::INT AS shipper_id,
    TRIM(shippername) AS shipper_name,
    TRIM(phone) AS phone
FROM bronze.shippers;

CREATE OR REPLACE VIEW silver.stg_suppliers AS
SELECT
    TRIM(supplierid)::INT AS supplier_id,
    TRIM(suppliername) AS supplier_name,
    TRIM(contactname) AS contact_name,
    TRIM(address) AS address,
    TRIM(city) AS city,
    TRIM(postalcode) AS postal_code,
    TRIM(country) AS country,
    TRIM(phone) AS phone
FROM bronze.suppliers;

-- Basic row-count checks
SELECT 'categories' AS table_name, COUNT(*) AS row_count FROM silver.stg_categories
UNION ALL SELECT 'customers', COUNT(*) FROM silver.stg_customers
UNION ALL SELECT 'employees', COUNT(*) FROM silver.stg_employees
UNION ALL SELECT 'orderdetails', COUNT(*) FROM silver.stg_orderdetails
UNION ALL SELECT 'orders', COUNT(*) FROM silver.stg_orders
UNION ALL SELECT 'products', COUNT(*) FROM silver.stg_products
UNION ALL SELECT 'shippers', COUNT(*) FROM silver.stg_shippers
UNION ALL SELECT 'suppliers', COUNT(*) FROM silver.stg_suppliers;