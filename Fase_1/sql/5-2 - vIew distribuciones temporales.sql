CREATE OR REPLACE VIEW `seminario-sistemas-2-481904.fase_1.v_dist_pago_q1` AS
SELECT
  payment_type,
  COUNT(*) AS trips,
  ROUND(100 * COUNT(*) / SUM(COUNT(*)) OVER(), 2) AS pct_trips,
  AVG(total_amount) AS avg_total,
  AVG(tip_amount) AS avg_tip,
  AVG(SAFE_DIVIDE(tip_amount, NULLIF(fare_amount, 0))) AS avg_tip_rate
FROM `seminario-sistemas-2-481904.fase_1.trips_q1_opt`
WHERE DATE(pickup_datetime) BETWEEN '2022-01-01' AND '2022-03-31'
GROUP BY payment_type;


CREATE OR REPLACE VIEW `seminario-sistemas-2-481904.fase_1.v_dist_pasajeros_q1` AS
SELECT
  passenger_count,
  COUNT(*) AS trips,
  ROUND(100 * COUNT(*) / SUM(COUNT(*)) OVER(), 2) AS pct_trips,
  AVG(trip_distance) AS avg_distance,
  AVG(total_amount) AS avg_total
FROM `seminario-sistemas-2-481904.fase_1.trips_q1_opt`
WHERE DATE(pickup_datetime) BETWEEN '2022-01-01' AND '2022-03-31'
GROUP BY passenger_count;


CREATE OR REPLACE VIEW `seminario-sistemas-2-481904.fase_1.v_pago_vs_pasajeros_q1` AS
SELECT
  payment_type,
  passenger_count,
  COUNT(*) AS trips,
  AVG(total_amount) AS avg_total,
  AVG(tip_amount) AS avg_tip
FROM `seminario-sistemas-2-481904.fase_1.trips_q1_opt`
WHERE DATE(pickup_datetime) BETWEEN '2022-01-01' AND '2022-03-31'
GROUP BY payment_type, passenger_count;
