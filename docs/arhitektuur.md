# MTR_toitlustus_aktiivsus_analyys

## Äriküsimus

Kui suur osa majandustegevuseteate esitanud toitlustusettevõtetest hakkab reaalselt majandustegevust näitama (käive ja töötajad) ning kui kiiresti see toimub?

### Mõõdikud:

1. Osakaal majandustegevusteate esitanud isikutest, kes deklareerivad töötajaid MTA andmetel (grupid: varasemalt töötajad, kuni 3 kuud, 4-6 kuud, 6-12 kuud, üle 12 kuu)
2. Osakaal majandustegevusteate esitanud isikutest, kes deklareerivad käivet MTA andmetel (grupid: varasemalt töötajad, kuni 3 kuud, 4-6 kuud, 6-12 kuud, üle 12 kuu)

## Andmeallikad

| Allikas                                                                                       | tüüp      | Uuenemise aeg    | Roll          |
| :-------------------------------------------------------------------------------------------- | :-------- | :--------------- | :------------ |
| Majandustegevuse register                                                                     | andmebaas | reaalajas uuenev | põhiandmevoog |
| Maksu- ja Tolliameti avaandmed tasutud maksude, käibe ja töötajate kohta käesoleval aastal    | fail      | korra kvartalis  | põhiandmevoog |
| Maksu- ja Tolliameti avaandmed tasutud maksude, käibe ja töötajate kohta varasematel aastatel | fail      | ei uuene         | lisaandmevoog |

## Andmevoog

```mermaid
graph LR
    subgraph sources["Andmeallikad"]
        MTRsource["MTR majandustegevuse teated<br/>toitlustuse kohta"]
        MTAsource1["MTA tasutud maksud<br/>käesoleva aasta kohta"]
        MTAsource2["MTA tasutud maksud<br/>varasemate aastate kohta"]
    end

    subgraph loading["Andmete laadimine"]
        MTRload["MTR_alusandmed"]
        MTAload1["MTA_alusandmed_ka"]
        MTAload2["MTA_alusandmed_va"]
    end

    subgraph processing["Andmete töötlemine ja ühendamine"]
        cleaning["Andmete puhastamine"]
        joining["Andmete ühendamine (JOIN)"]
        calc["Täiendavad arvutused"]
    end

    MTRsource --> MTRload
    MTAsource1 --> MTAload1
    MTAsource2 --> MTAload2

    MTRload --> cleaning
    MTAload1 --> cleaning
    MTAload2 --> cleaning

    cleaning --> joining
    joining --> calc
    calc --> mart["Andmebaasitabel / Data Mart"]

    mart --> viz["Visualiseerimine"]
    mart --> quality["Kvaliteedikontroll"]

    classDef sourceStyle stroke:#818cf8,fill:#eef2ff
    classDef loadStyle stroke:#2dd4bf,fill:#f0fdfa
    classDef processStyle stroke:#facc15,fill:#fefce8
    classDef vizStyle stroke:#a78bfa,fill:#f5f3ff
    classDef qualityStyle stroke:#4ade80,fill:#f0fdf4
    classDef groupStyle stroke:#818cf8,fill:#eef2ff

    class MTRsource,MTAsource1,MTAsource2 sourceStyle
    class MTRload,MTAload1,MTAload2 loadStyle
    class cleaning,joining,calc processStyle
    class viz vizStyle
    class quality qualityStyle
    class sources,loading,processing groupStyle
```

## Andmebaasi kihid

| Kiht | Roll |
| :--- | :--- |
|      |

...

## Tööjaotus

| Roll                       | Vastutus                                                  | Nimi         |
| :------------------------- | :-------------------------------------------------------- | :----------- |
| Andmeallika omanik         | Kirjutab sissevõtu loogika                                | Kaisa Eesmaa |
| Transformatsioonide omanik | Kirjutab andmete ühendamise ja mõõdikute arvutuse loogika |
| Kvaliteedi omanik          | Kirjutab testid ja vaatab läbi ebaõnnestunud testid       |
| Näidikulaua omanik         | Ehitab vaate                                              |

## Riskid

| Risk                                 | Mõju                                                       | Maandus                                                    |
| ------------------------------------ | ---------------------------------------------------------- | ---------------------------------------------------------- |
| Võrgupäring ei vasta                 | Andmeid ei saa värskendada                                 | Skript annab veateate, vajadusel käivitata uuesti.         |
| MTA uuendab andmeid korra kvartalis  | Värskete majandustegevusteadete kohta ei saa analüüsi teha | Leppida või leida teine infoalllikas                       |
| MTR muudab CSV faili andmestruktuuri | Andmeid ei saa värskendada                                 | Skript annab veateate, parandada skripti, käivitada uuesti |

## Privaatsus ja turve

Projekt kasutab ainult avalikke andmeid (MTR valik register ja MTA avaandmed). Isikuandmeid ei koguta. Andmebaasi kasutajanimi ja parool tulevad .env failist. .env faili ei tohi reposse lisada.
