# Публикации (OpenAIRE) на Flutter

ЛР2 (веха В1 «Каркас») и ЛР3 (веха В2 «Данные»). Курс кроссплатформенной разработки, группа ПИН-252т.

## Предметная область

Каталог научных публикаций из [OpenAIRE Graph](https://graph.openaire.eu/). OpenAIRE собирает
статьи, датасеты и программы из репозиториев и журналов в один открытый граф. В основном в каталоге
статьи, но встречаются и датасеты с программами, это видно по полю `type`.

Что есть в приложении:

- список публикаций: заглушка по типу записи, название, авторы, дата. Картинок у публикаций в
  OpenAIRE Graph нет;
- поиск по названию, запрос уходит через 400 мс после последней буквы;
- подгрузка следующей страницы при прокрутке;
- загрузка с индикатором и ошибка с кнопкой «Повторить»;
- карточка публикации: авторы, дата, издатель, тип, тематики, аннотация;
- похожие публикации на карточке: те, у которых есть общие тематики, загружаются параллельно;
- светлая и тёмная тема;
- интерфейс на русском и английском, язык переключается кнопкой в шапке.

## Данные

Источник — OpenAIRE Graph API, сущность
[research product](https://graph.openaire.eu/docs/data-model/entities/research-product/).

Адрес сервера: `https://api.openaire.eu/graph/v1`, задан только в `common/network/dio_client.dart`.
В список попадают типы `publication`, `dataset` и `software`, тип `other` отфильтрован.

| Поле модели | Поле в API | Что это |
|---|---|---|
| `id` | `id` | идентификатор записи |
| `mainTitle` | `mainTitle` | название |
| `authors` | `authors[].fullName` | авторы |
| `publicationDate` | `publicationDate` | дата публикации, может отсутствовать |
| `description` | `descriptions[0]` | аннотация без разметки JATS, может отсутствовать |
| `subjects` | `subjects[].subject.value` | тематики |
| `type` | `type` | тип: `publication`, `dataset`, `software` |
| `publisher` | `publisher` | издатель, может отсутствовать |

Содержимое каталога на английском и не переводится. Переводится только интерфейс.

## Запуск

```bash
flutter pub get
flutter run -d chrome              # браузер
flutter run -d macos               # второй таргет
dart run tool/check_arb.dart       # сверка ключей ru/en
dart run build_runner build --delete-conflicting-outputs   # после правки DTO
```

## Как устроен проект

| Папка | Что там |
|---|---|
| `features/publication/domain` | модель `PublicationModel` и интерфейс репозитория |
| `features/publication/data/api` | API-клиент: один метод на один адрес, возвращает DTO |
| `features/publication/data/dto` | DTO на `json_serializable`, рядом сгенерированные `.g.dart` |
| `features/publication/data/data_sources` | интерфейс датасорса и сетевая реализация: `DioException` превращается в `LoadException` |
| `features/publication/data/mappers` | DTO в модель приложения |
| `features/publication/data` | репозиторий на датасорсе |
| `features/publication/presentation/bloc` | Cubit списка и Bloc детали с их состояниями |
| `features/publication/presentation/view` | экраны и виджеты |
| `features/publication/presentation/utils` | расширения для показа модели |
| `common/navigation` | адреса экранов и go_router |
| `common/theme` | цвета, тема, Cubit темы |
| `common/locale` | Cubit языка |
| `common/network` | Dio и свои ошибки загрузки `LoadException` |
| `common/widgets` | шапка, кнопки темы и языка, экран ошибки с «Повторить» |
| `lib/l10n` | подписи интерфейса, две локали |

Цепочка: **API-клиент → датасорс → репозиторий → Cubit/Bloc → экран.** Собирается в `app.dart`:
`PublicationRepository(NetworkPublicationDataSource(PublicationApi(DioClient.create())))`, репозиторий
зарегистрирован через `RepositoryProvider` по интерфейсу.

Список — Cubit с методами `load()`, `retry()`, `search(query)` и `loadMore()`, создаётся в корне
приложения, поэтому список и запрос сохраняются после возврата с детали. Деталь — Bloc с событиями
`PublicationDetailOpened` и `PublicationDetailRetried`, его создаёт экран детали.

Какие адреса вызывает приложение:

| Экран | Запросы |
|---|---|
| Список | `/researchProducts?type=publication,dataset,software&page=N&pageSize=20` |
| Поиск | тот же адрес с `mainTitle=<запрос>`, первые 20 записей |
| Деталь | `/researchProducts/{id}`, потом до трёх запросов `/researchProducts?subjects=<тематика>&pageSize=5` параллельно |
