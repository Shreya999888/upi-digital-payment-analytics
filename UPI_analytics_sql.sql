create database Upi_analytics1;
use Upi_analytic_project1;
CREATE TABLE upi_transactions (
    transaction_id VARCHAR(30),
    timestamp DATETIME,
    transaction_type VARCHAR(20),
    merchant_category VARCHAR(50),
    amount_inr DECIMAL(12,2),
    transaction_status VARCHAR(20),
    sender_age_group VARCHAR(20),
    receiver_age_group VARCHAR(20),
    sender_state VARCHAR(50),
    sender_bank VARCHAR(50),
    receiver_bank VARCHAR(50),
    device_type VARCHAR(30),
    network_type VARCHAR(20),
    fraud_flag INT,
    hour_of_day INT,
    day_of_week VARCHAR(20),
    is_weekend INT,
    date DATE,
    year INT,
    month INT,
    month_name VARCHAR(20),
    day INT,
    day_name VARCHAR(20),
    hour INT
);
SELECT COUNT(*) FROM upi_transactions;
SELECT *
FROM upi_transactions
LIMIT 5;
SELECT
    COUNT(*) AS total_transactions,
    SUM(amount_inr) AS total_transaction_value,
    AVG(amount_inr) AS average_transaction_amount,
    MIN(amount_inr) AS minimum_transaction,
    MAX(amount_inr) AS maximum_transaction
FROM upi_transactions;
SELECT
    transaction_status,
    COUNT(*) AS transaction_count,
    ROUND(
        COUNT(*) * 100.0 /
        (SELECT COUNT(*) FROM upi_transactions),
        2
    ) AS percentage
FROM upi_transactions
GROUP BY transaction_status
ORDER BY transaction_count DESC;
SELECT
    ROUND(
        SUM(
            CASE
                WHEN transaction_status = 'SUCCESS' THEN 1
                ELSE 0
            END
        ) * 100.0 / COUNT(*),
        2
    ) AS success_rate
FROM upi_transactions;
SELECT
    transaction_type,
    COUNT(*) AS transactions,
    SUM(amount_inr) AS total_value,
    ROUND(AVG(amount_inr), 2) AS average_amount
FROM upi_transactions
GROUP BY transaction_type
ORDER BY total_value DESC;
SELECT
    year,
    month,
    COUNT(*) AS transactions,
    SUM(amount_inr) AS total_value,
    ROUND(AVG(amount_inr), 2) AS average_amount
FROM upi_transactions
GROUP BY year, month
ORDER BY year, month;