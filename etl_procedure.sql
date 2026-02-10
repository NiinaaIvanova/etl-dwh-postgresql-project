-- ============================================
-- Основная ETL процедура
-- Агрегирует данные из TOTAL_SALE в DWH
-- ============================================

CREATE OR REPLACE PROCEDURE etl.merge_monthly_revenue_to_dwh(
    p_month VARCHAR DEFAULT NULL
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_sql TEXT;
    v_processed_rows INT;
BEGIN
    -- Проверка существования исходной таблицы
    IF NOT EXISTS (
        SELECT 1 
        FROM information_schema.tables 
        WHERE table_name = 'total_sale'
    ) THEN
        RAISE EXCEPTION 'Таблица TOTAL_SALE не существует';
    END IF;
    
    -- ETL с параметризованным запросом
    IF p_month IS NOT NULL THEN
        v_sql := '
            INSERT INTO dwh.revenue_result (month_name, revenue, last_updated)
            SELECT 
                TRIM(TO_CHAR(date, ''Month'')) AS month_name,
                SUM(total) AS revenue,
                CURRENT_TIMESTAMP
            FROM TOTAL_SALE
            WHERE TRIM(TO_CHAR(date, ''Month'')) = $1
            GROUP BY TRIM(TO_CHAR(date, ''Month''))
            ON CONFLICT (month_name) 
            DO UPDATE SET 
                revenue = EXCLUDED.revenue,
                last_updated = EXCLUDED.last_updated';
        
        EXECUTE v_sql USING TRIM(p_month);
    ELSE
        -- Для всех месяцев
        INSERT INTO dwh.revenue_result (month_name, revenue, last_updated)
        SELECT 
            TRIM(TO_CHAR(date, 'Month')) AS month_name,
            SUM(total) AS revenue,
            CURRENT_TIMESTAMP
        FROM TOTAL_SALE
        GROUP BY TRIM(TO_CHAR(date, 'Month'))
        ON CONFLICT (month_name) 
        DO UPDATE SET 
            revenue = EXCLUDED.revenue,
            last_updated = EXCLUDED.last_updated;
    END IF;
    
    GET DIAGNOSTICS v_processed_rows = ROW_COUNT;
    RAISE NOTICE 'ETL завершен. Обработано строк: %', v_processed_rows;
END;
$$;