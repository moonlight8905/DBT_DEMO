WITH CTE AS(
    
    select
     TO_TIMESTAMP(STARTED_AT) AS started_at,
     DATE(TO_TIMESTAMP(STARTED_AT)) AS date_started_at,
     HOUR(TO_TIMESTAMP(STARTED_AT)) AS hour_started_at,
     DAYNAME(TO_TIMESTAMP(STARTED_AT)) AS day_started_at,
     CASE
        WHEN  DAYNAME(TO_TIMESTAMP(STARTED_AT)) IN('Sat','Sun')
        THEN 'Weekend'
        ELSE 'Business'
    END AS day_type,
    CASE 
        WHEN MONTH(TO_TIMESTAMP(STARTED_AT)) IN (12,1,2) THEN 'Winter'
        WHEN MONTH(TO_TIMESTAMP(STARTED_AT)) IN (3,4,5) THEN 'Spring'
        WHEN MONTH(TO_TIMESTAMP(STARTED_AT)) IN (6,7,8) THEN 'Summer'
        ELSE 'Autumn'
    END AS season
    from
    {{ source('demo', 'bike') }}
    where STARTED_AT != 'started_at'
)

select
*
from CTE