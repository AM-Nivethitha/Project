/* Final - 1. Demand Patterns and Peak Hours */

WITH HourlyDemand AS (
  SELECT
    EXTRACT(HOUR FROM tpep_pickup_datetime) AS pickup_hour,
    COUNT(*) AS demand_count
  FROM
    `analytics-406018.data.table_dbms`
  GROUP BY
    pickup_hour
)
SELECT
  pickup_hour,
  demand_count,
  RANK() OVER (ORDER BY demand_count DESC) AS peak_rank
FROM
  HourlyDemand
ORDER BY
  pickup_hour;

/* Final - 2/* Query 5: Calculate Cumulative Revenue Over Time*/

WITH HourlyPayment AS (
  SELECT
    EXTRACT(HOUR FROM tpep_pickup_datetime) AS pickup_hour,
    SUM(total_amount) AS hourly_payment
  FROM
    `analytics-406018.data.table_dbms`
  GROUP BY
    pickup_hour
)
SELECT
  pickup_hour,
  SUM(hourly_payment) OVER (ORDER BY pickup_hour) AS cumulative_hourly_payment
FROM
  HourlyPayment
ORDER BY
  pickup_hour;

  

/*
Final - 3 RatecodeID and average payments earned
*/

WITH RatecodeStats AS (
  SELECT
    RatecodeID,
    COUNT(*) AS ratecode_count,
    AVG(total_amount) AS avg_payment_total,
    RANK() OVER (ORDER BY AVG(total_amount) DESC) AS rank
  FROM
    `analytics-406018.data.table_dbms`
  GROUP BY
    RatecodeID
)

SELECT
  RatecodeID,
  ratecode_count,
  avg_payment_total,
  rank
FROM
  RatecodeStats;


/* Final - 4 Analyze payment types to understand customer preferences: */

SELECT
  t1.payment_type,
  t2.payment_method,
  COUNT(*) AS payment_count
FROM
  `analytics-406018.data.table_dbms` t1
JOIN
  `analytics-406018.data.table_dbms_transformed` t2
ON
  t1.tpep_pickup_datetime = t2.pickup_datetime
WHERE
  (t1.payment_type = 1 AND t2.payment_method = 'Credit Card')
  OR (t1.payment_type = 2 AND t2.payment_method = 'Cash')
  OR (t1.payment_type = 3 AND t2.payment_method = 'No Charge')
  OR (t1.payment_type = 4 AND t2.payment_method = 'Dispute')
GROUP BY
  t1.payment_type, t2.payment_method;


