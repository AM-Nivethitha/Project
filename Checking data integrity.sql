/*Checking Data Types*/
SELECT
  COLUMN_NAME,
  DATA_TYPE
FROM
  analytics-406018.data.INFORMATION_SCHEMA.COLUMNS
WHERE
  TABLE_NAME = 'table_dbms';

/*Checking Data Types */
SELECT
  COLUMN_NAME,
  DATA_TYPE
FROM
  analytics-406018.data.INFORMATION_SCHEMA.COLUMNS
WHERE
  TABLE_NAME = 'table_dbms_transformed';

/*checking NULL*/
SELECT
  *
FROM
  analytics-406018.data.table_dbms
WHERE
  VendorID IS NULL
  OR tpep_pickup_datetime IS NULL
  OR tpep_dropoff_datetime IS NULL
  OR passenger_count IS NULL
  OR trip_distance IS NULL
  OR pickup_longitude IS NULL
  OR pickup_latitude IS NULL
  OR RatecodeID IS NULL
  OR store_and_fwd_flag IS NULL
  OR dropoff_longitude IS NULL
  OR dropoff_latitude IS NULL
  OR payment_type IS NULL
  OR fare_amount IS NULL
  OR extra IS NULL
  OR mta_tax IS NULL
  OR tip_amount IS NULL
  OR tolls_amount IS NULL
  OR improvement_surcharge IS NULL
  OR total_amount IS NULL;


/*checking NULL*/
SELECT
  *
FROM
  analytics-406018.data.table_dbms_transformed
WHERE
   pickup_datetime IS NULL
  OR pickup_day_of_week IS NULL
  OR pickup_hour IS NULL
  OR passenger_count IS NULL
  OR trip_distance IS NULL
  OR total_payment IS NULL
  OR payment_type IS NULL
  OR payment_method IS NULL
  OR pickup_location IS NULL
  OR dropoff_location IS NULL
