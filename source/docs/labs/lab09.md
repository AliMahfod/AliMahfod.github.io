# Лабораторная работа 9

**Тема:** Работа с графикой, SourceCraft, CI/CD, артефакты (P3123)

**Выполнил:** Ali Mahfod

## Цель

Анализ и визуализация данных об успеваемости студентов (`pandas`, `matplotlib`), автоматический прогон notebook в **SourceCraft CI** с публикацией артефактов.

## Репозиторий

| Где | Ссылка |
|-----|--------|
| SourceCraft (ответ) | [sourcecraft.dev/nphne-hoxasjab/pyprog2026lab9](https://sourcecraft.dev/nphne-hoxasjab/pyprog2026lab9) |
| Шаблон (fork) | [itmo-python-lab-template](https://git.sourcecraft.dev/shaliko9/itmo-python-lab-template) |
| Notebook | `lab.ipynb` |

> После форка и push репозиторий должен быть **public**. CI workflow: `lab-check`.

---

## Задача

1. Форк шаблона SourceCraft → свой репозиторий  
2. Заполнить `lab.ipynb` (загрузка, EDA, признаки, groupby, ≥5 графиков)  
3. CI: выполнить notebook, сгенерировать `report.html`, сохранить артефакты  
4. Раннер добавляет в **последнюю ячейку** markdown с proof (hostname, `SOURCECRAFT_WORKSPACE`, timestamp — не Colab / не local)

## Результаты

| Элемент | Описание |
|---------|----------|
| Датасет | `data/StudentsPerformance.csv` — **1000** строк |
| Новые признаки | `average_score`, `passed_all` |
| Группировки | `test_prep`, `gender`, `parent_education` |
| Графики | гистограмма, 2 bar, scatter, boxplot |
| CI script | `scripts/ci_execute_notebook.py` |
| Артефакты CI | `executed_lab.ipynb`, `report.html` |

### Наблюдения (кратко)

- Курс подготовки **completed** → выше средний `average_score`, чем **none**
- Положительная связь **math_score** ↔ **reading_score**
- При более высоком **parent_education** медиана баллов выше

## CI/CD

**`.sourcecraft/ci.yaml`** — workflow `lab-check`:

```yaml
pip install -r requirements.txt
python scripts/ci_execute_notebook.py
```

Артефакты: `executed_lab.ipynb` (с ячейкой SourceCraft CI proof), `report.html`.

## Заключение

- Notebook заполнен и выполняется без ошибок  
- Pipeline настроен для SourceCraft  
- Для сдачи: **кликабельная ссылка** на public SourceCraft repo + успешный CI run с артефактами
