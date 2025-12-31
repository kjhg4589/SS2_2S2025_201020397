
SELECT
  'm_cost_linreg' AS model_name,
  *
FROM ML.TRAINING_INFO(MODEL `seminario-sistemas-2-481904.fase_2.m_cost_linreg`);

SELECT
  'm_cost_btree' AS model_name,
  *
FROM ML.TRAINING_INFO(MODEL `seminario-sistemas-2-481904.fase_2.m_cost_btree`);

SELECT
  'm_pay_logreg' AS model_name,
  *
FROM ML.TRAINING_INFO(MODEL `seminario-sistemas-2-481904.fase_2.m_pay_logreg`);

SELECT
  'm_pay_btree' AS model_name,
  *
FROM ML.TRAINING_INFO(MODEL `seminario-sistemas-2-481904.fase_2.m_pay_btree`);
