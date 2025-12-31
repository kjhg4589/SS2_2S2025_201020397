CREATE OR REPLACE TABLE `seminario-sistemas-2-481904.fase_2.pred_payment_btree_test` AS
WITH features AS (
  SELECT
    ROW_NUMBER() OVER() AS row_id,
    label,
    trip_distance,
    passenger_count,
    pickup_hour,
    pickup_dow,
    pickup_location_id,
    dropoff_location_id
  FROM `seminario-sistemas-2-481904.fase_2.v_test_payment`
),
pred AS (
  SELECT
    row_id,
    predicted_label AS pay_pred,                             
    predicted_label_probs[OFFSET(1)].prob AS p_card          
  FROM ML.PREDICT(
    MODEL `seminario-sistemas-2-481904.fase_2.m_pay_btree`,
    (SELECT
       row_id,
       trip_distance,
       passenger_count,
       pickup_hour,
       pickup_dow,
       pickup_location_id,
       dropoff_location_id
     FROM features)
  )
)
SELECT
  f.row_id,
  f.pickup_location_id,
  f.dropoff_location_id,
  f.passenger_count,
  f.trip_distance,
  f.label AS pay_real,               
  p.pay_pred,                        
  p.p_card,
  IF(f.label = p.pay_pred, 1, 0) AS correct
FROM features f
JOIN pred p USING (row_id);
