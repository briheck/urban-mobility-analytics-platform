# urban-mobility-analytics-platform

# Architecture Definition

NYC TLC Parquet Files
        ↓
Bronze: Raw files in GCS
        ↓
Silver: Cleaned/conformed trips in BigQuery
        ↓
Gold: dbt marts for dashboarding
        ↓
Power BI Dashboard
