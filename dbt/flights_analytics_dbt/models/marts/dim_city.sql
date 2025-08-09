WITH base AS (
    SELECT origin_city_name AS city_name 
    FROM {{ ref('stg_flights') }}

    UNION ALL

    SELECT dest_city_name AS city_name 
    FROM {{ ref('stg_flights') }}
),
deduped AS (
    SELECT DISTINCT city_name FROM base
),
split_city_state AS (
    SELECT 
        city_name,
        INITCAP(LOWER(TRIM(SPLIT(city_name, ',')[OFFSET(0)]))) AS city,
        UPPER(TRIM(SPLIT(city_name, ',')[OFFSET(1)])) AS state
    FROM deduped
),
final AS (
    SELECT DISTINCT city, state
    FROM split_city_state
)

SELECT
  ROW_NUMBER() OVER () AS id_city,
  city,
  state
FROM final
