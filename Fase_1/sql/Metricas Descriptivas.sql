-- Métricas descriptivas 
WITH base AS (
  SELECT
    trip_distance,
    fare_amount,
    tip_amount,
    total_amount,
    TIMESTAMP_DIFF(dropoff_datetime, pickup_datetime, MINUTE) AS duration_min
  FROM `bigquery-public-data.new_york_taxi_trips.tlc_yellow_trips_2022`
  WHERE pickup_datetime IS NOT NULL
    AND dropoff_datetime IS NOT NULL
),
clean AS (
  SELECT *
  FROM base
  WHERE duration_min BETWEEN 1 AND 240     
    AND trip_distance BETWEEN 0.1 AND 100  
    AND total_amount BETWEEN 0 AND 1000
)
SELECT
  COUNT(*) AS trips_clean,

  AVG(trip_distance) AS avg_distance,
  AVG(duration_min) AS avg_duration_min,
  AVG(fare_amount) AS avg_fare,
  AVG(tip_amount) AS avg_tip,
  AVG(total_amount) AS avg_total,

  AVG(SAFE_DIVIDE(tip_amount, NULLIF(fare_amount, 0))) AS avg_tip_rate
FROM clean;
