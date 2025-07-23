
/*
SELECT *
FROM {{ this }}
WHERE DATE(created_at) < CURRENT_DATE
UNION
*/
SELECT 
    DATE(date_time_utc) AT time zone 'CET' AS date,
    created_at,
    unpivot.sector,
    SUM(unpivot.volume) AS volume
FROM bronze.hourly_production_by_sector
JOIN LATERAL(VALUES
    ('gaz', hourly_production_by_sector.gaz),
    ('nucleaire', hourly_production_by_sector.nucleaire),
    ('charbon', hourly_production_by_sector.charbon),
    ('solaire', hourly_production_by_sector.solaire),
    ('eolien', hourly_production_by_sector.eolien),
    ('hydraulique', hourly_production_by_sector.hydraulique),
    ('bioenergies', hourly_production_by_sector.bioenergies),
    ('autres', hourly_production_by_sector.autres)
) unpivot(sector, volume) ON TRUE
GROUP BY
    DATE(date_time_utc) AT time zone 'CET',
    created_at,
    unpivot.sector