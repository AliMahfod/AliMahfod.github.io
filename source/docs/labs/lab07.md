# Лабораторная работа 7

**Тема:** Анализ текста — pandas / sklearn / NLTK (P3123), классификация тональности твитов

**Выполнил:** Ali Mahfod

## Цель

Освоить предобработку и векторизацию текстов (мешок слов, TF-IDF, n-граммы, токенизация, стоп-слова) и построить модели классификации **positive / negative** на корпусе [RuTweetCorp](http://study.mokoron.com/).

## Ноутбук

| Где | Ссылка |
|-----|--------|
| Репозиторий | [github.com/AliMahfod/PyProg2026Lab7](https://github.com/AliMahfod/PyProg2026Lab7) |
| Ноутбук | [s6p1_group1.ipynb](https://github.com/AliMahfod/PyProg2026Lab7/blob/main/s6p1_group1.ipynb) |
| Просмотр (nbviewer) | [nbviewer — Lab 7](https://nbviewer.org/github/AliMahfod/PyProg2026Lab7/blob/main/s6p1_group1.ipynb) |

Данные: `positive.csv`, `negative.csv` (скачиваются в ноутбуке).

---

## Задача

Классификация русскоязычных твитов по тональности. Корпус: **226 834** записи (после объединения positive + negative). Разбиение `train_test_split` (**random_state=42**, 25% test → **56 709** тестовых).

## Результаты `classification_report` (прогон кода)

| Модель | Accuracy | F1 (weighted) |
|--------|----------|----------------|
| **LinearSVC + TF-IDF (1–2)** | **0.780** | **0.780** |
| LogisticRegression + Count unigram | 0.770 | 0.770 |
| TF-IDF (1–5) + LogisticRegression | 0.750 | 0.750 |
| TF-IDF bigrams + LogisticRegression | 0.710 | 0.710 |
| XGBClassifier + Count unigram (n_estimators=200) | 0.680 | 0.680 |
| Count trigrams + LogisticRegression | 0.640 | 0.630 |
| Count pentagrams + LogisticRegression | 0.550 | 0.440 |

### Сравнение n-грамм (TF-IDF / Count)

- **Униграммы** дают лучший баланс precision/recall (~**0.77** accuracy).
- **Триграммы** Count: accuracy падает до ~**0.64** (как в борде для 3-грамм).
- **Пентаграммы** Count: ~**0.55** accuracy — сильный разброс классов, модель хуже обобщает.
- **TF-IDF биграммы:** F1 weighted ~**0.71** — ниже униграмм (~0.75–0.77), но выше пентаграмм.
- **TF-IDF триграммы:** ~**0.64** — близко к Count 3-gram.

### Самостоятельная работа

1. **LogisticRegression** + униграммы — см. таблицу (эталон борда ~0.77).
2. **XGBClassifier** с параметрами из задания (`learning_rate=0.1`, `max_depth=5`, …; `n_estimators=200` в ноутбуке для времени, в задании указано 1000).
3. **LinearSVC** + TF-IDF (1,2) — лучший результат в таблице (**~0.78**).
4. TF-IDF **биграммы** и **триграммы** — отдельные ячейки в ноутбуке; F1 ниже униграмм, выше пентаграмм.

## Особенности борда (кратко)

- **Пунктуация без stop-words:** метрики ≈ 1.0 — токены `:(` / `:)` почти напрямую кодируют класс (утечка).
- **Токенизация + стоп-слова:** recall по negative растёт.
- **Символьные n-граммы** (`analyzer='char'`) — работают без морфологии.
- **pymorphy3** — лемматизация по словам (`MorphAnalyzer`).

## Выводы

- Для русских твитов сильный baseline — **униграммы + LogisticRegression** или **TF-IDF + LinearSVC**.
- Слишком длинные n-граммы (5+) ухудшают качество из-за разреженности и переобучения.
- Эмоциональная пунктуация — мощный, но «нечестный» признак; на практике её убирают или учитывают осознанно.
- Полный код, графики и отчёты `classification_report` — в ноутбуке.
