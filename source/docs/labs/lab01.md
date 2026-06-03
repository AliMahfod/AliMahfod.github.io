# Лабораторная работа 1

**Тема:** Создание и развертывание статического сайта на базе MkDocs с публикацией на GitHub Pages

## Цель

- Освоить генератор статических сайтов MkDocs
- Организовать структуру документации-портфолио
- Изучить Git и GitHub
- Развернуть сайт на GitHub Pages (`username.github.io`)
- Настроить тему и файл `mkdocs.yml`

## Задание

### Основная часть

1. Создать публичный репозиторий на GitHub
2. Настроить GitHub Pages: публикация из каталога `/docs`, ветка `main`
3. Клонировать репозиторий локально
4. Создать виртуальное окружение Python и установить MkDocs
5. Настроить `.gitignore`
6. Выполнить `mkdocs new source`, локальный просмотр `mkdocs serve`
7. Сборка: `mkdocs build -d ../docs`
8. Закоммитить `source` и `docs`, отправить на GitHub

### Самостоятельная часть

1. Подключить тему оформления (Material)
2. Настроить `mkdocs.yml`: название, тема, `nav`
3. Создать страницы: главная, об авторе, раздел лабораторных работ
4. Единый шаблон отчёта на каждой странице лабы
5. Повторная сборка и публикация

## Код

Структура репозитория:

```
PyProg2026Lab1/
├── .gitignore
├── README.md
├── docs/              # собранный сайт (GitHub Pages)
└── source/
    ├── mkdocs.yml
    └── docs/          # исходники Markdown
```

Команды окружения и сборки:

```bash
python -m venv .venv
.venv\Scripts\activate
pip install mkdocs mkdocs-material
cd source
mkdocs serve
mkdocs build -d ../docs
```

Фрагмент `mkdocs.yml`:

```yaml
site_name: Ali Mahfod — Portfolio
theme:
  name: material
nav:
  - Главная: index.md
  - Об авторе: about.md
  - Лабораторные работы:
    - Обзор: labs/index.md
    - Лабораторная 1: labs/lab01.md
```

## Выводы

- Статический сайт генерируется из Markdown без серверной логики
- MkDocs упрощает навигацию и оформление через `mkdocs.yml`
- GitHub Pages публикует содержимое каталога `docs` на домене `username.github.io`
- Тема Material обеспечивает читаемость, поиск и переключение светлой/тёмной схемы
- Портфолио готово к добавлению новых лабораторных работ по единому шаблону
