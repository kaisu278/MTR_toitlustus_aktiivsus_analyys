DROP TABLE IF EXISTS mtr_toitlustus_maksud_kaesolev_aasta;
CREATE TABLE mtr_toitlustus_maksud_kaesolev_aasta AS WITH mtr_unikaalne AS (
    SELECT distinct registrikood
    FROM mtr_toitlustus_jagamine
)
SELECT mta.*
FROM mtr_unikaalne mtr
    LEFT JOIN tasutud_maksud_kaesolev_aasta mta ON mtr.registrikood = mta.registrikood;
DROP TABLE IF EXISTS mtr_toitlustus_maksud_varasemad_aastad;
CREATE TABLE mtr_toitlustus_maksud_varasemad_aastad AS WITH mtr_unikaalne AS (
    SELECT distinct registrikood
    FROM mtr_toitlustus_jagamine
)
SELECT mta.*
FROM mtr_unikaalne mtr
    LEFT JOIN tasutud_maksud_varasemad_aastad mta ON mtr.registrikood = mta.registrikood;