/*
SELECT *
FROM "dbelsa"."silver"."daily_global_metrics"
WHERE DATE(created_at) < CURRENT_DATE
UNION
*/
SELECT
    DATE(date_time_utc) AT time zone 'CET' AS date,
    created_at,
    'total' AS sector,
    SUM(rate_co2) AS rate_co2,
    SUM(consumption_d) AS consumption_d,
    SUM(consumption_forecast_d) AS consumption_forecast_d,
    SUM(consumption_forecast_d1) AS consumption_forecast_d1
FROM bronze.hourly_global_metrics
GROUP BY 1, 2, 3