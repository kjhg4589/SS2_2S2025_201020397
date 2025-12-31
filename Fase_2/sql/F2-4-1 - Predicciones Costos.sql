CREATE OR REPLACE TABLE `seminario-sistemas-2-481904.fase_2.pred_cost_btree_test` AS
WITH test AS (
  SELECT
    ROW_NUMBER() OVER() AS row_id,
    *
  FROM `seminario-sistemas-2-481904.fase_2.v_test_cost`
),
pred AS (
  SELECT
    row_id,
    predicted_label AS cost_pred
  FROM ML.PREDICT(
    MODEL `seminario-sistemas-2-481904.fase_2.m_cost_btree`,
    (
      SELECT
        row_id,
        trip_distance,
        passenger_count,
        pickup_hour,
        pickup_dow,
        pickup_location_id,
        dropoff_location_id
      FROM test
    )
  )
)
SELECT
  t.row_id,
  t.label AS cost_real,
  p.cost_pred,
  (t.label - p.cost_pred) AS error,
  ABS(t.label - p.cost_pred) AS abs_error,

  -- features para segmentar en el dashboard
  t.trip_distance,
  t.passenger_count,
  t.pickup_hour,
  t.pickup_dow,
  t.pickup_location_id,
  t.dropoff_location_id
FROM test t
JOIN pred p USING (row_id);
