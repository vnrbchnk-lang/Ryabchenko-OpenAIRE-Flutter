# Публикации (OpenAIRE) — каркас на Flutter

ЛР2, веха В1 «Каркас». Курс кроссплатформенной разработки, группа ПИН-252т.

## Предметная область

Каталог научных публикаций из [OpenAIRE Graph](https://graph.openaire.eu/). OpenAIRE собирает
статьи, датасеты и программы из репозиториев и журналов в один открытый граф. В основном в каталоге
статьи, но встречаются и датасеты с программами, это видно по полю `type`.

Что есть в приложении:

- список публикаций: заглушка по типу записи, название, авторы, дата. Картинок у публикаций в
  OpenAIRE Graph нет;
- поиск по названию;
- карточка публикации: авторы, дата, издатель, тип, тематики, аннотация;
- похожие публикации на карточке: те, у которых есть общие тематики;
- светлая и тёмная тема;
- интерфейс на русском и английском, язык переключается кнопкой в шапке.

## Данные

Источник — OpenAIRE Graph API, сущность
[research product](https://graph.openaire.eu/docs/data-model/entities/research-product/).

Сети в этой вехе нет. 20 записей лежат в `features/publication/data/mock_publications.dart`, те же,
что в ЛР1 на CMP. Когда появится сеть, поменяется только папка `data`.

| Поле модели | Поле в API | Что это |
|---|---|---|
| `id` | `id` | идентификатор записи |
| `mainTitle` | `mainTitle` | название |
| `authors` | `authors[].fullName` | авторы |
| `publicationDate` | `publicationDate` | дата публикации |
| `description` | `descriptions[]` | аннотация |
| `subjects` | `subjects[].subject.value` | тематики |
| `type` | `type` | тип: `publication`, `data`, `software` |
| `publisher` | `publisher` | издатель |

Содержимое каталога на английском и не переводится. Переводится только интерфейс.

## Запуск

```bash
flutter pub get
flutter run -d chrome              # браузер
flutter run -d windows             # второй таргет
dart run tool/check_arb.dart       # сверка ключей ru/en
```

## Как устроен проект

| Папка | Что там |
|---|---|
| `features/publication/domain` | модель `PublicationModel` и интерфейс репозитория |
| `features/publication/data` | моки и репозиторий, который их отдаёт |
| `features/publication/presentation/bloc` | Cubit списка и Bloc детали с их состояниями |
| `features/publication/presentation/view` | экраны и виджеты |
| `features/publication/presentation/utils` | расширения для показа модели |
| `common/navigation` | адреса экранов и go_router |
| `common/theme` | цвета, тема, Cubit темы |
| `common/locale` | Cubit языка |
| `common/widgets` | шапка и кнопки темы и языка |
| `lib/l10n` | подписи интерфейса, две локали |

Список — Cubit с методами `load()` и `search(query)`, создаётся в корне приложения, поэтому список и
запрос сохраняются после возврата с детали. Деталь — Bloc с событием `PublicationDetailOpened`,
его создаёт экран детали. Репозиторий зарегистрирован в `app.dart` через `RepositoryProvider` по
интерфейсу.
