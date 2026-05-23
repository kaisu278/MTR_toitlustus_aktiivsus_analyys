ALTER TABLE MTR_alusandmed
ALTER COLUMN kehtivuse_algus TYPE DATE USING TO_DATE(kehtivuse_algus, 'DD.MM.YYYY');