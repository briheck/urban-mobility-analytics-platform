CREATE OR REPLACE TABLE `urban_mobility_gold.fact_taxi_trips`
PARTITION BY pickup_date
AS

SELECT
    trips.vendor_id,
    trips.pickup_datetime,
    trips.dropoff_datetime,
    trips.pickup_date,
    trips.pickup_hour,

    trips.passenger_count,
    trips.trip_distance,
    trips.trip_duration_minutes,
    trips.fare_per_mile,
    trips.tip_percentage,

    trips.pickup_location_id,
    pickup_zone.borough AS pickup_borough,
    pickup_zone.zone_name AS pickup_zone_name,
    pickup_zone.service_zone AS pickup_service_zone,

    trips.dropoff_location_id,
    dropoff_zone.borough AS dropoff_borough,
    dropoff_zone.zone_name AS dropoff_zone_name,
    dropoff_zone.service_zone AS dropoff_service_zone,

    trips.payment_type,
    trips.fare_amount,
    trips.tip_amount,
    trips.total_amount

FROM `urban_mobility_silver.yellow_taxi_trips_cleaned` AS trips

LEFT JOIN `urban_mobility_silver.dim_taxi_zone` AS pickup_zone
    ON trips.pickup_location_id = pickup_zone.location_id

LEFT JOIN `urban_mobility_silver.dim_taxi_zone` AS dropoff_zone
    ON trips.dropoff_location_id = dropoff_zone.location_id;