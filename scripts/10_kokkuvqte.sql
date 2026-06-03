-- MTR toitlustus — 2024 ja 2025 statistika
WITH algus_2024_stats AS (
    SELECT
        COUNT(*) FILTER (WHERE maksu_a < 2024) AS varasemalt,
        COUNT(*) FILTER (WHERE maksu_a = 2024) AS jooksev,
        COUNT(*) FILTER (WHERE maksu_a = 2025) AS jargmine,
        COUNT(*) FILTER (WHERE maksu_a = 2026) AS ylejargmine
    FROM (
        SELECT DISTINCT ON (registrikood) maksu_a
        FROM algus_2024
        ORDER BY registrikood, maksu_a DESC
    ) t
),
algus_2025_stats AS (
    SELECT
        COUNT(*) FILTER (WHERE maksu_a < 2025) AS varasemalt,
        COUNT(*) FILTER (WHERE maksu_a = 2025) AS jooksev,
        COUNT(*) FILTER (WHERE maksu_a = 2026) AS jargmine,
        COUNT(*) FILTER (WHERE maksu_a = 2027) AS ylejargmine
    FROM (
        SELECT DISTINCT ON (registrikood) maksu_a
        FROM algus_2025
        ORDER BY registrikood, maksu_a DESC
    ) t
),
esmakordne AS (
    SELECT
        COUNT(*) FILTER (WHERE min_aasta = 2024) AS esm_2024,
        COUNT(*) FILTER (WHERE min_aasta = 2025) AS esm_2025
    FROM (
        SELECT registrikood, MIN(aasta) AS min_aasta
        FROM mtr_toitlustus_puhas
        GROUP BY registrikood
    ) t
    WHERE min_aasta IN (2024, 2025)
)
SELECT
    'algus_2024'                        AS tabel,
    a24.varasemalt,
    a24.jooksev,
    a24.jargmine,
    e.esm_2024                          AS esmakordne_taotlus
FROM algus_2024_stats a24, esmakordne e

UNION ALL

SELECT
    'algus_2025',
    a25.varasemalt,
    a25.jooksev,
    a25.jargmine,
    e.esm_2025
FROM algus_2025_stats a25, esmakordne e

UNION ALL

SELECT
    'Keskmiselt',
    ROUND((a24.varasemalt + a25.varasemalt) / 2.0, 1)::numeric,
    ROUND((a24.jooksev + a25.jooksev) / 2.0, 1)::numeric,
    ROUND((a24.jargmine + a25.jargmine) / 2.0, 1)::numeric,
    ROUND((e.esm_2024 + e.esm_2025) / 2.0, 1)::numeric
FROM algus_2024_stats a24, algus_2025_stats a25, esmakordne e;
