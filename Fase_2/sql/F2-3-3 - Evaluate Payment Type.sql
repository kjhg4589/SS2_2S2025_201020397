
CREATE OR REPLACE TABLE `seminario-sistemas-2-481904.fase_2.eval_pay_logreg` AS
SELECT *
FROM ML.EVALUATE(
  MODEL `seminario-sistemas-2-481904.fase_2.m_pay_logreg`,
  (SELECT * FROM `seminario-sistemas-2-481904.fase_2.v_test_payment`)
);

CREATE OR REPLACE TABLE `seminario-sistemas-2-481904.fase_2.eval_pay_btree` AS
SELECT *
FROM ML.EVALUATE(
  MODEL `seminario-sistemas-2-481904.fase_2.m_pay_btree`,
  (SELECT * FROM `seminario-sistemas-2-481904.fase_2.v_test_payment`)
);