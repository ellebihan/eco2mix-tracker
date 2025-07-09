{{ config(
  post_hook = [
	  "{{ add_index('perimetre') }}",
    ]
) }}

SELECT
  data->>'Perimetre' AS perimetre,
  data->>'Nature'::int AS nature,
  data->>'Date' AS date_production,
  data->>'Heures' AS heures
FROM {{ source("bronze", "eco2mix_rte") }} eco2mix_rte;