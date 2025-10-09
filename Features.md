# Features

## Student
### 1. (CORE) Zobrazení rozvrhu
Jakožto student potřebuju potřebuju přehledně zobrazit týdenní rozvrh, abych si mohl naplánovat dny.

### 2. Zobrazení rozvrhů předmětů
Jakožto student potřebuju být schopný najít rozvrh konktrétních předmětů, abych si mohl naplánovat rozvrh.

### 3. (CORE) Košík
Jakožto student, potřebuju bých schopný vytvořit provizorní graficky přehledný rozvrh předmětů, abych si mohl naplánovat rozvrh bez toho, aniž bych si musel předměty zapsat.

### 4. Export rozvrhu
Jako student potřebuji exportovat svůj rozvrh do PDF, abych si ho mohl vytisknout a připnout na nástěnku na koleji.

### 5. Zobrazení rozvrhu učebny
Jako student potřebuji zobrazit rozvrh jednotlivých učeben na fakultě, abych si mohl naplánovat, do které místnosti mohu jít studovat.

### 6. Zobrazení rozvrhu učitelů
Jako student potřebuji zobrazit rozvrh konkrétního učitele, abych věděl, kdy ho mohu zastihnout na chodbě pro případnou rychlou konzultaci.

### 7. Změna nastavení zobrazení rozvrhu
Jako student potřebuji v případě kombinovaného studia více oborů změnit nastavení rozvrhu tak, aby se mi zobrazovaly pouze předměty z určité fakulty.

## Teacher
### 1.(CORE) Vypsání předmětů
Jakožto učitel, potřebuju vypsat předmět a informace o něm (název, syllabus, popis...), aby manažeři rozhodli, zda je předmět dostatečne užitečný.

### 2. (CORE) Zobrazení rozvrhu
Jakožto učitel potřebuju potřebuju přehledně zobrazit týdenní rozvrh, abych si mohl naplánovat dny.

### 3. (CORE) Vypsání časových a prostorových požadavků
Jakožto učitel, definovat časovou a prostorovou náročnost předmětu a časové rozmezí, kdy jsem schopný je vyučovat.

### 4. Zobrazení rozvrhu učeben
Jako učitel potřebuji zobrazit rozvrh učeben, abych mohl přizpůsobit plánování výuky, konzultací nebo zkoušek.

## scheduling committee
###  1. Upozornění na kolize
Jakožto komise, potřebuju dostat upozornění, pokud bude jeden učitel vyučovat v jednom slotu vícekrát, abych zabránil nemožnost vyučovat.


### 2. Upozornění na nedostatek učeben
Jakožto komise, potřebuju být upozorněn, pokud v daném časovém slotu chybí volné učebny, abych mohl rozvrh přeuspořádat.

### 3. Schvalování rozvrhu
Jakožto komise, potřebuju možnost schválit finální verzi rozvrhu po vyřešení všech kolizí, aby mohla být publikována studentům a učitelům.


## Managers
### 1. Statistiky vytíženosti
Potřebuji statistická data o vytíženosti učitelů, učeben, množství přesunů mezi budovami u studnetů, abych věděl kde dochází k problémům a na co se zaměřovat.
### 2. Vyhodnocení studijních plánů
Potřebuji informaci o tom jak studenti plní doporučený studijní plán, aby odpovídal nejsnažšímu průchodu studiem.

### 3. Report o obsazenosti předmětů
Jako manažer potřebuji vidět, kolik studentů se přihlásilo do jednotlivých předmětů, abych mohl rozhodnout o otevření či sloučení skupin.

### 4. Monitoring kapacit
Jako manažer potřebuji sledovat, zda nejsou některé učebny nebo učitelé dlouhodobě nevyužití, abych optimalizoval zdroje fakulty.

## Features Breakdown
### Zobrazení rozvrhu
1. Student otevře zobrazení rozvrhu.
2. Systém zjistí, zda je student přihlášený
3. Systém načte správná data z databáze
4. Systém zobrazí data graficky

### Zobrazení rozvrhu (učitel)
1. Učitel otevře zobrazení rozvrhu.
2. Systém zjistí, zda je učitel přihlášený
3. Systém načte správná data z databáze
4. Systém zobrazí data graficky

### Vypsání předmětů
1. Učitel otevře formulář na vypsání předmětu
2. Vyplní formulář a odešle
3. Systém zkontroluje správnost dat
4. Systém pošle manažerovi upozornění s žádostí o vytvoření předmětu
5. ...

### Košík
1.	Student otevře „Košík“.
2.  Systém zjistí, zda je student přihlášený
3.	Systém načte seznam všech dostupných předmětů a jejich rozvrhových slotů.
4.	Student vybere požadované předměty a přidá je do košíku.
5.	Systém zkontroluje, zda se vybrané sloty nepřekrývají.
6.  okud dojde ke kolizi, systém upozorní a nabídne alternativy.
7.	Systém zobrazuje aktuální rozvrh graficky.

### Vypsání časových a prostorových požadavků
1.	Učitel otevře formulář pro definici požadavků.
2.	Systém ověří přihlášení učitele.
3.	Učitel vybere svůj předmět ze seznamu.
4.	Učitel zadá preferované časy, dny, délku a frekvenci výuky.
5.	Učitel zadá požadovaný typ a kapacitu učebny.
6.	Učitel může přidat speciální požadavky (např. projektor).
7.	Systém ověří dostupnost slotů a realistické možnosti.
8.	Systém upozorní na případné kolize s jinými předměty nebo učiteli.
9.	Po potvrzení systém uloží požadavky a odešle je komisi.



## Responsibilities
### Zobrzení rozvrhu 
1. 1. 
2. 1. Systém musí umožnit přihlášení studenta
2. 2. Systém musí bých schopný ověřit přihlášení
3. 1. Systém musí být schopný identifikovat správná data
3. 2. Systém musí najít data v databázi
4. 1. Systém musí graficky interpretovat data


### Košík

1.	Ověřit, že uživatel je přihlášený student
2.	Zajistit, že data o studijním programu odpovídají aktivnímu profilu.
3.	Načíst seznam dostupných předmětů a jejich časových slotů.
4.	Aktualizovat data při změně semestru nebo fakulty.
5.  Uchovávat metadata o kapacitách a vyučujících.
6.	Přidat předmět do košíku.
7.  Odebrat předmět z košíku.
8.  Uložit aktuální stav košíku .
9.	Umožnit načtení uloženého košíku po opětovném přihlášení.
11.	Porovnat časy jednotlivých slotů mezi předměty.
12.	Identifikovat kolize na základě učeben, času a dne.
13.	Poskytnout návrhy alternativních skupin.
14.	Graficky vykreslit předměty v týdenním přehledu.
15.	Zobrazit upozornění nebo zvýraznit konfliktní hodiny.

### Vypsání časových a prostorových požadavků

1. Ověřit, že uživatel má roli učitele.
2. Zajistit přístup k jeho přiřazeným předmětům.
3. Načíst seznam předmětů vypsaných daným učitelem.
4. Ověřit, že učitel má oprávnění upravovat daný předmět.
5. Poskytnout rozhraní pro zadání časů, dnů, délky a typu místnosti.
6. Validovat vstupy (např. rozsah hodin, formát času, kapacitu).
7. Umožnit uložení neúplného návrhu jako konceptu.
8. Ověřit, že požadovaný čas nekoliduje s jinými předměty učitele.
9. Ověřit dostupnost učeben v daném čase.
10. Detekovat nereálné požadavky (např. více hodin než dostupných slotů).
11. Upozornit na konflikty s jinými učiteli nebo místnostmi.
12. Nabídnout alternativní časy nebo učebny.
13. Uložit zadané požadavky do databáze.
14. Uchovat historii změn a návrhů.

