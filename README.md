# MTR_toitlustus_aktiivsus_analyys

Majandustegevusteate ja majandusaktiivsuse seos: toitlustusettevõtete analüüs MTR ja MTA andmete põhjal

## Äriküsimus

Kui suur osa majandustegevuseteate esitanud toitlustusettevõtetest hakkab reaalselt majandustegevust näitama (käive ja töötajad) ning kui kiiresti see toimub?

### Mõõdikud:

1. Osakaal majandustegevusteate esitanud isikutest, kes deklareerivad töötajaid MTA andmetel (grupid: varasemalt töötajad, kuni 3 kuud, 4-6 kuud, 6-12 kuud, üle 12 kuu)
2. Osakaal majandustegevusteate esitanud isikutest, kes deklareerivad käivet MTA andmetel (grupid: varasemalt töötajad, kuni 3 kuud, 4-6 kuud, 6-12 kuud, üle 12 kuu)

## Andmeallikad

| Allikas                                                                  | tüüp      | Uuenemise aeg    | Roll          |
| :----------------------------------------------------------------------- | :-------- | :--------------- | :------------ |
| Majandustegevuse register                                                | andmebaas | reaalajas uuenev | põhiandmevoog |
| Maksu- ja Tolliameti avaandmed tasutud maksude, käibe ja töötajate kohta | fail      | korra kvartalis  | põhiandmevoog |

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

# 3. Kui sul juba pole, siis installi Mermaid CLI
npm install -g @mermaid-js/mermaid-cli

# 4. Käivita teenused
docker compose up -d --build


```

## Meeskond

| Nimi            | Roll |
| --------------- | ---- |
| Aare Järvan     |
| Anne-Mai Ilumäe |
| Juta Luts       |
| Kaisa Eesmaa    |
