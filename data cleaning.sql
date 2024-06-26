--final joined data
--extracted data
SELECT ride_id, 
    EXTRACT(HOUR FROM (ended_at - started_at)) * 60 +
    EXTRACT(MINUTE FROM (ended_at - started_at)) +
    EXTRACT(SECOND FROM (ended_at - started_at)) / 60 AS ride_length,
    EXTRACT(HOUR FROM started_at) AS hour,
    CASE EXTRACT(DAYOFWEEK FROM started_at) 
      WHEN 1 THEN 'Sun'
      WHEN 2 THEN 'Mon'
      WHEN 3 THEN 'Tues'
      WHEN 4 THEN 'Wed'
      WHEN 5 THEN 'Thurs'
      WHEN 6 THEN 'Fri'
      WHEN 7 THEN 'Sat'    
    END AS week_day,
    CASE EXTRACT(MONTH FROM started_at)
      WHEN 1 THEN 'Jan'
      WHEN 2 THEN 'Feb'
      WHEN 3 THEN 'Mar'
      WHEN 4 THEN 'Apr'
      WHEN 5 THEN 'May'
      WHEN 6 THEN 'Jun'
      WHEN 7 THEN 'Jul'
      WHEN 8 THEN 'Aug'
      WHEN 9 THEN 'Sep'
      WHEN 10 THEN 'Oct'
      WHEN 11 THEN 'Nov'
      WHEN 12 THEN 'Dec'
    END AS month,
    CASE WHEN EXTRACT(DAYOFWEEK FROM started_at) IN (1, 7) THEN 'Weekend' ELSE 'Weekday' END AS day_type,    
FROM `case-study-419113.tripdata2020_case_study.merged_data` 


--join merged data and extracted data
SELECT
    `case-study-419113.tripdata2020_case_study.merged_data` .ride_id,
    `case-study-419113.tripdata2020_case_study.merged_data` .rideable_type,
    `case-study-419113.tripdata2020_case_study.merged_data` .started_at,
    `case-study-419113.tripdata2020_case_study.merged_data` .ended_at,
    `case-study-419113.tripdata2020_case_study.merged_data` .start_station_name,
    `case-study-419113.tripdata2020_case_study.merged_data` .start_station_id,
    `case-study-419113.tripdata2020_case_study.merged_data` .end_station_name,
    `case-study-419113.tripdata2020_case_study.merged_data` .end_station_id,
    `case-study-419113.tripdata2020_case_study.merged_data` .start_lat,
    `case-study-419113.tripdata2020_case_study.merged_data` .start_lng,
    `case-study-419113.tripdata2020_case_study.merged_data` .end_lat,
    `case-study-419113.tripdata2020_case_study.merged_data` .end_lng,
    `case-study-419113.tripdata2020_case_study.merged_data` .member_casual,
    `case-study-419113.tripdata2020_case_study.extracted_data1`.ride_length,
    `case-study-419113.tripdata2020_case_study.extracted_data1`.week_day,
    `case-study-419113.tripdata2020_case_study.extracted_data1`.month,
    `case-study-419113.tripdata2020_case_study.extracted_data1`.hour,
    `case-study-419113.tripdata2020_case_study.extracted_data1`.day_type 
FROM 
    `case-study-419113.tripdata2020_case_study.merged_data` 
JOIN
   `case-study-419113.tripdata2020_case_study.extracted_data1`
ON `case-study-419113.tripdata2020_case_study.merged_data`.ride_id = `case-study-419113.tripdata2020_case_study.extracted_data1`.ride_id
WHERE start_station_id IS NOT NULL
  AND end_station_id IS NOT NULL
  AND end_lat IS NOT NULL
  AND end_lng IS NOT NULL
  AND ride_length >= 1 AND ride_length <= 1440
	
--further filtering
SELECT DISTINCT(ride_id),
                rideable_type,started_at,ended_at,start_station_name,
                start_station_id,end_station_name,end_station_id,
                start_lat,start_lng,end_lat,end_lng,member_casual,
                ride_length,week_day,month,hour,day_type
FROM `case-study-419113.tripdata2020_case_study.joined_data2`
WHERE LENGTH(ride_id) = 16   


--get the number of rows
SELECT COUNT (ride_id)
FROM `case-study-419113.tripdata2020_case_study.final_joined_data2`
--there are 3253617 rides
