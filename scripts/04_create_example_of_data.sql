/* näide MTR andmetest */
SELECT count (*) as kannete_arv_MTR
FROM MTR_alusandmed;
SELECT taotluse_number,
    nimi,
    registrikood,
    kehtivuse_algus,
    kehtivuse_lopp,
    kehtivus,
    tegevusala
FROM MTR_alusandmed
limit 5;
/* näide MTA käesoleva aasta andmetest*/
SELECT count (*) as kannete_arv_MTA_ka
FROM MTA_alusandmed_ka;
SELECT andmete_seis,
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
FROM MTA_alusandmed_ka
limit 2;
/* näide MTA varasemate aastate andmetest */
SELECT count (*) as kannete_arv_MTA_va
FROM MTA_alusandmed_va;
SELECT andmete_seis,
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
FROM MTA_alusandmed_va
limit 2;