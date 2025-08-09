WITH base AS (
    SELECT DISTINCT
        stg.marketing_airline_network AS airline_code,
        sd.airlines_name AS airline_name
    FROM {{ref('stg_flights')}} stg
    JOIN {{ref('airlines_code')}} sd 
        ON sd.code = stg.marketing_airline_network
)

SELECT *
FROM base