-- ============================================================
-- Andmete teisendus: algus_2024, algus_2025, algus_2026
-- ============================================================
-- ------------------------------------------------------------
-- 1. algus_2024
-- ------------------------------------------------------------
DROP TABLE IF EXISTS yhendatud_maksud;
CREATE TABLE yhendatud_maksud AS
SELECT *
FROM mtr_toitlustus_maksud_kaesolev_aasta
UNION ALL
SELECT *
FROM mtr_toitlustus_maksud_varasemad_aastad;
DROP TABLE IF EXISTS algus_2024;
CREATE TABLE algus_2024 AS
SELECT ym.*,
    MIN(ym.aasta) OVER (PARTITION BY ym.registrikood) AS maksu_a
FROM yhendatud_maksud ym
WHERE ym.registrikood IN (
        SELECT registrikood
        FROM mtr_toitlustus_jagamine
        WHERE algus_a = 2024
    );
DELETE FROM yhendatud_maksud
WHERE registrikood IN (
        SELECT registrikood
        FROM mtr_toitlustus_jagamine
        WHERE algus_a = 2024
    );
-- ------------------------------------------------------------
-- 2. algus_2025
-- ------------------------------------------------------------
DROP TABLE IF EXISTS algus_2025;
CREATE TABLE algus_2025 AS
SELECT ym.*,
    MIN(ym.aasta) OVER (PARTITION BY ym.registrikood) AS maksu_a
FROM yhendatud_maksud ym
WHERE ym.registrikood IN (
        SELECT registrikood
        FROM mtr_toitlustus_jagamine
        WHERE algus_a = 2025
    );
DELETE FROM yhendatud_maksud
WHERE registrikood IN (
        SELECT registrikood
        FROM mtr_toitlustus_jagamine
        WHERE algus_a = 2025
    );
-- ------------------------------------------------------------
-- 3. algus_2026
-- ------------------------------------------------------------
DROP TABLE IF EXISTS algus_2026;
CREATE TABLE algus_2026 AS
SELECT ym.*,
    MIN(ym.aasta) OVER (PARTITION BY ym.registrikood) AS maksu_a
FROM yhendatud_maksud ym
WHERE ym.registrikood IN (
        SELECT registrikood
        FROM mtr_toitlustus_jagamine
        WHERE algus_a = 2026
    );
DELETE FROM yhendatud_maksud
WHERE registrikood IN (
        SELECT registrikood
        FROM mtr_toitlustus_jagamine
        WHERE algus_a = 2026
    );