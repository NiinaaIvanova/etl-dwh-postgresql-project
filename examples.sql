-- ============================================
-- Примеры использования ETL системы
-- ============================================

-- Пример 1: Первый запуск (все данные)
-- CALL etl.merge_monthly_revenue_to_dwh();

-- Пример 2: Обновить только январь
-- CALL etl.merge_monthly_revenue_to_dwh('January');

-- Пример 3: Посмотреть все отчеты
/*
SELECT '1. Месячная выручка:' as report;
SELECT * FROM reports.monthly_revenue;

SELECT '2. Топ месяцев:' as report;
SELECT * FROM reports.top_months;

SELECT '3. Сводка:' as report;
SELECT * FROM reports.summary;
*/

-- Пример 4: Проверить данные в DWH
-- SELECT * FROM dwh.revenue_result ORDER BY revenue DESC;

-- Пример 5: Очистить и перезагрузить
/*
TRUNCATE TABLE dwh.revenue_result;
CALL etl.merge_monthly_revenue_to_dwh();
*/