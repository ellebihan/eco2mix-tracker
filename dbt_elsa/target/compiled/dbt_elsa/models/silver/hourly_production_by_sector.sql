/*
SELECT *
FROM "dbelsa"."silver"."hourly_production_by_sector"
WHERE DATE(created_at) < CURRENT_DATE
UNION
*/
SELECT 
    date_time_utc,
    created_at,
    unpivot.sector,
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
) unpivot(sector, volume) ON TRUE
GROUP BY
    date_time_utc,
    created_at,
    unpivot.sector