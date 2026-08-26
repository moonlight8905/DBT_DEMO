WITH bike AS
(
    select
            RIDE_ID,
			REPLACE(STARTED_AT,'"','') AS started_at,
			REPLACE(ENDED_AT,'"','') AS ended_at,
			START_STATION_NAME,
			START_STATION_ID,
			END_STATION_NAME,
			END_STATION_ID,
			START_LAT,
			START_LNG,
			END_LAT,
			END_LNG,
			MEMBER_CSUAL
    from {{ source('demo', 'bike') }}    
    where ride_id != 'bikeid' and  started_at != '"starttime"' and  started_at != 'starttime'
)
select * from bike