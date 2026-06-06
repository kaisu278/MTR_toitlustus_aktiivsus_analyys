DROP TABLE IF EXISTS kvaliteedikontroll;

CREATE TABLE kvaliteedikontroll AS
SELECT *,
    'NULL andmeväljal' AS põhjus,
    CURRENT_TIMESTAMP AS kvaliteedikontrolli_aeg
FROM yhendatud_maksud
WHERE registrikood IS NULL;