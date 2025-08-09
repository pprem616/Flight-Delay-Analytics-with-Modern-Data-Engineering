
WITH raw AS(
SELECT * 
FROM {{ source('raw', 'raw_flight_data') }}
)

SELECT
    CAST(Year AS int64) AS year,
    CAST(Month AS int64) AS month,
    CAST(DayofMonth AS int64) AS day_of_month,
    CAST(DayOfWeek AS int64) AS day_of_week,
    CAST(FlightDate AS timestamp) AS flight_date,
    CAST(Marketing_Airline_Network AS string) AS marketing_airline_network,
    CAST(OriginCityName AS string) AS origin_city_name,
    CAST(DestCityName AS string) AS dest_city_name,
    CAST(DepTime AS float64) AS dep_time,
    CAST(DepDelay AS float64) AS dep_delay,
    CAST(DepDelayMinutes AS float64) AS dep_delay_minutes,
    CAST(TaxiOut AS float64) AS taxi_out,
    CAST(TaxiIn AS float64) AS taxi_in,
    CAST(ArrTime AS float64) AS arr_time,
    CAST(ArrDelay AS float64) AS arr_delay,
    CAST(ArrDelayMinutes AS float64) AS arr_delay_minutes,
    CAST(CRSElapsedTime AS float64) AS crs_elapsed_time,
    CAST(ActualElapsedTime AS float64) AS actual_elapsed_time,
    CAST(AirTime AS float64) AS air_time,
    CAST(Distance AS float64) AS distance,
    CAST(DistanceGroup AS int64) AS distance_group,
    CAST(CarrierDelay AS float64) AS carrier_delay,
    CAST(WeatherDelay AS float64) AS weather_delay,
    CAST(NASDelay AS float64) AS nas_delay,
    CAST(SecurityDelay AS float64) AS security_delay,
    CAST(LateAircraftDelay AS float64) AS late_aircraft_delay,
    CAST(Holidays AS boolean) AS holidays,
    CAST(CRSDepTimeMinute AS int64) AS crs_dep_time_minute,
    CAST(CRSDepTimeHour AS int64) AS crs_dep_time_hour,
    CAST(WheelsOffMinute AS int64) AS wheels_off_minute,
    CAST(WheelsOffHour AS int64) AS wheels_off_hour,
    CAST(CRSArrTimeMinute AS int64) AS crs_arr_time_minute,
    CAST(CRSArrTimeHour AS int64) AS crs_arr_time_hour,
    CAST(WheelsOnMinute AS int64) AS wheels_on_minute,
    CAST(WheelsOnHour AS int64) AS wheels_on_hour,
    CAST(CRSDepTimeHourDis AS string) AS crs_dep_time_hour_dis,
    CAST(WheelsOffHourDis AS string) AS wheels_off_hour_dis,
    CAST(CRSArrTimeHourDis AS string) AS crs_arr_time_hour_dis,
    CAST (WheelsOnHourDis AS string) AS wheels_on_hour_dis,
    CAST (CRSElapsedTimeGorup AS string) AS crs_elapsed_time_group,
    __index_level_0__ AS index_level_0
FROM raw
