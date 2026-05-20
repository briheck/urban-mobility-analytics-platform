bq query --use_legacy_sql=false '
CREATE OR REPLACE TABLE `urban_mobility_silver.yellow_taxi_trips_cleaned`
PARTITION BY pickup_date
AS

SELECT
    VendorID AS vendor_id,

    tpep_pickup_datetime AS pickup_datetime,
    tpep_dropoff_datetime AS dropoff_datetime,

    DATE(tpep_pickup_datetime) AS pickup_date,
    EXTRACT(HOUR FROM tpep_pickup_datetime) AS pickup_hour,

    passenger_count,
    trip_distance,

    PULocationID AS pickup_location_id,
    DOLocationID AS dropoff_location_id,

    payment_type,

    fare_amount,
    tip_amount,
    total_amount,

    TIMESTAMP_DIFF(
        tpep_dropoff_datetime,
        tpep_pickup_datetime,
        MINUTE
    ) AS trip_duration_minutes,

    SAFE_DIVIDE(
        fare_amount,
        NULLIF(trip_distance, 0)
    ) AS fare_per_mile,

    SAFE_DIVIDE(
        tip_amount,
        NULLIF(fare_amount, 0)
    ) AS tip_percentage

FROM `urban_mobility_bronze.yellow_taxi_trips`

WHERE
    trip_distance > 0
    AND fare_amount >= 0
    AND tpep_dropoff_datetime > tpep_pickup_datetime
'