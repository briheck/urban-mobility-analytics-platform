SELECT
    pickup_date,
    pickup_hour,
    pickup_borough,

    COUNT(*) AS total_trips,
    SUM(total_amount) AS total_revenue,
    AVG(total_amount) AS avg_total_fare,
    AVG(trip_distance) AS avg_trip_distance,
    AVG(trip_duration_minutes) AS avg_trip_duration_minutes

FROM {{ ref('fact_taxi_trips') }}

GROUP BY
    pickup_date,
    pickup_hour,
    pickup_borough