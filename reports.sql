-- ============================================
-- Готовые отчеты для бизнеса
-- ============================================

-- Основной отчет по месяцам
CREATE OR REPLACE VIEW reports.monthly_revenue AS
SELECT 
    month_name as "Месяц",
    revenue as "Выручка",
    last_updated as "Обновлено"
FROM dwh.revenue_result
ORDER BY 
    CASE month_name
        WHEN 'January' THEN 1
        WHEN 'February' THEN 2
        WHEN 'March' THEN 3
        WHEN 'April' THEN 4
        WHEN 'May' THEN 5
        WHEN 'June' THEN 6
        WHEN 'July' THEN 7
        WHEN 'August' THEN 8
        WHEN 'September' THEN 9
        WHEN 'October' THEN 10
        WHEN 'November' THEN 11
        WHEN 'December' THEN 12
    END;

-- Отчет с сортировкой по выручке
CREATE OR REPLACE VIEW reports.top_months AS
SELECT 
    month_name as "Месяц",
    revenue as "Выручка",
    RANK() OVER (ORDER BY revenue DESC) as "Рейтинг"
FROM dwh.revenue_result
ORDER BY revenue DESC;

-- Сводка
CREATE OR REPLACE VIEW reports.summary AS
SELECT 
    COUNT(*) as "Количество месяцев",
    SUM(revenue) as "Общая выручка",
    round(AVG(revenue), 2) as "Средняя выручка в месяц",
    MAX(revenue) as "Максимальная выручка",
    MIN(revenue) as "Минимальная выручка"
FROM dwh.revenue_result;