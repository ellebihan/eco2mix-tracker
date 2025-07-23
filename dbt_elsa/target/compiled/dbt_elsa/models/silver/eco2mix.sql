/*
SELECT *
FROM "dbelsa"."bronze"."eco2mix"
WHERE DATE(created_at) < CURRENT_DATE
UNION
*/
WITH production_split_by_date_filiere AS (
    SELECT 
        DATE(date_heure_utc) AT time zone 'CET' AS date,
        created_at,
        unpivot.filiere,
        SUM(unpivot.volume) AS volume
    FROM bronze.hourly_eco2mix
    JOIN LATERAL(VALUES
        ('gaz', hourly_eco2mix.gaz),
        ('nucleaire', hourly_eco2mix.nucleaire),
        ('charbon', hourly_eco2mix.charbon),
        ('solaire', hourly_eco2mix.solaire),
        ('eolien', hourly_eco2mix.eolien),
        ('hydraulique', hourly_eco2mix.hydraulique),
        ('bioenergies', hourly_eco2mix.bioenergies),
        ('autres', hourly_eco2mix.autres)
    ) unpivot(filiere, volume) ON TRUE
    GROUP BY
        DATE(date_heure_utc) AT time zone 'CET',
        created_at,
        unpivot.filiere
)
, total_by_date AS (
    SELECT
        date,
        created_at,
        'total' AS filiere,
        SUM(volume) AS volume
    FROM production_split_by_date_filiere
    GROUP BY
        date,
        created_at,
        'total'
)
, other_measures_by_date AS (
    SELECT
        DATE(date_heure_utc) AT time zone 'CET' AS date,
        created_at,
        'total' AS filiere,
        rate_co2,
        consumption_d,
        consumption_forecast_d,
        consumption_forecast_d1
    FROM bronze.hourly_eco2mix
    GROUP BY
        DATE(date_heure_utc) AT time zone 'CET',
        created_at,
        'total'
)
SELECT *
FROM production_split_by_date_filiere
UNION 
SELECT *
FROM total_by_date
UNION
SELECT *
FROM other_measures_by_date