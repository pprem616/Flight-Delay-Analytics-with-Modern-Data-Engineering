WITH base AS (
  SELECT
    row_number() OVER () AS id_flight,
    dair.airline_code,
    dair.airline_name,
    dd.flight_date,
    dd.year,
    dd.month,
    dd.day_of_week,
    dd.holidays,
    o.city AS origin_city,
    d.city AS dest_city,
    sf.dep_time,
    sf.dep_delay,
    sf.dep_delay_minutes,
    sf.taxi_out,
    sf.taxi_in,
    sf.arr_time,
    sf.arr_delay,
    sf.arr_delay_minutes,
    sf.crs_elapsed_time,
    sf.actual_elapsed_time,
    sf.air_time,
    sf.distance,
    sf.distance_group,
    sf.carrier_delay,
    sf.weather_delay,
    sf.nas_delay,
    sf.security_delay,
    sf.late_aircraft_delay,
    sf.crs_dep_time_hour_dis,
    sf.crs_arr_time_hour_dis,
    FROM {{ ref('stg_flights') }} sf
    LEFT JOIN {{ ref('dim_airline') }} dair
    on dair.airline_code = sf.marketing_airline_network
    LEFT JOIN {{ ref('dim_date') }} dd
    on dd.flight_date = sf.flight_date
    LEFT JOIN {{ ref('dim_city') }} o
    on o.city = trim(split(sf.origin_city_name, ',')[OFFSET(0)]) 
    and o.state = trim(split(sf.origin_city_name, ',')[OFFSET(1)])
    LEFT JOIN {{ ref('dim_city') }} d
    on d.city = trim(split(sf.dest_city_name, ',')[OFFSET(0)])
    and d.state = trim(split(sf.dest_city_name, ',')[OFFSET(1)])

)

SELECT * FROM base
