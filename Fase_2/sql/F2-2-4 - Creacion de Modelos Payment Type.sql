CREATE OR REPLACE MODEL `seminario-sistemas-2-481904.fase_2.m_pay_logreg`
OPTIONS(
  model_type = 'LOGISTIC_REG',
  input_label_cols = ['label']
) AS
SELECT * FROM `seminario-sistemas-2-481904.fase_2.v_train_payment`;

CREATE OR REPLACE MODEL `seminario-sistemas-2-481904.fase_2.m_pay_btree`
OPTIONS(
  model_type = 'BOOSTED_TREE_CLASSIFIER',
  input_label_cols = ['label'],
  max_iterations = 50
) AS
SELECT * FROM `seminario-sistemas-2-481904.fase_2.v_train_payment`;
