--Patrones temporales (mes, día, hora)
--Viajes por Mes
SELECT
  EXTRACT(MONTH FROM pickup_datetime) AS month,
  COUNT(*) AS trips,
  AVG(trip_distance) AS avg_distance,
  AVG(total_amount) AS avg_total,
  AVG(tip_amount) AS avg_tip
FROM `bigquery-public-data.new_york_taxi_trips.tlc_yellow_trips_2022`
GROUP BY month
ORDER BY month;

--Viajes por dia
SELECT
  EXTRACT(DAYOFWEEK FROM pickup_datetime) AS day_of_week,
  COUNT(*) AS trips,
  AVG(total_amount) AS avg_total,
  AVG(tip_amount) AS avg_tip
FROM `bigquery-public-data.new_york_taxi_trips.tlc_yellow_trips_2022`
GROUP BY day_of_week
ORDER BY day_of_week;

--Viajes por hora
SELECT
  EXTRACT(HOUR FROM pickup_datetime) AS hour,
  COUNT(*) AS trips,
  AVG(trip_distance) AS avg_distance,
  AVG(total_amount) AS avg_total,
  AVG(tip_amount) AS avg_tip
FROM `bigquery-public-data.new_york_taxi_trips.tlc_yellow_trips_2022`
GROUP BY hour
ORDER BY hour;

--mapa de calor
SELECT
  EXTRACT(DAYOFWEEK FROM pickup_datetime) AS day_of_week,
  EXTRACT(HOUR FROM pickup_datetime) AS hour,
  COUNT(*) AS trips,
  AVG(total_amount) AS avg_total
FROM `bigquery-public-data.new_york_taxi_trips.tlc_yellow_trips_2022`
GROUP BY day_of_week, hour
ORDER BY day_of_week, hour;
