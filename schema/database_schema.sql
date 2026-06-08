-- Retail Store Management Database Schema
-- This schema defines the structure for managing inventory, customers, orders, and employees

-- Create Categories Table
CREATE TABLE IF NOT EXISTS Categories (
    category_id INT PRIMARY KEY AUTO_INCREMENT,
    category_name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create Suppliers Table
CREATE TABLE IF NOT EXISTS Suppliers (
    supplier_id INT PRIMARY KEY AUTO_INCREMENT,
    supplier_name VARCHAR(150) NOT NULL,
    contact_person VARCHAR(100),
    email VARCHAR(100),
    phone VARCHAR(15),
    address VARCHAR(255),
    city VARCHAR(50),
    state VARCHAR(50),
    country VARCHAR(50),
    postal_code VARCHAR(10),
    payment_terms VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_supplier_name (supplier_name)
);

-- Create Products Table
CREATE TABLE IF NOT EXISTS Products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(200) NOT NULL,
    category_id INT NOT NULL,
    supplier_id INT NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    cost_price DECIMAL(10, 2),
    quantity_in_stock INT DEFAULT 0,
    reorder_level INT DEFAULT 10,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (category_id) REFERENCES Categories(category_id) ON DELETE RESTRICT,
    FOREIGN KEY (supplier_id) REFERENCES Suppliers(supplier_id) ON DELETE RESTRICT,
    INDEX idx_product_name (product_name),
    INDEX idx_category (category_id)
);

-- Create Customers Table
CREATE TABLE IF NOT EXISTS Customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_name VARCHAR(150) NOT NULL,
    email VARCHAR(100),
    phone VARCHAR(15),
    address VARCHAR(255),
    city VARCHAR(50),
    state VARCHAR(50),
    country VARCHAR(50),
    postal_code VARCHAR(10),
    customer_type ENUM('regular', 'premium', 'wholesale') DEFAULT 'regular',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_customer_name (customer_name),
    INDEX idx_email (email)
);

-- Create Employees Table
CREATE TABLE IF NOT EXISTS Employees (
    employee_id INT PRIMARY KEY AUTO_INCREMENT,
    employee_name VARCHAR(150) NOT NULL,
    email VARCHAR(100),
    phone VARCHAR(15),
    position VARCHAR(100),
    department VARCHAR(100),
    hire_date DATE,
    salary DECIMAL(10, 2),
    manager_id INT,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (manager_id) REFERENCES Employees(employee_id) ON DELETE SET NULL,
    INDEX idx_employee_name (employee_name),
    INDEX idx_department (department)
);

-- Create Orders Table
CREATE TABLE IF NOT EXISTS Orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    employee_id INT,
    order_date DATE NOT NULL,
    delivery_date DATE,
    total_amount DECIMAL(12, 2),
    order_status ENUM('pending', 'processing', 'shipped', 'delivered', 'cancelled') DEFAULT 'pending',
    payment_status ENUM('unpaid', 'partial', 'paid') DEFAULT 'unpaid',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id) ON DELETE RESTRICT,
    FOREIGN KEY (employee_id) REFERENCES Employees(employee_id) ON DELETE SET NULL,
    INDEX idx_customer (customer_id),
    INDEX idx_order_date (order_date),
    INDEX idx_order_status (order_status)
);

-- Create OrderItems Table
CREATE TABLE IF NOT EXISTS OrderItems (
    order_item_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    unit_price DECIMAL(10, 2) NOT NULL,
    line_total DECIMAL(12, 2),
    discount DECIMAL(5, 2) DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES Products(product_id) ON DELETE RESTRICT,
    INDEX idx_order (order_id),
    INDEX idx_product (product_id)
);

-- Create Stock Movement Table (for tracking inventory changes)
CREATE TABLE IF NOT EXISTS StockMovement (
    movement_id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT NOT NULL,
    movement_type ENUM('purchase', 'sale', 'adjustment', 'return') NOT NULL,
    quantity INT NOT NULL,
    reference_id INT,
    reference_type VARCHAR(50),
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (product_id) REFERENCES Products(product_id) ON DELETE RESTRICT,
    INDEX idx_product (product_id),
    INDEX idx_movement_type (movement_type),
    INDEX idx_created_at (created_at)
);

-- Create Indexes for Performance
CREATE INDEX idx_order_employee ON Orders(employee_id);
CREATE INDEX idx_orderitem_product ON OrderItems(product_id);
