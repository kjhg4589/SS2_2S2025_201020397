CREATE OR REPLACE VIEW `seminario-sistemas-2-481904.fase_1.v_metricas_descriptivas_q1` AS
SELECT
  COUNT(*) AS total_trips,

  AVG(trip_distance) AS avg_distance,
  MIN(trip_distance) AS min_distance,
  MAX(trip_distance) AS max_distance,
  APPROX_QUANTILES(trip_distance, 100)[OFFSET(50)] AS median_distasnce,

  AVG(TIMESTAMP_DIFF(dropoff_datetime, pickup_datetime, MINUTE)) AS avg_duration_min,
  MIN(TIMESTAMP_DIFF(dropoff_datetime, pickup_datetime, MINUTE)) AS min_duration_min,
  MAX(TIMESTAMP_DIFF(dropoff_datetime, pickup_datetime, MINUTE)) AS max_duration_min,
  APPROX_QUANTILES(TIMESTAMP_DIFF(dropoff_datetime, pickup_datetime, MINUTE), 100)[OFFSET(50)] AS median_duration_min,

  AVG(fare_amount) AS avg_fare,
  MIN(fare_amount) AS min_fare,
  MAX(fare_amount) AS max_fare,
  APPROX_QUANTILES(fare_amount, 100)[OFFSET(50)] AS median_fare,

  AVG(tip_amount) AS avg_tip,
  MIN(tip_amount) AS min_tip,
  MAX(tip_amount) AS max_tip,
  APPROX_QUANTILES(tip_amount, 100)[OFFSET(50)] AS median_tip,

  AVG(total_amount) AS avg_total,
  MIN(total_amount) AS min_total,
  MAX(total_amount) AS max_total,
  APPROX_QUANTILES(total_amount, 100)[OFFSET(50)] AS median_total,

  AVG(SAFE_DIVIDE(tip_amount, NULLIF(fare_amount, 0))) AS avg_tip_rate
FROM `seminario-sistemas-2-481904.fase_1.trips_q1_opt`
WHERE DATE(pickup_datetime) BETWEEN '2022-01-01' AND '2022-03-31';
