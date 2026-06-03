# Лабораторная работа 3

**Тема:** CI/CD для статического сайта в SourceCraft и GitHub Actions

## Цель

- Настроить автоматическое развёртывание MkDocs-сайта на **SourceCraft Sites**
- Настроить автоматическое развёртывание через **GitHub Actions** на GitHub Pages
- Использовать **один локальный репозиторий** с двумя удалёнными: `origin` (GitHub) и `sourcecraft`
- Описать настройки репозиториев и шаги деплоя в отчёте

## Задание

1. Создать организацию и репозиторий на [SourceCraft](https://sourcecraft.dev)
2. Создать PAT-токен с правами Maintainer
3. Добавить удалённый репозиторий `sourcecraft`
4. Настроить `.sourcecraft/ci.yaml` и `.sourcecraft/sites.yaml`
5. Настроить `.github/workflows/deploy.yml` для GitHub Pages
6. Продемонстрировать деплой на обе платформы
7. Предоставить **4 ссылки** (см. ниже)

## Как решена задача

### Структура репозитория PyProg2026Lab3

```
PyProg2026Lab3/
├── .github/workflows/deploy.yml
├── .sourcecraft/ci.yaml
├── .sourcecraft/sites.yaml
├── source/mkdocs.yml
├── source/docs/          ← Markdown-исходники
└── docs/                 ← локальная сборка (опционально)
```

### Задача 1 — SourceCraft CI/CD

**`.sourcecraft/sites.yaml`** — хостинг статики из ветки `release`, каталог `site/`:

```yaml
site:
  root: "site"
  ref: "release"
```

**`.sourcecraft/ci.yaml`** — при push в `main`:

1. Сборка MkDocs в каталог `site/`
2. Публикация содержимого в ветку `release` (SourceCraft Sites читает `site/`)

URL сайта: `https://nphne-hoxasjab.sourcecraft.site/pyprog2026lab3/`

### Задача 2 — GitHub Actions

**`.github/workflows/deploy.yml`** — при push в `main`:

1. `pip install mkdocs mkdocs-material`
2. `mkdocs build -f source/mkdocs.yml -d docs`
3. `actions/upload-pages-artifact` + `actions/deploy-pages`

URL сайта: `https://AliMahfod.github.io/`

### Два remote в одном локальном репозитории

```powershell
git remote -v
# origin      https://github.com/AliMahfod/AliMahfod.github.io.git
# sourcecraft https://git.sourcecraft.dev/nphne-hoxasjab/pyprog2026lab3.git

git push origin main
git push sourcecraft main
```

## Настройки в интерфейсе

### SourceCraft

| Где | Что включить |
|-----|----------------|
| Организация | **Public** (Sites работает только с публичными org/repo) |
| Репозиторий | **Public**, имя `pyprog2026lab3` |
| PAT | Права **Maintainer**, срок 6–12 месяцев |
| CI/CD → после push | Workflow `build-site` → Status **Success** |
| Deployments | Ссылка на опубликованный сайт |

### GitHub

| Где | Что включить |
|-----|----------------|
| Repo `AliMahfod.github.io` | **Public** |
| Settings → Pages | Source: **GitHub Actions** (не «Deploy from branch») |
| Settings → Actions → General | Workflow permissions: **Read and write** |
| Actions → workflow run | Deploy job **Success** |

## Код

SourceCraft CI (фрагмент):

```yaml
on:
  push:
    - workflows: build-site
      filter:
        branches: ["main"]

workflows:
  build-site:
    tasks:
      - name: build-and-deploy
        cubes:
          - name: build-mkdocs
            image: docker.io/library/python:3.11-slim
            script:
              - pip install mkdocs mkdocs-material
              - mkdocs build -f source/mkdocs.yml -d ../site
```

GitHub Actions (фрагмент):

```yaml
- run: pip install mkdocs mkdocs-material
- run: mkdocs build -f source/mkdocs.yml -d docs
- uses: actions/upload-pages-artifact@v3
  with:
    path: docs
- uses: actions/deploy-pages@v4
```

## Что сдать (4 ссылки)

| № | Описание | Ссылка |
|---|----------|--------|
| 1 | Сайт на SourceCraft | https://nphne-hoxasjab.sourcecraft.site/pyprog2026lab3/ |
| 2 | Репозиторий SourceCraft | https://sourcecraft.dev/nphne-hoxasjab/pyprog2026lab3 |
| 3 | Сайт на GitHub Pages | https://AliMahfod.github.io/ |
| 4 | Репозиторий GitHub | https://github.com/AliMahfod/AliMahfod.github.io |

## Выводы

- CI/CD автоматизирует сборку MkDocs и публикацию без ручного `mkdocs build`
- SourceCraft использует `.sourcecraft/ci.yaml` + `.sourcecraft/sites.yaml`
- GitHub Pages с Actions использует `.github/workflows/deploy.yml`
- Один локальный репозиторий может пушить в два remote (`origin` и `sourcecraft`)
- Для SourceCraft Sites нужны публичная организация и публичный репозиторий
- Для GitHub Pages через Actions нужно выбрать источник **GitHub Actions** в настройках Pages

**Ссылка на отчёт:** [Лабораторная работа 3](https://AliMahfod.github.io/labs/lab03/)
