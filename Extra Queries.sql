
/*
Query 3: Top Pickup and Dropoff Locations
*/

WITH LocationAnalysis AS (
  SELECT
    pickup_location,
    dropoff_location,
    COUNT(*) AS trip_count
  FROM
    `analytics-406018.data.table_dbms_transformed`

  GROUP BY
    pickup_location,
    dropoff_location
)
SELECT
  pickup_location,
  dropoff_location,
  trip_count,
  RANK() OVER (ORDER BY trip_count DESC) AS location_rank
FROM
  LocationAnalysis
ORDER BY
  location_rank;





/* 2nd Query: Calculate Cumulative Revenue Over Hourly Basis
This query uses a window function to calculate cumulative revenue over time (hour), allowing you to visualize the performance or utilization at specific hours.
*/

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
2. Route Optimization:
Identify common routes with high traffic:
*/

WITH RouteTraffic AS (
  SELECT
    ST_ASTEXT(ST_GEOGPOINT(pickup_longitude, pickup_latitude)) AS pickup_location,
    ST_ASTEXT(ST_GEOGPOINT(dropoff_longitude, dropoff_latitude)) AS dropoff_location,
    COUNT(*) AS traffic_count
  FROM
    `analytics-406018.data.table_dbms`
  GROUP BY
    pickup_location,
    dropoff_location
)
SELECT
  pickup_location,
  dropoff_location,
  traffic_count,
  RANK() OVER (ORDER BY traffic_count DESC) AS traffic_rank
FROM
  RouteTraffic
ORDER BY
  traffic_rank;


/*
3. Customer Preferences and Satisfaction:
Explore the relationship between passenger count and fare amounts:
*/

SELECT
  passenger_count,
  AVG(fare_amount) AS avg_fare_amount,
  AVG(tip_amount) AS avg_tip_amount
FROM
  `analytics-406018.data.table_dbms`
GROUP BY
  passenger_count;


/* Analyze payment types to understand customer preferences: */
SELECT
  payment_type,
  COUNT(*) AS payment_count
FROM
  `analytics-406018.data.table_dbms`
GROUP BY
  payment_type;


/* New 3 */

WITH PassengerStats AS (
  -- Analyze relationship between passenger count and fare amounts
  SELECT
    passenger_count,
    AVG(fare_amount) AS avg_fare_amount,
    AVG(tip_amount) AS avg_tip_amount
  FROM
    `analytics-406018.data.table_dbms`
  GROUP BY
    passenger_count
),

PaymentAnalysis AS (
  -- Analyze payment types to understand customer preferences
  SELECT
    payment_type,
    COUNT(*) AS payment_count
  FROM
    `analytics-406018.data.table_dbms`
  GROUP BY
    payment_type
)

-- Combine all insights
SELECT
  ps.passenger_count,
  ps.avg_fare_amount,
  ps.avg_tip_amount
FROM
  PassengerStats ps
ORDER BY
  ps.passenger_count;

-- Separate analysis for payment types
SELECT
  pa.payment_type,
  pa.payment_count
FROM
  PaymentAnalysis pa
ORDER BY
  pa.payment_type;

/*
4. Revenue and Pricing Strategy:
Calculate the average total amount and identify factors contributing to higher fares:
*/
SELECT
  passenger_count,
  AVG(total_amount) AS avg_total_amount,
  MAX(total_amount) AS max_total_amount,
  MIN(total_amount) AS min_total_amount
FROM
  `analytics-406018.data.table_dbms`
GROUP BY
  passenger_count;

/*
Explore the relationship between fare amounts and additional charges:
*/
SELECT
  fare_amount,
  AVG(tip_amount) AS avg_tip_amount,
  AVG(tolls_amount) AS avg_tolls_amount
FROM
  `analytics-406018.data.table_dbms`
GROUP BY
  fare_amount;


/*
5. Geospatial Analysis for Hotspots:
Visualize pickup and dropoff locations on a map:
*/

SELECT
  ST_GEOGPOINT(pickup_longitude, pickup_latitude) AS pickup_location,
  ST_GEOGPOINT(dropoff_longitude, dropoff_latitude) AS dropoff_location
FROM
  `analytics-406018.data.table_dbms`;


