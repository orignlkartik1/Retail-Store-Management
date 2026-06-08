# Database Design Documentation

## Overview

The Retail Store Management database is designed using relational database principles to manage all aspects of a retail store operation. The schema follows **Third Normal Form (3NF)** to ensure data integrity, reduce redundancy, and optimize query performance.

## Design Principles

### 1. Normalization (3NF)
- **First Normal Form (1NF)**: Atomic values only, no repeating groups
- **Second Normal Form (2NF)**: No partial dependencies on composite keys
- **Third Normal Form (3NF)**: No transitive dependencies

## Table Relationships

```
Categories (1) ──→ (Many) Products
Suppliers (1) ──→ (Many) Products
Products (1) ──→ (Many) OrderItems
Customers (1) ──→ (Many) Orders
Employees (1) ──→ (Many) Orders
Orders (1) ──→ (Many) OrderItems
Products (1) ──→ (Many) StockMovement
Employees (1) ──→ (Many) Employees [Manager relationship]
```

## Key Features

- **8 Main Tables**: Categories, Suppliers, Products, Customers, Employees, Orders, OrderItems, StockMovement
- **Referential Integrity**: Foreign key constraints maintain data consistency
- **Performance Indexes**: Strategic indexing on frequently searched columns
- **Audit Trail**: Timestamps track when records are created and updated
- **Business Rules**: ENUM fields enforce valid status values

---

**Last Updated**: June 8, 2026
