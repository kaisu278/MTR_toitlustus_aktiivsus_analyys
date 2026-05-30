import requests
from pathlib import Path
import pandas as pd

url = "https://ncfailid.emta.ee/s/bCszrta8THHA9xn/download/tasutud_maksud_varasemad_aastad.csv"

DATA_DIR = Path("data")
DATA_DIR.mkdir(exist_ok=True)

RAW_FILE = DATA_DIR / "tasutud_maksud_varasemad_aastad.csv"
CLEAN_FILE = DATA_DIR / "tasutud_maksud_varasemad_aastad_puhas.csv"

try:
    print("Laen faili alla...")

    response = requests.get(url, timeout=300, stream=True)
    response.raise_for_status()

    with open(RAW_FILE, "wb") as file:
        for chunk in response.iter_content(chunk_size=1024 * 1024):
            if chunk:
                file.write(chunk)

    print(f"Fail laaditi edukalt alla: {RAW_FILE}")
    print(f"Faili suurus: {RAW_FILE.stat().st_size:,} baiti")

    df = pd.read_csv(
        RAW_FILE,
        sep=",",
        encoding="utf-8",
        dtype={"Registrikood": str}
    )

    df.columns = [
        "andmete_seis",
        "registrikood",
        "nimi",
        "liik",
        "maakond",
        "tegevusala",
        "aasta",
        "riiklikud_maksud_i_kv",
        "riiklikud_maksud_ii_kv",
        "riiklikud_maksud_iii_kv",
        "riiklikud_maksud_iv_kv",
        "toojoumaksud_i_kv",
        "toojoumaksud_ii_kv",
        "toojoumaksud_iii_kv",
        "toojoumaksud_iv_kv",
        "kaive_i_kv",
        "kaive_ii_kv",
        "kaive_iii_kv",
        "kaive_iv_kv",
        "tootajate_arv_i_kv",
        "tootajate_arv_ii_kv",
        "tootajate_arv_iii_kv",
        "tootajate_arv_iv_kv"
    ]

    df.to_csv(
        CLEAN_FILE,
        index=False,
        sep=";",
        encoding="utf-8-sig"
    )

    print(f"Puhastatud CSV loodud: {CLEAN_FILE}")
    print(f"Ridu: {len(df)}")

    print("\nVEERUD:")
    for col in df.columns:
        print(col)

except Exception as error:
    print("Faili töötlemisel tekkis viga:")
    print(error)