from pathlib import Path
import pandas as pd

file_path = Path("data/bronze/yellow_taxi/yellow_tripdata_2025-01.parquet")

df = pd.read_parquet(file_path)

print("Rows:", len(df))
print("Columns:", len(df.columns))
print("\nColumn names:")
print(df.columns.tolist())

print("\nFirst 5 rows:")
print(df.head())

print("\nData types:")
print(df.dtypes)