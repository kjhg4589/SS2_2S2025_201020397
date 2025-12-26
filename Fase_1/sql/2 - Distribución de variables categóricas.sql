--Distribución de variables categóricas
--Distribución por metodo de pago
SELECT
  payment_type,
  COUNT(*) AS trips,
  ROUND(100 * COUNT(*) / SUM(COUNT(*)) OVER(), 2) AS pct_trips,
  AVG(total_amount) AS avg_total,
  AVG(tip_amount) AS avg_tip
FROM `bigquery-public-data.new_york_taxi_trips.tlc_yellow_trips_2022`
GROUP BY payment_type
ORDER BY trips DESC;

--Distribución por cantidad de pasajeros
SELECT
  passenger_count,
  COUNT(*) AS trips,
  ROUND(100 * COUNT(*) / SUM(COUNT(*)) OVER(), 2) AS pct_trips,
  AVG(trip_distance) AS avg_distance,
  AVG(total_amount) AS avg_total
FROM `bigquery-public-data.new_york_taxi_trips.tlc_yellow_trips_2022`
GROUP BY passenger_count
ORDER BY passenger_count;

--Pago vs Pasajeros
SELECT
  payment_type,
  passenger_count,
  COUNT(*) AS trips,
  AVG(total_amount) AS avg_total,
  AVG(tip_amount) AS avg_tip
FROM `bigquery-public-data.new_york_taxi_trips.tlc_yellow_trips_2022`
GROUP BY payment_type, passenger_count
ORDER BY payment_type, passenger_count;
