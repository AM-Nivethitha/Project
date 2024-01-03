CREATE TABLE analytics-406018.data.table_dbms_transformed1 AS
SELECT
  tpep_pickup_datetime AS pickup_datetime,
  EXTRACT(DAYOFWEEK FROM tpep_pickup_datetime) AS pickup_day_of_week,
  EXTRACT(HOUR FROM tpep_pickup_datetime) AS pickup_hour,
  passenger_count,
  trip_distance,
  fare_amount + tip_amount + tolls_amount + improvement_surcharge AS total_payment,
  payment_type,
  CASE
    WHEN payment_type = 1 THEN 'Credit Card'
    WHEN payment_type = 2 THEN 'Cash'
    WHEN payment_type = 3 THEN 'No Charge'
    WHEN payment_type = 4 THEN 'Dispute'
    ELSE NULL  -- Handle other cases as needed
  END AS payment_method,
  ST_AsText(ST_GeogPoint(pickup_longitude, pickup_latitude)) AS pickup_location,
  ST_AsText(ST_GeogPoint(dropoff_longitude, dropoff_latitude)) AS dropoff_location
FROM
  analytics-406018.data.table_dbms;

