SELECT
    id,
    created_at,
    (data->>'date')::date AS date_utc2,
    (data->>'heure')::time AS heure_utc2,   
    (data->>'date_heure')::timestamp AS date_heure_utc,   
    (data->>'gaz')::int AS gaz,
    (data->>'nucleaire')::int AS nucleaire,
    (data->>'charbon')::int AS charbon,
    (data->>'solaire')::int AS solaire,
    (data->>'eolien')::int AS eolien,
    (data->>'hydraulique')::int AS hydraulique,
    (data->>'bioenergies')::int AS bioenergies,
    (data->>'autres')::int AS autres,
    (data->>'prevision_j')::int AS prevision_j,
    (data->>'prevision_j1')::int AS prevision_j1
FROM bronze.rte_eco2mix