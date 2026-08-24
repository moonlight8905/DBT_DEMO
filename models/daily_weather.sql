{{
    config(
        materialized='table'
    )
}}

WITH daily_weather AS(

    select
        date(time) as day_weather,
        weather,
        temp,
        pressure,
        humidity,
        clouds
    FROM {{ source('demo', 'weather') }}

),

daily_weather_agg AS(
    select
        day_weather,
        weather,
        ROUND(AVG(temp),2) AS avg_temp,
        ROUND(AVG(pressure),2) AS avg_pressure,
        ROUND(AVG(humidity),2) AS avg_humidity,
        ROUND(AVG(clouds),2) AS avg_clouds
    from daily_weather
    group by day_weather, weather
    QUALIFY ROW_NUMBER() OVER(PARTITION BY day_weather ORDER BY COUNT(weather) DESC) = 1

)

select
    *
from daily_weather_agg