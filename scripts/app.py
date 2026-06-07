import os
import psycopg2
import pandas as pd
import streamlit as st
from dotenv import load_dotenv
import plotly.graph_objects as go

load_dotenv()

@st.cache_data(ttl=60)
def get_load_count_2026() -> int:
    conn = psycopg2.connect(
        host=os.getenv("DB_HOST", "db"),
        port=os.getenv("DB_PORT", "5432"),
        dbname=os.getenv("DB_NAME"),
        user=os.getenv("DB_USER"),
        password=os.getenv("DB_PASSWORD")
    )
    df = pd.read_sql(
        "SELECT COUNT(*) AS load_algusega_2026 FROM mtr_toitlustus_jagamine WHERE algus_a=2026",
        conn
    )
    conn.close()
    return int(df["load_algusega_2026"].iloc[0])

st.title("MTR Toitlustus — ülevaade")
count = get_load_count_2026()
st.metric(label="Tegevusload algusega 2026", value=f"{count:,}".replace(",", " "))

@st.cache_data(ttl=60)
def get_maksu_stats():
    conn = psycopg2.connect(
        host=os.getenv("DB_HOST", "db"),
        port=os.getenv("DB_PORT", "5432"),
        dbname=os.getenv("DB_NAME"),
        user=os.getenv("DB_USER"),
        password=os.getenv("DB_PASSWORD")
    )
    query = """
    WITH algus_2024_stats AS (
    SELECT COUNT(*) FILTER (
            WHERE maksu_a < 2024
        ) AS varasemalt,
        COUNT(*) FILTER (
            WHERE maksu_a = 2024
        ) AS jooksev,
        COUNT(*) FILTER (
            WHERE maksu_a = 2025
        ) AS jargmine,
        COUNT(*) FILTER (
            WHERE maksu_a = 2026
        ) AS ylejargmine
    FROM (
            SELECT DISTINCT ON (registrikood) maksu_a
            FROM algus_2024
            ORDER BY registrikood,
                maksu_a DESC
        ) t
),
algus_2025_stats AS (
    SELECT COUNT(*) FILTER (
            WHERE maksu_a < 2025
        ) AS varasemalt,
        COUNT(*) FILTER (
            WHERE maksu_a = 2025
        ) AS jooksev,
        COUNT(*) FILTER (
            WHERE maksu_a = 2026
        ) AS jargmine,
        COUNT(*) FILTER (
            WHERE maksu_a = 2027
        ) AS ylejargmine
    FROM (
            SELECT DISTINCT ON (registrikood) maksu_a
            FROM algus_2025
            ORDER BY registrikood,
                maksu_a DESC
        ) t
),
esmakordne AS (
    SELECT COUNT(*) FILTER (
            WHERE min_aasta = 2024
        ) AS esm_2024,
        COUNT(*) FILTER (
            WHERE min_aasta = 2025
        ) AS esm_2025
    FROM (
            SELECT registrikood,
                MIN(algus_a) AS min_aasta
            FROM mtr_toitlustus_jagamine
            GROUP BY registrikood
        ) t
    WHERE min_aasta IN (2024, 2025)
)
SELECT 'algus_2024' AS tabel,
    a24.varasemalt,
    a24.jooksev,
    a24.jargmine,
    e.esm_2024 AS esmakordne_taotlus
FROM algus_2024_stats a24,
    esmakordne e
UNION ALL
SELECT 'algus_2025',
    a25.varasemalt,
    a25.jooksev,
    a25.jargmine,
    e.esm_2025
FROM algus_2025_stats a25,
    esmakordne e
UNION ALL
SELECT 'Keskmiselt',
    ROUND(
        (a24.varasemalt + a25.varasemalt) / 2.0,
        1
    )::numeric,
    ROUND(
        (a24.jooksev + a25.jooksev) / 2.0,
        1
    )::numeric,
    ROUND((a24.jargmine + a25.jargmine) / 2.0, 1)::numeric,
    ROUND((e.esm_2024 + e.esm_2025) / 2.0, 1)::numeric
FROM algus_2024_stats a24,
    algus_2025_stats a25,
    esmakordne e
    """
    df = pd.read_sql(query, conn)
    conn.close()
    return df


st.subheader("Loa kehtivuse algusest alates makstakse makse ja deklareeritakse töötajaid:")
df = get_maksu_stats()
df.columns = ["Aasta", "Enne kehtivuse algust", "Jooksval aastal", "Järgmisel aastal", "Esmakordne taotlus"]
st.dataframe(df, hide_index=True)

# Sektordiagramm (ainult keskmiste rea põhjal)
avg_row = df[df["Aasta"] == "Keskmiselt"].iloc[0]
esm_total = float(avg_row["Esmakordne taotlus"])
vals = {
    "Enne kehtivuse algust": float(avg_row["Enne kehtivuse algust"]),
    "Jooksval aastal": float(avg_row["Jooksval aastal"]),
    "Järgmisel aastal": float(avg_row["Järgmisel aastal"]),
}
muud = max(0, esm_total - sum(vals.values()))
pie_labels = list(vals.keys()) + ["Muud"]
pie_values = list(vals.values()) + [muud]

import plotly.graph_objects as go
fig = go.Figure(go.Pie(
    labels=pie_labels,
    values=pie_values,
    hole=0.3,
    textinfo="label+percent",
    sort=False,
))
fig.update_layout(
    title="Esmakordsetest taotlustest (100%) maksu-aasta jaotus — keskmiselt",
    margin=dict(t=50, b=20, l=20, r=20),
)
st.plotly_chart(fig, use_container_width=True)
