# Лабораторная работа 5

**Тема:** Регрессия с применением Scikit-Learn (P3123) — предсказание цены на недвижимость

**Выполнил:** Ali Mahfod

## Цель

- Освоить задачу **регрессии** на данных King County (цены на дома)
- Обучить линейную регрессию и Random Forest из борда, сравнить **MAE**, **MSE**, **RMSE**
- Подобрать гиперпараметры RF, сравнить дополнительные регрессоры
- Описать интеграцию модели с веб-API

## Задание

1. Локальная копия борда `s1p1-predict-house-price-tasks` (Jupyter)
2. Заполнить ячейки `# N. TO DO`
3. Самостоятельно: отбор признаков, tuning RF, другие модели, шаги деплоя
4. Ссылка на **открытый** `.ipynb` на GitHub (проверка в инкогнито)

## Ноутбук

| Где | Ссылка |
|-----|--------|
| Репозиторий | [github.com/AliMahfod/PyProg2026Lab5](https://github.com/AliMahfod/PyProg2026Lab5) |
| Ноутбук | [s1p1_predict_house_price_tasks.ipynb](https://github.com/AliMahfod/PyProg2026Lab5/blob/main/s1p1_predict_house_price_tasks.ipynb) |
| Просмотр (nbviewer) | [nbviewer — Lab 5](https://nbviewer.org/github/AliMahfod/PyProg2026Lab5/blob/main/s1p1_predict_house_price_tasks.ipynb) |

Данные: `predict_house_price_training_data.xlsx`, `predict_house_price_test_data.xlsx` в том же репозитории.

## Сравнение моделей (тестовая выборка, 6 484 записи)

| Модель | MAE | RMSE |
|--------|-----|------|
| HistGradientBoosting | **67 799.61** | **121 248.83** |
| Gradient Boosting | 73 117.15 | 128 346.60 |
| Random Forest (n=100) | 70 896.79 | 135 516.61 |
| Random Forest (tuned) | 70 507.28 | 135 725.17 |
| Random Forest (борд, 10 деревьев) | 70 639.11 | 135 745.61 |
| Extra Trees | 71 858.68 | 137 533.17 |
| kNN (k=15) | 90 774.15 | 169 100.95 |
| SVR (RBF) | 91 334.36 | 195 688.54 |
| Ridge (scaled) | ~126 716 | ~201 863 |
| Linear Regression (борд) | 126 852.51 | 201 883.24 |

**Замечания:**

- The table is sorted by **RMSE** (lower is better). **HistGradientBoosting** beats the board models — that is the goal of the independent work.
- **Random Forest (tuned)** can score slightly *worse* on the hold-out test than RF with 10 or 100 trees: `GridSearchCV` optimizes **cross-validation**, not the test set. Small RMSE differences (~200) are normal.
- **ElasticNet** in the notebook used unscaled features and hit a `ConvergenceWarning`; Ridge/ElasticNet should use `StandardScaler` (fixed in the repo). Unscaled ElasticNet metrics (~212 856 RMSE) are not comparable to the board LR line.
- Board reference: LR **MAE ≈ 126 853**, RF **RMSE ≈ 137 104** (10 trees, as in the assignment notebook).

### Отбор признаков (5 наименее важных)

Удалены: *Год реновации*, *Количество этажей*, *Состояние*, *Спальни*, *Просмотрены ранее*. Для RF (`n_estimators=100`): все признаки **MAE 70 897 / RMSE 135 517**; без пяти слабых — **MAE 72 571 / RMSE 137 907** (небольшое **ухудшение**), то есть даже слабые столбцы дают небольшой вклад в ансамбль.

## Самостоятельная работа

### Дополнительные методы

**Ridge**, **ElasticNet**, **SVR**, **kNN**, **Gradient Boosting**, **HistGradientBoosting**, **Extra Trees** — сводка в `results_df` в ноутбуке. Обзор регрессии в sklearn: [Habr — Mail.ru](https://habr.com/ru/company/mailru/blog/513842/), [ODS](https://habr.com/ru/companies/ods/articles/645887/).

### Интеграция с веб-сервисом (FastAPI / Flask)

1. Обучить модель на полной обучающей выборке  
2. `joblib.dump({"model": reg, "features": list(X.columns)}, "house_price.joblib")`  
3. FastAPI: `POST /predict` с JSON признаков (площадь, координаты, …)  
4. При старте: `payload = joblib.load(...)`; `model.predict([vector])`  
5. Ответ: `{"price": float}`  
6. Запуск: `uvicorn app:app` или `flask run`; опционально Docker + pydantic  

## Выводы

- Пройден ML-пайплайн регрессии: EDA → разделение X/y → обучение → MAE/RMSE на тесте.
- Нелинейные ансамбли (RF, бустинг) сильно лучше линейной модели на этих признаках.
- Важнейшие фичи: жилая площадь, оценка риелтора, геолокация (широта).
- Модель можно вынести в REST API через `joblib`.
