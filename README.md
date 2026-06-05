# MTR_toitlustus_aktiivsus_analyys

Majandustegevusteate ja majandusaktiivsuse seos: toitlustusettevõtete analüüs MTR ja MTA andmete põhjal

## Äriküsimus

Kui suur osa majandustegevuseteate esitanud toitlustusettevõtetest hakkab reaalselt majandustegevust näitama (käive ja töötajad) ning kui kiiresti see toimub?

### Mõõdikud:

1. Osakaal majandustegevusteate esitanud isikutest, kes deklareerivad töötajaid MTA andmetel (grupid: varasemalt töötajad, kuni 3 kuud, 4-6 kuud, 6-12 kuud, üle 12 kuu)
2. Osakaal majandustegevusteate esitanud isikutest, kes deklareerivad käivet MTA andmetel (grupid: varasemalt töötajad, kuni 3 kuud, 4-6 kuud, 6-12 kuud, üle 12 kuu)

## Andmeallikad

| Allikas                                                                                       | tüüp      | Uuenemise aeg    | Roll          |
| :-------------------------------------------------------------------------------------------- | :-------- | :--------------- | :------------ |
| Majandustegevuse registeri avaandm                                                            | fail      | reaalajas uuenev | põhiandmevoog |
| Maksu- ja Tolliameti avaandmed tasutud maksude, käibe ja töötajate kohta käesoleval aastal    | fail      | korra kvartalis  | põhiandmevoog |
| Maksu- ja Tolliameti avaandmed tasutud maksude, käibe ja töötajate kohta varasematel aastatel | fail      | ei uuene         | lisaandmevoog |
## Andmestik

## Stack

| Komponent         | Kirjeldus                               | Tööriist |
| :---------------- | :-------------------------------------- | :------- |
| Sissevõtt         | Andmete allalaadimine                   |
| Transformatsiooon | Andmete ühendamine, mõõdikute arvutused |
| Andmehoidla       |
| Näidikulaud       | Mõõdikute kuvamine                      |

## Käivitamine

```bash
# 1. Klooni repo ja liigu kausta
git clone <https://github.com/kaisu278/MTR_toitlustus_aktiivsus_analyys>
cd <MTR_toitlustus_aktiivsus_analyys>

# 2. Kopeeri keskkonnamuutujad
cp .env.example .env
Muuda .env failis paroolid ja muud seaded vastavalt vajadusele

# 3. Kui sul juba pole, siis installi Mermaid CLI, python requests
npm install -g @mermaid-js/mermaid-cli
pip install requests
pip install requests pandas


# 4. Käivita teenused
docker compose up -d --build

# 5. Lae alla majandustegevusregistri avaandmed
python scripts\01_MTR_alusandmed.py

# 6. Tee XML tabelist CSV fail ja filtreeri välja ainult majandustegevsuteated toitlustamise tegevusalal
python scripts\02_MTR_to_csv.py

# 7. Lae alla MTA andmed tasutud maksude, käibe ja töötajate kohta jooksva perioodi kohta
python scripts\03_MTA_jooksvad_alusandmed.py

# 8. Lae alla MTA andmed tasutud maksude, käibe ja töötajate kohta varasema perioodi kohta
python scripts\04_MTA_varasemad_alusandmed.py

# 9. Tee MTR andmetest puhastatud tabel, kus on ainult olulised andmed
python scripts\05_MTR_andmete_puhastamine.py

# 10. Tee MTR andmetest ettevalmistav tabel aastate kaupa jagamiseks
python scripts/051_MTR_andmed_jagamiseks.py

# 11. Loo ühendus andmebaasiga
docker compose exec db psql -U praktikum -d praktikum

# 12. Loo tabelid ja lae sissetõmmatud andmed dockerisse
\i /scripts/06_uute_tabelite_laadimine.sql

# 13. Toitlustuslubadega ettevõtete tabeli loomine
\i /scripts/061_toitlustus_jagamine_laadimine.sql

# 14. Tee MTA andmetest tabelid, kus on ainult MTR toitlustuse majandustegevusteate esitanud isikute andmed
\i /scripts/07_MTR_MTA_andmed_juurde.sql

# 15. Pane MTA andmetega tabelid kokku
 \i /scripts/08_MTR_MTA_andmed_kokku.sql

# 16. Jaga lubade kehtivuse alguse alusel 3-ks tabeliks
\i /scripts/09_andmete_jagamine_maksu.sql

# 17. Koosta lõplikud tabelid
\i /scripts/10_kokkuvõte.sql

# 18. Ava brauseris dashboard
http://localhost:8501


# Otsad kokku
\q
Kui soovid praktikumis tööle joone alla tõmmata, peata konteiner:

docker compose down
Kui soovid kustutada ka andmemahu:

docker compose down -v

```

## Meeskond

| Nimi            | Roll |
| --------------- | ---- |
| Aare Järvan     |
| Anne-Mai Ilumäe |
| Juta Luts       |
| Kaisa Eesmaa    |
