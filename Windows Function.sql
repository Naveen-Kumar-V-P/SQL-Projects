SELECT Column_Name,
	WINDOW_FUNCTION () OVER (
    [PARTITION BY column]
	[ORDER BY column]
	[ROWS/RANGE frame_specification]
    )
FROM Table_Name;

use training;

CREATE TABLE sales (
    sale_id INT PRIMARY KEY,
    product_name VARCHAR(50),
    category VARCHAR(30),
    sale_date DATE,
    salesperson VARCHAR(30),
    amount DECIMAL(10,2),
    region VARCHAR(20)
);


INSERT INTO sales VALUES
(1, 'iPhone 15', 'Electronics', '2024-01-15', 'Ravi', 75000, 'Chennai'),
(2, 'Samsung TV', 'Electronics', '2024-01-16', 'Priya', 45000, 'Chennai'),
(3, 'Nike Shoes', 'Fashion', '2024-01-17', 'Kumar', 8000, 'Bangalore'),
(4, 'Adidas Shoes', 'Fashion', '2024-01-18', 'Ravi', 12000, 'Chennai'),
(5, 'MacBook Pro', 'Electronics', '2024-01-19', 'Deepa', 125000, 'Mumbai'),
(6, 'Levis Jeans', 'Fashion', '2024-01-20', 'Priya', 5000, 'Chennai'),
(7, 'OnePlus Phone', 'Electronics', '2024-01-21', 'Kumar', 35000, 'Bangalore'),
(8, 'Formal Shirt', 'Fashion', '2024-01-22', 'Deepa', 3000, 'Mumbai'),
(9, 'iPad', 'Electronics', '2024-01-23', 'Ravi', 55000, 'Chennai'),
(10, 'Sports Watch', 'Fashion', '2024-01-24', 'Priya', 15000, 'Chennai');

########### ROW_NUMBER ##############

Select 
sale_id,
product_name,
amount,
ROW_NUMBER() OVER (ORDER BY amount DESC) as Sales_Rank
From sales;

############## RANK & DENSE_RANK ###################

SELECT 
    salesperson,
    amount,
    ROW_NUMBER() OVER (ORDER BY amount DESC) as sale_rank,
    RANK() OVER (ORDER BY amount DESC) as rank_with_gaps,
    DENSE_RANK() OVER (ORDER BY amount DESC) as denseRank
FROM sales;

###################### PARTITION BY ######################

SELECT 
    product_name,
    category,salesperson,
    amount,
    ROW_NUMBER() OVER (PARTITION BY category ORDER BY amount DESC) as category_rank,
    RANK() OVER (PARTITION BY category ORDER BY amount DESC) as category_rank1,
    DENSE_RANK() OVER (PARTITION BY category ORDER BY amount DESC) as category_densrank
FROM sales;

#################### SUM #####################

SELECT 
    sale_date,
    amount,
    SUM(amount) OVER (ORDER BY sale_date) as running_total
FROM sales
ORDER BY sale_date;

##################### LAG() & LEAD() ########################

SELECT 
    sale_date,
    amount,
    LAG(amount) OVER (ORDER BY sale_date) as previous_day_sales,
    LAG(amount,1) OVER (ORDER BY sale_date) as previous_1day_sales,
	LAG(amount,2) OVER (ORDER BY sale_date) as previous_2day_sales,
    amount - LAG(amount, 1) OVER (ORDER BY sale_date) as difference
FROM sales
ORDER BY sale_date;

#################### FIRST VALUE() & LAST VALUE() ###################

SELECT 
    product_name,
    category,
    amount,
    FIRST_VALUE(amount) OVER (
        PARTITION BY category 
        ORDER BY amount DESC 
        ROWS UNBOUNDED PRECEDING
    ) as highest_in_category,
    amount * 100.0 / FIRST_VALUE(amount) OVER (
        PARTITION BY category 
        ORDER BY amount DESC 
        ROWS UNBOUNDED PRECEDING
    ) as percentage_of_highest
FROM sales;

###################### NTILE ##################

SELECT 
    salesperson,
    SUM(amount) as total_sales,
    NTILE(4) OVER (ORDER BY SUM(amount)) as performance_quartile
FROM sales
GROUP BY salesperson;

##########################################################################################

CREATE TABLE student_scores (
    student_id INT,
    student_name VARCHAR(50),
    subject VARCHAR(30),
    score INT,
    class VARCHAR(10)
);

INSERT INTO student_scores VALUES
(1, 'Ravi', 'Math', 95, '10A'),
(2, 'Priya', 'Math', 88, '10A'),
(3, 'Kumar', 'Math', 76, '10A'),
(4, 'Deepa', 'Math', 92, '10A'),
(5, 'Arjun', 'Math', 84, '10A'),
(6, 'Meera', 'Math', 79, '10A'),
(7, 'Siva', 'Math', 91, '10A'),
(8, 'Lakshmi', 'Math', 87, '10A'),
(9, 'Karthik', 'Math', 73, '10A'),
(10, 'Divya', 'Math', 89, '10A'),
(11, 'Raj', 'Math', 82, '10A'),
(12, 'Sowmya', 'Math', 94, '10A');

SELECT 
    student_name,
    score,
    NTILE(4) OVER (ORDER BY score DESC) as performance_quartile,
    CASE 
        WHEN NTILE(4) OVER (ORDER BY score DESC) = 1 THEN 'Excellent'
        WHEN NTILE(4) OVER (ORDER BY score DESC) = 2 THEN 'Good'
        WHEN NTILE(4) OVER (ORDER BY score DESC) = 3 THEN 'Average'
        ELSE 'Needs Improvement'
    END as performance_category
FROM student_scores
ORDER BY score DESC;


INSERT INTO student_scores VALUES (13, 'Anita', 'Math', 90, '10A');

SELECT 
    student_name,
    score,
    NTILE(4) OVER (ORDER BY score DESC) as quartile
FROM student_scores
ORDER BY score DESC;


CREATE TABLE sales_performance (
    salesperson VARCHAR(50),
    region VARCHAR(30),
    total_sales DECIMAL(12,2),
    quarter VARCHAR(10)
);

INSERT INTO sales_performance VALUES
('Ravi', 'Chennai', 1250000, 'Q1'),
('Priya', 'Mumbai', 980000, 'Q1'),
('Kumar', 'Bangalore', 1150000, 'Q1'),
('Deepa', 'Delhi', 1320000, 'Q1'),
('Arjun', 'Chennai', 890000, 'Q1'),
('Meera', 'Mumbai', 1180000, 'Q1'),
('Siva', 'Bangalore', 1050000, 'Q1'),
('Lakshmi', 'Delhi', 1280000, 'Q1');

SELECT 
    salesperson,
    region,
    total_sales,
    NTILE(5) OVER (ORDER BY total_sales DESC) as performance_quintile,
    CASE 
        WHEN NTILE(5) OVER (ORDER BY total_sales DESC) = 1 THEN 'Top Performer'
        WHEN NTILE(5) OVER (ORDER BY total_sales DESC) = 2 THEN 'High Performer'
        WHEN NTILE(5) OVER (ORDER BY total_sales DESC) = 3 THEN 'Average Performer'
        WHEN NTILE(5) OVER (ORDER BY total_sales DESC) = 4 THEN 'Below Average'
        ELSE 'Needs Support'
    END as performance_level,
    ROUND(
        (NTILE(5) OVER (ORDER BY total_sales DESC) - 1) * 20 + 10, 0
    ) as percentile_range
FROM sales_performance
ORDER BY total_sales DESC;

SELECT 
    salesperson,
    region,
    total_sales,
    NTILE(3) OVER (ORDER BY total_sales DESC) as overall_tier,
    NTILE(3) OVER (
        PARTITION BY region 
        ORDER BY total_sales DESC
    ) as region_tier,
    CASE 
        WHEN NTILE(3) OVER (
            PARTITION BY region 
            ORDER BY total_sales DESC
        ) = 1 THEN 'Top in Region'
        WHEN NTILE(3) OVER (
            PARTITION BY region 
            ORDER BY total_sales DESC
        ) = 2 THEN 'Middle in Region'
        ELSE 'Bottom in Region'
    END as region_performance
FROM sales_performance
ORDER BY region, total_sales DESC;



CREATE TABLE customer_data (
    customer_id INT,
    customer_name VARCHAR(50),
    annual_spend DECIMAL(10,2),
    order_frequency INT,
    last_purchase_days INT
);

INSERT INTO customer_data VALUES
(1, 'Customer A', 50000, 12, 5),
(2, 'Customer B', 25000, 8, 15),
(3, 'Customer C', 75000, 15, 3),
(4, 'Customer D', 15000, 4, 30),
(5, 'Customer E', 35000, 10, 10),
(6, 'Customer F', 80000, 18, 2),
(7, 'Customer G', 12000, 3, 45),
(8, 'Customer H', 42000, 11, 8);


SELECT 
    customer_name,
    annual_spend,
    NTILE(4) OVER (ORDER BY annual_spend DESC) as spend_tier,
    CASE 
        WHEN NTILE(4) OVER (ORDER BY annual_spend DESC) = 1 THEN 'Premium'
        WHEN NTILE(4) OVER (ORDER BY annual_spend DESC) = 2 THEN 'Gold'
        WHEN NTILE(4) OVER (ORDER BY annual_spend DESC) = 3 THEN 'Silver'
        ELSE 'Bronze'
    END as customer_segment,
    NTILE(3) OVER (ORDER BY annual_spend DESC) as spending_score,
    NTILE(3) OVER (ORDER BY order_frequency DESC) as frequency_score,
    NTILE(3) OVER (ORDER BY last_purchase_days ASC) as recency_score
FROM customer_data
ORDER BY annual_spend DESC;



