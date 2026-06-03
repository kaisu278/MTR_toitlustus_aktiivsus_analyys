DROP TABLE IF EXISTS mtr_toitlustus_jagamine;
CREATE TABLE mtr_toitlustus_jagamine (
    registrikood TEXT,
    nimi TEXT,
    staatus TEXT,
    kehtiv_alates DATE,
    kehtiv_kuni DATE,
    algus_a INTEGER
);

COPY mtr_toitlustus_jagamine
FROM '/data/mtr_toitlustus_jagamine.csv' WITH (
        FORMAT csv,
        HEADER true,
        DELIMITER ';',
        ENCODING 'UTF8'
    );
