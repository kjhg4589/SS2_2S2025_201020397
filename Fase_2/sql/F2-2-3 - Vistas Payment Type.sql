-- TRAIN (80%)
CREATE OR REPLACE VIEW `seminario-sistemas-2-481904.fase_2.v_train_payment` AS
SELECT
  payment_type AS label,
  trip_distance,
  passenger_count,
  EXTRACT(HOUR FROM pickup_datetime) AS pickup_hour,
  EXTRACT(DAYOFWEEK FROM pickup_datetime) AS pickup_dow,
  pickup_location_id,
  dropoff_location_id
FROM `seminario-sistemas-2-481904.fase_1.trips_q1_opt`
WHERE DATE(pickup_datetime) BETWEEN '2022-01-01' AND '2022-03-31'
  AND payment_type IS NOT NULL
  AND trip_distance IS NOT NULL
  AND passenger_count IS NOT NULL
  AND dropoff_datetime > pickup_datetime
  AND trip_distance > 0
  AND passenger_count BETWEEN 1 AND 9
  AND MOD(ABS(FARM_FINGERPRINT(
      CONCAT(CAST(pickup_datetime AS STRING), '|', CAST(dropoff_datetime AS STRING), '|',
             pickup_location_id, '|', dropoff_location_id)
  )), 100) < 80;

-- TEST (20%)
CREATE OR REPLACE VIEW `seminario-sistemas-2-481904.fase_2.v_test_payment` AS
SELECT
  payment_type AS label,
  trip_distance,
  passenger_count,
  EXTRACT(HOUR FROM pickup_datetime) AS pickup_hour,
  EXTRACT(DAYOFWEEK FROM pickup_datetime) AS pickup_dow,
  pickup_location_id,
  dropoff_location_id
FROM `seminario-sistemas-2-481904.fase_1.trips_q1_opt`
WHERE DATE(pickup_datetime) BETWEEN '2022-01-01' AND '2022-03-31'
  AND payment_type IS NOT NULL
  AND trip_distance IS NOT NULL
  AND passenger_count IS NOT NULL
  AND dropoff_datetime > pickup_datetime
  AND trip_distance > 0
  AND passenger_count BETWEEN 1 AND 9
  AND MOD(ABS(FARM_FINGERPRINT(
      CONCAT(CAST(pickup_datetime AS STRING), '|', CAST(dropoff_datetime AS STRING), '|',
             pickup_location_id, '|', dropoff_location_id)
  )), 100) >= 80;
