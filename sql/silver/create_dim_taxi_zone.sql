bq query --use_legacy_sql=false '
CREATE OR REPLACE TABLE `urban_mobility_silver.dim_taxi_zone`
AS

SELECT
    LocationID AS location_id,
    Borough AS borough,
    Zone AS zone_name,
    service_zone

FROM `urban_mobility_bronze.taxi_zone_lookup`
'