# User Guide - Retail Store Management System

## Getting Started

This guide explains how to use the Retail Store Management database system effectively.

## 1. Database Setup

### Initial Setup
1. Review `schema/database_schema.sql` for the complete table structure
2. Create the database using your SQL client
3. Load sample data from `data/sample_data.sql` for testing

### Connection Details
- **Database Server**: Your configured SQL server (MySQL/PostgreSQL)
- **Database Name**: retail_store_mgmt
- **Required Permissions**: SELECT, INSERT, UPDATE, DELETE

## 2. Working with Products

### Adding a New Product
```sql
INSERT INTO Products (product_name, category_id, supplier_id, price, cost_price, quantity_in_stock)
VALUES ('Product Name', 1, 1, 99.99, 50.00, 50);
```

### Updating Product Stock
```sql
UPDATE Products 
SET quantity_in_stock = quantity_in_stock + 50
WHERE product_id = 1;
```

### Finding Low Stock Items
```sql
SELECT product_name, quantity_in_stock, reorder_level
FROM Products
WHERE quantity_in_stock <= reorder_level
ORDER BY quantity_in_stock ASC;
```

### Viewing Product Profitability
```sql
SELECT 
    product_name,
    price,
    cost_price,
    (price - cost_price) as profit_per_unit,
    ROUND(((price - cost_price) / price) * 100, 2) as profit_margin
FROM Products
ORDER BY profit_margin DESC;
```

## 3. Customer Management

### Adding a New Customer
```sql
INSERT INTO Customers (customer_name, email, phone, address, city, state, country, customer_type)
VALUES ('John Doe', 'john@example.com', '555-1234', '123 Main St', 'Portland', 'OR', 'USA', 'regular');
```

### Viewing Customer Purchase History
```sql
SELECT 
    o.order_id,
    o.order_date,
    o.total_amount,
    o.order_status
FROM Orders o
WHERE o.customer_id = 1
ORDER BY o.order_date DESC;
```

### Finding Top Customers
```sql
SELECT 
    c.customer_id,
    c.customer_name,
    COUNT(o.order_id) as total_orders,
    SUM(oi.line_total) as total_spent
FROM Customers c
LEFT JOIN Orders o ON c.customer_id = o.customer_id
LEFT JOIN OrderItems oi ON o.order_id = oi.order_id
GROUP BY c.customer_id, c.customer_name
ORDER BY total_spent DESC
LIMIT 10;
```

## 4. Processing Orders

### Creating an Order Header
```sql
INSERT INTO Orders (customer_id, employee_id, order_date, order_status, payment_status)
VALUES (1, 2, CURDATE(), 'pending', 'unpaid');
```

### Adding Items to an Order
```sql
INSERT INTO OrderItems (order_id, product_id, quantity, unit_price, line_total)
VALUES (1, 5, 2, 29.99, 59.98);
```

### Updating Order Status
```sql
UPDATE Orders
SET order_status = 'shipped', delivery_date = DATE_ADD(CURDATE(), INTERVAL 5 DAY)
WHERE order_id = 1;
```

### Recording Payment
```sql
UPDATE Orders
SET payment_status = 'paid'
WHERE order_id = 1;
```

### Calculating Order Total
```sql
SELECT 
    o.order_id,
    SUM(oi.line_total) as subtotal,
    COALESCE(SUM(oi.discount), 0) as total_discount,
    SUM(oi.line_total) - COALESCE(SUM(oi.discount), 0) as final_total
FROM Orders o
LEFT JOIN OrderItems oi ON o.order_id = oi.order_id
WHERE o.order_id = 1
GROUP BY o.order_id;
```

## 5. Inventory Tracking

### Recording Stock Purchase
```sql
-- Update product stock
UPDATE Products SET quantity_in_stock = quantity_in_stock + 100 WHERE product_id = 1;

-- Record movement
INSERT INTO StockMovement (product_id, movement_type, quantity, reference_id, reference_type)
VALUES (1, 'purchase', 100, 1, 'supplier');
```

### Recording Sales Movement
```sql
INSERT INTO StockMovement (product_id, movement_type, quantity, reference_id, reference_type)
VALUES (1, 'sale', -1, 1, 'order');
```

### Stock Movement History
```sql
SELECT 
    p.product_name,
    sm.movement_type,
    sm.quantity,
    sm.created_at
FROM StockMovement sm
JOIN Products p ON sm.product_id = p.product_id
WHERE sm.product_id = 1
ORDER BY sm.created_at DESC;
```

## 6. Reports and Analysis

### Daily Sales Report
```sql
SELECT 
    o.order_date,
    COUNT(o.order_id) as orders_count,
    SUM(oi.line_total) as daily_sales,
    AVG(oi.line_total) as avg_order_value
FROM Orders o
LEFT JOIN OrderItems oi ON o.order_id = oi.order_id
WHERE o.order_date = CURDATE()
GROUP BY o.order_date;
```

### Best Selling Products
```sql
SELECT 
    p.product_name,
    SUM(oi.quantity) as total_sold,
    SUM(oi.line_total) as total_revenue,
    AVG(oi.unit_price) as avg_price
FROM OrderItems oi
JOIN Products p ON oi.product_id = p.product_id
GROUP BY p.product_id, p.product_name
ORDER BY total_sold DESC
LIMIT 10;
```

### Inventory Valuation
```sql
SELECT 
    c.category_name,
    COUNT(p.product_id) as product_count,
    SUM(p.quantity_in_stock) as total_units,
    SUM(p.quantity_in_stock * p.cost_price) as total_cost_value,
    SUM(p.quantity_in_stock * p.price) as total_retail_value
FROM Products p
JOIN Categories c ON p.category_id = c.category_id
GROUP BY c.category_id, c.category_name;
```

### Employee Performance
```sql
SELECT 
    e.employee_name,
    e.position,
    COUNT(o.order_id) as orders_processed,
    SUM(oi.line_total) as total_sales_value
FROM Employees e
LEFT JOIN Orders o ON e.employee_id = o.employee_id
LEFT JOIN OrderItems oi ON o.order_id = oi.order_id
WHERE YEAR(o.order_date) = YEAR(CURDATE())
GROUP BY e.employee_id, e.employee_name, e.position
ORDER BY total_sales_value DESC;
```

## 7. Best Practices

### Data Entry
1. Always verify customer and product IDs before creating orders
2. Use consistent date formats (YYYY-MM-DD)
3. Double-check calculations before recording
4. Document any manual adjustments

### Data Integrity
1. Use transactions for multi-step operations
2. Validate data before insertion
3. Use stored procedures for complex operations
4. Regular backups of critical data

### Performance
1. Use indexes for frequently searched fields
2. Avoid full table scans with proper WHERE clauses
3. Archive old orders periodically
4. Monitor query performance

### Security
1. Use parameterized queries to prevent SQL injection
2. Limit user access based on roles
3. Encrypt sensitive data
4. Maintain audit logs

## 8. Common Tasks

### Task: Process a Complete Order
```sql
-- 1. Insert customer (if new)
INSERT INTO Customers (...) VALUES (...);

-- 2. Create order
INSERT INTO Orders (...) VALUES (...);
SET @order_id = LAST_INSERT_ID();

-- 3. Add order items
INSERT INTO OrderItems (...) VALUES (@order_id, ...);

-- 4. Update stock
UPDATE Products SET quantity_in_stock = quantity_in_stock - qty WHERE product_id = pid;

-- 5. Record stock movement
INSERT INTO StockMovement (...) VALUES (pid, 'sale', -qty, @order_id, 'order');

-- 6. Update order total (calculate from items)
UPDATE Orders SET total_amount = (...) WHERE order_id = @order_id;
```

### Task: Generate Monthly Sales Report
```sql
SELECT 
    DATE_TRUNC('month', o.order_date) as month,
    COUNT(o.order_id) as total_orders,
    SUM(oi.line_total) as total_revenue,
    COUNT(DISTINCT o.customer_id) as unique_customers
FROM Orders o
LEFT JOIN OrderItems oi ON o.order_id = oi.order_id
WHERE o.order_date >= DATE_TRUNC('month', CURDATE() - INTERVAL 12 MONTH)
GROUP BY DATE_TRUNC('month', o.order_date)
ORDER BY month;
```

## 9. Troubleshooting

### Issue: Referential Integrity Error
**Solution**: Verify that referenced IDs exist in parent tables before inserting/updating

### Issue: Stock Going Negative
**Solution**: Implement constraint checks and always verify stock before processing sales

### Issue: Slow Queries
**Solution**: Check indexes, add WHERE clauses, consider archiving old data

### Issue: Duplicate Data
**Solution**: Use unique constraints, validate data before insertion

## 10. Support and Assistance

For more information:
- See `schema/database_schema.sql` for table structures
- See `queries/basic_queries.sql` for common query examples
- See `docs/DESIGN.md` for database design details
- See `docs/REQUIREMENTS.md` for functional specifications

---

**Last Updated**: June 8, 2026
