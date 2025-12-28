CREATE OR REPLACE TABLE `seminario-sistemas-2-481904.fase_1.yellow_2022_subset` AS
SELECT
  pickup_datetime,
  dropoff_datetime,
  pickup_location_id,
  dropoff_location_id,
  passenger_count,
  trip_distance,
  fare_amount,
  tip_amount,
  total_amount,
  payment_type
FROM `bigquery-public-data.new_york_taxi_trips.tlc_yellow_trips_2022`
WHERE pickup_datetime IS NOT NULL
  AND dropoff_datetime IS NOT NULL;

--TABLA LIMPIA
CREATE OR REPLACE TABLE `seminario-sistemas-2-481904.fase_1.trips_q1_clean` AS
SELECT pickup_datetime
    , dropoff_datetime
    , DATE(pickup_datetime) AS pk_datetime
    , EXTRACT(MONTH FROM pickup_datetime) pickup_month
    , EXTRACT(HOUR FROM pickup_datetime) pickup_hour
    , EXTRACT(DAYOFWEEK FROM pickup_datetime) pickup_dow

    , pickup_location_id
    , dropoff_location_id
    , passenger_count
    , trip_distance
    , fare_amount
    , tip_amount
    , total_amount
    , payment_type

    , TIMESTAMP_DIFF(dropoff_datetime, pickup_datetime, MINUTE) AS duration_min

    , CASE payment_type
       WHEN '1' THEN 'Credit Card'
       WHEN '2' THEN 'Cash'
       WHEN '3' THEN 'No charge'
       WHEN '4' THEN 'Dispute'
       WHEN '5' THEN 'Unknoe'
       WHEN '6' THEN 'Voided Trip'
       ELSE 'OTHER'
      END AS ayment_type_desc

FROM `bigquery-public-data.new_york_taxi_trips.tlc_yellow_trips_2022`
 WHERE pickup_datetime IS NOT NULL
   AND dropoff_datetime IS NOT NULL


-- PARTICION Y CLUSTER
CREATE OR REPLACE TABLE `seminario-sistemas-2-481904.fase_1.trips_q1_opt` 
PARTITION BY DATE(pickup_datetime)
CLUSTER BY pickup_location_id, dropoff_location_id 
AS
SELECT pickup_datetime
    , dropoff_datetime

    , DATE(pickup_datetime) AS pk_datetime
    , EXTRACT(MONTH FROM pickup_datetime) pickup_month
    , EXTRACT(HOUR FROM pickup_datetime) pickup_hour
    , EXTRACT(DAYOFWEEK FROM pickup_datetime) pickup_dow

    , pickup_location_id
    , dropoff_location_id

    , passenger_count
    , trip_distance
    , fare_amount
    , tip_amount
    , total_amount
    , payment_type

    , TIMESTAMP_DIFF(dropoff_datetime, pickup_datetime, MINUTE) AS duration_min

    , CASE payment_type
       WHEN '1' THEN 'Credit Card'
       WHEN '2' THEN 'Cash'
       WHEN '3' THEN 'No charge'
       WHEN '4' THEN 'Dispute'
       WHEN '5' THEN 'Unknoe'
       WHEN '6' THEN 'Voided Trip'
       ELSE 'OTHER'
      END AS ayment_type_desc

FROM `bigquery-public-data.new_york_taxi_trips.tlc_yellow_trips_2022`
 WHERE pickup_datetime IS NOT NULL
   AND dropoff_datetime IS NOT NULL

  
  