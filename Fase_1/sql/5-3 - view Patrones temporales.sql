CREATE OR REPLACE VIEW `seminario-sistemas-2-481904.fase_1.v_patron_mes_q1` AS
SELECT
  EXTRACT(MONTH FROM pickup_datetime) AS month,
  COUNT(*) AS trips,
  AVG(trip_distance) AS avg_distance,
  AVG(total_amount) AS avg_total,
  AVG(tip_amount) AS avg_tip
FROM `seminario-sistemas-2-481904.fase_1.trips_q1_opt`
WHERE DATE(pickup_datetime) BETWEEN '2022-01-01' AND '2022-03-31'
GROUP BY month;

CREATE OR REPLACE VIEW `seminario-sistemas-2-481904.fase_1.v_patron_dia_semana_q1` AS
SELECT
  EXTRACT(DAYOFWEEK FROM pickup_datetime) AS day_of_week,
  COUNT(*) AS trips,
  AVG(total_amount) AS avg_total,
  AVG(tip_amount) AS avg_tip
FROM `seminario-sistemas-2-481904.fase_1.trips_q1_opt`
WHERE DATE(pickup_datetime) BETWEEN '2022-01-01' AND '2022-03-31'
GROUP BY day_of_week;

CREATE OR REPLACE VIEW `seminario-sistemas-2-481904.fase_1.v_patron_hora_q1` AS
SELECT
  EXTRACT(HOUR FROM pickup_datetime) AS hour,
  COUNT(*) AS trips,
  AVG(trip_distance) AS avg_distance,
  AVG(total_amount) AS avg_total,
  AVG(tip_amount) AS avg_tip
FROM `seminario-sistemas-2-481904.fase_1.trips_q1_opt`
WHERE DATE(pickup_datetime) BETWEEN '2022-01-01' AND '2022-03-31'
GROUP BY hour;

CREATE OR REPLACE VIEW `seminario-sistemas-2-481904.fase_1.v_patron_dia_hora_q1` AS
SELECT
  EXTRACT(DAYOFWEEK FROM pickup_datetime) AS day_of_week,
  EXTRACT(HOUR FROM pickup_datetime) AS hour,
  COUNT(*) AS trips,
  AVG(total_amount) AS avg_total
FROM `seminario-sistemas-2-481904.fase_1.trips_q1_opt`
WHERE DATE(pickup_datetime) BETWEEN '2022-01-01' AND '2022-03-31'
GROUP BY day_of_week, hour;
