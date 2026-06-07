DROP TABLE IF EXISTS kvaliteedikontroll_tabel;
CREATE TABLE kvaliteedikontroll_tabel AS
SELECT *,
    CURRENT_TIMESTAMP AS kvaliteedikontrolli_aeg
FROM yhendatud_maksud
WHERE riiklikud_maksud_i_kv < 0
    OR riiklikud_maksud_ii_kv < 0
    OR riiklikud_maksud_iii_kv < 0
    OR riiklikud_maksud_iv_kv < 0
    OR tootajate_arv_i_kv < 0
    OR tootajate_arv_ii_kv < 0
    OR tootajate_arv_iii_kv < 0
    OR tootajate_arv_iv_kv < 0
    OR registrikood is NULL;