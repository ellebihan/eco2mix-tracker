SELECT 
    DATE(date_time_utc) AT time zone 'CET' AS date,
    created_at,
    sector,
    SUM(volume) as volume
FROM silver.hourly_production_by_sector
GROUP BY
    DATE(date_time_utc) AT time zone 'CET',
    created_at,
    sector