from pathlib import Path
import requests

TAXI_ZONE_URL = "https://d37ci6vzurychx.cloudfront.net/misc/taxi_zone_lookup.csv"
DATA_DIR = Path("data/bronze/taxi_zones")


def download_taxi_zone_lookup() -> None:
    file_name = "taxi_zone_lookup.csv"
    output_path = DATA_DIR / file_name

    DATA_DIR.mkdir(parents=True, exist_ok=True)

    print(f"Downloading {TAXI_ZONE_URL}")
    response = requests.get(TAXI_ZONE_URL)
    response.raise_for_status()

    with open(output_path, "wb") as file:
        file.write(response.content)

    print(f"Saved to {output_path}")


if __name__ == "__main__":
    download_taxi_zone_lookup()