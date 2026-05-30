from pathlib import Path
import pandas as pd

DATA_DIR = Path("data")

INPUT_FILE = DATA_DIR / "mtr_toitlustus_majandustegevusteated.csv"
OUTPUT_FILE = DATA_DIR / "mtr_toitlustus_puhas.csv"

df = pd.read_csv(
    INPUT_FILE,
    sep=";",
    encoding="utf-8-sig"
)

df_valitud = df[
    [
        "registrikood",
        "nimi",
        "load_luba_staatus",
        "load_luba_kehtiv_alates",
        "load_luba_kehtiv_kuni"
    ]
]

df_valitud = df_valitud.rename(columns={
    "load_luba_staatus": "staatus",
    "load_luba_kehtiv_alates": "kehtiv_alates",
    "load_luba_kehtiv_kuni": "kehtiv_kuni"
})

# Lisa aasta veerg
df_valitud["aasta"] = pd.to_datetime(
    df_valitud["kehtiv_alates"],
    errors="coerce"
).dt.year

df_valitud.to_csv(
    OUTPUT_FILE,
    index=False,
    sep=";",
    encoding="utf-8-sig"
)

print(f"Fail loodud: {OUTPUT_FILE}")
print(f"Ridu: {len(df_valitud)}")