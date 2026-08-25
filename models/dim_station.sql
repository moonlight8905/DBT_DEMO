{{
    config(
        materialized='table'
    )
}}

WITH BIKE AS(
    select distinct
        START_STATION_ID AS station_id,
        START_STATION_NAME AS station_name,
        START_LAT AS station_lat,
        START_LNG AS station_long
    from {{ source('demo', 'bike') }}
    where ride_id != 'ride_id'
)

select * from BIKE
