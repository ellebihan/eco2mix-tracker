
  
    

  create  table "elsa"."bronze"."daily_consumption__dbt_tmp"
  
  
    as
  
  (
    SELECT
    id,
    created_at,
    data->>'date' AS date,
    data->>'heure' AS heure,   
    data->>'gaz' AS gaz,
    data->>'nucleaire' AS nucleaire,
    data->>'charbon' AS charbon,
    data->>'solaire' AS solaire,
    data->>'eolien' AS eolien,
    data->>'hydraulique' AS hydraulique,
    data->>'bioenergies' AS bioenergies,
    data->>'autres' AS autres,
    data->>'prevision_j' AS prevision_j,
    data->>'prevision_j1' AS prevision_j1
FROM "elsa"."bronze"."rte_eco2mix"
  );
  