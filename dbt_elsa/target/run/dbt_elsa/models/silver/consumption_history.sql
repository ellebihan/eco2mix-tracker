
  
    

  create  table "dbelsa"."bronze"."consumption_history__dbt_tmp"
  
  
    as
  
  (
    /*
SELECT *
FROM "dbelsa"."bronze"."consumption_history"
WHERE DATE(created_at) < CURRENT_DATE
UNION
*/
SELECT 
    date,
    created_at,
    unpivot.filiere,
    SUM(unpivot.volume) AS volume
FROM bronze.consumption
JOIN LATERAL(VALUES
    ('gaz', consumption.gaz),
    ('nucleaire', consumption.nucleaire),
    ('charbon', consumption.charbon),
    ('solaire', consumption.solaire),
    ('eolien', consumption.eolien),
    ('hydraulique', consumption.hydraulique),
    ('bioenergies', consumption.bioenergies),
    ('autres', consumption.autres)
) unpivot(filiere, volume) ON TRUE
GROUP BY
    date,
    created_at,
    unpivot.filiere
  );
  