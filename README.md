# MTR_toitlustus_aktiivsus_analyys

Majandustegevusteate ja majandusaktiivsuse seos: toitlustusettevõtete analüüs MTR ja MTA andmete põhjal

## Äriküsimus

Kui suur osa majandustegevuseteate esitanud toitlustusettevõtetest hakkab reaalselt majandustegevust näitama (makstud maksud ja töötajad) ning kui kiiresti see toimub?

### Mõõdikud:

1. Tegevusloa saanud ettevõtete arv 2026. aastal
2. Osakaal majandustegevusteate esitanud isikutest, kes deklareerivad töötajaid ja tasuvad makse MTA andmetel (grupid: enne kehtivuse algust, jooksval aastal, järgmisel aastal) 

## Andmeallikad

| Allikas                                                                                       | tüüp      | Uuenemise aeg    | Roll          |
| :-------------------------------------------------------------------------------------------- | :-------- | :--------------- | :------------ |
| Majandustegevuse registeri avaandmed                                                            | fail      | reaalajas uuenev | põhiandmevoog |
| Maksu- ja Tolliameti avaandmed tasutud maksude, käibe ja töötajate kohta käesoleval aastal    | fail      | korra kvartalis  | põhiandmevoog |
| Maksu- ja Tolliameti avaandmed tasutud maksude, käibe ja töötajate kohta varasematel aastatel | fail      | ei uuene         | lisaandmevoog |

## Stack

| Komponent         | Tööriist |
| :---------------- | :------- |
| Sissevõtt         | Python |
| Transformatsiooon | SQL |
| Andmehoidla       | Postgre SQL |
| Näidikulaud       | Streamlit |

## Käivitamine

```bash
# 1. Klooni repo ja liigu kausta
git clone https://github.com/kaisu278/MTR_toitlustus_aktiivsus_analyys
cd MTR_toitlustus_aktiivsus_analyys

# 2. Kopeeri keskkonnamuutujad
cp .env.example .env
Muuda .env failis paroolid ja muud seaded vastavalt vajadusele

# 3. Käivita projektitöö
## Windows
.\run_all.ps1
## masOS/Linux
chmod +x run_all.sh
./run_all.sh

```

## Andmevoog
1. Sissevõtt - Majandustegevuse registri andmed saadakse MTR avaandmetest, mis uuenevad iga päev - https://andmed.eesti.ee/datasets/majandustegevuse-register. Maksu- ja Tolliameti andmed on kättesaadavad MTA kodulehelt - https://www.emta.ee/eraklient/amet-uudised-ja-kontakt/uudised-pressiinfo-statistika/statistika-ja-avaandmed#tasutud-maksud. Andmed loetakse sisse pythoni koodide abil. 
2. Laadimine - MTR ja MTA andmed laetakse staging kihti. MTR avaandmed on XML kujul, need teisendati CSV formaati ja lisati juurde kehtivuse alguse aasta. MTA andmetabelitest filtreeriti välja ainult nende ettevõtete andmed, kellel on toitlustuse majandustegevusteatis esitatud. 
3. Transformatsioon - vaatluse alla on võetud aastad 2024 - 2026 ning nende aastate kohta tehti eraldi tabelid, kus on konkreetse aasta majandustegevusteatise esitanud ettevõtete MTA andmed. 
4. Kvaliteedikontroll - kontrollitud, et registrikood ei oleks puudu ning töötajate arv või makstud maksude summa ei oleks negatiivne.
5. Näidikulaud - välja on toodud jooksva aasta majandustegevusteatiste arv. Lisaks majandustegevusteatise esmakordselt esitanud ettevõtete arv, enne teatise kehtivuse algust töötajaid deklareerinud ja makse tasunud ettevõtete arv, jooksval aastal ja järgmisel aastal töötajaid deklareerinud ja makse tasunud ettevõtete arv. 

## Andmekvaliteedi testid
Projekt kontrollib järgmist: 
1. Registrikood ei tohi olla puudu
2. Riiklikud tasutud maksud ei tohi olla negatiivne
3. Töötajate arv ei tohi olla negatiivne

## Projekti struktuur
```
.
├── compose.yml                                     ← kõik teenused
├── .env.example                                    ← kopeeri .env-iks
├── .gitignore
├── run_all.ps1                                     ← paneb kogu projekti käima
├── Dockerfile.superset
├── DS_store
├── scripts/
│   ├── 01_MTR_alusandmed.py                        ← MTR avaandmete sissevõtt
│   ├── 02_MTR_to_CSV.py                            ← MTR avaandmest toitlustuse majandustegevusteatiste väljafiltreerimine
│   ├── 03_MTA_jooksvad_alusandmed.py               ← MTA käesoleva ja eelmise aasta avaandmete sissevõtt
│   ├── 04_MTA_varasemad_alusandmed.py              ← MTA eelmiste aastate avaandmete sissevõtt
│   ├── 05_MTR_andmed_jagamiseks.py                 ← MTR andmetest vajalike veergude väljavõtmine
│   ├── 06_uute_tabelite_laadimine.sql              ← Tabelite loomine, andmete tabelitesse laadimine
│   ├── 07_MTR_MTA_andmed_juurde                    ← MTA andmetest ainult toitlustuse majandustetgevusteatistega ettevõtete andmete väljasorteerimine
│   ├── 08_andmete_jagamine_maksu_algus.sql         ← Andmete sorteerimine aastate lõikes
│   ├── 09_kvaliteedikontroll.sql                   ← Kvaliteedi testimine
│   ├── 10_kokkuvqte.sql                            ← Näidikutabeli jaoks alusandmete tabeli loomine
│   ├── app.py  
│   ├── requirements.txt
├── data/
│   └── avaandmed_ettevotjad.xml                    ← MTR avaandmed
│   └── mtr_toitlustus_jagamine.csv   
│   └── mtr_toitlustus_majandustegevusteated.csv    ← ainult toitlustuse majandustegevusteated
│   └── tasutud_maksud_kaesolev_aasta_puhas.csv     ← ainult toitlustuse majandustegevusteadete esitanud isikute MTA andmed
│   └── tasutud_maksud_kaesolev_aasta.csv           ← MTA avaandmed käesoleva ja eelmise aasta kohta 
│   └── tasutud_maksud_varasemad_aastad_puhas.csv   ← ainult toitlustuse majandustegevusteadete esitanud isikute MTA andmed
│   └── tasutud_maksud_varasemad_aastad.csv         ← MTA avaandmed varasemate aastate kohta  
└── docs/
    ├── arhitektuur.md                              ← nädal 1 väljund
    └── progress.md                                 ← nädal 2 väljund
```

## Kokkuvõte, puudused ja võimalikud edasiarendused
### Kokkuvõte
Loodud on töötav andmetoru avaandmete sisselugemisest näidikulauani. 

### Puudused
Projekt on väga primitiivne, sest kokku sattusid algajad. Võrreldud on aastate kaupa, mitte kuudega nagu algselt plaanis oli. 

### Mis edasi
Võrdlus kvartalite kaupa, s.h aasta vahetuse arvestamine. 
Eraldi võrdlus tasutud maksude, käibe ja töötajate kohta. 
Prognoos eelnevate aastate andmete pinnalt, kui palju makse, töötajaid ja käivet võiks toitlustuse majandustegevusteate esitanud isikud edaspidi deklareerida. 

## Meeskond

| Nimi            | Roll |
| --------------- | ---- |
| Aare Järvan     | Kirjutab andmete ühendamise ja mõõdikute arvutuse loogika |
| Anne-Mai Ilumäe | Kirjutab testid ja vaatab läbi ebaõnnestunud testid |
| Juta Luts       | Ehitab vaate |
| Kaisa Eesmaa    | Kirjutab sissevõtu loogika |
