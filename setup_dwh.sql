-- ============================================
-- Настройка DWH для автоматизации отчетов
-- Предполагается, что таблица TOTAL_SALE уже существует
-- ============================================

-- Создаем схему для DWH
CREATE SCHEMA IF NOT EXISTS dwh;

-- Создаем схему для ETL процедур
CREATE SCHEMA IF NOT EXISTS etl;

-- Создаем схему для отчетов
CREATE SCHEMA IF NOT EXISTS reports;

-- Создаем таблицу для агрегированных данных
CREATE TABLE IF NOT EXISTS dwh.revenue_result (
    month_name VARCHAR(20) PRIMARY KEY,
    revenue DECIMAL NOT NULL,
    last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Проверяем, что таблица TOTAL_SALE существует
DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM information_schema.tables 
        WHERE table_name = 'total_sale'
    ) THEN
        RAISE EXCEPTION 'Таблица TOTAL_SALE не найдена. Проект требует существующей таблицы TOTAL_SALE.';
    END IF;
    
    RAISE NOTICE 'DWH настроен успешно. Таблица TOTAL_SALE найдена.';
END;
$$;