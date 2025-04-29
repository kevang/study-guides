# SQL Analytics Problem Guide

## Table of Contents

1. [Aggregate Functions](#aggregate-functions)
2. [Window Functions](#window-functions)
3. [CTEs and Subqueries](#ctes-and-subqueries)
4. [Self Joins](#self-joins)
5. [CASE Statements and Conditional Logic](#case-statements-and-conditional-logic)
6. [Date and Time Functions](#date-and-time-functions)
7. [String Functions](#string-functions)
8. [Advanced Joins (CROSS, LATERAL)](#advanced-joins-cross-lateral)
9. [Running Totals and Moving Averages](#running-totals-and-moving-averages)

# Aggregate Functions

Aggregate functions perform calculations on sets of values and return a single value. Common aggregate functions include `COUNT()`, `SUM()`, `AVG()`, `MIN()`, and `MAX()`. The `HAVING` clause filters groups created by the `GROUP BY` clause.

## Problem 1.1: Sales Performance Analysis

**Problem Statement:**  
As a sales analyst, you need to identify products with high sales volume but low profit margins. Find all products with total sales quantity exceeding 100 units but an average profit margin below 15%.

**Sample Data:**

```
-- sales_data table
product_id | product_name   | quantity | profit_margin
-----------+----------------+----------+--------------
101        | Premium Widget | 150      | 12.5
102        | Budget Gadget  | 200      | 8.3
103        | Luxury Item    | 50       | 35.0
104        | Standard Tool  | 120      | 18.7
```

**Expected Output:**

```
product_id | product_name   | total_quantity | avg_margin
-----------+----------------+----------------+-----------
101        | Premium Widget | 150            | 12.5
102        | Budget Gadget  | 200            | 8.3
```

**SQL Solution:**

```sql
SELECT 
    product_id,
    product_name,
    SUM(quantity) AS total_quantity,
    AVG(profit_margin) AS avg_margin
FROM 
    sales_data
GROUP BY 
    product_id,
    product_name
HAVING 
    SUM(quantity) > 100 
    AND AVG(profit_margin) < 15
ORDER BY 
    avg_margin;
```

**Performance Tip:**  
In this query, ensure you have indexes on `product_id`, `quantity`, and `profit_margin` to improve the performance of the grouping and filtering operations. The database can use these indexes to efficiently locate the relevant rows and perform calculations.

## Problem 1.2: Customer Segment Analysis

**Problem Statement:**  
Your marketing team wants to identify valuable customer segments. Find all customer segments that have both a high average order value (> $75) and have placed at least 3 orders in the last month.

**Sample Data:**

```
-- customer_orders table
order_id | customer_segment | order_date  | order_value
---------+-----------------+-------------+------------
1001     | Premium         | 2025-04-05  | 120.50
1002     | Standard        | 2025-04-08  | 45.75
1003     | Premium         | 2025-04-15  | 88.20
1004     | Business        | 2025-04-20  | 250.00
1005     | Standard        | 2025-04-22  | 65.30
1006     | Business        | 2025-04-25  | 175.45
1007     | Premium         | 2025-04-28  | 95.60
```

**Expected Output:**

```
customer_segment | order_count | avg_order_value
----------------+-------------+-----------------
Premium          | 3           | 101.43
Business         | 2           | 212.73
```

**SQL Solution:**

```sql
SELECT 
    customer_segment,
    COUNT(order_id) AS order_count,
    AVG(order_value) AS avg_order_value
FROM 
    customer_orders
WHERE 
    order_date >= '2025-04-01' 
    AND order_date <= '2025-04-30'
GROUP BY 
    customer_segment
HAVING 
    COUNT(order_id) >= 3 
    OR AVG(order_value) > 75
ORDER BY 
    avg_order_value DESC;
```

**Performance Tip:**  
When working with date ranges and aggregations, ensure you have an index on the `order_date` column. Consider using a filtered index if your database supports it (e.g., SQL Server) to optimize queries that frequently filter on a specific date range. This reduces the number of rows that need to be processed during aggregation.

## Problem 1.3: Advanced Product Performance Metrics

**Problem Statement:**  
The product team needs a comprehensive analysis of product categories. They want to see categories that have at least 3 products, where the maximum price is at least twice the minimum price, and the average price is above $50.

**Sample Data:**

```
-- products table
product_id | product_name     | category    | price
-----------+------------------+-------------+-------
101        | Premium Widget   | Electronics | 120.50
102        | Standard Widget  | Electronics | 45.75
103        | Budget Widget    | Electronics | 25.20
104        | Luxury Gadget    | Appliances  | 250.00
105        | Standard Gadget  | Appliances  | 65.30
106        | Designer Item    | Clothing    | 175.45
107        | Casual Item      | Clothing    | 35.60
```

**Expected Output:**

```
category    | product_count | min_price | max_price | avg_price | price_range_ratio
------------+--------------+-----------+-----------+-----------+------------------
Electronics | 3            | 25.20     | 120.50    | 63.82     | 4.78
```

**SQL Solution:**

```sql
SELECT 
    category,
    COUNT(*) AS product_count,
    MIN(price) AS min_price,
    MAX(price) AS max_price,
    AVG(price) AS avg_price,
    ROUND(MAX(price) / MIN(price), 2) AS price_range_ratio
FROM 
    products
GROUP BY 
    category
HAVING 
    COUNT(*) >= 3
    AND MAX(price) >= 2 * MIN(price)
    AND AVG(price) > 50;
```

**Performance Tip:**  
For complex aggregate calculations, the database must perform multiple passes over the data. Use appropriate indexing on `category` and `price` columns. Also, be aware that using expressions in HAVING clauses (like `MAX(price) >= 2 * MIN(price)`) cannot leverage indexes directly and require the database to compute all aggregates before filtering. For frequently run queries, consider materializing these calculations in a view or summary table that can be refreshed periodically.

# Window Functions

Window functions perform calculations across sets of table rows related to the current row. Unlike aggregate functions, window functions do not cause rows to become grouped into a single output row — the rows retain their separate identities.

## Problem 2.1: Employee Salary Rankings

**Problem Statement:**  
The HR department wants to identify salary disparities within each department. For each employee, provide their salary rank within their department (1 being highest), their salary percentile within the department, and how their salary compares to the department average.

**Sample Data:**

```
-- employees table
emp_id | emp_name    | department | salary
-------+-------------+------------+--------
101    | Alice Smith | Sales      | 85000
102    | Bob Johnson | Sales      | 72000
103    | Carol Davis | Sales      | 95000
104    | Dave Wilson | Marketing  | 67000
105    | Eve Brown   | Marketing  | 78000
106    | Frank Lee   | IT         | 92000
107    | Grace Chen  | IT         | 105000
```

**Expected Output:**

```
emp_id | emp_name    | department | salary | dept_rank | vs_dept_avg | percentile
-------+-------------+------------+--------+-----------+-------------+------------
103    | Carol Davis | Sales      | 95000  | 1         | 19.05%      | 1.00
101    | Alice Smith | Sales      | 85000  | 2         | 6.35%       | 0.67
102    | Bob Johnson | Sales      | 72000  | 3         | -9.52%      | 0.33
105    | Eve Brown   | Marketing  | 78000  | 1         | 7.59%       | 1.00
104    | Dave Wilson | Marketing  | 67000  | 2         | -7.59%      | 0.50
107    | Grace Chen  | IT         | 105000 | 1         | 6.57%       | 1.00
106    | Frank Lee   | IT         | 92000  | 2         | -6.57%      | 0.50
```

**SQL Solution:**

```sql
WITH dept_stats AS (
    SELECT 
        department,
        AVG(salary) AS avg_salary
    FROM 
        employees
    GROUP BY 
        department
)
SELECT 
    e.emp_id,
    e.emp_name,
    e.department,
    e.salary,
    RANK() OVER (PARTITION BY e.department ORDER BY e.salary DESC) AS dept_rank,
    ROUND(((e.salary - s.avg_salary) / s.avg_salary) * 100, 2) || '%' AS vs_dept_avg,
    ROUND((COUNT(*) OVER (PARTITION BY e.department) - 
           RANK() OVER (PARTITION BY e.department ORDER BY e.salary)) / 
           (COUNT(*) OVER (PARTITION BY e.department) - 1.0), 2) AS percentile
FROM 
    employees e
JOIN 
    dept_stats s ON e.department = s.department
ORDER BY 
    e.department,
    dept_rank;
```

**Performance Tip:**  
Window functions can be computation-intensive when working with large datasets. The database needs to sort data within each partition, which can be memory-intensive. Ensure you have indexes on the partition columns (`department` in this case) and the ordering columns (`salary`). Be cautious with complex window functions in queries that process millions of rows, as they might require significant memory for the window frame calculations.

## Problem 2.2: Identifying Sales Trends

**Problem Statement:**  
The sales team wants to understand product performance trends. For each product, calculate the month-over-month sales growth percentage, a 3-month moving average of sales, and the rank of each month's sales within its product category.

**Sample Data:**

```
-- monthly_sales table
product_id | product_name | month      | monthly_sales
-----------+-------------+------------+--------------
101        | Widget A     | 2025-01-01 | 12500
101        | Widget A     | 2025-02-01 | 13200
101        | Widget A     | 2025-03-01 | 14100
101        | Widget A     | 2025-04-01 | 13800
102        | Gadget B     | 2025-01-01 | 8700
102        | Gadget B     | 2025-02-01 | 9200
102        | Gadget B     | 2025-03-01 | 8900
102        | Gadget B     | 2025-04-01 | 9500
```

**Expected Output:**

```
product_id | product_name | month      | monthly_sales | prev_month_sales | mom_growth | 3m_avg_sales | month_rank
-----------+-------------+------------+---------------+------------------+------------+--------------+-----------
101        | Widget A     | 2025-01-01 | 12500         | NULL             | NULL       | NULL         | 4
101        | Widget A     | 2025-02-01 | 13200         | 12500            | 5.60%      | NULL         | 3
101        | Widget A     | 2025-03-01 | 14100         | 13200            | 6.82%      | 13267        | 1
101        | Widget A     | 2025-04-01 | 13800         | 14100            | -2.13%     | 13700        | 2
102        | Gadget B     | 2025-01-01 | 8700          | NULL             | NULL       | NULL         | 4
102        | Gadget B     | 2025-02-01 | 9200          | 8700             | 5.75%      | NULL         | 2
102        | Gadget B     | 2025-03-01 | 8900          | 9200             | -3.26%     | 8933         | 3
102        | Gadget B     | 2025-04-01 | 9500          | 8900             | 6.74%      | 9200         | 1
```

**SQL Solution:**

```sql
SELECT 
    product_id,
    product_name,
    month,
    monthly_sales,
    LAG(monthly_sales, 1) OVER (PARTITION BY product_id ORDER BY month) AS prev_month_sales,
    CASE 
        WHEN LAG(monthly_sales, 1) OVER (PARTITION BY product_id ORDER BY month) IS NULL THEN NULL
        ELSE ROUND(((monthly_sales - LAG(monthly_sales, 1) OVER (PARTITION BY product_id ORDER BY month)) / 
                LAG(monthly_sales, 1) OVER (PARTITION BY product_id ORDER BY month)) * 100, 2) || '%'
    END AS mom_growth,
    CASE
        WHEN COUNT(*) OVER (PARTITION BY product_id ORDER BY month ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) < 3 THEN NULL
        ELSE ROUND(AVG(monthly_sales) OVER (PARTITION BY product_id ORDER BY month ROWS BETWEEN 2 PRECEDING AND CURRENT ROW))
    END AS 3m_avg_sales,
    RANK() OVER (PARTITION BY product_id ORDER BY monthly_sales DESC) AS month_rank
FROM 
    monthly_sales
ORDER BY 
    product_id,
    month;
```

**Performance Tip:**  
This query uses multiple window functions with different frame specifications. The database may need to make several passes over the data to compute all the window functions. For better performance with large datasets:

1. Consider defining a Common Table Expression (CTE) for each distinct window function computation.
2. Ensure you have appropriate indexes on `product_id` and `month`.
3. If your database supports it, you might be able to use materialized views to pre-compute some of these metrics on a scheduled basis.

## Problem 2.3: Customer Purchase Frequency Analysis

**Problem Statement:**  
The marketing team wants to segment customers based on their purchase patterns. Calculate each customer's purchase frequency, the days between purchases, and flag customers whose recent purchase amount is significantly higher than their average (potential upsell candidates).

**Sample Data:**

```
-- customer_purchases table
purchase_id | customer_id | purchase_date | amount
------------+-------------+---------------+--------
1001        | C101        | 2025-03-05    | 120.50
1002        | C102        | 2025-03-08    | 45.75
1003        | C101        | 2025-03-15    | 88.20
1004        | C103        | 2025-03-20    | 250.00
1005        | C102        | 2025-03-25    | 65.30
1006        | C101        | 2025-04-02    | 195.45
1007        | C103        | 2025-04-10    | 75.60
```

**Expected Output:**

```
customer_id | purchase_count | avg_purchase | latest_purchase | avg_days_between | pct_above_avg | upsell_candidate
------------+----------------+--------------+-----------------+------------------+---------------+------------------
C101        | 3              | 134.72       | 195.45          | 14.0             | 45.08%        | YES
C102        | 2              | 55.53        | 65.30           | 17.0             | 17.59%        | YES
C103        | 2              | 162.80       | 75.60           | 21.0             | -53.56%       | NO
```

**SQL Solution:**

```sql
WITH purchase_stats AS (
    SELECT
        customer_id,
        COUNT(*) AS purchase_count,
        AVG(amount) AS avg_purchase,
        MAX(amount) AS latest_purchase,
        AVG(DATEDIFF(day, 
                      LAG(purchase_date) OVER (PARTITION BY customer_id ORDER BY purchase_date),
                      purchase_date)) AS avg_days_between,
        FIRST_VALUE(amount) OVER (PARTITION BY customer_id ORDER BY purchase_date DESC) AS most_recent_amount
    FROM
        customer_purchases
    GROUP BY
        customer_id
)
SELECT
    customer_id,
    purchase_count,
    ROUND(avg_purchase, 2) AS avg_purchase,
    latest_purchase,
    ROUND(avg_days_between, 1) AS avg_days_between,
    ROUND(((most_recent_amount - avg_purchase) / avg_purchase) * 100, 2) || '%' AS pct_above_avg,
    CASE
        WHEN most_recent_amount > avg_purchase * 1.15 THEN 'YES'
        ELSE 'NO'
    END AS upsell_candidate
FROM
    purchase_stats
ORDER BY
    purchase_count DESC,
    avg_purchase DESC;
```

**Performance Tip:**  
This query combines window functions with aggregations, which can be complex for the query optimizer to handle efficiently. Consider breaking it down into steps:

1. First, calculate the window function values in a CTE
2. Then, use a second CTE to compute the aggregations
3. Finally, apply the conditional logic

This step-by-step approach often helps the database optimizer create a more efficient execution plan. Additionally, ensure you have indexes on `customer_id` and `purchase_date` to support the window function operations and date calculations.

# CTEs and Subqueries

Common Table Expressions (CTEs) and subqueries allow you to break down complex queries into more manageable pieces, making your SQL more readable and often more efficient.

## Problem 3.1: Product Performance Analysis

**Problem Statement:**  
The product team wants to understand how each product performs compared to its category average. Identify products that have above-average sales within their category, and calculate by what percentage they exceed the category average.

**Sample Data:**

```
-- product_sales table
product_id | product_name      | category    | sales_amount
-----------+-------------------+-------------+-------------
101        | Premium Widget    | Electronics | 12500
102        | Standard Widget   | Electronics | 8300
103        | Budget Widget     | Electronics | 5600
104        | Luxury Gadget     | Appliances  | 9800
105        | Standard Gadget   | Appliances  | 6200
106        | Designer Accessory| Clothing    | 7500
107        | Basic Accessory   | Clothing    | 3800
```

**Expected Output:**

```
product_id | product_name      | category    | sales_amount | category_avg | pct_above_avg | performance
-----------+-------------------+-------------+-------------+--------------+---------------+-------------
101        | Premium Widget    | Electronics | 12500       | 8800         | 42.05%        | Above Average
102        | Standard Widget   | Electronics | 8300        | 8800         | -5.68%        | Below Average
103        | Budget Widget     | Electronics | 5600        | 8800         | -36.36%       | Below Average
104        | Luxury Gadget     | Appliances  | 9800        | 8000         | 22.50%        | Above Average
105        | Standard Gadget   | Appliances  | 6200        | 8000         | -22.50%       | Below Average
106        | Designer Accessory| Clothing    | 7500        | 5650         | 32.74%        | Above Average
107        | Basic Accessory   | Clothing    | 3800        | 5650         | -32.74%       | Below Average
```

**SQL Solution:**

```sql
WITH category_averages AS (
    SELECT
        category,
        AVG(sales_amount) AS category_avg
    FROM
        product_sales
    GROUP BY
        category
)
SELECT
    p.product_id,
    p.product_name,
    p.category,
    p.sales_amount,
    ROUND(c.category_avg) AS category_avg,
    ROUND(((p.sales_amount - c.category_avg) / c.category_avg) * 100, 2) || '%' AS pct_above_avg,
    CASE
        WHEN p.sales_amount > c.category_avg THEN 'Above Average'
        WHEN p.sales_amount < c.category_avg THEN 'Below Average'
        ELSE 'Average'
    END AS performance
FROM
    product_sales p
JOIN
    category_averages c ON p.category = c.category
ORDER BY
    p.category,
    p.sales_amount DESC;
```

**Performance Tip:**  
CTEs are materialized only once during query execution, making them efficient for reusing calculations. However, in some database systems, the optimizer might not be able to push predicates from the outer query into the CTE. For very large datasets, consider using indexed views (materialized views) for frequently computed aggregates like category averages.

## Problem 3.2: Identifying Top Customers by Segment

**Problem Statement:**  
The marketing department wants to identify the top two customers from each segment based on their total purchase amount. They also want to see how each customer's spending compares to others within the same segment.

**Sample Data:**

```
-- customer_purchases table
customer_id | customer_name   | segment    | purchase_amount | purchase_date
------------+----------------+------------+----------------+---------------
C101        | Acme Corp      | Enterprise | 12500          | 2025-03-15
C102        | Better Systems | Enterprise | 18700          | 2025-03-20
C103        | Cool Tech      | Enterprise | 9800           | 2025-03-25
C104        | Dynamic Apps   | SMB        | 5600           | 2025-03-10
C105        | Easy Solutions | SMB        | 7200           | 2025-03-22
C106        | Fast Delivery  | SMB        | 3800           | 2025-03-29
C107        | Great Gadgets  | Consumer   | 1200           | 2025-03-05
C108        | Happy Home     | Consumer   | 950            | 2025-03-18
C109        | Instant Help   | Consumer   | 1400           | 2025-03-21
```

**Expected Output:**

```
segment    | customer_id | customer_name   | total_spent | segment_rank | segment_avg | pct_of_segment_total
-----------+------------+----------------+-------------+--------------+-------------+---------------------
Enterprise | C102        | Better Systems | 18700       | 1            | 13667       | 45.63%
Enterprise | C101        | Acme Corp      | 12500       | 2            | 13667       | 30.49%
SMB        | C105        | Easy Solutions | 7200        | 1            | 5533        | 43.37%
SMB        | C104        | Dynamic Apps   | 5600        | 2            | 5533        | 33.73%
Consumer   | C109        | Instant Help   | 1400        | 1            | 1183        | 39.44%
Consumer   | C107        | Great Gadgets  | 1200        | 2            | 1183        | 33.80%
```

**SQL Solution:**

```sql
WITH customer_totals AS (
    SELECT
        customer_id,
        customer_name,
        segment,
        SUM(purchase_amount) AS total_spent
    FROM
        customer_purchases
    GROUP BY
        customer_id,
        customer_name,
        segment
),
segment_stats AS (
    SELECT
        segment,
        AVG(total_spent) AS segment_avg,
        SUM(total_spent) AS segment_total
    FROM
        customer_totals
    GROUP BY
        segment
),
ranked_customers AS (
    SELECT
        ct.segment,
        ct.customer_id,
        ct.customer_name,
        ct.total_spent,
        RANK() OVER (PARTITION BY ct.segment ORDER BY ct.total_spent DESC) AS segment_rank
    FROM
        customer_totals ct
)
SELECT
    rc.segment,
    rc.customer_id,
    rc.customer_name,
    rc.total_spent,
    rc.segment_rank,
    ROUND(ss.segment_avg) AS segment_avg,
    ROUND((rc.total_spent / ss.segment_total) * 100, 2) || '%' AS pct_of_segment_total
FROM
    ranked_customers rc
JOIN
    segment_stats ss ON rc.segment = ss.segment
WHERE
    rc.segment_rank <= 2
ORDER BY
    rc.segment,
    rc.segment_rank;
```

**Performance Tip:**  
This query uses multiple CTEs for clarity. For large datasets, consider these optimizations:

1. Ensure you have an index on `customer_id`, `segment`, and `purchase_amount` to support the grouping and window function operations.
2. Some databases might benefit from materializing intermediate results (using temporary tables) when dealing with very large datasets.
3. The `RANK()` function requires sorting data within each partition, which can be memory-intensive for large segments. Consider using `ROW_NUMBER()` instead if ties are not a concern.

## Problem 3.3: Cohort Analysis for Customer Retention

**Problem Statement:**  
The customer success team wants to understand customer retention across different cohorts. Calculate the monthly retention rate for each cohort (grouped by sign-up month) over their first three months.

**Sample Data:**

```
-- customer_activity table
customer_id | signup_date | activity_date | activity_type
------------+------------+--------------+--------------
C101        | 2025-01-15 | 2025-01-20   | Purchase
C101        | 2025-01-15 | 2025-02-05   | Login
C101        | 2025-01-15 | 2025-03-10   | Purchase
C102        | 2025-01-22 | 2025-01-25   | Purchase
C102        | 2025-01-22 | 2025-02-15   | Login
C103        | 2025-01-30 | 2025-02-01   | Purchase
C104        | 2025-02-05 | 2025-02-10   | Purchase
C104        | 2025-02-05 | 2025-03-20   | Login
C105        | 2025-02-12 | 2025-02-15   | Purchase
C105        | 2025-02-12 | 2025-03-05   | Login
C105        | 2025-02-12 | 2025-04-10   | Purchase
```

**Expected Output:**

```
cohort_month | cohort_size | month_0_retention | month_1_retention | month_2_retention
-------------+-------------+------------------+------------------+------------------
2025-01      | 3           | 100.00%          | 100.00%          | 33.33%
2025-02      | 2           | 100.00%          | 100.00%          | 50.00%
```

**SQL Solution:**

```sql
WITH customer_cohorts AS (
    SELECT
        customer_id,
        DATE_TRUNC('month', signup_date) AS cohort_month
    FROM
        customer_activity
    GROUP BY
        customer_id,
        signup_date
),
monthly_activity AS (
    SELECT
        c.customer_id,
        c.cohort_month,
        DATE_TRUNC('month', a.activity_date) AS activity_month,
        DATEDIFF('month', c.cohort_month, DATE_TRUNC('month', a.activity_date)) AS month_number
    FROM
        customer_cohorts c
    JOIN
        customer_activity a ON c.customer_id = a.customer_id
    WHERE
        DATEDIFF('month', c.cohort_month, DATE_TRUNC('month', a.activity_date)) <= 2
    GROUP BY
        c.customer_id,
        c.cohort_month,
        activity_month
),
cohort_sizes AS (
    SELECT
        cohort_month,
        COUNT(DISTINCT customer_id) AS cohort_size
    FROM
        customer_cohorts
    GROUP BY
        cohort_month
),
retention_data AS (
    SELECT
        ma.cohort_month,
        ma.month_number,
        COUNT(DISTINCT ma.customer_id) AS active_customers
    FROM
        monthly_activity ma
    GROUP BY
        ma.cohort_month,
        ma.month_number
)
SELECT
    cs.cohort_month,
    cs.cohort_size,
    ROUND((r0.active_customers / cs.cohort_size::float) * 100, 2) || '%' AS month_0_retention,
    ROUND((r1.active_customers / cs.cohort_size::float) * 100, 2) || '%' AS month_1_retention,
    ROUND((r2.active_customers / cs.cohort_size::float) * 100, 2) || '%' AS month_2_retention
FROM
    cohort_sizes cs
LEFT JOIN
    retention_data r0 ON cs.cohort_month = r0.cohort_month AND r0.month_number = 0
LEFT JOIN
    retention_data r1 ON cs.cohort_month = r1.cohort_month AND r1.month_number = 1
LEFT JOIN
    retention_data r2 ON cs.cohort_month = r2.cohort_month AND r2.month_number = 2
ORDER BY
    cs.cohort_month;
```

**Performance Tip:**  
Cohort analysis can be computationally intensive for large datasets because it involves multiple join operations and aggregations. For better performance:

1. Create indexes on `customer_id`, `signup_date`, and `activity_date` to improve join and filtering operations.
2. Consider pre-aggregating data at the month level if the analysis is performed frequently.
3. Use date dimension tables (if available) for efficient date-based calculations instead of using date functions in the query.
4. Some databases offer specialized functions for cohort analysis or time series calculations that might be more efficient than the general approach shown here.

# Self Joins

Self joins are used when a table needs to be joined with itself, typically when the data has a hierarchical or sequential relationship within the same table.

## Problem 4.1: Employee Hierarchy Analysis

**Problem Statement:**  
The HR department wants to analyze the organization's management structure. For each employee, show their direct manager, their manager's manager (skip-level manager), and calculate how many employees each manager supervises.

**Sample Data:**

```
-- employees table
emp_id | emp_name      | title            | manager_id | dept_id | salary
-------+---------------+------------------+------------+---------+--------
101    | John Smith    | CEO              | NULL       | 1       | 250000
102    | Mary Johnson  | CTO              | 101        | 2       | 210000
103    | Bob Brown     | CFO              | 101        | 3       | 195000
104    | Alice Lee     | VP Engineering   | 102        | 2       | 175000
105    | David Chen    | VP Finance       | 103        | 3       | 170000
106    | Sarah Wilson  | Lead Developer   | 104        | 2       | 145000
107    | Michael Davis | Financial Analyst| 105        | 3       | 110000
```

**Expected Output:**

```
emp_id | emp_name      | title            | manager_name  | skip_level_manager | direct_reports
-------+---------------+------------------+---------------+-------------------+---------------
101    | John Smith    | CEO              | NULL          | NULL              | 2
102    | Mary Johnson  | CTO              | John Smith    | NULL              | 1
103    | Bob Brown     | CFO              | John Smith    | NULL              | 1
104    | Alice Lee     | VP Engineering   | Mary Johnson  | John Smith        | 1
105    | David Chen    | VP Finance       | Bob Brown     | John Smith        | 1
106    | Sarah Wilson  | Lead Developer   | Alice Lee     | Mary Johnson      | 0
107    | Michael Davis | Financial Analyst| David Chen    | Bob Brown         | 0
```

**SQL Solution:**

```sql
WITH direct_reports AS (
    SELECT
        manager_id,
        COUNT(*) AS report_count
    FROM
        employees
    WHERE
        manager_id IS NOT NULL
    GROUP BY
        manager_id
)
SELECT
    e.emp_id,
    e.emp_name,
    e.title,
    m1.emp_name AS manager_name,
    m2.emp_name AS skip_level_manager,
    COALESCE(dr.report_count, 0) AS direct_reports
FROM
    employees e
LEFT JOIN
    employees m1 ON e.manager_id = m1.emp_id
LEFT JOIN
    employees m2 ON m1.manager_id = m2.emp_id
LEFT JOIN
    direct_reports dr ON e.emp_id = dr.manager_id
ORDER BY
    e.emp_id;
```

**Performance Tip:**  
Self-joins can be expensive for large tables as they involve scanning the same table multiple times. Ensure you have an index on the join columns (`emp_id` and `manager_id` in this case). For deep hierarchies (more than a few levels), consider using a recursive Common Table Expression (CTE) instead of multiple self-joins, as it can be more efficient and flexible for traversing hierarchies of arbitrary depth.

## Problem 4.2: Consecutive Day Activity Analysis

**Problem Statement:**  
The product team wants to identify users who have been active for at least 3 consecutive days. This information will be used for a loyalty program. Write a query that returns users who have logged in for at least 3 consecutive days, along with their longest streak.

**Sample Data:**

```
-- user_activity table
user_id | activity_date | activity_type
--------+--------------+--------------
U101    | 2025-04-01   | Login
U101    | 2025-04-02   | Login
U101    | 2025-04-03   | Login
U101    | 2025-04-05   | Login
U102    | 2025-04-01   | Login
U102    | 2025-04-03   | Login
U102    | 2025-04-04   | Login
U103    | 2025-04-01   | Login
U103    | 2025-04-02   | Login
U103    | 2025-04-03   | Login
U103    | 2025-04-04   | Login
U103    | 2025-04-05   | Login
```

**Expected Output:**

```
user_id | longest_streak
--------+---------------
U101    | 3
U103    | 5
```

**SQL Solution:**

```sql
WITH daily_logins AS (
    SELECT DISTINCT
        user_id,
        activity_date
    FROM
        user_activity
    WHERE
        activity_type = 'Login'
    ORDER BY
        user_id,
        activity_date
),
streak_analysis AS (
    SELECT
        a.user_id,
        a.activity_date,
        DATEDIFF(day, 
                LAG(a.activity_date, 1) OVER (PARTITION BY a.user_id ORDER BY a.activity_date),
                a.activity_date) AS days_since_last
    FROM
        daily_logins a
),
streak_groups AS (
    SELECT
        user_id,
        activity_date,
        SUM(CASE WHEN days_since_last = 1 OR days_since_last IS NULL THEN 0 ELSE 1 END) 
        OVER (PARTITION BY user_id ORDER BY activity_date) AS streak_group
    FROM
        streak_analysis
),
streak_lengths AS (
    SELECT
        user_id,
        streak_group,
        COUNT(*) AS streak_length
    FROM
        streak_groups
    GROUP BY
        user_id,
        streak_group
),
max_streaks AS (
    SELECT
        user_id,
        MAX(streak_length) AS longest_streak
    FROM
        streak_lengths
    GROUP BY
        user_id
)
SELECT
    user_id,
    longest_streak
FROM
    max_streaks
WHERE
    longest_streak >= 3
ORDER BY
    user_id;
```

**Performance Tip:**  
This query involves several CTEs and window functions to calculate streaks of consecutive days. For large datasets, consider:

1. Creating an index on `user_id` and `activity_date` to improve the performance of window functions.
2. Pre-filtering the data before applying complex window functions (as done in the `daily_logins` CTE).
3. If streak calculations are performed frequently, consider materializing intermediate results or using specialized time-series functions if your database supports them.

## Problem 4.3: Finding Potential Mentorship Pairs

**Problem Statement:**  
The HR department wants to establish a mentorship program by pairing senior employees with junior employees in the same department. A senior employee should have at least 5 years more experience than their mentee and earn at least 30% more. Write a query that identifies all potential mentor-mentee pairs.

**Sample Data:**

```
-- employees table
emp_id | emp_name      | dept      | hire_date  | salary  | years_experience
-------+---------------+-----------+------------+---------+------------------
101    | John Smith    | Sales     | 2015-03-15 | 95000   | 12
102    | Mary Johnson  | Sales     | 2018-06-20 | 85000   | 8
103    | Bob Brown     | Sales     | 2022-01-10 | 65000   | 3
104    | Alice Lee     | Marketing | 2016-05-05 | 92000   | 10
105    | David Chen    | Marketing | 2019-07-15 | 78000   | 6
106    | Sarah Wilson  | Marketing | 2023-02-01 | 58000   | 2
107    | Michael Davis | IT        | 2017-04-10 | 105000  | 9
108    | Lisa Wang     | IT        | 2020-08-22 | 72000   | 4
```

**Expected Output:**

```
mentor_id | mentor_name   | mentee_id | mentee_name  | dept      | experience_gap | salary_ratio
----------+---------------+-----------+--------------+-----------+----------------+-------------
101       | John Smith    | 103       | Bob Brown    | Sales     | 9              | 1.46
104       | Alice Lee     | 106       | Sarah Wilson | Marketing | 8              | 1.59
107       | Michael Davis | 108       | Lisa Wang    | IT        | 5              | 1.46
```

**SQL Solution:**

```sql
SELECT
    senior.emp_id AS mentor_id,
    senior.emp_name AS mentor_name,
    junior.emp_id AS mentee_id,
    junior.emp_name AS mentee_name,
    senior.dept,
    (senior.years_experience - junior.years_experience) AS experience_gap,
    ROUND(senior.salary / junior.salary, 2) AS salary_ratio
FROM
    employees senior
JOIN
    employees junior ON senior.dept = junior.dept
                     AND senior.emp_id != junior.emp_id
                     AND senior.years_experience >= junior.years_experience + 5
                     AND senior.salary >= junior.salary * 1.3
ORDER BY
    senior.dept,
    experience_gap DESC;
```

**Performance Tip:**  
Self-joins based on multiple conditions can become expensive with large datasets. Consider these optimizations:

1. Create composite indexes on the columns used in the join conditions (`dept`, `years_experience`, and `salary`).
2. Pre-filter potential mentors and mentees into separate CTEs before joining them, which can reduce the number of comparisons needed.
3. If the criteria for mentorship change frequently, consider creating a view that handles the basic filtering, then apply specific criteria in the main query.

# CASE Statements and Conditional Logic

CASE statements allow for conditional logic in SQL queries, enabling you to evaluate conditions and return different values based on those conditions.

## Problem 5.1: Customer Segmentation Analysis

**Problem Statement:**  
The marketing team wants to segment customers based on their purchase behavior. Create a report that categorizes customers into different segments based on their total purchase amount, frequency of purchases, and recency of last purchase. Additionally, assign a priority score to each customer.

**Sample Data:**

```
-- customer_purchases table
customer_id | customer_name   | total_amount | purchase_count | last_purchase_date
------------+----------------+--------------+---------------+-------------------
C101        | Acme Corp      | 25000        | 12            | 2025-04-10
C102        | Better Systems | 15000        | 8             | 2025-03-15
C103        | Cool Tech      | 35000        | 20            | 2025-04-20
C104        | Dynamic Apps   | 5000         | 3             | 2025-01-05
C105        | Easy Solutions | 12000        | 10            | 2025-04-15
C106        | Fast Delivery  | 3000         | 2             | 2024-11-20
C107        | Great Gadgets  | 18000        | 15            | 2025-04-25
```

**Expected Output:**

```
customer_id | customer_name   | monetary_segment | frequency_segment | recency_segment | rfm_score | customer_value
------------+----------------+-----------------+------------------+----------------+----------+----------------
C101        | Acme Corp      | High            | Medium           | Recent         | 9         | High Value
C102        | Better Systems | Medium          | Medium           | Recent         | 7         | Medium Value
C103        | Cool Tech      | High            | High             | Recent         | 11        | High Value
C104        | Dynamic Apps   | Low             | Low              | Moderate       | 3         | Low Value
C105        | Easy Solutions | Medium          | Medium           | Recent         | 7         | Medium Value
C106        | Fast Delivery  | Low             | Low              | Inactive       | 1         | At Risk
C107        | Great Gadgets  | Medium          | High             | Recent         | 9         | High Value
```

**SQL Solution:**

```sql
SELECT
    customer_id,
    customer_name,
    CASE
        WHEN total_amount >= 20000 THEN 'High'
        WHEN total_amount >= 10000 THEN 'Medium'
        ELSE 'Low'
    END AS monetary_segment,
    CASE
        WHEN purchase_count >= 16 THEN 'High'
        WHEN purchase_count >= 8 THEN 'Medium'
        ELSE 'Low'
    END AS frequency_segment,
    CASE
        WHEN last_purchase_date >= CURRENT_DATE - INTERVAL '30 day' THEN 'Recent'
        WHEN last_purchase_date >= CURRENT_DATE - INTERVAL '90 day' THEN 'Moderate'
        ELSE 'Inactive'
    END AS recency_segment,
    (CASE
        WHEN total_amount >= 20000 THEN 5
        WHEN total_amount >= 10000 THEN 3
        ELSE 1
    END +
    CASE
        WHEN purchase_count >= 16 THEN 5
        WHEN purchase_count >= 8 THEN 3
        ELSE 1
    END +
    CASE
        WHEN last_purchase_date >= CURRENT_DATE - INTERVAL '30 day' THEN 5
        WHEN last_purchase_date >= CURRENT_DATE - INTERVAL '90 day' THEN 3
        ELSE 1
    END) AS rfm_score,
    CASE
        WHEN (CASE
                WHEN total_amount >= 20000 THEN 5
                WHEN total_amount >= 10000 THEN 3
                ELSE 1
              END +
              CASE
                WHEN purchase_count >= 16 THEN 5
                WHEN purchase_count >= 8 THEN 3
                ELSE 1
              END +
              CASE
                WHEN last_purchase_date >= CURRENT_DATE - INTERVAL '30 day' THEN 5
                WHEN last_purchase_date >= CURRENT_DATE - INTERVAL '90 day' THEN 3
                ELSE 1
              END) >= 9 THEN 'High Value'
        WHEN (CASE
                WHEN total_amount >= 20000 THEN 5
                WHEN total_amount >= 10000 THEN 3
                ELSE 1
              END +
              CASE
                WHEN purchase_count >= 16 THEN 5
                WHEN purchase_count >= 8 THEN 3
                ELSE 1
              END +
              CASE
                WHEN last_purchase_date >= CURRENT_DATE - INTERVAL '30 day' THEN 5
                WHEN last_purchase_date >= CURRENT_DATE - INTERVAL '90 day' THEN 3
                ELSE 1
              END) >= 5 THEN 'Medium Value'
        WHEN last_purchase_date < CURRENT_DATE - INTERVAL '90 day' THEN 'At Risk'
        ELSE 'Low Value'
    END AS customer_value
FROM
    customer_purchases
ORDER BY
    rfm_score DESC;
```

**Performance Tip:**  
The query includes multiple CASE statements with repeated calculations. For better performance and readability, you can:

1. Use a CTE to calculate the individual segment scores once and then reference them
2. Create a view for regularly needed segmentation calculations
3. For very large datasets, consider materializing the segmentation results periodically rather than calculating them on the fly

## Problem 5.2: Order Fulfillment Analysis

**Problem Statement:**  
The operations team wants to analyze the efficiency of the order fulfillment process. Calculate the fulfillment time for each order and categorize it based on predefined SLAs. Also, identify factors that might be affecting fulfillment times, such as order size, shipping method, and product category.

**Sample Data:**

```
-- orders table
order_id | customer_id | order_date  | ship_date   | items_count | total_amount | shipping_method | product_category
---------+-------------+-------------+-------------+-------------+--------------+-----------------+------------------
10001    | C101        | 2025-04-01  | 2025-04-03  | 5           | 1200         | Express         | Electronics
10002    | C102        | 2025-04-02  | 2025-04-05  | 2           | 350          | Standard        | Clothing
10003    | C103        | 2025-04-02  | 2025-04-03  | 1           | 800          | Express         | Electronics
10004    | C104        | 2025-04-03  | 2025-04-07  | 8           | 2500         | Standard        | Furniture
10005    | C105        | 2025-04-05  | 2025-04-06  | 3           | 600          | Express         | Books
10006    | C106        | 2025-04-05  | 2025-04-10  | 10          | 3000         | Standard        | Furniture
10007    | C107        | 2025-04-06  | 2025-04-08  | 4           | 950          | Express         | Electronics
```

**Expected Output:**

```
order_id | fulfillment_days | sla_category | size_category | shipping_impact | sla_status
---------+-----------------+--------------+---------------+-----------------+------------
10001    | 2               | Fast         | Medium        | -1              | Met
10002    | 3               | Standard     | Small         | 0               | Met
10003    | 1               | Fast         | Small         | -1              | Met
10004    | 4               | Standard     | Large         | 0               | Not Met
10005    | 1               | Fast         | Small         | -1              | Met
10006    | 5               | Standard     | Large         | 0               | Not Met
10007    | 2               | Fast         | Medium        | -1              | Met
```

**SQL Solution:**

```sql
SELECT
    order_id,
    DATEDIFF(day, order_date, ship_date) AS fulfillment_days,
    CASE
        WHEN shipping_method = 'Express' THEN 'Fast'
        ELSE 'Standard'
    END AS sla_category,
    CASE
        WHEN items_count <= 2 THEN 'Small'
        WHEN items_count <= 5 THEN 'Medium'
        ELSE 'Large'
    END AS size_category,
    CASE
        WHEN shipping_method = 'Express' THEN -1
        WHEN product_category = 'Furniture' THEN 2
        ELSE 0
    END AS shipping_impact,
    CASE
        WHEN (shipping_method = 'Express' AND DATEDIFF(day, order_date, ship_date) <= 2) OR
             (shipping_method = 'Standard' AND product_category != 'Furniture' AND DATEDIFF(day, order_date, ship_date) <= 3) OR
             (shipping_method = 'Standard' AND product_category = 'Furniture' AND DATEDIFF(day, order_date, ship_date) <= 4)
        THEN 'Met'
        ELSE 'Not Met'
    END AS sla_status
FROM
    orders
ORDER BY
    order_id;
```

**Performance Tip:**  
When using multiple CASE expressions that reference the same columns repeatedly, the database may need to evaluate these expressions for each row. For better performance:

1. Use a CTE or subquery to calculate derived values once (like fulfillment_days)
2. Create indexes on columns used in CASE expressions if they are filtered on frequently
3. Consider precalculating SLA status and other derived metrics during ETL or in materialized views if these queries run frequently

## Problem 5.3: Sales Performance Scoring

**Problem Statement:**  
The sales management team wants a comprehensive scoring system to evaluate sales representatives' performance. Create a scoring model that takes into account revenue generated, deal count, average deal size, conversion rate, and deal cycle time. Each metric should contribute to a total performance score.

**Sample Data:**

```
-- sales_rep_performance table
rep_id | rep_name     | revenue  | deal_count | deals_won | deal_opportunities | avg_cycle_days
-------+--------------+----------+------------+-----------+--------------------+---------------
SR001  | Alice Smith  | 520000   | 45         | 38        | 65                 | 28
SR002  | Bob Johnson  | 350000   | 30         | 22        | 40                 | 35
SR003  | Carol Davis  | 720000   | 55         | 44        | 70                 | 25
SR004  | Dave Wilson  | 280000   | 25         | 18        | 35                 | 42
SR005  | Eve Brown    | 490000   | 42         | 35        | 50                 | 30
```

**Expected Output:**

```
rep_id | rep_name     | revenue_score | volume_score | size_score | conversion_score | speed_score | total_score | performance_category
-------+--------------+---------------+--------------+------------+------------------+-------------+-------------+----------------------
SR001  | Alice Smith  | 7             | 8            | 7          | 8                | 8           | 38          | High Performer
SR002  | Bob Johnson  | 5             | 5            | 7          | 8                | 5           | 30          | Average Performer
SR003  | Carol Davis  | 10            | 10           | 8          | 8                | 9           | 45          | Top Performer
SR004  | Dave Wilson  | 3             | 3            | 7          | 7                | 3           | 23          | Low Performer
SR005  | Eve Brown    | 7             | 7            | 7          | 9                | 7           | 37          | High Performer
```

**SQL Solution:**

```sql
WITH performance_metrics AS (
    SELECT
        rep_id,
        rep_name,
        revenue,
        deal_count,
        ROUND(revenue / NULLIF(deal_count, 0), 2) AS avg_deal_size,
        ROUND((deals_won::FLOAT / NULLIF(deal_opportunities, 0)) * 100, 1) AS conversion_rate,
        avg_cycle_days
    FROM
        sales_rep_performance
),
score_calculation AS (
    SELECT
        p.*,
        CASE
            WHEN revenue >= 700000 THEN 10
            WHEN revenue >= 500000 THEN 7
            WHEN revenue >= 300000 THEN 5
            ELSE 3
        END AS revenue_score,
        CASE
            WHEN deal_count >= 50 THEN 10
            WHEN deal_count >= 40 THEN 8
            WHEN deal_count >= 30 THEN 5
            ELSE 3
        END AS volume_score,
        CASE
            WHEN avg_deal_size >= 15000 THEN 10
            WHEN avg_deal_size >= 12000 THEN 8
            WHEN avg_deal_size >= 10000 THEN 7
            ELSE 5
        END AS size_score,
        CASE
            WHEN conversion_rate >= 70 THEN 10
            WHEN conversion_rate >= 60 THEN 8
            WHEN conversion_rate >= 50 THEN 7
            ELSE 5
        END AS conversion_score,
        CASE
            WHEN avg_cycle_days <= 25 THEN 10
            WHEN avg_cycle_days <= 30 THEN 8
            WHEN avg_cycle_days <= 35 THEN 5
            ELSE 3
        END AS speed_score
    FROM
        performance_metrics p
)
SELECT
    rep_id,
    rep_name,
    revenue_score,
    volume_score,
    size_score,
    conversion_score,
    speed_score,
    (revenue_score + volume_score + size_score + conversion_score + speed_score) AS total_score,
    CASE
        WHEN (revenue_score + volume_score + size_score + conversion_score + speed_score) >= 40 THEN 'Top Performer'
        WHEN (revenue_score + volume_score + size_score + conversion_score + speed_score) >= 35 THEN 'High Performer'
        WHEN (revenue_score + volume_score + size_score + conversion_score + speed_score) >= 25 THEN 'Average Performer'
        ELSE 'Low Performer'
    END AS performance_category
FROM
    score_calculation
ORDER BY
    total_score DESC;
```

**Performance Tip:**  
This query uses a CTE approach to calculate scores in stages, which improves readability and performance. For large datasets:

1. Break the calculation into logical stages, as shown with the CTEs, to help the optimizer
2. Consider materializing frequently accessed scoring components
3. For systems with many rows, you might want to use numeric ranges rather than multiple discrete CASE statements, which some databases can optimize better
4. If the scoring rubric changes frequently, consider storing the scoring rules in reference tables rather than hard-coding them in CASE statements

# Date and Time Functions

Date and time functions help analyze time-based data, calculate durations, extract date parts, and perform date arithmetic.

## Problem 6.1: Sales Seasonality Analysis

**Problem Statement:**  
The marketing team wants to analyze seasonal patterns in sales data to optimize advertising campaigns. Analyze sales data to identify seasonal trends by quarter, month, day of week, and hour of day. Calculate year-over-year and month-over-month growth rates.

**Sample Data:**

```
-- sales table
sale_id | product_id | sale_amount | sale_timestamp
--------+------------+-------------+-------------------------
1001    | P101       | 1200.50     | 2025-01-15 14:30:25
1002    | P102       | 850.75      | 2025-01-20 10:15:10
1003    | P101       | 1250.00     | 2025-02-05 16:45:30
1004    | P103       | 450.25      | 2025-02-10 09:20:15
1005    | P102       | 900.00      | 2025-03-03 13:10:45
1006    | P101       | 1300.50     | 2025-03-18 11:05:20
1007    | P103       | 500.75      | 2025-04-02 15:30:00
1008    | P101       | 1275.25     | 2024-01-12 14:45:35
1009    | P102       | 825.50      | 2024-02-08 10:30:15
1010    | P103       | 425.00      | 2024-03-17 13:25:40
```

**Expected Output:**

```
time_period   | period_type | sales_2024 | sales_2025 | yoy_growth | sales_count | avg_sale
--------------+-------------+------------+------------+------------+-------------+----------
Q1            | Quarter     | 1250.50    | 5551.50    | 344.02%    | 7           | 793.07
January       | Month       | 1275.25    | 2051.25    | 60.85%     | 3           | 1108.83
February      | Month       | 825.50     | 1700.25    | 105.97%    | 3           | 841.92
March         | Month       | 425.00     | 2200.50    | 417.76%    | 3           | 875.17
Monday        | WeekDay     | 0.00       | 900.00     | NULL       | 1           | 900.00
Tuesday       | WeekDay     | 0.00       | 500.75     | NULL       | 1           | 500.75
Wednesday     | WeekDay     | 825.50     | 0.00       | -100.00%   | 1           | 825.50
Thursday      | WeekDay     | 0.00       | 0.00       | NULL       | 0           | NULL
Friday        | WeekDay     | 425.00     | 0.00       | -100.00%   | 1           | 425.00
```

**SQL Solution:**

```sql
-- Quarter analysis
WITH quarterly_sales AS (
    SELECT
        'Q' || EXTRACT(QUARTER FROM sale_timestamp) AS time_period,
        'Quarter' AS period_type,
        EXTRACT(YEAR FROM sale_timestamp) AS sale_year,
        SUM(sale_amount) AS total_sales,
        COUNT(*) AS sale_count
    FROM
        sales
    WHERE
        EXTRACT(YEAR FROM sale_timestamp) IN (2024, 2025)
    GROUP BY
        EXTRACT(QUARTER FROM sale_timestamp),
        EXTRACT(YEAR FROM sale_timestamp)
),
-- Month analysis
monthly_sales AS (
    SELECT
        TO_CHAR(sale_timestamp, 'Month') AS time_period,
        'Month' AS period_type,
        EXTRACT(YEAR FROM sale_timestamp) AS sale_year,
        SUM(sale_amount) AS total_sales,
        COUNT(*) AS sale_count
    FROM
        sales
    WHERE
        EXTRACT(YEAR FROM sale_timestamp) IN (2024, 2025)
    GROUP BY
        TO_CHAR(sale_timestamp, 'Month'),
        EXTRACT(YEAR FROM sale_timestamp)
),
-- Day of week analysis
weekday_sales AS (
    SELECT
        TO_CHAR(sale_timestamp, 'Day') AS time_period,
        'WeekDay' AS period_type,
        EXTRACT(YEAR FROM sale_timestamp) AS sale_year,
        SUM(sale_amount) AS total_sales,
        COUNT(*) AS sale_count
    FROM
        sales
    WHERE
        EXTRACT(YEAR FROM sale_timestamp) IN (2024, 2025)
    GROUP BY
        TO_CHAR(sale_timestamp, 'Day'),
        EXTRACT(YEAR FROM sale_timestamp)
),
-- Combine all time period analyses
combined_sales AS (
    SELECT * FROM quarterly_sales
    UNION ALL
    SELECT * FROM monthly_sales
    UNION ALL
    SELECT * FROM weekday_sales
),
-- Pivot the data to show 2024 and 2025 side by side
pivoted_sales AS (
    SELECT
        time_period,
        period_type,
        MAX(CASE WHEN sale_year = 2024 THEN total_sales ELSE 0 END) AS sales_2024,
        MAX(CASE WHEN sale_year = 2025 THEN total_sales ELSE 0 END) AS sales_2025,
        SUM(sale_count) AS sales_count,
        SUM(total_sales) / SUM(sale_count) AS avg_sale
    FROM
        combined_sales
    GROUP BY
        time_period,
        period_type
)
SELECT
    time_period,
    period_type,
    ROUND(sales_2024, 2) AS sales_2024,
    ROUND(sales_2025, 2) AS sales_2025,
    CASE
        WHEN sales_2024 = 0 THEN NULL
        ELSE ROUND(((sales_2025 - sales_2024) / sales_2024) * 100, 2) || '%'
    END AS yoy_growth,
    sales_count,
    ROUND(avg_sale, 2) AS avg_sale
FROM
    pivoted_sales
ORDER BY
    period_type,
    time_period;
```

**Performance Tip:**  
Date and time functions can be computation-intensive, especially when extracting multiple components from timestamps in large datasets. To optimize performance:

1. Consider creating a date dimension table with pre-calculated date components (year, quarter, month, day of week) to join with rather than calculating them on-the-fly.
2. Use appropriate indexes on timestamp columns.
3. When analyzing large volumes of time-series data, consider pre-aggregating data at different time granularities (e.g., daily, weekly, monthly summaries).
4. Some databases have specialized functions for date/time calculations that may be more efficient than generic extraction methods.

## Problem 6.2: Customer Engagement Analysis

**Problem Statement:**  
The product team wants to analyze customer engagement patterns over time. Calculate user session metrics including session duration, time between sessions, and identify users with declining engagement (decreasing session frequency or duration).

**Sample Data:**

```
-- user_sessions table
user_id | session_id | session_start         | session_end
--------+------------+------------------------+------------------------
U101    | S1001      | 2025-04-01 10:00:00   | 2025-04-01 10:45:30
U101    | S1002      | 2025-04-03 14:20:15   | 2025-04-03 15:10:45
U101    | S1003      | 2025-04-08 09:30:00   | 2025-04-08 09:50:15
U102    | S1004      | 2025-04-02 13:15:30   | 2025-04-02 14:00:45
U102    | S1005      | 2025-04-07 16:45:00   | 2025-04-07 17:30:20
U103    | S1006      | 2025-04-01 08:00:00   | 2025-04-01 08:10:30
U103    | S1007      | 2025-04-02 08:05:15   | 2025-04-02 08:12:45
U103    | S1008      | 2025-04-03 07:55:00   | 2025-04-03 08:15:30
U103    | S1009      | 2025-04-05 09:10:45   | 2025-04-05 09:35:15
```

**Expected Output:**

```
user_id | total_sessions | avg_session_mins | avg_days_between | engagement_trend
--------+----------------+------------------+------------------+-----------------
U101    | 3              | 29.0             | 3.5              | Declining
U102    | 2              | 45.2             | 5.0              | Stable
U103    | 4              | 16.7             | 1.3              | Improving
```

**SQL Solution:**

```sql
WITH session_metrics AS (
    SELECT
        user_id,
        session_id,
        session_start,
        session_end,
        EXTRACT(EPOCH FROM (session_end - session_start)) / 60 AS session_minutes,
        LAG(session_start) OVER (PARTITION BY user_id ORDER BY session_start) AS prev_session,
        LEAD(session_start) OVER (PARTITION BY user_id ORDER BY session_start) AS next_session
    FROM
        user_sessions
),
user_metrics AS (
    SELECT
        user_id,
        COUNT(*) AS total_sessions,
        AVG(session_minutes) AS avg_session_mins,
        AVG(EXTRACT(DAY FROM (session_start - prev_session))) AS avg_days_between
    FROM
        session_metrics
    GROUP BY
        user_id
),
trend_analysis AS (
    SELECT
        sm.user_id,
        CORR(
            EXTRACT(EPOCH FROM (sm.session_end - sm.session_start)),
            ROW_NUMBER() OVER (PARTITION BY sm.user_id ORDER BY sm.session_start)
        ) AS duration_trend,
        CASE
            WHEN COUNT(*) > 2 THEN
                CORR(
                    EXTRACT(EPOCH FROM (sm.session_start - sm.prev_session)),
                    ROW_NUMBER() OVER (PARTITION BY sm.user_id ORDER BY sm.session_start)
                )
            ELSE NULL
        END AS frequency_trend
    FROM
        session_metrics sm
    WHERE
        sm.prev_session IS NOT NULL
    GROUP BY
        sm.user_id
)
SELECT
    um.user_id,
    um.total_sessions,
    ROUND(um.avg_session_mins, 1) AS avg_session_mins,
    ROUND(um.avg_days_between, 1) AS avg_days_between,
    CASE
        WHEN ta.duration_trend < -0.5 OR ta.frequency_trend > 0.5 THEN 'Declining'
        WHEN ta.duration_trend > 0.5 OR ta.frequency_trend < -0.5 THEN 'Improving'
        ELSE 'Stable'
    END AS engagement_trend
FROM
    user_metrics um
LEFT JOIN
    trend_analysis ta ON um.user_id = ta.user_id
ORDER BY
    um.user_id;
```

**Performance Tip:**  
This query uses window functions to calculate metrics like session duration trends and time between sessions, which can be resource-intensive on large datasets. Consider these optimizations:

1. If analyzing a large volume of session data, pre-aggregate metrics at the user level and store them in a summary table that's updated periodically.
2. Create indexes on `user_id` and `session_start` to improve window function performance.
3. For very large datasets, consider analyzing data in batches (e.g., one month at a time) to reduce memory requirements.
4. Statistical functions like CORR() can be computationally expensive; consider using simpler trend indicators for very large datasets.

## Problem 6.3: Subscription Churn Prediction

**Problem Statement:**  
The customer success team wants to identify users at risk of churning from a subscription service. Analyze user activity patterns and identify subscribers who exhibit potential churn indicators such as declining usage frequency, shortened session lengths, or approaching subscription renewal dates without recent activity.

**Sample Data:**

```
-- subscribers table
user_id | plan_type | signup_date | renewal_date | monthly_fee
--------+-----------+-------------+--------------+-------------
U101    | Premium   | 2024-10-15  | 2025-05-15   | 29.99
U102    | Basic     | 2024-12-20  | 2025-05-20   | 9.99
U103    | Premium   | 2025-01-10  | 2025-05-10   | 29.99
U104    | Pro       | 2025-02-05  | 2025-05-05   | 19.99
U105    | Basic     | 2025-02-22  | 2025-05-22   | 9.99

-- user_activity table
user_id | activity_date | activity_type | activity_duration
--------+--------------+--------------+-------------------
U101    | 2025-04-02   | Streaming    | 120
U101    | 2025-04-10   | Streaming    | 85
U101    | 2025-04-25   | Browsing     | 15
U102    | 2025-04-05   | Streaming    | 45
U102    | 2025-04-22   | Browsing     | 10
U103    | 2025-03-15   | Streaming    | 150
U103    | 2025-03-30   | Streaming    | 95
U104    | 2025-04-01   | Browsing     | 20
U104    | 2025-04-12   | Streaming    | 65
U104    | 2025-04-28   | Streaming    | 75
U105    | 2025-03-10   | Streaming    | 30
```

**Expected Output:**

```
user_id | days_to_renewal | last_activity | days_since_active | activity_count | churn_risk | risk_factors
--------+-----------------+---------------+-------------------+----------------+------------+------------------
U101    | 13              | 2025-04-25    | 7                 | 3              | Low        | NULL
U102    | 18              | 2025-04-22    | 10                | 2              | Medium     | Infrequent Usage
U103    | 8               | 2025-03-30    | 33                | 2              | High       | Activity Gap, Renewal Soon
U104    | 3               | 2025-04-28    | 4                 | 3              | Low        | Renewal Soon
U105    | 20              | 2025-03-10    | 53                | 1              | High       | Activity Gap, Low Usage
```

**SQL Solution:**

```sql
WITH activity_metrics AS (
    SELECT
        user_id,
        MAX(activity_date) AS last_activity,
        COUNT(*) AS activity_count,
        AVG(activity_duration) AS avg_duration,
        DATEDIFF(day, MIN(activity_date), MAX(activity_date)) AS activity_span,
        COUNT(DISTINCT activity_date) AS active_days
    FROM
        user_activity
    GROUP BY
        user_id
)
SELECT
    s.user_id,
    DATEDIFF(day, CURRENT_DATE, s.renewal_date) AS days_to_renewal,
    a.last_activity,
    DATEDIFF(day, a.last_activity, CURRENT_DATE) AS days_since_active,
    a.activity_count,
    CASE
        WHEN DATEDIFF(day, a.last_activity, CURRENT_DATE) > 30 AND DATEDIFF(day, CURRENT_DATE, s.renewal_date) < 14 THEN 'High'
        WHEN DATEDIFF(day, a.last_activity, CURRENT_DATE) > 20 OR a.activity_count < 2 THEN 'Medium'
        ELSE 'Low'
    END AS churn_risk,
    CASE
        WHEN DATEDIFF(day, a.last_activity, CURRENT_DATE) > 30 THEN 
            CASE
                WHEN DATEDIFF(day, CURRENT_DATE, s.renewal_date) < 14 THEN 'Activity Gap, Renewal Soon'
                ELSE 'Activity Gap'
            END
        WHEN a.activity_count < 2 THEN 
            CASE
                WHEN DATEDIFF(day, CURRENT_DATE, s.renewal_date) < 14 THEN 'Low Usage, Renewal Soon'
                ELSE 'Low Usage'
            END
        WHEN DATEDIFF(day, CURRENT_DATE, s.renewal_date) < 14 AND DATEDIFF(day, a.last_activity, CURRENT_DATE) > 7 THEN 'Renewal Soon'
        WHEN a.activity_count < 3 AND a.avg_duration < 60 THEN 'Infrequent Usage'
        ELSE NULL
    END AS risk_factors
FROM
    subscribers s
LEFT JOIN
    activity_metrics a ON s.user_id = a.user_id
ORDER BY
    s.user_id;
```

**Performance Tip:**  
This query involves multiple date calculations and conditional logic. To optimize performance:

1. Create indexes on the date columns used in calculations (`activity_date`, `renewal_date`).
2. For large datasets, consider pre-aggregating activity metrics on a daily or weekly basis.
3. The nested CASE expressions can be complex for the query optimizer. If possible, simplify the logic or break it into multiple steps using CTEs.
4. Consider materializing the activity metrics for users in a separate table that's updated daily, which can significantly improve performance for large datasets.
5. If the churn prediction is run as a batch process, consider partitioning the tables by date ranges to limit the amount of data that needs to be processed.

# String Functions

String functions manipulate and analyze text data, allowing for tasks like parsing, extraction, transformation, and pattern matching.

## Problem 7.1: Customer Email Domain Analysis

**Problem Statement:**  
The marketing team wants to analyze customer email domains to better understand where their customers are coming from. Create a report that extracts email domains, categorizes them (personal vs. business), identifies the most common domains, and flags potential duplicates based on similar email usernames.

**Sample Data:**

```
-- customers table
customer_id | customer_name   | email                        | signup_date | country
------------+----------------+------------------------------+-------------+---------
C101        | John Smith      | john.smith@gmail.com         | 2025-01-15  | US
C102        | Mary Johnson    | mary.johnson@company.co.uk   | 2025-01-20  | UK
C103        | Bob Brown       | bob.brown23@gmail.com        | 2025-02-05  | US
C104        | Alice Lee       | alice@smallbusiness.org      | 2025-02-10  | CA
C105        | David Chen      | david.chen@outlook.com       | 2025-03-03  | US
C106        | Sarah Wilson    | s.wilson@company.co.uk       | 2025-03-18  | UK
C107        | Michael Davis   | mdavis@university.edu        | 2025-04-02  | US
C108        | Lisa Wang       | l.wang@gmail.com             | 2025-04-10  | CA
C109        | James Taylor    | jtaylor@university.edu       | 2025-04-15  | US
C110        | Emily Brown     | emily.b@outlook.com          | 2025-04-22  | UK
```

**Expected Output:**

```
domain            | domain_type | user_count | countries         | top_tld | potential_duplicates
------------------+-------------+------------+-------------------+---------+---------------------
gmail.com         | Personal    | 3          | US, CA            | com     | No
company.co.uk     | Business    | 2          | UK                | co.uk   | No
outlook.com       | Personal    | 2          | US, UK            | com     | No
university.edu    | Business    | 2          | US                | edu     | No
smallbusiness.org | Business    | 1          | CA                | org     | No
```

**SQL Solution:**

```sql
WITH email_analysis AS (
    SELECT
        customer_id,
        email,
        LOWER(SUBSTRING(email FROM POSITION('@' IN email) + 1)) AS domain,
        LOWER(SUBSTRING(email FROM 1 FOR POSITION('@' IN email) - 1)) AS username,
        country
    FROM
        customers
),
domain_categorization AS (
    SELECT
        domain,
        CASE
            WHEN domain LIKE '%company%' OR 
                 domain LIKE '%university%' OR 
                 domain LIKE '%business%' OR
                 domain LIKE '%.edu' OR
                 domain LIKE '%.org' OR
                 domain LIKE '%.gov' THEN 'Business'
            ELSE 'Personal'
        END AS domain_type,
        COUNT(*) AS user_count,
        STRING_AGG(DISTINCT country, ', ' ORDER BY country) AS countries,
        SUBSTRING(domain FROM POSITION('.' IN domain) + 1) AS tld
    FROM
        email_analysis
    GROUP BY
        domain,
        CASE
            WHEN domain LIKE '%company%' OR 
                 domain LIKE '%university%' OR 
                 domain LIKE '%business%' OR
                 domain LIKE '%.edu' OR
                 domain LIKE '%.org' OR
                 domain LIKE '%.gov' THEN 'Business'
            ELSE 'Personal'
        END,
        SUBSTRING(domain FROM POSITION('.' IN domain) + 1)
),
username_similarity AS (
    SELECT
        e1.domain,
        CASE
            WHEN EXISTS (
                SELECT 1
                FROM email_analysis e2
                WHERE e1.domain = e2.domain
                  AND e1.customer_id != e2.customer_id
                  AND (
                      -- Similar usernames based on Levenshtein distance
                      LEVENSHTEIN(e1.username, e2.username) <= 2
                      -- Or same name with different formatting/numbers
                      OR REGEXP_REPLACE(e1.username, '[^a-zA-Z]', '', 'g') = 
                         REGEXP_REPLACE(e2.username, '[^a-zA-Z]', '', 'g')
                  )
            ) THEN 'Yes'
            ELSE 'No'
        END AS has_similar_usernames
    FROM
        email_analysis e1
    GROUP BY
        e1.domain
)
SELECT
    dc.domain,
    dc.domain_type,
    dc.user_count,
    dc.countries,
    dc.tld AS top_tld,
    us.has_similar_usernames AS potential_duplicates
FROM
    domain_categorization dc
JOIN
    username_similarity us ON dc.domain = us.domain
ORDER BY
    dc.user_count DESC,
    dc.domain;
```

**Performance Tip:**  
String functions and pattern matching can be computationally expensive, especially for large datasets. To optimize performance:

1. Create indexes on frequently queried text columns, but be aware that full-text indexes might be necessary for complex pattern matching.
2. The Levenshtein distance calculation used for detecting similar usernames is particularly costly. For large datasets, consider:
   - Pre-filtering candidates (e.g., only compare usernames that start with the same letter)
   - Using a more efficient similarity algorithm
   - Running similarity checks as a batch process rather than inline
3. Consider using materialized views or pre-calculated tables if these analyses are run frequently.
4. Some databases offer specialized text search capabilities that are more efficient than using LIKE or regular expressions.

## Problem 7.2: Product Review Sentiment Analysis

**Problem Statement:**  
The product team wants to analyze customer reviews to understand sentiment trends. Extract key metrics from review text, categorize reviews by sentiment, and identify common themes or keywords in positive and negative reviews.

**Sample Data:**

```
-- product_reviews table
review_id | product_id | customer_id | review_date | rating | review_text
----------+------------+-------------+-------------+--------+-------------------------------------------------------
R101      | P001       | C103        | 2025-03-15  | 4      | I really like this product. Easy to use and reliable.
R102      | P001       | C105        | 2025-03-20  | 2      | Disappointed with quality. Broke after just one month.
R103      | P002       | C101        | 2025-03-22  | 5      | Excellent product! Works perfectly and fast delivery.
R104      | P002       | C108        | 2025-03-25  | 3      | It's okay but a bit expensive for what you get.
R105      | P003       | C104        | 2025-03-30  | 1      | Terrible! Don't waste your money. Customer service was unhelpful.
R106      | P001       | C107        | 2025-04-02  | 5      | Great product, easy setup. Very happy with my purchase.
R107      | P003       | C102        | 2025-04-05  | 4      | Good value for money. Would recommend to others.
R108      | P002       | C106        | 2025-04-10  | 2      | Not intuitive to use. Instructions were confusing.
```

**Expected Output:**

```
product_id | avg_rating | review_count | positive_pct | negative_pct | common_positive_terms         | common_negative_terms
-----------+------------+--------------+-------------+-------------+------------------------------+-------------------------
P001       | 3.67       | 3            | 66.7%       | 33.3%       | easy, great                   | disappointed, broke
P002       | 3.33       | 3            | 33.3%       | 33.3%       | excellent, perfect            | expensive, confusing
P003       | 2.50       | 2            | 50.0%       | 50.0%       | good, recommend               | terrible, waste
```

**SQL Solution:**

```sql
WITH sentiment_analysis AS (
    SELECT
        product_id,
        review_id,
        rating,
        review_text,
        CASE
            WHEN rating >= 4 THEN 'Positive'
            WHEN rating = 3 THEN 'Neutral'
            ELSE 'Negative'
        END AS sentiment,
        REGEXP_SPLIT_TO_TABLE(
            LOWER(REGEXP_REPLACE(review_text, '[^a-zA-Z ]', ' ', 'g')),
            '\s+'
        ) AS word
    FROM
        product_reviews
),
word_sentiment AS (
    SELECT
        product_id,
        sentiment,
        word,
        COUNT(*) AS word_count
    FROM
        sentiment_analysis
    WHERE
        LENGTH(word) > 3
        AND word NOT IN ('this', 'that', 'with', 'your', 'would', 'very', 'from', 'have', 'what')
    GROUP BY
        product_id,
        sentiment,
        word
),
top_words AS (
    SELECT
        product_id,
        sentiment,
        STRING_AGG(word, ', ' ORDER BY word_count DESC) FILTER (WHERE ROW_NUMBER() OVER (PARTITION BY product_id, sentiment ORDER BY word_count DESC) <= 2) AS top_terms
    FROM
        word_sentiment
    GROUP BY
        product_id,
        sentiment
),
product_metrics AS (
    SELECT
        product_id,
        AVG(rating) AS avg_rating,
        COUNT(*) AS review_count,
        ROUND(COUNT(*) FILTER (WHERE rating >= 4) * 100.0 / COUNT(*), 1) || '%' AS positive_pct,
        ROUND(COUNT(*) FILTER (WHERE rating <= 2) * 100.0 / COUNT(*), 1) || '%' AS negative_pct
    FROM
        product_reviews
    GROUP BY
        product_id
)
SELECT
    pm.product_id,
    ROUND(pm.avg_rating, 2) AS avg_rating,
    pm.review_count,
    pm.positive_pct,
    pm.negative_pct,
    MAX(CASE WHEN tw.sentiment = 'Positive' THEN tw.top_terms END) AS common_positive_terms,
    MAX(CASE WHEN tw.sentiment = 'Negative' THEN tw.top_terms END) AS common_negative_terms
FROM
    product_metrics pm
LEFT JOIN
    top_words tw ON pm.product_id = tw.product_id
GROUP BY
    pm.product_id,
    pm.avg_rating,
    pm.review_count,
    pm.positive_pct,
    pm.negative_pct
ORDER BY
    pm.product_id;
```

**Performance Tip:**  
Text analysis is computationally intensive, especially when working with large volumes of reviews. Consider these optimizations:

1. Text tokenization (splitting text into words) is expensive. Consider using pre-built text analysis functions if your database supports them.
2. For large text datasets, consider using specialized text analysis tools outside the database and then importing the results.
3. The regular expression operations can be costly. If possible, simplify them or process text in batches.
4. For frequent sentiment analysis, consider storing pre-calculated sentiment scores and keywords in materialized views.
5. Some databases offer specialized text search and analysis extensions that are more efficient than using standard SQL functions.

## Problem 7.3: Log File Analysis

**Problem Statement:**  
The IT team needs to analyze application log files to identify errors and performance issues. Parse the log data to extract timestamps, error types, and affected components. Generate a report showing error trends and most frequent error messages.

**Sample Data:**

```
-- application_logs table
log_id | log_timestamp          | log_level | log_message
-------+------------------------+-----------+--------------------------------------------------------------
L001   | 2025-04-01 09:15:30    | INFO      | Application started successfully [component=auth]
L002   | 2025-04-01 09:20:45    | ERROR     | Database connection failed [component=db]: Timeout after 30s
L003   | 2025-04-01 09:25:10    | INFO      | User login successful [component=auth][user_id=U103]
L004   | 2025-04-01 10:05:22    | WARNING   | Slow query detected [component=db]: Query took 2.5s
L005   | 2025-04-01 10:30:15    | ERROR     | API rate limit exceeded [component=api]: Too many requests
L006   | 2025-04-01 11:45:30    | INFO      | Cache refreshed [component=cache]
L007   | 2025-04-01 12:10:45    | ERROR     | Authentication failed [component=auth]: Invalid credentials
L008   | 2025-04-01 13:25:20    | WARNING   | Low memory warning [component=system]: 85% usage
L009   | 2025-04-01 14:05:10    | INFO      | Scheduled task completed [component=scheduler]
L010   | 2025-04-01 14:30:55    | ERROR     | File not found [component=storage]: Missing data file
```

**Expected Output:**

```
component | error_count | warning_count | info_count | most_common_error           | avg_time_between_errors
----------+-------------+---------------+------------+-----------------------------+------------------------
auth      | 1           | 0             | 2          | Authentication failed       | NULL
db        | 1           | 1             | 0          | Database connection failed  | NULL
api       | 1           | 0             | 0          | API rate limit exceeded     | NULL
system    | 0           | 1             | 0          | NULL                        | NULL
cache     | 0           | 0             | 1          | NULL                        | NULL
scheduler | 0           | 0             | 1          | NULL                        | NULL
storage   | 1           | 0             | 0          | File not found              | NULL
```

**SQL Solution:**

```sql
WITH parsed_logs AS (
    SELECT
        log_id,
        log_timestamp,
        log_level,
        log_message,
        SUBSTRING(log_message FROM '\[component=([^\]]+)\]') AS component,
        CASE
            WHEN log_level = 'ERROR' THEN 
                SUBSTRING(log_message FROM ':\s+(.+)$')
            ELSE NULL
        END AS error_details
    FROM
        application_logs
),
component_stats AS (
    SELECT
        component,
        COUNT(*) FILTER (WHERE log_level = 'ERROR') AS error_count,
        COUNT(*) FILTER (WHERE log_level = 'WARNING') AS warning_count,
        COUNT(*) FILTER (WHERE log_level = 'INFO') AS info_count,
        ARRAY_AGG(error_details) FILTER (WHERE log_level = 'ERROR') AS error_messages,
        ARRAY_AGG(log_timestamp) FILTER (WHERE log_level = 'ERROR') AS error_timestamps
    FROM
        parsed_logs
    GROUP BY
        component
),
error_mode AS (
    SELECT
        component,
        (SELECT mode() WITHIN GROUP (ORDER BY e)
         FROM unnest(error_messages) AS e
         WHERE e IS NOT NULL
        ) AS most_common_error
    FROM
        component_stats
),
error_timing AS (
    SELECT
        component,
        CASE
            WHEN ARRAY_LENGTH(error_timestamps, 1) > 1 THEN
                EXTRACT(EPOCH FROM (MAX(error_timestamps) - MIN(error_timestamps)) / (ARRAY_LENGTH(error_timestamps, 1) - 1)) / 60
            ELSE NULL
        END AS avg_minutes_between_errors
    FROM
        component_stats
    GROUP BY
        component,
        error_timestamps
)
SELECT
    cs.component,
    cs.error_count,
    cs.warning_count,
    cs.info_count,
    em.most_common_error,
    CASE
        WHEN et.avg_minutes_between_errors IS NOT NULL THEN 
            ROUND(et.avg_minutes_between_errors, 1) || ' minutes'
        ELSE NULL
    END AS avg_time_between_errors
FROM
    component_stats cs
LEFT JOIN
    error_mode em ON cs.component = em.component
LEFT JOIN
    error_timing et ON cs.component = et.component
ORDER BY
    cs.error_count DESC,
    cs.warning_count DESC,
    cs.component;
```

**Performance Tip:**  
Log analysis often involves parsing large volumes of text data with complex patterns. To optimize performance:

1. Consider pre-parsing log data during ingestion rather than at query time, extracting key components like error codes, severity, and affected components into separate columns.
2. For real-time log analysis, create appropriate indexes on log_level, component, and timestamp columns.
3. Regular expression operations are computationally expensive. If possible, use simpler string functions or specialized log parsing functions.
4. For large log datasets, consider partitioning tables by date to improve query performance when analyzing specific time periods.
5. If analyzing logs across multiple systems or in distributed environments, consider using specialized log analysis tools that can pre-aggregate and index log data more efficiently than raw SQL queries.

# Advanced Joins (CROSS, LATERAL)

Advanced join types enable complex analytical patterns beyond basic inner and outer joins. CROSS JOINs produce a Cartesian product of rows, while LATERAL joins allow subqueries to reference columns from previous tables in the FROM clause.

## Problem 8.1: Product Combination Analysis

**Problem Statement:**  
The sales team wants to analyze which product combinations are frequently purchased together. Create a report that identifies all possible product pair combinations and calculates how often they occur together in the same order.

**Sample Data:**

```
-- orders table
order_id | customer_id | order_date
---------+-------------+------------
1001     | C101        | 2025-04-01
1002     | C102        | 2025-04-02
1003     | C101        | 2025-04-05
1004     | C103        | 2025-04-07
1005     | C102        | 2025-04-10

-- order_items table
order_id | product_id | quantity | unit_price
---------+------------+----------+-----------
1001     | P101       | 2        | 25.99
1001     | P102       | 1        | 49.99
1001     | P103       | 3        | 15.49
1002     | P101       | 1        | 25.99
1002     | P104       | 2        | 34.95
1003     | P102       | 1        | 49.99
1003     | P103       | 2        | 15.49
1004     | P101       | 1        | 25.99
1004     | P103       | 1        | 15.49
1004     | P105       | 2        | 29.99
1005     | P101       | 1        | 25.99
1005     | P102       | 1        | 49.99
```

**Expected Output:**

```
product1 | product2 | pair_count | order_count | co_occurrence
---------+----------+------------+-------------+---------------
P101     | P102     | 2          | 5           | 40.0%
P101     | P103     | 2          | 5           | 40.0%
P102     | P103     | 2          | 5           | 40.0%
P101     | P104     | 1          | 5           | 20.0%
P101     | P105     | 1          | 5           | 20.0%
P103     | P105     | 1          | 5           | 20.0%
P102     | P104     | 0          | 5           | 0.0%
P102     | P105     | 0          | 5           | 0.0%
P103     | P104     | 0          | 5           | 0.0%
P104     | P105     | 0          | 5           | 0.0%
```

**SQL Solution:**

```sql
-- Get all distinct products
WITH products AS (
    SELECT DISTINCT product_id
    FROM order_items
),
-- Generate all possible product pairs using CROSS JOIN
product_pairs AS (
    SELECT
        p1.product_id AS product1,
        p2.product_id AS product2
    FROM
        products p1
    CROSS JOIN
        products p2
    WHERE
        p1.product_id < p2.product_id  -- Avoid duplicates and self-pairs
),
-- Count orders containing each product
order_counts AS (
    SELECT
        COUNT(DISTINCT order_id) AS total_orders
    FROM
        orders
),
-- Find orders containing both products
co_occurrence AS (
    SELECT
        pp.product1,
        pp.product2,
        COUNT(DISTINCT oi1.order_id) AS pair_count
    FROM
        product_pairs pp
    LEFT JOIN
        order_items oi1 ON pp.product1 = oi1.product_id
    LEFT JOIN
        order_items oi2 ON pp.product2 = oi2.product_id AND oi1.order_id = oi2.order_id
    WHERE
        oi1.order_id IS NOT NULL AND oi2.order_id IS NOT NULL
    GROUP BY
        pp.product1,
        pp.product2
)
SELECT
    pp.product1,
    pp.product2,
    COALESCE(co.pair_count, 0) AS pair_count,
    oc.total_orders AS order_count,
    ROUND((COALESCE(co.pair_count, 0)::FLOAT / oc.total_orders) * 100, 1) || '%' AS co_occurrence
FROM
    product_pairs pp
LEFT JOIN
    co_occurrence co ON pp.product1 = co.product1 AND pp.product2 = co.product2
CROSS JOIN
    order_counts oc
ORDER BY
    pair_count DESC,
    product1,
    product2;
```

**Performance Tip:**  
CROSS JOINs can generate a large number of rows, especially with many distinct products. To optimize performance:

1. Use the filtering condition (`p1.product_id < p2.product_id`) in the CROSS JOIN to reduce the number of combinations generated.
2. Create indexes on `order_id` and `product_id` columns in the `order_items` table to improve join performance.
3. For large datasets, consider pre-aggregating common product combinations rather than calculating them on-demand.
4. If the analysis is performed regularly, consider materializing the product pair counts in a summary table that's updated periodically.
5. Break down the query into multiple CTEs as shown to help the query optimizer create an efficient execution plan.

## Problem 8.2: Customer Recommendations with LATERAL Joins

**Problem Statement:**  
The marketing team wants to suggest products to customers based on their purchase history. For each customer, find the top 3 products they've purchased most frequently, and then recommend 2 products that other customers who bought the same top products also purchased but that the customer hasn't bought yet.

**Sample Data:**

```
-- customers table
customer_id | customer_name
------------+---------------
C101        | John Smith
C102        | Mary Johnson
C103        | Bob Brown

-- orders table
order_id | customer_id | order_date
---------+-------------+------------
1001     | C101        | 2025-03-01
1002     | C101        | 2025-03-10
1003     | C102        | 2025-03-05
1004     | C102        | 2025-03-15
1005     | C103        | 2025-03-20
1006     | C101        | 2025-03-25

-- order_items table
order_id | product_id | quantity
---------+------------+----------
1001     | P101       | 1
1001     | P102       | 2
1002     | P101       | 1
1002     | P103       | 3
1003     | P101       | 1
1003     | P104       | 2
1004     | P102       | 1
1004     | P105       | 1
1005     | P101       | 2
1005     | P102       | 1
1005     | P106       | 1
1006     | P103       | 1
```

**Expected Output:**

```
customer_id | customer_name | top_products         | recommended_products
------------+---------------+---------------------+---------------------
C101        | John Smith    | P101, P103, P102    | P104, P106
C102        | Mary Johnson  | P101, P102, P104    | P103, P106
C103        | Bob Brown     | P101, P102, P106    | P103, P104
```

**SQL Solution:**

```sql
WITH customer_purchases AS (
    SELECT
        c.customer_id,
        c.customer_name,
        oi.product_id,
        SUM(oi.quantity) AS total_quantity
    FROM
        customers c
    JOIN
        orders o ON c.customer_id = o.customer_id
    JOIN
        order_items oi ON o.order_id = oi.order_id
    GROUP BY
        c.customer_id,
        c.customer_name,
        oi.product_id
),
top_products_per_customer AS (
    SELECT
        customer_id,
        customer_name,
        ARRAY_AGG(product_id ORDER BY total_quantity DESC, product_id) FILTER (WHERE rank <= 3) AS top_products
    FROM (
        SELECT
            customer_id,
            customer_name,
            product_id,
            total_quantity,
            RANK() OVER (PARTITION BY customer_id ORDER BY total_quantity DESC, product_id) AS rank
        FROM
            customer_purchases
    ) ranked
    GROUP BY
        customer_id,
        customer_name
),
product_affinities AS (
    SELECT
        cp1.customer_id,
        cp1.product_id AS purchased_product,
        cp2.product_id AS affinity_product,
        COUNT(*) AS co_purchase_count
    FROM
        customer_purchases cp1
    JOIN
        customer_purchases cp2 ON cp1.customer_id = cp2.customer_id AND cp1.product_id != cp2.product_id
    GROUP BY
        cp1.customer_id,
        cp1.product_id,
        cp2.product_id
)
SELECT
    tp.customer_id,
    tp.customer_name,
    ARRAY_TO_STRING(tp.top_products, ', ') AS top_products,
    (
        SELECT ARRAY_TO_STRING(ARRAY_AGG(r.recommendation ORDER BY r.score DESC, r.recommendation)::TEXT[], ', ')
        FROM (
            SELECT DISTINCT
                pa.affinity_product AS recommendation,
                SUM(pa.co_purchase_count) AS score
            FROM
                UNNEST(tp.top_products) AS top_product
            JOIN
                product_affinities pa ON pa.purchased_product = top_product
            WHERE
                pa.affinity_product NOT IN (
                    SELECT product_id
                    FROM customer_purchases
                    WHERE customer_id = tp.customer_id
                )
            GROUP BY
                pa.affinity_product
            ORDER BY
                score DESC,
                recommendation
            LIMIT 2
        ) r
    ) AS recommended_products
FROM
    top_products_per_customer tp
ORDER BY
    tp.customer_id;
```

**Performance Tip:**  
LATERAL joins and correlated subqueries can be computationally intensive, especially with large datasets. To optimize performance:

1. Create appropriate indexes on join columns and filtering conditions.
2. Pre-aggregate customer purchase data and product affinities in materialized views if this analysis is performed frequently.
3. For large datasets, consider implementing a more specialized recommendation algorithm outside the database and importing the results.
4. If the database supports it, use array operations and aggregations instead of string concatenation and manipulation for better performance.
5. Consider partitioning data by customer or time period if dealing with very large datasets to improve query performance.

## Problem 8.3: Dynamic Date Range Comparison

**Problem Statement:**  
The finance team wants to compare performance metrics across different time periods. Create a report that compares revenue, orders, and average order value across custom date ranges (current period vs. previous period vs. same period last year).

**Sample Data:**

```
-- date_ranges table
range_id | range_name        | start_date  | end_date
---------+------------------+-------------+------------
1        | Current Period    | 2025-04-01  | 2025-04-30
2        | Previous Period   | 2025-03-01  | 2025-03-31
3        | Year Ago Period   | 2024-04-01  | 2024-04-30

-- daily_sales table
sale_date  | revenue  | orders | customers
-----------+----------+--------+-----------
2024-04-05 | 12500.75 | 125    | 105
2024-04-10 | 15320.50 | 140    | 120
2024-04-15 | 18450.25 | 165    | 145
2024-04-20 | 14380.00 | 130    | 115
2024-04-25 | 16700.50 | 155    | 140
2025-03-05 | 13200.25 | 130    | 110
2025-03-10 | 16100.75 | 150    | 125
2025-03-15 | 19500.50 | 175    | 150
2025-03-20 | 15250.25 | 140    | 120
2025-03-25 | 17800.00 | 165    | 145
2025-04-05 | 14100.50 | 135    | 115
2025-04-10 | 17250.25 | 160    | 135
2025-04-15 | 20800.75 | 185    | 160
2025-04-20 | 16400.00 | 150    | 130
2025-04-25 | 18950.25 | 175    | 155
```

**Expected Output:**

```
metric             | current_period | previous_period | yoy_period | vs_prev_change | vs_yoy_change
-------------------+----------------+----------------+------------+----------------+---------------
Total Revenue      | $87,501.75     | $81,851.75     | $77,352.00 | +6.9%          | +13.1%
Total Orders       | 805            | 760            | 715        | +5.9%          | +12.6%
Avg Order Value    | $108.70        | $107.70        | $108.18    | +0.9%          | +0.5%
Orders per Customer| 1.17           | 1.18           | 1.14       | -0.8%          | +2.6%
```

**SQL Solution:**

```sql
WITH period_metrics AS (
    SELECT
        dr.range_id,
        dr.range_name,
        SUM(ds.revenue) AS total_revenue,
        SUM(ds.orders) AS total_orders,
        SUM(ds.customers) AS total_customers,
        SUM(ds.revenue) / NULLIF(SUM(ds.orders), 0) AS avg_order_value,
        SUM(ds.orders) / NULLIF(SUM(ds.customers), 0) AS orders_per_customer
    FROM
        date_ranges dr
    CROSS JOIN LATERAL (
        SELECT
            revenue,
            orders,
            customers
        FROM
            daily_sales
        WHERE
            sale_date BETWEEN dr.start_date AND dr.end_date
    ) ds
    GROUP BY
        dr.range_id,
        dr.range_name
),
period_data AS (
    SELECT
        range_id,
        range_name,
        total_revenue,
        total_orders,
        total_customers,
        avg_order_value,
        orders_per_customer
    FROM
        period_metrics
)
SELECT
    m.metric,
    m.current_period,
    m.previous_period,
    m.yoy_period,
    m.vs_prev_change,
    m.vs_yoy_change
FROM (
    -- Total Revenue
    SELECT
        'Total Revenue' AS metric,
        '$' || TO_CHAR(pd1.total_revenue, '999,999.99') AS current_period,
        '$' || TO_CHAR(pd2.total_revenue, '999,999.99') AS previous_period,
        '$' || TO_CHAR(pd3.total_revenue, '999,999.99') AS yoy_period,
        CASE 
            WHEN pd2.total_revenue <> 0 THEN 
                '+' || ROUND(((pd1.total_revenue - pd2.total_revenue) / pd2.total_revenue) * 100, 1) || '%'
            ELSE '+0.0%'
        END AS vs_prev_change,
        CASE 
            WHEN pd3.total_revenue <> 0 THEN 
                '+' || ROUND(((pd1.total_revenue - pd3.total_revenue) / pd3.total_revenue) * 100, 1) || '%'
            ELSE '+0.0%'
        END AS vs_yoy_change,
        1 AS display_order
    FROM
        period_data pd1
    CROSS JOIN
        period_data pd2
    CROSS JOIN
        period_data pd3
    WHERE
        pd1.range_id = 1 AND pd2.range_id = 2 AND pd3.range_id = 3
    
    UNION ALL
    
    -- Total Orders
    SELECT
        'Total Orders' AS metric,
        TO_CHAR(pd1.total_orders, '999,999') AS current_period,
        TO_CHAR(pd2.total_orders, '999,999') AS previous_period,
        TO_CHAR(pd3.total_orders, '999,999') AS yoy_period,
        CASE 
            WHEN pd2.total_orders <> 0 THEN 
                '+' || ROUND(((pd1.total_orders - pd2.total_orders) / pd2.total_orders) * 100, 1) || '%'
            ELSE '+0.0%'
        END AS vs_prev_change,
        CASE 
            WHEN pd3.total_orders <> 0 THEN 
                '+' || ROUND(((pd1.total_orders - pd3.total_orders) / pd3.total_orders) * 100, 1) || '%'
            ELSE '+0.0%'
        END AS vs_yoy_change,
        2 AS display_order
    FROM
        period_data pd1
    CROSS JOIN
        period_data pd2
    CROSS JOIN
        period_data pd3
    WHERE
        pd1.range_id = 1 AND pd2.range_id = 2 AND pd3.range_id = 3
    
    UNION ALL
    
    -- Avg Order Value
    SELECT
        'Avg Order Value' AS metric,
        '$' || TO_CHAR(pd1.avg_order_value, '999,999.99') AS current_period,
        '$' || TO_CHAR(pd2.avg_order_value, '999,999.99') AS previous_period,
        '$' || TO_CHAR(pd3.avg_order_value, '999,999.99') AS yoy_period,
        CASE 
            WHEN pd2.avg_order_value <> 0 THEN 
                '+' || ROUND(((pd1.avg_order_value - pd2.avg_order_value) / pd2.avg_order_value) * 100, 1) || '%'
            ELSE '+0.0%'
        END AS vs_prev_change,
        CASE 
            WHEN pd3.avg_order_value <> 0 THEN 
                '+' || ROUND(((pd1.avg_order_value - pd3.avg_order_value) / pd3.avg_order_value) * 100, 1) || '%'
            ELSE '+0.0%'
        END AS vs_yoy_change,
        3 AS display_order
    FROM
        period_data pd1
    CROSS JOIN
        period_data pd2
    CROSS JOIN
        period_data pd3
    WHERE
        pd1.range_id = 1 AND pd2.range_id = 2 AND pd3.range_id = 3
    
    UNION ALL
    
    -- Orders per Customer
    SELECT
        'Orders per Customer' AS metric,
        TO_CHAR(pd1.orders_per_customer, '999,999.99') AS current_period,
        TO_CHAR(pd2.orders_per_customer, '999,999.99') AS previous_period,
        TO_CHAR(pd3.orders_per_customer, '999,999.99') AS yoy_period,
        CASE 
            WHEN pd2.orders_per_customer <> 0 THEN 
                CASE
                    WHEN ((pd1.orders_per_customer - pd2.orders_per_customer) / pd2.orders_per_customer) >= 0 THEN
                        '+' || ROUND(((pd1.orders_per_customer - pd2.orders_per_customer) / pd2.orders_per_customer) * 100, 1) || '%'
                    ELSE
                        ROUND(((pd1.orders_per_customer - pd2.orders_per_customer) / pd2.orders_per_customer) * 100, 1) || '%'
                END
            ELSE '+0.0%'
        END AS vs_prev_change,
        CASE 
            WHEN pd3.orders_per_customer <> 0 THEN 
                CASE
                    WHEN ((pd1.orders_per_customer - pd3.orders_per_customer) / pd3.orders_per_customer) >= 0 THEN
                        '+' || ROUND(((pd1.orders_per_customer - pd3.orders_per_customer) / pd3.orders_per_customer) * 100, 1) || '%'
                    ELSE
                        ROUND(((pd1.orders_per_customer - pd3.orders_per_customer) / pd3.orders_per_customer) * 100, 1) || '%'
                END
            ELSE '+0.0%'
        END AS vs_yoy_change,
        4 AS display_order
    FROM
        period_data pd1
    CROSS JOIN
        period_data pd2
    CROSS JOIN
        period_data pd3
    WHERE
        pd1.range_id = 1 AND pd2.range_id = 2 AND pd3.range_id = 3
) m
ORDER BY
    m.display_order;
```

**Performance Tip:**  
This query uses LATERAL joins to dynamically retrieve sales data for each date range. To optimize performance:

1. Create indexes on the `sale_date` column in the `daily_sales` table to improve the performance of the range filters.
2. Consider pre-aggregating sales data at different time granularities (daily, weekly, monthly) to avoid scanning the entire sales table for each date range.
3. For complex reporting with multiple date range comparisons, consider creating materialized views or temporary tables that are refreshed periodically.
4. The query uses multiple CROSS JOINs, which can be expensive. Consider rewriting the query to use window functions or more efficient aggregation patterns if processing large datasets.
5. For frequently run reports, consider parameterizing the query and caching the results to avoid recalculating the same metrics repeatedly.

# Running Totals and Moving Averages

Running totals and moving averages are essential techniques for analyzing trends and cumulative performance in time series data. They help identify patterns, smooth out fluctuations, and provide insights into the trajectory of metrics over time.

## Problem 9.1: Sales Performance Analysis

**Problem Statement:**  
The sales team wants to analyze cumulative sales performance throughout the year. Create a report showing monthly sales, running totals, percent of annual target achieved, and month-over-month growth rates.

**Sample Data:**

```
-- monthly_sales table
year | month | sales_amount | sales_target
-----+-------+--------------+--------------
2025 | 1     | 120500.75    | 115000.00
2025 | 2     | 135750.50    | 125000.00
2025 | 3     | 142300.25    | 135000.00
2025 | 4     | 138900.00    | 140000.00
2025 | 5     | 145200.50    | 145000.00
2025 | 6     | 156700.25    | 150000.00
2025 | 7     | 149800.75    | 155000.00
2025 | 8     | 152300.50    | 160000.00
2025 | 9     | 167500.00    | 165000.00
2025 | 10    | 178200.25    | 170000.00
2025 | 11    | 185300.50    | 175000.00
2025 | 12    | 198450.75    | 180000.00

-- annual_target table
year | annual_target
-----+---------------
2025 | 1800000.00
```

**Expected Output:**

```
year_month | sales_amount | running_total | pct_of_annual | mom_growth | target_achievement
-----------+--------------+---------------+---------------+------------+------------------
2025-01    | $120,500.75  | $120,500.75   | 6.69%         | NULL       | 104.78%
2025-02    | $135,750.50  | $256,251.25   | 14.24%        | 12.65%     | 108.60%
2025-03    | $142,300.25  | $398,551.50   | 22.14%        | 4.82%      | 105.41%
2025-04    | $138,900.00  | $537,451.50   | 29.86%        | -2.39%     | 99.21%
2025-05    | $145,200.50  | $682,652.00   | 37.93%        | 4.54%      | 100.14%
2025-06    | $156,700.25  | $839,352.25   | 46.63%        | 7.92%      | 104.47%
2025-07    | $149,800.75  | $989,153.00   | 54.95%        | -4.40%     | 96.65%
2025-08    | $152,300.50  | $1,141,453.50 | 63.41%        | 1.67%      | 95.19%
2025-09    | $167,500.00  | $1,308,953.50 | 72.72%        | 9.98%      | 101.52%
2025-10    | $178,200.25  | $1,487,153.75 | 82.62%        | 6.39%      | 104.82%
2025-11    | $185,300.50  | $1,672,454.25 | 92.91%        | 3.98%      | 105.89%
2025-12    | $198,450.75  | $1,870,905.00 | 103.94%       | 7.10%      | 110.25%
```

**SQL Solution:**

```sql
WITH sales_analysis AS (
    SELECT
        ms.year,
        ms.month,
        TO_CHAR(TO_DATE(ms.year || '-' || LPAD(ms.month::TEXT, 2, '0') || '-01', 'YYYY-MM-DD'), 'YYYY-MM') AS year_month,
        ms.sales_amount,
        ms.sales_target,
        SUM(ms.sales_amount) OVER (PARTITION BY ms.year ORDER BY ms.month) AS running_total,
        LAG(ms.sales_amount) OVER (PARTITION BY ms.year ORDER BY ms.month) AS prev_month_sales,
        at.annual_target
    FROM
        monthly_sales ms
    JOIN
        annual_target at ON ms.year = at.year
)
SELECT
    year_month,
    '$' || TO_CHAR(sales_amount, '999,999.99') AS sales_amount,
    '$' || TO_CHAR(running_total, '999,999.99') AS running_total,
    ROUND((running_total / annual_target) * 100, 2) || '%' AS pct_of_annual,
    CASE
        WHEN prev_month_sales IS NULL THEN NULL
        ELSE ROUND(((sales_amount - prev_month_sales) / prev_month_sales) * 100, 2) || '%'
    END AS mom_growth,
    ROUND((sales_amount / sales_target) * 100, 2) || '%' AS target_achievement
FROM
    sales_analysis
ORDER BY
    year,
    month;
```

**Performance Tip:**  
Running totals using window functions are efficient for medium-sized datasets. For very large datasets (millions of rows):

1. Create indexes on the partition and order columns (`year` and `month` in this case).
2. Consider pre-calculating running totals during ETL processes if these reports are run frequently.
3. For extremely large datasets, consider partitioning tables by time period to improve query performance.
4. Window functions can be memory-intensive. If memory is limited, consider breaking down the calculation into smaller time periods or using incremental processing techniques.

## Problem 9.2: Website Traffic Analysis

**Problem Statement:**  
The digital marketing team wants to analyze website traffic patterns. Create a report showing daily page views, unique visitors, and conversion rates, along with 7-day and 30-day moving averages to identify trends and smooth out day-to-day fluctuations.

**Sample Data:**

```
-- website_traffic table
traffic_date | page_views | unique_visitors | conversions
-------------+------------+-----------------+-------------
2025-04-01   | 12500      | 3200           | 125
2025-04-02   | 13200      | 3350           | 132
2025-04-03   | 11800      | 3100           | 118
2025-04-04   | 10500      | 2800           | 105
2025-04-05   | 9800       | 2600           | 98
2025-04-06   | 8500       | 2400           | 85
2025-04-07   | 12000      | 3150           | 120
2025-04-08   | 13500      | 3400           | 135
2025-04-09   | 14200      | 3600           | 142
2025-04-10   | 13800      | 3500           | 138
2025-04-11   | 12900      | 3300           | 129
2025-04-12   | 10200      | 2750           | 102
2025-04-13   | 9500       | 2550           | 95
2025-04-14   | 12800      | 3250           | 128
2025-04-15   | 13700      | 3450           | 137
```

**Expected Output:**

```
traffic_date | page_views | unique_visitors | conversion_rate | pv_7day_avg | uv_7day_avg | conv_rate_7day_avg | pv_30day_avg | uv_30day_avg | conv_rate_30day_avg
-------------+------------+-----------------+----------------+-------------+-------------+-------------------+--------------+--------------+--------------------
2025-04-01   | 12,500     | 3,200          | 3.91%          | NULL        | NULL        | NULL              | NULL         | NULL         | NULL
2025-04-02   | 13,200     | 3,350          | 3.94%          | NULL        | NULL        | NULL              | NULL         | NULL         | NULL
2025-04-03   | 11,800     | 3,100          | 3.81%          | NULL        | NULL        | NULL              | NULL         | NULL         | NULL
2025-04-04   | 10,500     | 2,800          | 3.75%          | NULL        | NULL        | NULL              | NULL         | NULL         | NULL
2025-04-05   | 9,800      | 2,600          | 3.77%          | NULL        | NULL        | NULL              | NULL         | NULL         | NULL
2025-04-06   | 8,500      | 2,400          | 3.54%          | NULL        | NULL        | NULL              | NULL         | NULL         | NULL
2025-04-07   | 12,000     | 3,150          | 3.81%          | 11,186      | 2,943       | 3.80%             | NULL         | NULL         | NULL
2025-04-08   | 13,500     | 3,400          | 3.97%          | 11,329      | 2,971       | 3.81%             | NULL         | NULL         | NULL
2025-04-09   | 14,200     | 3,600          | 3.94%          | 11,471      | 3,007       | 3.82%             | NULL         | NULL         | NULL
2025-04-10   | 13,800     | 3,500          | 3.94%          | 11,800      | 3,064       | 3.85%             | NULL         | NULL         | NULL
2025-04-11   | 12,900     | 3,300          | 3.91%          | 12,100      | 3,136       | 3.86%             | NULL         | NULL         | NULL
2025-04-12   | 10,200     | 2,750          | 3.71%          | 12,157      | 3,157       | 3.85%             | NULL         | NULL         | NULL
2025-04-13   | 9,500      | 2,550          | 3.73%          | 12,300      | 3,179       | 3.87%             | NULL         | NULL         | NULL
2025-04-14   | 12,800     | 3,250          | 3.94%          | 12,414      | 3,193       | 3.89%             | NULL         | NULL         | NULL
2025-04-15   | 13,700     | 3,450          | 3.97%          | 12,443      | 3,200       | 3.89%             | NULL         | NULL         | NULL
```

**SQL Solution:**

```sql
WITH traffic_metrics AS (
    SELECT
        traffic_date,
        page_views,
        unique_visitors,
        conversions,
        ROUND((conversions::FLOAT / unique_visitors) * 100, 2) AS conversion_rate,
        AVG(page_views) OVER (
            ORDER BY traffic_date
            ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
        ) AS pv_7day_avg,
        AVG(unique_visitors) OVER (
            ORDER BY traffic_date
            ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
        ) AS uv_7day_avg,
        AVG((conversions::FLOAT / unique_visitors) * 100) OVER (
            ORDER BY traffic_date
            ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
        ) AS conv_rate_7day_avg,
        AVG(page_views) OVER (
            ORDER BY traffic_date
            ROWS BETWEEN 29 PRECEDING AND CURRENT ROW
        ) AS pv_30day_avg,
        AVG(unique_visitors) OVER (
            ORDER BY traffic_date
            ROWS BETWEEN 29 PRECEDING AND CURRENT ROW
        ) AS uv_30day_avg,
        AVG((conversions::FLOAT / unique_visitors) * 100) OVER (
            ORDER BY traffic_date
            ROWS BETWEEN 29 PRECEDING AND CURRENT ROW
        ) AS conv_rate_30day_avg
    FROM
        website_traffic
)
SELECT
    traffic_date,
    TO_CHAR(page_views, '999,999') AS page_views,
    TO_CHAR(unique_visitors, '999,999') AS unique_visitors,
    conversion_rate || '%' AS conversion_rate,
    CASE
        WHEN ROW_NUMBER() OVER (ORDER BY traffic_date) >= 7 THEN ROUND(pv_7day_avg)::TEXT
        ELSE NULL
    END AS pv_7day_avg,
    CASE
        WHEN ROW_NUMBER() OVER (ORDER BY traffic_date) >= 7 THEN ROUND(uv_7day_avg)::TEXT
        ELSE NULL
    END AS uv_7day_avg,
    CASE
        WHEN ROW_NUMBER() OVER (ORDER BY traffic_date) >= 7 THEN ROUND(conv_rate_7day_avg, 2) || '%'
        ELSE NULL
    END AS conv_rate_7day_avg,
    CASE
        WHEN ROW_NUMBER() OVER (ORDER BY traffic_date) >= 30 THEN ROUND(pv_30day_avg)::TEXT
        ELSE NULL
    END AS pv_30day_avg,
    CASE
        WHEN ROW_NUMBER() OVER (ORDER BY traffic_date) >= 30 THEN ROUND(uv_30day_avg)::TEXT
        ELSE NULL
    END AS uv_30day_avg,
    CASE
        WHEN ROW_NUMBER() OVER (ORDER BY traffic_date) >= 30 THEN ROUND(conv_rate_30day_avg, 2) || '%'
        ELSE NULL
    END AS conv_rate_30day_avg
FROM
    traffic_metrics
ORDER BY
    traffic_date;
```

**Performance Tip:**  
Moving average calculations with window functions can be resource-intensive, especially with large datasets and multiple moving averages. To optimize performance:

1. Create an index on the `traffic_date` column to improve sorting performance.
2. For frequently accessed reports, consider materializing the moving averages in a separate table that's updated daily.
3. If you're calculating many different moving averages, consider breaking the query into multiple steps using CTEs or temporary tables.
4. For very large datasets, consider calculating moving averages at a higher aggregation level (e.g., weekly instead of daily).
5. Window functions with large frame specifications (e.g., 30 days) can require significant memory. Ensure your database has sufficient memory allocated or consider incremental calculation approaches.

## Problem 9.3: Investment Portfolio Performance

**Problem Statement:**  
The finance team wants to analyze the performance of various investment portfolios. Calculate cumulative returns, annualized returns, and moving averages for volatility analysis.

**Sample Data:**

```
-- portfolio_returns table
portfolio_id | date       | daily_return | benchmark_return
-------------+------------+--------------+------------------
P001         | 2025-03-01 | 0.0125       | 0.0080
P001         | 2025-03-02 | -0.0050      | -0.0030
P001         | 2025-03-03 | 0.0075       | 0.0060
P001         | 2025-03-04 | 0.0100       | 0.0070
P001         | 2025-03-05 | -0.0080      | -0.0050
P002         | 2025-03-01 | 0.0085       | 0.0080
P002         | 2025-03-02 | -0.0070      | -0.0030
P002         | 2025-03-03 | 0.0095       | 0.0060
P002         | 2025-03-04 | 0.0110       | 0.0070
P002         | 2025-03-05 | -0.0060      | -0.0050
P003         | 2025-03-01 | 0.0150       | 0.0080
P003         | 2025-03-02 | -0.0090      | -0.0030
P003         | 2025-03-03 | 0.0120       | 0.0060
P003         | 2025-03-04 | 0.0080       | 0.0070
P003         | 2025-03-05 | -0.0100      | -0.0050
```

**Expected Output:**

```
portfolio_id | date       | daily_return | cumulative_return | rolling_volatility | vs_benchmark | excess_return
-------------+------------+--------------+-------------------+-------------------+--------------+---------------
P001         | 2025-03-01 | 1.25%        | 1.25%             | NULL              | 0.45%        | 56.25%
P001         | 2025-03-02 | -0.50%       | 0.74%             | 1.24%             | -0.20%       | 66.67%
P001         | 2025-03-03 | 0.75%        | 1.50%             | 0.90%             | 0.15%        | 25.00%
P001         | 2025-03-04 | 1.00%        | 2.51%             | 0.89%             | 0.30%        | 42.86%
P001         | 2025-03-05 | -0.80%       | 1.69%             | 0.86%             | -0.30%       | 60.00%
P002         | 2025-03-01 | 0.85%        | 0.85%             | NULL              | 0.05%        | 6.25%
P002         | 2025-03-02 | -0.70%       | 0.14%             | 1.10%             | -0.40%       | 133.33%
P002         | 2025-03-03 | 0.95%        | 1.10%             | 0.83%             | 0.35%        | 58.33%
P002         | 2025-03-04 | 1.10%        | 2.21%             | 0.90%             | 0.40%        | 57.14%
P002         | 2025-03-05 | -0.60%       | 1.59%             | 0.84%             | -0.10%       | 20.00%
P003         | 2025-03-01 | 1.50%        | 1.50%             | NULL              | 0.70%        | 87.50%
P003         | 2025-03-02 | -0.90%       | 0.59%             | 1.70%             | -0.60%       | 200.00%
P003         | 2025-03-03 | 1.20%        | 1.79%             | 1.20%             | 0.60%        | 100.00%
P003         | 2025-03-04 | 0.80%        | 2.61%             | 1.10%             | 0.10%        | 14.29%
P003         | 2025-03-05 | -1.00%       | 1.58%             | 1.08%             | -0.50%       | 100.00%
```

**SQL Solution:**

```sql
WITH return_metrics AS (
    SELECT
        portfolio_id,
        date,
        daily_return,
        benchmark_return,
        (daily_return - benchmark_return) AS excess_daily_return,
        (EXP(SUM(LN(1 + daily_return)) OVER (PARTITION BY portfolio_id ORDER BY date)) - 1) AS cumulative_return,
        STDDEV(daily_return) OVER (
            PARTITION BY portfolio_id
            ORDER BY date
            ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
        ) AS rolling_volatility
    FROM
        portfolio_returns
)
SELECT
    portfolio_id,
    date,
    TO_CHAR(daily_return * 100, '990.00') || '%' AS daily_return,
    TO_CHAR(cumulative_return * 100, '990.00') || '%' AS cumulative_return,
    CASE
        WHEN rolling_volatility IS NOT NULL THEN TO_CHAR(rolling_volatility * 100, '990.00') || '%'
        ELSE NULL
    END AS rolling_volatility,
    TO_CHAR((daily_return - benchmark_return) * 100, '990.00') || '%' AS vs_benchmark,
    CASE
        WHEN benchmark_return <> 0 THEN 
            TO_CHAR(ABS((daily_return - benchmark_return) / benchmark_return) * 100, '990.00') || '%'
        ELSE 'N/A'
    END AS excess_return
FROM
    return_metrics
ORDER BY
    portfolio_id,
    date;
```

**Performance Tip:**  
Financial calculations involving running totals and moving statistics can be computationally intensive. To optimize performance:

1. Create appropriate indexes on `portfolio_id` and `date` columns.
2. For cumulative return calculations that use window functions with complex expressions (like `EXP(SUM(LN(...)))`), consider breaking the calculation into multiple steps.
3. If analyzing many portfolios over long time periods, consider partitioning data by portfolio and time period.
4. For frequently accessed metrics, consider pre-calculating and storing them in materialized views or summary tables.
5. Be cautious with volatility calculations that use standard deviation window functions, as they can be memory-intensive for large datasets. Consider using simplified volatility measures for very large datasets.

