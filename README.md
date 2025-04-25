# GRP-96-Ecommerce-DB-Design
Peer Group Assignment: E-commerce Database Design! 🎯 We’ll be designing an Entity-Relationship Diagram (ERD) and building an e-commerce database.

## Nomakha Dlomo – Database Testing & Attribute Tables

### Tables Created:
- `attribute_category`: Groups product attributes by category (e.g., Physical, Technical)
- `product_attribute`: Stores custom product attributes like material, weight, battery life, etc.

### 🔍 Relationship Verification:
- Linked `product_attribute.product_id` → `product.product_id`
- Linked `product_attribute.attribute_category_id` → `attribute_category.category_id`

### Validation Process:
- Inserted invalid rows first to trigger foreign key errors (confirmed constraints).
- Added valid brands/products/categories from Lucky’s tables.
- Inserted valid attribute data.
- Performed JOIN queries to confirm links across all related tables.

### Sample Query Used:

```sql
SELECT 
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
