
-- LINEAR REGRESSION
CREATE OR REPLACE TABLE `seminario-sistemas-2-481904.fase_2.eval_cost_linreg` AS
SELECT *
FROM ML.EVALUATE(
  MODEL `seminario-sistemas-2-481904.fase_2.m_cost_linreg`,
  (SELECT * FROM `seminario-sistemas-2-481904.fase_2.v_test_cost`)
);

-- BOOSTED TREE REGRESSOR
CREATE OR REPLACE TABLE `seminario-sistemas-2-481904.fase_2.eval_cost_btree` AS
SELECT *
FROM ML.EVALUATE(
  MODEL `seminario-sistemas-2-481904.fase_2.m_cost_btree`,
  (SELECT * FROM `seminario-sistemas-2-481904.fase_2.v_test_cost`)
);
