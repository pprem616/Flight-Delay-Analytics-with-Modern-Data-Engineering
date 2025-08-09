WITH base AS (
  SELECT
    id_flight,
    carrier_delay,
    weather_delay,
    nas_delay,
    security_delay,
    late_aircraft_delay
  FROM {{ ref('fact_flight_delay') }}
)

SELECT
  id_flight,
  'Carrier Delay' AS delay_type,
  carrier_delay AS delay_minutes
FROM base

UNION ALL

SELECT
  id_flight,
  'Weather Delay' AS delay_type,
  weather_delay AS delay_minutes
FROM base

UNION ALL

SELECT
  id_flight,
  'NAS Delay' AS delay_type,
  nas_delay AS delay_minutes
FROM base

UNION ALL

SELECT
  id_flight,
  'Security Delay' AS delay_type,
  security_delay AS delay_minutes
FROM base

UNION ALL

SELECT
  id_flight,
  'Late Aircraft Delay' AS delay_type,
  late_aircraft_delay AS delay_minutes
FROM base
