![logo_ironhack_blue 7](https://user-images.githubusercontent.com/23629340/40541063-a07a0a8a-601a-11e8-91b5-2f13e4e6b441.png)

# Proyecto de Análisis de Datos End to End | Attrition predictive model

<details>
  <summary>
   <h2>Introducción</h2>
  </summary>

La Society for Human Resource Management (SHRM) estima que el costo de reemplazar a un empleado puede variar entre el 50 % y el 200 % de su salario anual. Por ejemplo, reemplazar a un empleado que gana $50,000 podría costar entre $25,000 y $100,000. Además, un estudio de Gallup informa que las empresas con alta retención de empleados logran un 21 % más de rentabilidad y un 17 % más de productividad en comparación con aquellas con altas tasas de rotación.

Este proyecto tiene como objetivo desarrollar una herramienta que no solo prediga los riesgos asociados con la rotación de empleados, sino que también aumente la conciencia sobre las acciones más críticas necesarias para retener a los empleados en cualquier organización.

El conjunto de datos se obtuvo de una competencia en línea en HackerEarth. HackerEarth posee los derechos para extraer y usar estos datos. La información fue recuperada de:

Conjunto de datos de Kaggle: https://www.kaggle.com/datasets/blurredmachine/hackerearth-employee-attrition/data?select=Train.csv
Problema práctico de HackerEarth: https://www.hackerearth.com/practice/machine-learning/machine-learning-algorithms/beginners-guide-regression-analysis-plot-interpretations/practice-problems/machine-learning/predict-the-employee-attrition-rate-in-organizations-1d700a97/.
El modelo y el análisis también se verificaron con el proyecto de Rasmo Wanyama en https://github.com/rasmodev/Employee-Attrition-Prediction?tab=MIT-1-ov-file.

MIT License

Copyright (c) 2024 Rasmo Wanyama

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

  <br>
  <hr> 

</details>

<details>
  <summary>
   <h2>Objetivos</h2>
  </summary>

Este proyecto está sujeto a evaluación por parte de Ironhack, lo que requiere cumplir con los siguientes objetivos:

Recopilación de datos.
Limpieza de datos.
Manipulación de datos.
Análisis exploratorio de datos (EDA).
Ingeniería de características.
Preprocesamiento.
Selección de modelo.
Evaluación del modelo.
Visualización de datos.

  <br>
  <hr> 

</details>

![image.png](attachment:f0a597b1-ab5e-44ec-bdda-614f31304501.png)

## EDA Linea de trabajo Inicial

Analizando la calidad de los datos, se identifica que existen filas sin información completa, en este caso se procede a aplicar la moda o media para completar dichos valores.
- La edad máxima es de 65 años y la mínima de 19.
- Podemos eliminar la columna de Employee_ID porque ya hemos comprobado que todos los valores son únicos.
- La columna de Hometown puede llegar a ser transformada en otra numérica como población, por si tuviera alguna relación con la aceptación de la presión y cultura. También podemos llegar a analizar posteriormente cómo la localización entre norte/sur, este/oeste puede afectar a la cultura. Considero que tener conocimiento de la residencia actual puede aportar mucho más al attrition rate. Procedo a hacer uso la transformación de esta variable como nivel de tasa de desempleo, suponiendo que tiene una influencia en su cultura que en su ciudad natal haya mayor o menor tasa de desempleo.
*Posible línea de trabajo desestimada por priorización, procedo con el uso de dummies para la clasificación de las categóricas por falta de información de la fecha de obtención de estos datos. INICIO*
Este campo puede personalizarse teniendo en cuenta la fuente de datos clasificado por industrias y para cada persona del estudio, en este caso no haré tal tratamiento y utilizaré valores totales.
Valores tomados de la oficina de estadística laboral de estados unidos, https://www.bls.gov/lau/lamtrk23.htm, de 2023 por estado al que pertenece cada ciudad.
Lebanon (Ohio 3.5) 
Springfield (Illinois 4.5)
Franklin (Tennessee 3.3)
Washington (Virginia 2.9)
Clinton (Mississippi 3.2)
*Posible línea de trabajo desestimada por priorización, procedo con el uso de dummies para la clasificación de las categóricas por falta de información de la fecha de obtención de estos datos. FIN*

- Las Variables VAR son anónimas, por lo que para cumplir el objetivo de ser una herramienta para el futuro, estas variables serán eliminadas del dataset.
- Teniendo en cuenta la población de tipos de beneficios sociales otorgados, siendo los extremos muy poco poblados, voy a transformar en una variable binaria, haciendo una separación de beneficios superiores e inferiores, de esta forma doy más consistencia y robustez al dato.
- La población de la columna Units me supone un reto, ya que generar columnas dummy supondrá una variabilidad muy grande y preferiría que estuvieran más polarizadas. Pienso en la posibilidad de estudiar cada unidad para encontrar símiles entre ellas y aplicar características básicas según la unidad, utilizando documentación de buena calidad, pasando a 3 o 4 columnas. Teniendo en cuenta la característica de visión a largo plazo, determino añadir una columna binaria que cumpla con una diferenciación extra entre las Units. Operativo vs. Estratégico: Los departamentos con un enfoque más operativo, como Sales, Operations, y Logistics, suelen tener más empleados, ya que están involucrados en actividades cotidianas y en el flujo constante de trabajo. Los departamentos estratégicos, como R&D, HR y Accounting, tienen un enfoque a largo plazo y, generalmente, menos empleados.
Operativos: IT, Logistics, Sales, Operations, Purchasing, Production.
Estratégicos: R&D, Accounting and Finance, HR Management, Marketing, Quality, Security.
-Respecto a la variable de compensación y beneficios, se engloba los valores que contienen menos cantidad de población para hacer una binarización entre categoría media-baja y media-alta, siendo el Type4 la más alta.
Media baja --> 0
type0     187
type1     133
type2    3945
-----------
Media alta --> 1
type3    2382
type4     353

## EDA Linea de trabajo Catboost

El modelo predictivo de clasificación CatBoost permite hacer uso de valores categóricos sin necesidad de un preprocesado, por lo que la única eliminación necesaria es Employee_ID.



## Modelado Linea de trabajo Inicial

En búsqueda de la realización de una predicción numérica, de un valor entre 1 y 0, los modelos seleccionados han sido Regresión Lineal y Random Forest Regression.
Durante el desarrollo y ajuste de los modelos, los valores en los que trabajaban las predicciones es entorno al 0.2, esto es provocado por la información aportada por el modelo, la cual consta de una mayoritaria parte de empleados con ese valor, haciendo que el modelo completo se encuentre sesgado. En este caso se realizaron operaciones normalización y escalado logarítmico para conseguir un mejor comportamiento pero ambos modelos, pese haber hecho uso de optimización de hiperparámetros con más de 20 minutos de entrenamiento, los valores estaban demasiado condicionados y acababan en 0,1.
Los datos extraídos del las 3 versiones de los 2 modelos pueden encontrarse en la carpeta de Obsoletos, para su uso es necesario desempacar el contenido en la carpeta principal.
Teniendo en cuenta esta situación, donde los valores de R^2 se encontraban cercanos a 0 por el lado negativo, acabo desestimando su uso. Realizando un análisis de las columnas aportadas, identifico que el modelo requiere de una mayor complejidad hasta el punto de tratar de realizar pruebas con otras bases de datos, las cuales sí se comportaban correctamente con los modelos entrenados.

Este calle sin salida me llevó a investigar el trabajo realizado por Rasmo Wanyama, analista de datos de Nairobi County en Kenya, mediante su espacio en GitHub.

## Modelado Linea de trabajo Catboost

Rasmo Wanyama en su proyecto Employee Attrition Prediction cuenta con una base de datos con tendencias claras, que permiten un nivel mayor de análisis post desarrollo de modelo. El modelo del señor Rasmo Wanyama consigue una precisión superior al 86%, con una cantidad inferior de datos de la que yo disponía pero con una calidad mejor consigue un resultado muy positivo, aunque se trata de un modelo de clasificación y no de regresión como tenía planteado en un inicio.

Por lo tanto, mis datos, tras ser estudiada la población de niveles de Attrition mediante un pareto, considero que los valores de attrition, por ser los que menor cantidad se muestran y teniendo en cuenta que las personas con nivel alto de attrition no están en las empresas, este valor será superior a 0.3. Un Attrition True, corresponde a una persona con alto nivel de probabilidad de abandono y un False corresponde a uno con no salida inminente.

Hacer uso del modelo con la población antes comentada, supone una precisión entorno al 70%, no suficiente como para considerar que el modelo es óptimo.

Por ese motivo, hago uso de una herramienta utilizada en el proyecto de Rasmo Wayama nombrada como Oversampler, este módulo genera población de forma aleatoria para tener un equilibrio de datos entre los resultados positivos y los negativos. Gracias a esta tarea de balanceamiento, el modelo consigue llegar al 88% de precisión.

Por último, la clasificación, como herramienta en el uso real, está enfocada en hacer uso de los recuros para atender al personal que tiene más probabilidad de abandonar la empresa, por lo que necesito que la clasificación realice los menores falsos positivos posible, sin afectar enormemente a los falsos negativos. De esta forma aplico un thresh = 0.6, y consiguiendo una precisión de 89% con los valores de evaluación.

## Análisis de importancia

Esta fase está destinada a analizar el peso que demuestran tener las variables en el dataset de estudio, a mi entender, se trata de identificar el comportamiento de las personas en una empresa sin tener información en detalle, únicamente con valors objetivos y medibles. También se debe comprender, que este modelo puede contener diferentes distribuciones de importancia si la información proviniera de otra empresa, lo cual la dota de limitación básica, pero a su vez dispone de una gran flexibilidad encuanto el entrenamiento.

Con mi DATASET
Tras el análisis con el uso de la herramienta Bash, los campos de mayor impacto son:

Alta importancia categórica:
Unit
Compensation_and_Benefits
Hometown
Decision_skill_possess

Lado positivo True:
Valores bajos de Education_level


Lado negativo False:
Valores altos de Time_of_service

De este análisis podemos identificar que tener un nivel de eduación bajo, hace tener una probabilidad de abandono mayor, y a su vez, cuanto más tiempo estás en una empresa, más probabilidad hay de que continúes en esta.

Con el DATASET del señor Rasmo Wanyama

Alta importancia categórica:
JobRole
Department

Lado positivo True:
Valores altos de horas extras
Valores bajos de YearsWithCurrManager
Valores bajos de EnvironmentSatisfaction
Valores bajos de Salario

Lado negativo False:
Valores bajos de horas extras
Valores altos de JobSatisfaction

La mayor cantidad de variables numéricas en este dataset permite un análisis más concreta, haciendo que podamos identificar que realizar horas extras es un punto diferenciador vital en el modelo y que haber cambiado de jefe o llevar poco tiempo como jefe, supone un gran impacto en el aumento de la probabilidad de abandono. Finalmente se identifica claramente que valorar la satisfacción tiene un impacto muy grande en la decisión de abandono.

## Herramienta de predicción evolutiva

Uno de los objetivos de este proyecto es crear una herramienta que pueda utilizar el equipo de recursos humanos para prever la evolución de su equipo en cuanto a probabilidad de abandono. Para ello hago uso de las variables que tienen que ver con el tiempo y aplico una evolución de 24 meses en adelante para realizar predicciones parciales y así mostrar la evolución.

Esta predicción tiene en cuenta que el equipo de recursos humanos no realiza acciones para tratar de disminuir esta probabilidad y por lo tanto es un indicador ideal, con margen de error que tiene como función, hacer uso de estos datos como justificación de las acciones pertinentes, así como asignación de presupuestos.

En este bloque, es donde he resultado tener una respuesta la cual no pretendía resolver antes de empezar el proyecto, os diré por qué.

Tras realizar la graficación de los valores de Attrition pasados los meses, tanto en mi dataset, como en el del señor Rasmo Wanyamna, sorpresivamente, encuentro que cuando no toman ninguna acción y solo por el paso del tiempo, la probabilidad de abandono se ve reducida.

La reducción en 2 años es deste un 10% hasta un 30% con un 12% de error atribuído al modelo. Esto resulta esclarecedor cuando una persona que considera que quiere abandonar la empresa y esta no le indica que vaya a realizar ninguna acción para retenerle, únicamente en algunos casos la de aumento salarial. Es cierto que aumentar el salario tiene un impacto en la probabilidad de abandono, pero se trata de la 3a en valor de importancia y no demuestra ser totalmente diferenciadora mientras que otras sí lo son, como por ejemplo la EnvironmentSatisfaction.

Es posible, que los equipos de recursos humanos puedan interiorizar con el tiempo, que no realizar ninguna acción, "dejar pasar el tiempo", es suficiente para retener talento. Y es cierto que sí afecta en cuanto a la retención, y probabilísticamente tiene sentido y aplicación temporal en muchos casos, pero en estos casos, las otras variables pueden empezar a sentir un desgaste y evolución no contemplada en la herramienta.

Por último, quiero aclarar que los valores tan altos de abandono mostrados en el proyecto se deben al balanceo de los valores de entrenamiento mediante el oversampling.

## Pipeline

El pipeline creado sigue los pasos previos y propios de pipeline:

### Previo
Generación de Modelo (entrenamiento y evaluación)
Guardado de modelo

### Flujo
Rellenar cuestionario de Google Docs. (https://docs.google.com/forms/d/e/1FAIpQLSccDh3faFOi4aIeM9IgHzwcfL-dyBRgE1Jy0blQFgXbMIijkQ/viewform)
Exportar csv. (https://docs.google.com/spreadsheets/d/1acTNyZUaHN5RutekGCLvyJolMM-l9CvC_KD8Pdd8DlI/edit?gid=702761399#gid=702761399)
Importación de modelo en Jupyter.
Realizar predicción.
Generar csv de resultados.



## Recomendaciones

Las entrevistas de salida de los trabajadores deberán realizarse mediante los mismos términos que aquellos que se mantienen en la empresa para poder realizar una alimentación de datos significativa. 

Tener en cuenta que las transiciones a nuevos Managers son cruciales para que tu equipo no desee abandonar, los nuevos Managers deben estar debidamente capacitados para tomar el rol y ejercer como tal.

La realización de horas extras ataca principalmente y con mayor importancia al abandono, por lo que tratad de minimizarlas y contratad a más personal para suplirlas o bien para amortiguarlo, asociad a un aumento salarial suficiente como para no impactar negativamente.
