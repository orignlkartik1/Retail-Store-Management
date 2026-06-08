-- Basic Queries for Retail Store Management System
-- These queries demonstrate fundamental SQL operations

-- ========================================
-- PRODUCT QUERIES
-- ========================================

-- Get all products with category and supplier information
SELECT 
    p.product_id,
    p.product_name,
    c.category_name,
    s.supplier_name,
    p.price,
    p.quantity_in_stock
FROM Products p
JOIN Categories c ON p.category_id = c.category_id
JOIN Suppliers s ON p.supplier_id = s.supplier_id
ORDER BY p.product_name;

-- Get products with low stock levels
SELECT 
    product_id,
    product_name,
    quantity_in_stock,
    reorder_level,
    (reorder_level - quantity_in_stock) as units_to_order
FROM Products
WHERE quantity_in_stock <= reorder_level
ORDER BY quantity_in_stock;

-- Get products by category with count
SELECT 
    c.category_name,
    COUNT(p.product_id) as product_count,
    AVG(p.price) as avg_price,
    MIN(p.price) as min_price,
    MAX(p.price) as max_price
FROM Products p
JOIN Categories c ON p.category_id = c.category_id
GROUP BY c.category_id, c.category_name
ORDER BY product_count DESC;
