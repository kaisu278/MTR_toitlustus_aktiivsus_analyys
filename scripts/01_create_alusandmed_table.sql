DROP TABLE IF EXISTS MTR_alusandmed;
create table MTR_alusandmed (
    taotluse_number TEXT NOT NULL,
    nimi TEXT,
    registrikood TEXT,
    kehtivuse_algus TEXT,
    kehtivuse_lopp TEXT,
    kehtivus TEXT,
    tegevusala TEXT,
    lisainfo TEXT
);
DROP TABLE IF EXISTS MTA_alusandmed_ka;
create table MTA_alusandmed_ka (
    andmete_seis TEXT,
    registrikood TEXT,
    nimi TEXT,
    liik TEXT,
    maakond TEXT,
    tegevusala TEXT,
    aasta INTEGER,
    riiklikud_maksud_i_kv BIGINT,
    riiklikud_maksud_ii_kv BIGINT,
    riiklikud_maksud_iii_kv BIGINT,
    riiklikud_maksud_iv_kv BIGINT,
    toojoumaksud_i_kv BIGINT,
    toojoumaksud_ii_kv BIGINT,
    toojoumaksud_iii_kv BIGINT,
    toojoumaksud_iv_kv BIGINT,
    kaive_i_kv BIGINT,
    kaive_ii_kv BIGINT,
    kaive_iii_kv BIGINT,
    kaive_iv_kv BIGINT,
    tootajate_arv_i_kv INTEGER,
    tootajate_arv_ii_kv INTEGER,
    tootajate_arv_iii_kv INTEGER,
    tootajate_arv_iv_kv INTEGER
);
DROP TABLE IF EXISTS MTA_alusandmed_va;
create table MTA_alusandmed_va (
    andmete_seis TEXT,
    registrikood TEXT,
    nimi TEXT,
    liik TEXT,
    maakond TEXT,
    tegevusala TEXT,
    aasta INTEGER,
    riiklikud_maksud_i_kv BIGINT,
    riiklikud_maksud_ii_kv BIGINT,
    riiklikud_maksud_iii_kv BIGINT,
    riiklikud_maksud_iv_kv BIGINT,
    toojoumaksud_i_kv BIGINT,
    toojoumaksud_ii_kv BIGINT,
    toojoumaksud_iii_kv BIGINT,
    toojoumaksud_iv_kv BIGINT,
    kaive_i_kv BIGINT,
    kaive_ii_kv BIGINT,
    kaive_iii_kv BIGINT,
    kaive_iv_kv BIGINT,
    tootajate_arv_i_kv INTEGER,
    tootajate_arv_ii_kv INTEGER,
    tootajate_arv_iii_kv INTEGER,
    tootajate_arv_iv_kv INTEGER
)