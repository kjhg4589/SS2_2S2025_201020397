SELECT
  'LOGISTIC' AS model,
  roc_auc,
  accuracy,
  precision,
  recall,
  f1_score,
  log_loss
FROM `seminario-sistemas-2-481904.fase_2.eval_pay_logreg`

UNION ALL

SELECT
  'BTREE' AS model,
  roc_auc,
  accuracy,
  precision,
  recall,
  f1_score,
  log_loss
FROM `seminario-sistemas-2-481904.fase_2.eval_pay_btree`
ORDER BY model;