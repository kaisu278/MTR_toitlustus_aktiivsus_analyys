DROP TABLE IF EXISTS mtr_toitlustus_puhas;
DROP TABLE IF EXISTS tasutud_maksud_kaesolev_aasta;
DROP TABLE IF EXISTS tasutud_maksud_varasemad_aastad;
CREATE TABLE mtr_toitlustus_puhas (
    registrikood TEXT,
    nimi TEXT,
    staatus TEXT,
    kehtiv_alates DATE,
    kehtiv_kuni DATE,
    aasta INTEGER
);
CREATE TABLE tasutud_maksud_kaesolev_aasta (
    andmete_seis TEXT,
    registrikood TEXT,
    nimi TEXT,
    liik TEXT,
    maakond TEXT,
    tegevusala TEXT,
    aasta INTEGER,
    riiklikud_maksud_i_kv NUMERIC,
    riiklikud_maksud_ii_kv NUMERIC,
    riiklikud_maksud_iii_kv NUMERIC,
    riiklikud_maksud_iv_kv NUMERIC,
    toojoumaksud_i_kv NUMERIC,
    toojoumaksud_ii_kv NUMERIC,
    toojoumaksud_iii_kv NUMERIC,
    toojoumaksud_iv_kv NUMERIC,
    kaive_i_kv NUMERIC,
    kaive_ii_kv NUMERIC,
    kaive_iii_kv NUMERIC,
    kaive_iv_kv NUMERIC,
    tootajate_arv_i_kv NUMERIC,
    tootajate_arv_ii_kv NUMERIC,
    tootajate_arv_iii_kv NUMERIC,
    tootajate_arv_iv_kv NUMERIC
);
CREATE TABLE tasutud_maksud_varasemad_aastad (
    andmete_seis TEXT,
    registrikood TEXT,
    nimi TEXT,
    liik TEXT,
    maakond TEXT,
    tegevusala TEXT,
    aasta INTEGER,
    riiklikud_maksud_i_kv NUMERIC,
    riiklikud_maksud_ii_kv NUMERIC,
    riiklikud_maksud_iii_kv NUMERIC,
    riiklikud_maksud_iv_kv NUMERIC,
    toojoumaksud_i_kv NUMERIC,
    toojoumaksud_ii_kv NUMERIC,
    toojoumaksud_iii_kv NUMERIC,
    toojoumaksud_iv_kv NUMERIC,
    kaive_i_kv NUMERIC,
    kaive_ii_kv NUMERIC,
    kaive_iii_kv NUMERIC,
    kaive_iv_kv NUMERIC,
    tootajate_arv_i_kv NUMERIC,
    tootajate_arv_ii_kv NUMERIC,
    tootajate_arv_iii_kv NUMERIC,
    tootajate_arv_iv_kv NUMERIC
);
COPY mtr_toitlustus_puhas
FROM '/data/mtr_toitlustus_puhas.csv' WITH (
        FORMAT csv,
        HEADER true,
        DELIMITER ';',
        ENCODING 'UTF8'
    );
COPY tasutud_maksud_kaesolev_aasta
FROM '/data/tasutud_maksud_kaesolev_aasta_puhas.csv' WITH (
        FORMAT csv,
        HEADER true,
        DELIMITER ';',
        QUOTE '"',
        ENCODING 'UTF8'
    );
COPY tasutud_maksud_varasemad_aastad
FROM '/data/tasutud_maksud_varasemad_aastad_puhas.csv' WITH (
        FORMAT csv,
        HEADER true,
        DELIMITER ';',
        QUOTE '"',
        ENCODING 'UTF8'
    );