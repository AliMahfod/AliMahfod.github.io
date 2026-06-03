# Лабораторная работа 3

**Тема:** CI/CD для статического сайта в SourceCraft и GitHub Actions

## Цель

- Настроить автоматическое развёртывание MkDocs-сайта на **SourceCraft Sites**
- Настроить автоматическое развёртывание через **GitHub Actions** на GitHub Pages
- Использовать **один локальный репозиторий** с двумя удалёнными: `origin` (GitHub) и `sourcecraft`
- Описать настройки репозиториев и шаги деплоя в отчёте

## Задание

1. Создать организацию и репозиторий на SourceCraft
2. Создать PAT-токен с правами Maintainer
3. Добавить удалённый репозиторий `sourcecraft`
4. Настроить `.sourcecraft/ci.yaml` и `.sourcecraft/sites.yaml`
5. Настроить `.github/workflows/deploy.yml` для GitHub Pages
6. Продемонстрировать деплой на обе платформы
7. Предоставить **4 ссылки**

Полный отчёт и конфигурации — в репозитории **PyProg2026Lab3**.

## Код

Структура репозитория:

```
PyProg2026Lab3/
├── .github/workflows/deploy.yml
├── .sourcecraft/ci.yaml
├── .sourcecraft/sites.yaml
└── source/
```

## Выводы

- CI/CD автоматизирует сборку и публикацию MkDocs-сайта
- SourceCraft: `.sourcecraft/ci.yaml` + `.sourcecraft/sites.yaml`
- GitHub: `.github/workflows/deploy.yml`, Pages source = GitHub Actions
- Один локальный репозиторий → два remote: `git push origin main` и `git push sourcecraft main`

**Репозиторий GitHub:** [AliMahfod.github.io](https://github.com/AliMahfod/AliMahfod.github.io)

**Ссылка на отчёт:** [Лабораторная работа 3](https://AliMahfod.github.io/labs/lab03/)
