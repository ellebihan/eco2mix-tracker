
SELECT
    id,
    created_at,
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
    (data->>'prevision_j')::int AS prevision_j,
    (data->>'prevision_j1')::int AS prevision_j1
FROM {{ source('bronze', 'rte_eco2mix') }}