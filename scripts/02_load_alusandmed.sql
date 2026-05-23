TRUNCATE TABLE MTR_alusandmed;
COPY MTR_alusandmed (
    taotluse_number,
    nimi,
    registrikood,
    kehtivuse_algus,
    kehtivuse_lopp,
    kehtivus,
    tegevusala,
    lisainfo
)
FROM '/data/MTR_majandustegevusteated_toitlustus.csv' with (
        FORMAT csv,
        HEADER true,
        DELIMITER ';',
        ENCODING 'UTF8'
    );
TRUNCATE TABLE MTA_alusandmed_ka;
COPY MTA_alusandmed_ka (
    andmete_seis,
    registrikood,
    nimi,
    liik,
    maakond,
    tegevusala,
    aasta,
    riiklikud_maksud_i_kv,
    riiklikud_maksud_ii_kv,
    riiklikud_maksud_iii_kv,
    riiklikud_maksud_iv_kv,
    toojoumaksud_i_kv,
    toojoumaksud_ii_kv,
    toojoumaksud_iii_kv,
    toojoumaksud_iv_kv,
    kaive_i_kv,
    kaive_ii_kv,
    kaive_iii_kv,
    kaive_iv_kv,
    tootajate_arv_i_kv,
    tootajate_arv_ii_kv,
    tootajate_arv_iii_kv,
    tootajate_arv_iv_kv
)
FROM '/data/MTA_tasutud_maksud_kaesolev_aasta.csv' with (
        FORMAT csv,
        HEADER true,
        DELIMITER ',',
        QUOTE '"',
        ENCODING 'UTF8'
    );
TRUNCATE TABLE MTA_alusandmed_va;
COPY MTA_alusandmed_va (
    andmete_seis,
    registrikood,
    nimi,
    liik,
    maakond,
    tegevusala,
    aasta,
    riiklikud_maksud_i_kv,
    riiklikud_maksud_ii_kv,
    riiklikud_maksud_iii_kv,
    riiklikud_maksud_iv_kv,
    toojoumaksud_i_kv,
    toojoumaksud_ii_kv,
    toojoumaksud_iii_kv,
    toojoumaksud_iv_kv,
    kaive_i_kv,
    kaive_ii_kv,
    kaive_iii_kv,
    kaive_iv_kv,
    tootajate_arv_i_kv,
    tootajate_arv_ii_kv,
    tootajate_arv_iii_kv,
    tootajate_arv_iv_kv
)
FROM '/data/MTA_tasutud_maksud_varasemad_aastad.csv' with (
        FORMAT csv,
        HEADER true,
        DELIMITER ',',
        QUOTE '"',
        ENCODING 'UTF8'
    );