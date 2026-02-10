Простой ETL проект для автоматизации отчетов по месячной выручке.

## Назначение
Автоматическая агрегация данных из существующей таблицы `TOTAL_SALE` в DWH для быстрого формирования отчетов.

## Предварительные требования
- PostgreSQL 12+
- Существующая таблица [TOTAL_SALE](https://github.com/NiinaaIvanova/etl-dwh-postgresql-project/blob/54cf52d16b03406278c6663cf06d40721b0f2525/total_sale.csv) с полями:
  - `date` (DATE) - дата продажи
  - `total` (DECIMAL) - сумма продажи

## Файлы проекта

[setup_dwh.sql](https://github.com/NiinaaIvanova/etl-dwh-postgresql-project/blob/81185b5c2ea06be9f466a204d314158384b8d814/setup_dwh.sql) - Создание схем и таблиц DWH

[etl_procedure.sql](https://github.com/NiinaaIvanova/etl-dwh-postgresql-project/blob/81185b5c2ea06be9f466a204d314158384b8d814/etl_procedure.sql) - Основная ETL процедура

[reports.sql](https://github.com/NiinaaIvanova/etl-dwh-postgresql-project/blob/81185b5c2ea06be9f466a204d314158384b8d814/reports.sql) - Готовые отчеты

[examples.sql](https://github.com/NiinaaIvanova/etl-dwh-postgresql-project/blob/81185b5c2ea06be9f466a204d314158384b8d814/examples.sql) - Примеры использования
