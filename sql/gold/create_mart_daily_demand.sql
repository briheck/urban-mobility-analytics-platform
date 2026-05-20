CREATE OR REPLACE TABLE `urban_mobility_gold.mart_daily_demand`
AS

SELECT
    pickup_date,
    pickup_borough,

    COUNT(*) AS total_trips,
    SUM(total_amount) AS total_revenue,
    AVG(total_amount) AS avg_total_fare,
    AVG(trip_distance) AS avg_trip_distance,
    AVG(trip_duration_minutes) AS avg_trip_duration_minutes,
    AVG(fare_per_mile) AS avg_fare_per_mile,
    AVG(tip_percentage) AS avg_tip_percentage

FROM `urban_mobility_gold.fact_taxi_trips`

GROUP BY
    pickup_date,
    pickup_borough;