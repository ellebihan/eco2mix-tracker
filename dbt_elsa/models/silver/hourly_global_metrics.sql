
/*
SELECT *
FROM {{ this }}
WHERE DATE(created_at) < CURRENT_DATE
UNION
*/
SELECT
    date_time_utc,
    created_at,
    'total' AS sector,
    SUM(rate_co2) AS rate_co2,
    SUM(consumption_d) AS consumption_d,
    SUM(consumption_forecast_d) AS consumption_forecast_d,
    SUM(consumption_forecast_d1) AS consumption_forecast_d1
FROM bronze.hourly_eco2mix
GROUP BY 1, 2, 3