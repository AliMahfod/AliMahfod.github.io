# Лабораторная работа 10

**Тема:** ML-сервис для предсказания одобрения ипотеки — FastAPI, uv, SourceCraft CI (P3123)

**Выполнил:** Ali Mahfod

## Цель

Полный цикл ML-сервиса: предобработка данных, обучение и сравнение моделей, REST API, веб-интерфейс, CI на SourceCraft.

## Репозитории

| Где | Ссылка |
|-----|--------|
| SourceCraft (ответ) | [sourcecraft.dev/nphne-hoxasjab/pyprog2026lab10](https://sourcecraft.dev/nphne-hoxasjab/pyprog2026lab10) |
| GitHub | [github.com/AliMahfod/PyProg2026Lab10](https://github.com/AliMahfod/PyProg2026Lab10) |

---

## Задача

Консультирующий сервис для сотрудника банка: вероятность **одобрения / отказа** по ипотеке на основе данных клиента.

## Данные

`data/loan_data.csv` — **45 000** строк, 14 признаков (в т.ч. `loan_status`: 1 = approved, 0 = rejected).

## Модели (сравнение ROC-AUC)

| Модель | ROC-AUC (test) |
|--------|----------------|
| Logistic Regression | ~0.956 |
| **Random Forest** | **~0.972** (выбрана) |
| Gradient Boosting | ~0.972 |

Предобработка: IQR-clipping, imputation, OneHot + StandardScaler, SelectKBest (k=20).

## API (FastAPI)

| Метод | Путь | Назначение |
|-------|------|------------|
| POST | `/upload-model` | Загрузка `.pkl` |
| POST | `/predict` | JSON `{ "records": [...] }` — сырые поля клиента |
| POST | `/predict-from-csv` | CSV → `roc_auc` (если есть `loan_status`) + предсказания |

## Frontend

`static/index.html` — форма ввода, вызов `/predict`, примеры approve/reject. Промпты: `docs/frontend_prompts.md`.

## Локальный запуск

```powershell
cd lab10
uv sync --extra dev
uv run python -m mortgage_api.train
uv run uvicorn mortgage_api.main:app --port 8080
```

UI: http://127.0.0.1:8080/

## CI (SourceCraft)

Workflow **`lab-check`**: `uv sync` → train → `ruff` → `pytest`.

## Заключение

- Сервис соответствует ТЗ: 3 endpoint’а, обработка ошибок, UI, README, тесты, линтинг.
- Датасет несбалансирован (~78% отказов) — модель консервативна; в UI добавлены пояснения и примеры.
