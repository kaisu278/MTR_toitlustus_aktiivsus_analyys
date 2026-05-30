from pathlib import Path
import pandas as pd
import xml.etree.ElementTree as ET

DATA_DIR = Path("data")
XML_FILE = DATA_DIR / "avaandmed_ettevotjad.xml"
CSV_FILE = DATA_DIR / "mtr_avaandmed_ettevotjad_load.csv"

def clean_tag(tag):
    return tag.split("}")[-1]

def flatten_children(element, prefix=""):
    row = {}

    for child in element:
        tag = clean_tag(child.tag)
        key = f"{prefix}_{tag}" if prefix else tag

        if len(child):
            row.update(flatten_children(child, key))
        else:
            row[key] = child.text.strip() if child.text else ""

    return row

tree = ET.parse(XML_FILE)
root = tree.getroot()

records = []

for element in root.iter():
    if clean_tag(element.tag) == "ettevotja":
        ettevotja_andmed = {}

        for child in element:
            tag = clean_tag(child.tag)

            if tag != "load":
                ettevotja_andmed[tag] = child.text.strip() if child.text else ""

        load_element = None

        for child in element:
            if clean_tag(child.tag) == "load":
                load_element = child
                break

        if load_element is None:
            records.append(ettevotja_andmed)
            continue

        for luba in load_element:
            row = ettevotja_andmed.copy()

            luba_andmed = flatten_children(luba, "load_luba")
            row.update(luba_andmed)

            records.append(row)

df = pd.DataFrame(records)

df_filtered = df[
    (df["load_luba_tyyp"] == "Majandustegevusteade")
    & (df["load_luba_tegevusala"] == "Toitlustamine")
]

CSV_FILE = DATA_DIR / "mtr_toitlustus_majandustegevusteated.csv"

df_filtered.to_csv(
    CSV_FILE,
    index=False,
    encoding="utf-8-sig",
    sep=";"
)

print(f"CSV loodud: {CSV_FILE}")
print(f"Kirjeid enne filtrit: {len(df)}")
print(f"Kirjeid pärast filtrit: {len(df_filtered)}")

print("Veerud:")
print(df_filtered.columns.tolist())

print("\nESIMESED 10 RIDA:")
print(df.head(10).to_string())