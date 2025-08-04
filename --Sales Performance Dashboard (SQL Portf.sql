--Sales Performance Dashboard (SQL Portfolio Project)
-- Project Goal
--Build a SQL-driven backend that allows businesses to track sales KPIs such as revenue, quantity sold, customer behavior, and regional performance.

--1. Total Revenue by Region
SELECT 
  c.region,
  SUM(oi.sales_value) AS total_revenue
FROM order_items oi
JOIN orders o ON oi.order_id = o.order_id
JOIN customers c ON o.customer_id = c.customer_id
GROUP BY c.region
ORDER BY total_revenue DESC;


--2. Monthly Sales Trend

SELECT 
  DATE_TRUNC('month', o.order_date) AS month,
  SUM(oi.sales_value) AS total_sales
FROM order_items oi
JOIN orders o ON oi.order_id = o.order_id
GROUP BY month
ORDER BY month;

--3. Top 10 Best-Selling Products

SELECT 
  p.product_name,
  SUM(oi.quantity) AS total_units_sold,
  SUM(oi.sales_value) AS revenue
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_units_sold DESC
LIMIT 10;

--4. Customer Segmentation by Spend

SELECT 
  c.segment,
  COUNT(DISTINCT o.customer_id) AS total_customers,
  SUM(oi.sales_value) AS total_revenue,
  ROUND(SUM(oi.sales_value) / COUNT(DISTINCT o.customer_id), 2) AS avg_revenue_per_customer
FROM order_items oi
JOIN orders o ON oi.order_id = o.order_id
JOIN customers c ON o.customer_id = c.customer_id
GROUP BY c.segment
ORDER BY total_revenue DESC;


--5. Sales by Product Category
SELECT 
  p.category,
  SUM(oi.sales_value) AS revenue
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.category
ORDER BY revenue DESC;
