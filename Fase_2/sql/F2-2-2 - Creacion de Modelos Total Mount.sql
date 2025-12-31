CREATE OR REPLACE MODEL `seminario-sistemas-2-481904.fase_2.m_cost_linreg`
OPTIONS(
  model_type = 'LINEAR_REG',
  input_label_cols = ['label']
) AS
SELECT * FROM `seminario-sistemas-2-481904.fase_2.v_train_cost`;

CREATE OR REPLACE MODEL `seminario-sistemas-2-481904.fase_2.m_cost_btree`
OPTIONS(
  model_type = 'BOOSTED_TREE_REGRESSOR',
  input_label_cols = ['label'],
  max_iterations = 50
) AS
SELECT * FROM `seminario-sistemas-2-481904.fase_2.v_train_cost`;

