# Retail Store Management System

A comprehensive database project designed to apply database knowledge to real-world retail scenarios. This system manages inventory, customers, sales, and employees for a retail store.

## Project Overview

This project demonstrates the design and implementation of a relational database for managing various aspects of a retail store operation including:
- **Inventory Management**: Track products, stock levels, and supplier information
- **Customer Management**: Store customer details and purchase history
- **Sales & Orders**: Process transactions and manage order details
- **Employee Management**: Manage staff information and roles
- **Supplier Management**: Track supplier details and relationships

## Features

✅ Normalized relational database design  
✅ Product inventory tracking with stock management  
✅ Customer relationship management (CRM)  
✅ Sales transaction recording  
✅ Employee and staff management  
✅ Supplier and vendor management  
✅ Order processing and fulfillment tracking  
✅ Reporting and analytics capabilities  

## Database Schema

The system uses the following main tables:

### Core Tables
- **Products**: Product information, pricing, and stock levels
- **Customers**: Customer demographics and contact information
- **Orders**: Order headers with customer and date information
- **OrderItems**: Individual line items within orders
- **Employees**: Staff information and roles
- **Suppliers**: Vendor and supplier details
- **Categories**: Product categorization

See `schema/database_schema.sql` for the complete database structure.

## Getting Started

### Prerequisites
- SQL Database (MySQL, PostgreSQL, or similar)
- Basic understanding of relational databases
- SQL client or IDE

### Installation

1. Clone the repository:
```bash
git clone https://github.com/orignlkartik1/Retail-Store-Management.git
cd Retail-Store-Management
```

2. Set up the database:
```bash
# For MySQL
mysql -u root -p < schema/database_schema.sql

# For PostgreSQL
psql -U postgres -f schema/database_schema.sql
```

3. Load sample data:
```bash
mysql -u root -p < data/sample_data.sql
```

## Project Structure

```
Retail-Store-Management/
├── README.md                          # Project documentation
├── schema/
│   ├── database_schema.sql           # Complete database schema
│   └── erd.md                        # Entity Relationship Diagram
├── data/
│   ├── sample_data.sql               # Sample data for testing
│   └── insert_queries.sql            # Common insert patterns
├── queries/
│   ├── basic_queries.sql             # Basic SELECT queries
│   ├── analytical_queries.sql        # Complex analytical queries
│   ├── reports.sql                   # Business reporting queries
│   └── procedures.sql                # Stored procedures
├── docs/
│   ├── DESIGN.md                     # Database design documentation
│   ├── REQUIREMENTS.md               # Functional requirements
│   └── USER_GUIDE.md                 # User guide and usage
└── .gitignore                        # Git ignore file
```

## Key Queries

### Get Total Sales by Product
```sql
SELECT p.product_name, SUM(oi.quantity * oi.unit_price) as total_sales
FROM Products p
JOIN OrderItems oi ON p.product_id = oi.product_id
GROUP BY p.product_id, p.product_name
ORDER BY total_sales DESC;
```

### Customer Purchase Summary
```sql
SELECT c.customer_id, c.customer_name, COUNT(o.order_id) as total_orders, 
       SUM(oi.quantity * oi.unit_price) as total_spent
FROM Customers c
LEFT JOIN Orders o ON c.customer_id = o.customer_id
LEFT JOIN OrderItems oi ON o.order_id = oi.order_id
GROUP BY c.customer_id, c.customer_name;
```

## Database Normalization

The database follows **3NF (Third Normal Form)** principles:
- Eliminates data redundancy
- Maintains data integrity
- Improves query performance
- Simplifies maintenance

## Technologies Used

- **Database**: SQL (MySQL/PostgreSQL compatible)
- **Version Control**: Git
- **Documentation**: Markdown

## Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/enhancement`)
3. Commit your changes (`git commit -am 'Add new feature'`)
4. Push to the branch (`git push origin feature/enhancement`)
5. Submit a Pull Request

## Learning Objectives

This project helps learners understand:
- Relational database design principles
- SQL query optimization
- Data modeling and normalization
- Real-world database scenarios
- Business logic implementation in databases

## License

This project is open source and available for educational purposes.

## Author

**Kartik** - orignlkartik1

## Support

For issues or questions, please create an issue in the repository.

---

**Last Updated**: June 8, 2026
