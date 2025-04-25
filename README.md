# GRP-96-Ecommerce-DB-Design
Peer Group Assignment: E-commerce Database Design! 🎯 We’ll be designing an Entity-Relationship Diagram (ERD) and building an e-commerce database.

## Overview
This project involves designing an e-commerce database for GROUP 96, consisting of 7 members: Lucky Nakola, Precious Diana, Bilha Mwpondu, E.O. Deborah, Joseph Mutua, Nomakha Dlomo, and Phuti Morudu. We’ve created 12 tables to manage products, categories, variations, attributes, and more, with a focus on a Kenyan e-commerce context (e.g., KES prices, Safaricom brand). 

## Team Contributions
Lucky Nakola – Team Lead, Initial ERD Draft, Database Completion

## Tasks Completed:
Created the initial ERD draft for all 12 tables (pending refinement by Precious).
Created product and brand tables.
Due to limited contributions, completed all remaining tables: product_category, product_item, product_variation, product_image, color, size_category, size_option, attribute_type.
Added sample data for all tables, ensuring a Kenyan context (e.g., Safaricom router, KES prices).
Set up the repository and managed branches for collaboration.


## Tables Created:
product: Stores product details (name, brand, base price in KES).
brand: Manages brand data (e.g., Nike, Samsung, Safaricom).
product_category: Classifies products (e.g., Clothing, Electronics).
product_item: Represents purchasable items with variations.
product_variation: Links products to variations (size, color).
product_image: Stores product image URLs.
color: Manages color options (e.g., Black, White).
size_category: Groups sizes (e.g., Clothing Sizes, Shoe Sizes).
size_option: Lists specific sizes (e.g., S, M, 40, 42).
attribute_type: Defines attribute types (e.g., text, number, boolean).


## Sample Data:
Added brands like Safaricom, products like a router (KES 4999.00), and variations (e.g., T-Shirt in S/Black).



# Nomakha Dlomo – Database Testing & Attribute Tables

## Tables Created:
attribute_category: Groups product attributes by category (e.g., Physical, Technical).
product_attribute: Stores custom product attributes like material, weight, battery life, etc.


## 🔍 Relationship Verification:
Linked product_attribute.product_id → product.product_id.
Linked product_attribute.attribute_category_id → attribute_category.category_id.
Updated to link product_attribute.attribute_type_id → attribute_type.attribute_type_id after Lucky added attribute_type.


## Validation Process:
Inserted invalid rows first to trigger foreign key errors (confirmed constraints).
Added valid brands/products/categories from Lucky’s tables.
Inserted valid attribute data.
Performed JOIN queries to confirm links across all related tables.


Sample Query Used:SELECT 
    p.name AS product_name,
    ac.name AS category_name,
    pa.name AS attribute_name,
    pa.value
FROM 
    product_attribute pa
JOIN 
    product p ON pa.product_id = p.product_id
JOIN 
    attribute_category ac ON pa.attribute_category_id = ac.category_id;


## Setup Instructions

Clone the Repository:git clone https://github.com/WAIYAH/GRP-96-Ecommerce-DB-Design.git
cd GRP-96-Ecommerce-DB-Design


Set Up the Database:
Install MySQL if not already installed.
Run the SQL script:mysql -u your_username -p < sql/ecommerce.sql


Enter your MySQL password to create the ecommerce database and tables.


Verify the Database:
Connect to MySQL:mysql -u your_username -p


Use the database:USE ecommerce;


Run queries to test (e.g., Nomakha’s sample query above).



## ERD Explanation

The initial ERD draft is in diagrams/ecommerce_erd.drawio (created by Lucky).
Pending Refinement: Precious is tasked with adding constraints (e.g., NOT NULL, UNIQUE) and finalizing the ERD.
Structure:
12 tables with relationships (e.g., product to brand via brand_id, product_variation to size_option and color).
