{{ config(
    tags = ['bronze', 'realtime', consommation],
    alias = 'bronze_eco2mix',
    post_hook = [
	  "{{ add_index('id', created_at) }}",
    ]
    )
}}

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
FROM rte_eco2mix;