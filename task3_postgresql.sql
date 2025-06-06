
-- Task 3: PostgreSQL SQL Script by Akhil Shaikh

-- Create users table
CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    name TEXT,
    email TEXT
);

-- Insert data into users
INSERT INTO users (name, email) VALUES
('Akhil', 'akhil@example.com'),
('Sara', 'sara@example.com'),
('John', 'john@example.com'),
('Meena', 'meena@example.com');

-- Create orders table
CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES users(user_id),
    total_amount NUMERIC
);

-- Insert data into orders
INSERT INTO orders (user_id, total_amount) VALUES
(1, 250),
(2, 400),
(1, 150),
(3, 300),
(4, 100),
(1, 200);

-- Create products table
CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    product_name TEXT,
    price NUMERIC
);

-- Insert data into products
INSERT INTO products (product_name, price) VALUES
('Laptop', 50000),
('Mouse', 800),
('Keyboard', 1200);

-- Query 1: Show all users
SELECT * FROM users;

-- Query 2: Total number of orders
SELECT COUNT(*) AS total_orders FROM orders;

-- Query 3: Total revenue
SELECT SUM(total_amount) AS total_revenue FROM orders;

-- Query 4: Average order value per user
SELECT user_id, AVG(total_amount) AS avg_order_value
FROM orders
GROUP BY user_id;

-- Query 5: Orders with user details
SELECT u.name, o.order_id, o.total_amount
FROM users u
JOIN orders o ON u.user_id = o.user_id;

-- Query 6: Users with more than 1 order
SELECT u.name
FROM users u
JOIN orders o ON u.user_id = o.user_id
GROUP BY u.user_id, u.name
HAVING COUNT(o.order_id) > 1;

-- Query 7: User with highest total spend
SELECT u.name, SUM(o.total_amount) AS total_spent
FROM users u
JOIN orders o ON u.user_id = o.user_id
GROUP BY u.user_id, u.name
ORDER BY total_spent DESC
LIMIT 1;
