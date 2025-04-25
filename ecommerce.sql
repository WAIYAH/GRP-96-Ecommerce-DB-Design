-- Create the ecommerce database
CREATE DATABASE ecommerce;
USE ecommerce;

-- Table: brand
CREATE TABLE brand (
    brand_id INT PRIMARY KEY AUTO_INCREMENT,
    brand_name VARCHAR(100) NOT NULL UNIQUE
);

-- Table: product
CREATE TABLE product (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    brand_id INT NOT NULL,
    base_price DECIMAL(10,2) NOT NULL, -- Price in KES
    FOREIGN KEY (brand_id) REFERENCES brand(brand_id)
);

-- Table: attribute_category
CREATE TABLE IF NOT EXISTS attribute_category (
    category_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL
);

-- Table: product_attribute
CREATE TABLE IF NOT EXISTS product_attribute (
    attribute_id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT NOT NULL,
    attribute_category_id INT NOT NULL,
    name VARCHAR(100) NOT NULL,
    value VARCHAR(255),
    FOREIGN KEY (product_id) REFERENCES product(product_id),
    FOREIGN KEY (attribute_category_id) REFERENCES attribute_category(category_id)
);

-- Sample Data for Testing

-- Insert brands
INSERT INTO brand (brand_name) VALUES 
('Nike'), 
('Samsung');

-- Insert products
INSERT INTO product (name, brand_id, base_price) VALUES 
('T-Shirt', 1, 999.00), 
('Smartwatch', 2, 14999.00);
-- Insert attribute categories
INSERT INTO attribute_category (name) VALUES 
('Physical'), 
('Technical');

-- Insert product attributes (Assuming product_id 1 and 2 exist from Lucky’s data)
INSERT INTO product_attribute (product_id, attribute_category_id, name, value) VALUES 
(1, 1, 'Material', 'Cotton'),
(1, 1, 'Weight', '0.3kg'),
(2, 2, 'Battery Life', '12 hours'),
(2, 2, 'Water Resistance', 'Yes');