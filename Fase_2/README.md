# Proyecto Fase 2 – Modelado Predictivo con BigQuery ML

## Universidad de San Carlos de Guatemala  
**Facultad:** Ingeniería  
**Carrera:** Ingeniería en Ciencias y Sistemas  
**Curso:** Seminario de Sistemas 2  

---

- Kevin Josue Hernandez Gomez - 201020397


---

## 2. Objetivo del proyecto
El objetivo de esta fase es diseñar, entrenar y evaluar modelos predictivos
utilizando BigQuery ML sobre el dataset NYC Taxi Trips 2022, con el fin de
predecir una variable relevante del negocio y contrastar los valores reales
frente a los valores predichos mediante visualizaciones interactivas.

---

## 3. Dataset utilizado
Se utilizaron las tablas derivadas y optimizadas creadas en la **Fase 1**,
particularmente la tabla:

- `fase_1.trips_q1_opt`

La tabla se encuentra particionada por fecha y clusterizada por ubicación,
permitiendo un procesamiento eficiente y controlado de costos.

---

## 4. Definición del problema de predicción

En esta fase se abordaron dos problemas de predicción complementarios,
utilizando técnicas de aprendizaje automático implementadas directamente
en BigQuery ML:

- **Predicción del costo total del viaje (`total_amount`)**  
  Se modeló como un problema de **regresión**, con el objetivo de estimar el
  monto total que pagará un pasajero a partir de características como la
  distancia del viaje, la cantidad de pasajeros, la hora del día y las
  ubicaciones de origen y destino.

- **Predicción del método de pago (`payment_type`)**  
  Se modeló como un problema de **clasificación**, cuyo objetivo es determinar
  el método de pago más probable para un viaje, a partir de variables
  operativas y temporales del mismo.

Ambos problemas fueron seleccionados por su relevancia directa en el contexto
del negocio de transporte urbano, ya que permiten anticipar ingresos y
comprender patrones de comportamiento de los usuarios, aportando valor a la
toma de decisiones operativas y estratégicas.


---

## 5. Preparación de los datos

Previo al entrenamiento de los modelos predictivos, se realizó un proceso de
preparación y transformación de los datos con el objetivo de garantizar la
calidad de la información y la validez de los resultados obtenidos.

Las principales actividades realizadas fueron:

- **Selección de variables independientes (features)**  
  Se eligieron variables relevantes desde el punto de vista operativo y
  temporal, tales como la distancia del viaje, la cantidad de pasajeros,
  la hora del día, el día de la semana y las ubicaciones de origen y destino.

- **Creación de variables derivadas**  
  A partir del campo de fecha y hora del viaje se generaron variables como
  la hora de recogida y el día de la semana, las cuales permiten capturar
  patrones temporales en el comportamiento de los viajes.

- **Filtrado de registros inválidos o atípicos**  
  Se excluyeron viajes con valores inconsistentes, tales como distancias
  negativas o nulas, duraciones inválidas y cantidades de pasajeros fuera
  de rangos razonables, con el fin de reducir el ruido en los datos.

- **Prevención de fugas de información (*data leakage*)**  
  Para evitar el uso de información que no estaría disponible al momento de
  realizar una predicción real, se excluyeron variables directamente
  relacionadas con la variable objetivo del conjunto de características
  utilizadas durante el entrenamiento.

--- 
## 6. División de datos (Train / Test)

Los datos fueron divididos en conjuntos de entrenamiento y prueba con el fin
de evaluar el desempeño de los modelos de manera objetiva y reproducible.

- **Entrenamiento:** 80% de los registros  
- **Prueba:** 20% de los registros  

La estrategia de división utilizada fue **aleatoria controlada**, implementada
mediante una función hash (`FARM_FINGERPRINT`) aplicada sobre un conjunto de
campos del viaje. Esta técnica permite asignar cada registro de forma
determinística a uno de los conjuntos, asegurando que la misma observación no
aparezca simultáneamente en entrenamiento y prueba.

Esta estrategia garantiza una evaluación consistente del desempeño de los
modelos, manteniendo una distribución representativa de los datos en ambos
conjuntos.


---

## 7. Modelos implementados

Para abordar los problemas de predicción definidos, se entrenaron modelos
utilizando BigQuery ML, seleccionando algoritmos adecuados según la naturaleza
de cada variable objetivo.

### 7.1 Predicción del costo total del viaje (Regresión)

- **Modelo 1: Regresión Lineal (`LINEAR_REG`)**  
  - **Objetivo:** Estimar el costo total del viaje (`total_amount`) a partir de
    variables operativas y temporales.  
  - **Justificación:** Este modelo fue utilizado como línea base por su
    simplicidad e interpretabilidad, permitiendo identificar relaciones
    lineales entre las variables independientes y la variable objetivo.

- **Modelo 2: Árboles Potenciados (`BOOSTED_TREE_REGRESSOR`)**  
  - **Objetivo:** Estimar el costo total del viaje (`total_amount`).  
  - **Justificación:** Este modelo permite capturar relaciones no lineales y
    combinaciones complejas entre las variables, lo que suele resultar en un
    mejor desempeño predictivo en problemas de regresión con múltiples
    factores.

---

### 7.2 Predicción del método de pago (Clasificación)

- **Modelo 3: Regresión Logística (`LOGISTIC_REG`)**  
  - **Objetivo:** Clasificar el método de pago del viaje, modelado como un
    problema de clasificación binaria (tarjeta vs efectivo).  
  - **Justificación:** La regresión logística es un modelo ampliamente utilizado
    en problemas de clasificación binaria, ofreciendo una interpretación clara
    de las probabilidades asociadas a cada clase.

- **Modelo 4: Árboles Potenciados (`BOOSTED_TREE_CLASSIFIER`)**  
  - **Objetivo:** Clasificar el método de pago del viaje.  
  - **Justificación:** Este modelo fue incluido para capturar relaciones no
    lineales entre las variables explicativas y el método de pago, permitiendo
    comparar su desempeño frente a un modelo lineal de referencia.


---

## 8. Evaluación de modelos

El desempeño de los modelos entrenados fue evaluado utilizando la función
`ML.EVALUATE` de BigQuery ML, aplicando el mismo conjunto de datos de prueba
para garantizar una comparación justa entre los modelos.

### Métricas utilizadas

- **Modelos de regresión (costo del viaje):**
  - *Mean Absolute Error (MAE)*
  - *Root Mean Squared Error (RMSE)*
  - *R² Score*

- **Modelos de clasificación (método de pago):**
  - *Accuracy*
  - *Precision*
  - *Recall*
  - *F1-Score*
  - *ROC AUC*

Estas métricas permiten evaluar tanto la precisión de las predicciones como
la capacidad de generalización de cada modelo.

---

### Comparación de desempeño

Los resultados obtenidos para cada par de modelos fueron comparados utilizando
las métricas correspondientes a su tipo de problema. Para la regresión, se
analizó la reducción del error entre el modelo lineal y el modelo de árboles
potenciados. Para la clasificación, se compararon las métricas de exactitud y
discriminación entre la regresión logística y el clasificador basado en
árboles.

Esta comparación permitió identificar el modelo con mejor desempeño para cada
problema de predicción, el cual fue seleccionado para la generación de
predicciones y su posterior visualización.

---

## 9. Modelo seleccionado y justificación
Con base en las métricas obtenidas y consideraciones de interpretabilidad
y desempeño, se seleccionó el modelo:

- **Modelo final:** Modelo 1 

Este modelo presentó mejores resultados para el problema planteado.

---

## 10. Generación de predicciones
Se generaron predicciones sobre el conjunto de prueba utilizando
`ML.PREDICT`, almacenando los resultados en una tabla/vista para su
posterior análisis y visualización.

---

## 11. Visualización de resultados
Se desarrolló un tablero interactivo en Google Looker Studio
que permite:

- Comparar valores reales vs valores predichos
- Analizar el error del modelo
- Visualizar el comportamiento de las predicciones por variables relevantes

🔗 **Enlace al tablero:**  
(Agregar enlace aquí)

---

## 12. Hallazgos relevantes
Entre los principales hallazgos se identificaron:

- (Ejemplo: mejor desempeño del modelo en ciertos rangos horarios)
- (Ejemplo: mayor error en viajes de larga distancia)
- (Ejemplo: variables con mayor impacto en la predicción)

---

## 13. Consideraciones sobre sesgos y limitaciones
Se identifican posibles sesgos en los datos, como variaciones por zona o
horario, los cuales pueden influir en las predicciones del modelo y deben
ser considerados al interpretar los resultados.

---

## 14. Organización del repositorio
La estructura del repositorio para la Fase 2 es la siguiente:

```text
Fase_2/
│
├── sql/
│   ├── preparacion_datos.sql
│   ├── entrenamiento_modelo_1.sql
│   ├── entrenamiento_modelo_2.sql
│   ├── evaluacion_modelos.sql
│   └── predicciones.sql
│
├── evidencias/
│   ├── entrenamiento_modelos.png
│   ├── metricas_evaluacion.png
│   └── predicciones.png
│
└── README.md
