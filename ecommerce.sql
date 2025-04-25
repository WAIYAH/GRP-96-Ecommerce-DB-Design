-- This SQL script creates the database schema for an ecommerce platform.
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

-- Table: product_category 
CREATE TABLE product_category (
    category_id INT PRIMARY KEY AUTO_INCREMENT,
    category_name VARCHAR(100) NOT NULL UNIQUE
);

-- Table: product_item 
CREATE TABLE product_item (
    item_id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT NOT NULL,
    variation_id INT, -- Will reference product_variation
    stock_quantity INT NOT NULL DEFAULT 0,
    FOREIGN KEY (product_id) REFERENCES product(product_id)
    -- FOREIGN KEY (variation_id) will be added after product_variation table
);

-- Table: product_variation 
CREATE TABLE product_variation (
    variation_id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT NOT NULL,
    size_id INT, -- Will reference size_option
    color_id INT, -- Will reference color
    FOREIGN KEY (product_id) REFERENCES product(product_id)
    -- FOREIGN KEY (size_id, color_id) will be added after size_option and color tables
);

-- Table: product_image 
CREATE TABLE product_image (
    image_id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT NOT NULL,
    image_url VARCHAR(255) NOT NULL,
    FOREIGN KEY (product_id) REFERENCES product(product_id)
);

-- Table: color 
CREATE TABLE color (
    color_id INT PRIMARY KEY AUTO_INCREMENT,
    color_name VARCHAR(50) NOT NULL UNIQUE
);

-- Table: size_category 
CREATE TABLE size_category (
    size_category_id INT PRIMARY KEY AUTO_INCREMENT,
    category_name VARCHAR(100) NOT NULL UNIQUE
);

-- Table: size_option 
CREATE TABLE size_option (
    size_id INT PRIMARY KEY AUTO_INCREMENT,
    size_category_id INT NOT NULL,
    size_value VARCHAR(50) NOT NULL,
    FOREIGN KEY (size_category_id) REFERENCES size_category(size_category_id)
);

-- Table: attribute_type 
CREATE TABLE attribute_type (
    attribute_type_id INT PRIMARY KEY AUTO_INCREMENT,
    type_name VARCHAR(50) NOT NULL UNIQUE -- e.g., text, number, boolean
);

-- Add missing foreign keys after all tables are created
ALTER TABLE product_item
ADD FOREIGN KEY (variation_id) REFERENCES product_variation(variation_id);

ALTER TABLE product_variation
ADD FOREIGN KEY (size_id) REFERENCES size_option(size_id),
ADD FOREIGN KEY (color_id) REFERENCES color(color_id);

-- Update product_attribute to reference attribute_type (Nomakha's table needs this)
ALTER TABLE product_attribute
ADD COLUMN attribute_type_id INT,
ADD FOREIGN KEY (attribute_type_id) REFERENCES attribute_type(attribute_type_id);

-- Sample Data for Testing

-- Insert brands 
INSERT INTO brand (brand_name) VALUES 
('Nike'), 
('Samsung'),
('Safaricom'), -- Kenyan brand
('Adidas'),
('Sony');

-- Insert product categories 
INSERT INTO product_category (category_name) VALUES 
('Clothing'),
('Electronics'),
('Footwear'),
('Accessories'),
('Gadgets');

-- Insert products 
INSERT INTO product (name, brand_id, base_price) VALUES 
('T-Shirt', 1, 999.00), 
('Smartwatch', 2, 14999.00),
('Router', 3, 4999.00), -- Safaricom router
('Running Shoes', 4, 5999.00),
('Headphones', 5, 2999.00);

-- Insert attribute categories
INSERT INTO attribute_category (name) VALUES 
('Physical'), 
('Technical');

-- Insert attribute types
INSERT INTO attribute_type (type_name) VALUES 
('text'),
('number'),
('boolean');

-- Insert product attributes
UPDATE product_attribute SET attribute_type_id = 1 WHERE name IN ('Material', 'Water Resistance'); -- text
UPDATE product_attribute SET attribute_type_id = 2 WHERE name IN ('Weight', 'Battery Life'); -- number
INSERT INTO product_attribute (product_id, attribute_category_id, name, value, attribute_type_id) VALUES 
(1, 1, 'Material', 'Cotton', 1),
(1, 1, 'Weight', '0.3kg', 2),
(2, 2, 'Battery Life', '12 hours', 2),
(2, 2, 'Water Resistance', 'Yes', 1),
(3, 2, 'Speed', '100Mbps', 2),
(4, 1, 'Material', 'Mesh', 1),
(5, 2, 'Wireless', 'Yes', 1);

-- Insert colors
INSERT INTO color (color_name) VALUES 
('Black'),
('White'),
('Red'),
('Blue'),
('Green');

-- Insert size categories
INSERT INTO size_category (category_name) VALUES 
('Clothing Sizes'),
('Shoe Sizes');

-- Insert size options
INSERT INTO size_option (size_category_id, size_value) VALUES 
(1, 'S'),  -- Clothing
(1, 'M'),
(1, 'L'),
(2, '40'), -- Shoes
(2, '42');

-- Insert product variations 
INSERT INTO product_variation (product_id, size_id, color_id) VALUES 
(1, 1, 1), -- T-Shirt, S, Black
(1, 2, 3), -- T-Shirt, M, Red
(4, 4, 2), -- Running Shoes, 40, White
(2, NULL, 4), -- Smartwatch, Blue (no size)
(5, NULL, 5); -- Headphones, Green (no size)

-- Insert product items 
INSERT INTO product_item (product_id, variation_id, stock_quantity) VALUES 
(1, 1, 50), -- T-Shirt S Black
(1, 2, 30), -- T-Shirt M Red
(2, 4, 20), -- Smartwatch Blue
(4, 3, 15), -- Running Shoes 40 White
(5, 5, 25); -- Headphones Green

-- Insert product images 
INSERT INTO product_image (product_id, image_url) VALUES 
(1, 'https://example.com/images/tshirt_black_s.jpg'),
(1, 'https://example.com/images/tshirt_red_m.jpg'),
(2, 'https://example.com/images/smartwatch_blue.jpg'),
(4, 'https://example.com/images/shoes_white_40.jpg'),
(5, 'https://example.com/images/headphones_green.jpg');