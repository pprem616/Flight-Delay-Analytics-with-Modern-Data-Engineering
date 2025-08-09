WITH base AS (
SELECT DISTINCT
    flight_date, 
    year,
    month,
    day_of_month,
    day_of_week,
    holidays
FROM {{ref('stg_flights')}}
)

SELECT * 
FROM base

