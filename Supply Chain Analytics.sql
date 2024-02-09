Create Database Supply_Chain_Analytics;
Use Supply_Chain_Analytics;

# Creating Inventory Table
CREATE TABLE inventory (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(255),
    stock_quantity INT,
    reorder_level INT
);

# Creating Orders Table
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    product_id INT,
    order_date DATE,
    delivery_date DATE,
    quantity_ordered INT,
    status VARCHAR(50),
    FOREIGN KEY (product_id) REFERENCES inventory(product_id)
);

# Creating Suppliers Table
CREATE TABLE suppliers (
    supplier_id INT PRIMARY KEY,
    supplier_name VARCHAR(255),
    supplier_rating DECIMAL(3, 2)
);

# Sample Data for Inventory
INSERT INTO inventory VALUES
    (1, 'Aspirin', 100, 20),
    (2, 'Bandages', 200, 50),
    (3, 'Antibiotics', 50, 10),
    (4, 'Painkillers', 75, 15),
    (5, 'Cough Syrup', 30, 5);

# Sample Data for Orders
INSERT INTO orders VALUES
    (1, 1, '2024-01-15', '2024-01-20', 3, 'Shipped'),
    (2, 2, '2024-01-16', '2024-01-21', 5, 'Delivered'),
    (3, 3, '2024-01-17', '2024-01-22', 2, 'Pending'),
    (4, 1, '2024-01-18', '2024-01-23', 1, 'Delivered'),
    (5, 2, '2024-01-19', '2024-01-24', 4, 'Shipped'),
    (6, 3, '2024-01-20', '2024-01-25', 2, 'Delivered'),
    (7, 1, '2024-01-21', '2024-01-26', 3, 'Shipped'),
    (8, 2, '2024-01-22', '2024-01-27', 2, 'Pending'),
    (9, 3, '2024-01-23', '2024-01-28', 5, 'Delivered'),
    (10, 1, '2024-01-24', '2024-01-29', 1, 'Shipped');

# Sample Data for Suppliers
INSERT INTO suppliers VALUES
    (1, 'ABC Electronics', 4.2),
    (2, 'XYZ Pharma', 3.8),
    (3, 'Globe Foods', 4.5),
    (4, 'Swift Logistics', 3.9),
    (5, 'Innovate Solutions', 4.1),
    (6, 'Green Agro', 4.3),
    (7, 'Tech Innovators', 3.7),
    (8, 'MediCare Supplies', 4.6),
    (9, 'Quality Materials', 4.0),
    (10, 'Fashion Trends', 3.5);

# Query to Analyze Inventory Levels
SELECT
    product_id,
    product_name,
    stock_quantity,
    reorder_level,
    CASE
        WHEN stock_quantity <= reorder_level THEN 'Reorder Required'
        ELSE 'Sufficient Stock'
    END AS stock_status
FROM
    inventory;

# Query to Analyze Order Fulfillment Times
SELECT
    order_id,
    product_name,
    order_date,
    delivery_date,
    DATEDIFF(delivery_date, order_date) AS fulfillment_time_days,
    status
FROM
    orders
JOIN
    inventory ON orders.product_id = inventory.product_id;

#  Query to Analyze Supplier Performance
SELECT
    supplier_id,
    supplier_name,
    supplier_rating
FROM
    suppliers
ORDER BY
    supplier_rating DESC;
