# Edenemisraport

## Mis on valmis
- [x] Docker Compose käivitab kõik teenused
- [x] Andmed saadakse allikast kätte - MTR avaandmed andmeväravast ja MTA avaandmed MTA kodulehelt
- [x] Andmed laetakse `staging` kihti 
- [x] Vähemalt üks transformatsioon toimib - andmed puhastatud (üleliigne nt MTA andmetest välja jäetud), MTR andmetes majandustegevusteate kehtivuse algusest aasta välja arvutatud
- [ ] Vähemalt üks näidikulaud on nähtaval
- [ ] Vähemalt üks andmekvaliteedi test 

## Järgmised sammud
- MTR andmetes on üks ettevõte esitanud mitu toitlustamise majandustegevusteadet. Kas võtta ainult kõige vanem? 
- MTR andmetes on vaja välja arvutada majandustegevusteate kehtivuse alguse kvartal
- juurde on vaja tekitada lisatabel kvartali numbritega, nt 2022.a I kv on 1, 2022.a II kv on 2, jne. 
- MTR andmetele juurde panna kvartali number
- MTR andmetele on juurde vaja panna MTA andmed - alates majandustegevusteate kehtivuse alguse kvartalile eelnevast kvartalist
- andmete pinnalt leida grupid, millal pärast majandustegevusteate kehtivuse algust hakkas ettevõte näitama töötajaid ja millal käivet -> tulemitabel
- kvaliteeditest, kas tulemitabelis on ettevõtted ühekordselt
- näidikulauale lisada näidik, kui palju iga aasta/kvartal lisandub majandustegevusteate saanud ettevõtteid
- näidikulauale lisada näidik, kui kiiresti hakkab ettevõte näitama töötajaid ja käivet pärast majandustegevusteate saamist

## Mis takistab
- oskuste puudumine
- ajapuudus

## Kontrollpunkt