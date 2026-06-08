# User Guide - Retail Store Management System

## Getting Started

This guide explains how to use the Retail Store Management database system effectively.

## Database Setup

### Initial Setup
1. Review `schema/database_schema.sql` for the complete table structure
2. Create the database using your SQL client
3. Load sample data from `data/sample_data.sql` for testing

## Working with Products

### Adding a New Product
```sql
INSERT INTO Products (product_name, category_id, supplier_id, price, cost_price, quantity_in_stock)
VALUES ('Product Name', 1, 1, 99.99, 50.00, 50);
```

### Finding Low Stock Items
```sql
SELECT product_name, quantity_in_stock, reorder_level
FROM Products
WHERE quantity_in_stock <= reorder_level
ORDER BY quantity_in_stock ASC;
```

## Processing Orders

### Creating an Order
```sql
INSERT INTO Orders (customer_id, employee_id, order_date, order_status, payment_status)
VALUES (1, 2, CURDATE(), 'pending', 'unpaid');
```

### Adding Order Items
```sql
INSERT INTO OrderItems (order_id, product_id, quantity, unit_price, line_total)
VALUES (1, 5, 2, 29.99, 59.98);
```

## Key Queries

### Best Selling Products
```sql
SELECT 
    p.product_name,
    SUM(oi.quantity) as total_sold,
    SUM(oi.line_total) as total_revenue
FROM OrderItems oi
JOIN Products p ON oi.product_id = p.product_id
GROUP BY p.product_id, p.product_name
ORDER BY total_sold DESC
LIMIT 10;
```

### Customer Purchase Summary
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
ORDER BY total_spent DESC;
```

## Best Practices

1. **Data Entry**: Verify customer and product IDs before creating orders
2. **Data Integrity**: Use transactions for multi-step operations
3. **Performance**: Use indexes for frequently searched fields
4. **Security**: Use parameterized queries to prevent SQL injection

---

**Last Updated**: June 8, 2026
