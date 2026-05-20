from pathlib import Path
import requests

BASE_URL = "https://d37ci6vzurychx.cloudfront.net/trip-data"
DATA_DIR = Path("data/bronze/yellow_taxi")

def download_file(year: int, month: int) -> None:
    month_str = f"{month:02d}"
    file_name = f"yellow_tripdata_{year}-{month_str}.parquet"
    url = f"{BASE_URL}/{file_name}"

    DATA_DIR.mkdir(parents=True, exist_ok=True)
    output_path = DATA_DIR / file_name

    print(f"Downloading {url}")
    response = requests.get(url)
    response.raise_for_status()

    with open(output_path, "wb") as file:
        file.write(response.content)

    print(f"Saved to {output_path}")

if __name__ == "__main__":
    download_file(2025, 1)