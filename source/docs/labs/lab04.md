# Лабораторная работа 4

**Тема:** Классификация с применением Scikit-Learn (P3123) — предсказание дефолта по кредиту

**Выполнил:** Ali Mahfod

## Цель

- Освоить задачу **бинарной классификации** на данных Kaggle [*Give Me Some Credit*](https://www.kaggle.com/c/GiveMeSomeCredit)
- Обучить и сравнить классификаторы из борда и дополнительные модели
- Изучить метрики: **accuracy**, **confusion matrix**, **ROC-AUC**, **F1**, выбор порога
- Описать современные подходы и интеграцию модели с веб-API

## Задание

1. Локальная копия борда `s2p1-predict-credit-default-tasks` (Jupyter)
2. Заполнить ячейки `# N. TODO`
3. Самостоятельно: дополнительные классификаторы, таблица сравнения, обзор алгоритмов, шаги деплоя
4. Ссылка на **открытый** `.ipynb` на GitHub (проверка в инкогнито)

## Ноутбук

| Где | Ссылка |
|-----|--------|
| Репозиторий | [github.com/AliMahfod/PyProg2026Lab4](https://github.com/AliMahfod/PyProg2026Lab4) |
| Ноутбук | [s2p1_predict_credit_default_tasks.ipynb](https://github.com/AliMahfod/PyProg2026Lab4/blob/main/s2p1_predict_credit_default_tasks.ipynb) |
| Просмотр (nbviewer) | [nbviewer — Lab 4](https://nbviewer.org/github/AliMahfod/PyProg2026Lab4/blob/main/s2p1_predict_credit_default_tasks.ipynb) |

Данные: `training_data.csv`, `test_data.csv` в том же репозитории.

## Сравнение моделей (тестовая выборка, 37 500 записей)

| Модель | Accuracy | ROC-AUC | F1 |
|--------|----------|---------|-----|
| Gradient Boosting | 0.9358 | **0.8643** | 0.2869 |
| HistGradientBoosting | 0.9355 | 0.8622 | 0.2740 |
| AdaBoost | 0.9343 | 0.8583 | 0.2673 |
| Random Forest (tuned) | 0.8572 | 0.8573 | **0.3848** |
| Random Forest (борд) | 0.9338 | 0.8395 | 0.2682 |
| Extra Trees | 0.9327 | 0.8275 | 0.2538 |
| kNN (k=25) | 0.9315 | 0.7354 | 0.1021 |
| Gaussian Naive Bayes | 0.9321 | 0.6972 | 0.0428 |
| Logistic Regression (борд) | 0.9329 | 0.6911 | 0.0817 |
| SVM (RBF) | 0.9337 | 0.6610 | 0.0647 |
| Constant (всегда 0) | 0.9326 | 0.5000 | 0.0000 |

**Замечания:**

- При ~6% дефолтов **accuracy** почти как у константного классификатора (~0.93) — для скоринга важнее **ROC-AUC** и **F1** по классу 1.
- Лучший **ROC-AUC** на тесте: **Gradient Boosting** (0.8643); лучший **F1**: tuned **Random Forest** (0.3848).
- **SVM** и **kNN** (с `StandardScaler`) хуже леса и бустинга на этих признаках.

## Самостоятельная работа

### Дополнительные методы (Scikit-Learn)

Помимо LR и RF из борда: **SVM**, **kNN**, **Gradient Boosting**, **HistGradientBoosting**, **AdaBoost**, **Extra Trees**, **Gaussian NB** — сводная таблица строится в последней ячейке ноутбука (`results_df`).

### Современные алгоритмы (Kaggle / публикации)

На [Give Me Some Credit](https://www.kaggle.com/c/GiveMeSomeCredit) и в credit scoring чаще используют **XGBoost**, **LightGBM**, **CatBoost**, стекинг и калибровку вероятностей; в отчётах — **SHAP** для интерпретации.

### Интеграция с веб-сервисом (FastAPI / Flask)

1. `joblib.dump(model, "model.joblib")` после обучения  
2. REST API: `POST /predict` с JSON-признаками  
3. При старте: `model = joblib.load(...)`  
4. Ответ: вероятность дефолта (`predict_proba`)  
5. Запуск: `uvicorn main:app` или `flask run`  
6. Опционально: Docker, pydantic-валидация, логи  

## Выводы

- Пройден полный ML-пайплайн в Scikit-Learn: препроцессинг → обучение → метрики.
- Одной accuracy недостаточно при дисбалансе классов.
- Ансамбли (RF, бустинг) превосходят SVM/kNN на табличных признаках этой задачи.
- Модель можно вынести в API через сериализацию `joblib`.
