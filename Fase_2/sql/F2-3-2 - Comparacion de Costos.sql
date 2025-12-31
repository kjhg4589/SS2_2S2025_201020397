SELECT
  'LINEAR_REG' AS model,
  *
FROM `seminario-sistemas-2-481904.fase_2.eval_cost_linreg`

UNION ALL

SELECT
  'BTREE_REGRESSOR' AS model,
  *
FROM `seminario-sistemas-2-481904.fase_2.eval_cost_btree`
ORDER BY model;
