-- Sample Data for Retail Store Management System
-- This file contains sample data for testing and development

-- Insert Categories
INSERT INTO Categories (category_name, description) VALUES
('Electronics', 'Electronic devices and accessories'),
('Clothing', 'Apparel and fashion items'),
('Home & Kitchen', 'Home and kitchen appliances'),
('Books', 'Books and educational materials'),
('Sports', 'Sports and fitness equipment'),
('Toys', 'Toys and games');

-- Insert Suppliers
INSERT INTO Suppliers (supplier_name, contact_person, email, phone, address, city, state, country, postal_code) VALUES
('Tech Supplies Co.', 'John Smith', 'john@techsupplies.com', '555-0101', '123 Tech Street', 'San Francisco', 'CA', 'USA', '94102'),
('Fashion Wholesale Ltd.', 'Sarah Johnson', 'sarah@fashionwholesale.com', '555-0102', '456 Fashion Ave', 'New York', 'NY', 'USA', '10001'),
('Home Depot Inc.', 'Mike Wilson', 'mike@homedepot.com', '555-0103', '789 Industrial Blvd', 'Atlanta', 'GA', 'USA', '30303'),
('Book Publishers Group', 'Emily Brown', 'emily@bookpublishers.com', '555-0104', '321 Literature Lane', 'Boston', 'MA', 'USA', '02101'),
('Sports Equipment Ltd.', 'David Lee', 'david@sportsequip.com', '555-0105', '654 Athletic Drive', 'Denver', 'CO', 'USA', '80202');

-- Insert Products
INSERT INTO Products (product_name, category_id, supplier_id, price, cost_price, quantity_in_stock, reorder_level, description) VALUES
('Laptop Computer', 1, 1, 1299.99, 850.00, 25, 5, 'High-performance laptop'),
('Smartphone', 1, 1, 799.99, 450.00, 40, 10, 'Latest model smartphone'),
('Wireless Headphones', 1, 1, 199.99, 100.00, 60, 15, 'Noise-cancelling headphones'),
('Cotton T-Shirt', 2, 2, 29.99, 10.00, 150, 30, 'Premium cotton t-shirt'),
('Jeans', 2, 2, 79.99, 25.00, 100, 20, 'Classic blue jeans'),
('Microwave Oven', 3, 3, 249.99, 150.00, 15, 5, 'High-powered microwave'),
('Coffee Maker', 3, 3, 89.99, 40.00, 30, 8, 'Programmable coffee maker'),
('Database Design', 4, 4, 49.99, 15.00, 50, 10, 'Comprehensive database guide'),
('SQL Query Book', 4, 4, 39.99, 12.00, 45, 10, 'Advanced SQL techniques'),
('Tennis Racket', 5, 5, 129.99, 60.00, 20, 5, 'Professional tennis racket'),
('Yoga Mat', 5, 5, 34.99, 12.00, 80, 15, 'Non-slip yoga mat'),
('Dumbbells Set', 5, 5, 149.99, 70.00, 25, 5, 'Adjustable dumbbells');
