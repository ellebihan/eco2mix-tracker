
  
    

  create  table "dbelsa"."bronze"."hourly_eco2mix__dbt_tmp"
  
  
    as
  
  (
    SELECT
    id,
    created_at,
    (data->>'date_heure')::timestamp AS date_heure_utc,
    (data->>'date')::date AS date,
    (data->>'heure')::time AS heure,
    (data->>'gaz')::int AS gaz,
    (data->>'nucleaire')::int AS nucleaire,
    (data->>'charbon')::int AS charbon,
    (data->>'solaire')::int AS solaire,
    (data->>'eolien')::int AS eolien,
    (data->>'hydraulique')::int AS hydraulique,
    (data->>'bioenergies')::int AS bioenergies,
    (data->>'autres')::int AS autres,
    (data->>'taux_co2')::int AS rate_co2,
    (data->>'consumption')::int AS consumption_d,
    (data->>'prevision_j')::int AS consumption_forecast_d,
    (data->>'prevision_j1')::int AS consumption_forecast_d1
FROM bronze.rte_eco2mix
  );
  