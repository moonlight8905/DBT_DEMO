WITH CTE AS (
    select
        t.*,
        w.*
    from {{ ref('fact_trip') }} t
    left join {{ ref('daily_weather') }} w
        on t.trip_date = w.day_weather
)

select * from CTE