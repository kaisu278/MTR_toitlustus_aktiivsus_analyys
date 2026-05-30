import requests
from pathlib import Path

url = "https://mtr.ttja.ee/opendata/avaandmed_ettevotjad.xml"

# Kaust, kuhu fail salvestatakse
output_folder = Path("data")
output_folder.mkdir(exist_ok=True)

# Salvestatava faili nimi
output_file = output_folder / "avaandmed_ettevotjad.xml"

try:
    response = requests.get(url, timeout=60)
    response.raise_for_status()

    with open(output_file, "wb") as file:
        file.write(response.content)

    print(f"Fail laaditi edukalt alla: {output_file}")

except requests.exceptions.RequestException as error:
    print("Faili allalaadimisel tekkis viga:")
    print(error)

