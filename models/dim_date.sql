WITH CTE AS(
    
    select
     TO_TIMESTAMP(STARTED_AT) AS started_at,
     DATE(TO_TIMESTAMP(STARTED_AT)) AS date_started_at,
     HOUR(TO_TIMESTAMP(STARTED_AT)) AS hour_started_at,
     DAYNAME(TO_TIMESTAMP(STARTED_AT)) AS day_started_at,
    {{day_type('STARTED_AT')}} AS day_type, -- we can create a macro to save this piece of code to be reuseable. Create file date_utils.sql under Macros folder
                                            --Now that we created the macro, we can just call it instead of typing out the whole case statement
    {{get_season('STARTED_AT')}} AS season
    from
    {{ source('demo', 'bike') }}
    where STARTED_AT != 'started_at'
)

select
*
from CTE