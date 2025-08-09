WITH base AS (
  SELECT
    id_flight,
    crs_arr_time_hour_dis,
    crs_dep_time_hour_dis,
    arr_delay_minutes,
    dep_delay_minutes
  FROM {{ ref('fact_flight_delay') }}
)

SELECT
  id_flight,
  'Departure Delay' AS delay_type,
  crs_dep_time_hour_dis AS delay_period
FROM base
WHERE dep_delay_minutes > 0

UNION ALL

SELECT
  id_flight,
  'Arrival Delay' AS delay_type,
  crs_arr_time_hour_dis AS delay_period
FROM base
WHERE arr_delay_minutes > 0
