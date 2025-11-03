# University Scheduling System

## Core features and responsibilities

Core features (5):

1. Zobrazení rozvrhu (Student)
2. Košík (Student)
3. Vypsání předmětů (Teacher)
4. Zobrazení rozvrhu (Teacher)
5. Vypsání časových a prostorových požadavků (Teacher)

---

### Feature: Zobrazení rozvrhu (Student) — **CORE**

**User story**  
Jakožto student potřebuju přehledně zobrazit týdenní rozvrh, abych si mohl naplánovat dny.

**Feature breakdown**

 1. Student otevře zobrazení rozvrhu.
 2. Systém zjistí, zda je student přihlášený.
 3. Systém načte správná data z databáze.
 4. Systém zobrazí data graficky.

**Responsibilities**

- **Autentizace a autorizace**
  - Umožnit přihlášení studenta.
  - Ověřit přihlášení.
- **Získání a výběr dat**
  - Identifikovat správná data pro daného studenta.
  - Najít data v databázi (předměty, skupiny, místnosti, vyučující).
  - Načíst metadata o předmětech (např. kapacita, trvání, časové sloty).
  - Sloučit data z více zdrojů (např. rozvrh, změny).
- **Prezentace**
  - Graficky interpretovat týdenní přehled (časová mřížka, barvy, konflikty/kapacity).
  - Zobrazit interaktivní prvky (tooltipy, detaily předmětu).
  - Přizpůsobit zobrazení různým zařízením (mobil, desktop).
- **Správa chyb a výjimek**
  - Zachytit chyby při načítání nebo zpracování dat.
  - Zobrazit srozumitelnou chybovou hlášku uživateli.
  - Logovat technické chyby pro správce systému.
- **Uživatelská interakce a export**
  - Umožnit přepínání mezi týdny nebo semestry.
  - Umožnit export rozvrhu (PDF, iCal, CSV).
  - Nabídnout tiskovou verzi rozvrhu.

---

### Feature: Košík (Student) — **CORE**

**User story**  
Jakožto student, potřebuju být schopný vytvořit provizorní graficky přehledný rozvrh předmětů, abych si mohl naplánovat rozvrh bez toho, aniž bych si musel předměty zapsat.

**Feature breakdown**

1. Student otevře „Košík“.
2. Systém zjistí, zda je student přihlášený.
3. Systém načte seznam všech dostupných předmětů a jejich rozvrhových slotů.
4. Student vybere požadované předměty a přidá je do košíku.
5. Systém zkontroluje, zda se vybrané sloty nepřekrývají.
6. Pokud dojde ke kolizi, systém upozorní a nabídne alternativy.
7. Systém zobrazuje aktuální rozvrh graficky.

**Responsibilities**

- **Identita a kontext studia**
  - Ověřit, že uživatel je přihlášený student.
  - Zajistit, že data o studijním programu odpovídají aktivnímu profilu.
  - Aktualizovat data při změně semestru nebo fakulty.
- **Práce s nabídkou a metadaty**
  - Načíst seznam dostupných předmětů a jejich časových slotů.
  - Uchovávat metadata o kapacitách a vyučujících.
- **Operace s košíkem**
  - Přidat/Odebrat předmět.
  - Uložit aktuální stav košíku a umožnit načtení po opětovném přihlášení.
- **Kontrola kolizí a návrhy**
  - Porovnat časy slotů mezi předměty.
  - Identifikovat kolize (učebna, čas, den) a poskytnout alternativní skupiny.
- **Vizualizace**
  - Graficky vykreslit předměty v týdenním přehledu.
  - Zobrazit upozornění nebo zvýraznit konfliktní hodiny.

---

### Feature: Vypsání předmětů (Teacher) — **CORE**

**User story**  
Jakožto učitel, potřebuju vypsat předmět a informace o něm (název, syllabus, popis...), aby manažeři rozhodli, zda je předmět dostatečně užitečný.

**Feature breakdown**

1. Učitel otevře formulář na vypsání předmětu.
2. Vyplní formulář a odešle.
3. Systém zkontroluje správnost dat.
4. Systém pošle manažerovi upozornění s žádostí o vytvoření předmětu.
5. … (pokračování schvalovacím tokem dle pravidel fakulty)

**Responsibilities**

- **Autorizace učitele**
  - Ověřit roli „učitel“.
- **Validace a správa obsahu**
  - Validovat název, popis, syllabus, kredity aj.
  - Umožnit uložení konceptu a následné úpravy.
  - Ověřit povinné položky (název, kód, rozsah, jazyk).
- **Workflow a notifikace**
  - Vytvořit žádost o schválení pro manažera.
  - Zaslat notifikace zainteresovaným rolím.
  - Uchovat historii verzí a schvalovacích kroků.
  - Umožnit zrušení či stažení žádosti před schválením.
- **Uživatelská interakce a použitelnost**
  - Poskytnout přehledné rozhraní formuláře.
  - Zobrazit validace v reálném čase (např. chybové hlášky u polí).
  - Potvrdit úspěšné odeslání žádosti.

---

### Feature: Zobrazení rozvrhu (Teacher) — **CORE**

**User story**  
Jakožto učitel potřebuju přehledně zobrazit týdenní rozvrh, abych si mohl naplánovat dny.

**Feature breakdown**

 1. Učitel otevře zobrazení rozvrhu.
 2. Systém zjistí, zda je učitel přihlášený.
 3. Systém načte správná data z databáze (jeho předměty, konzultace, zkoušky).
 4. Systém zobrazí data graficky.

**Responsibilities**

- **Autentizace a rozsah dat**
  - Ověřit přihlášení učitele a jeho přiřazené předměty.
  - Omezit zobrazení pouze na kurzy, kde má roli vyučující nebo garant.
- **Získání a výběr dat**
  - Načíst výuku, konzultace, zkoušky, služební akce.
  - Aktualizovat záznamy při změně rozvrhu nebo zkouškového období.
- **Prezentace**
  - Graficky interpretovat týdenní přehled (časová mřížka, barvy, konflikty/kapacity).
  - Zobrazit detailní informace po kliknutí (předmět, skupina, místnost, počet studentů).
  - Přizpůsobit zobrazení pro různé zařízení (mobil, desktop).
- **Správa chyb a výjimek**
  - Zachytit chyby při načítání nebo zpracování dat.
  - Zobrazit srozumitelnou chybovou hlášku uživateli.
- **Uživatelská interakce a export**
  - Umožnit přepínání mezi týdny nebo semestry.
  - Umožnit export rozvrhu (PDF, iCal, CSV).
  - Nabídnout tiskovou verzi rozvrhu.

---

### Feature: Vypsání časových a prostorových požadavků (Teacher) — **CORE**

**User story**  
Jakožto učitel, definovat časovou a prostorovou náročnost předmětu a časové rozmezí, kdy jsem schopný je vyučovat.

**Feature breakdown**

1. Učitel otevře formulář pro definici požadavků.
2. Systém ověří přihlášení učitele.
3. Učitel vybere svůj předmět ze seznamu.
4. Učitel zadá preferované časy, dny, délku a frekvenci výuky.
5. Učitel zadá požadovaný typ a kapacitu učebny.
6. Učitel může přidat speciální požadavky (např. projektor).
7. Systém ověří dostupnost slotů a realistické možnosti.
8. Systém upozorní na případné kolize s jinými předměty nebo učiteli.
9. Po potvrzení systém uloží požadavky a odešle je komisi.

**Responsibilities**

- **Oprávnění a přístup**
  - Ověřit, že uživatel má roli učitele.
  - Zajistit přístup k jeho přiřazeným předmětům.
  - Ověřit právo upravovat daný předmět.
- **Vstupy a validace**
  - Poskytnout rozhraní pro časy/dny/délku/typ místnosti/kapacitu/speciální požadavky.
  - Validovat rozsah hodin, formát času, kapacitu; povolit uložení jako koncept.
- **Dostupnost a kolize**
  - Ověřit nekolidující časy vůči rozvrhu učitele a ostatním předmětům.
  - Ověřit dostupnost učeben v daném čase.
  - Detekovat nereálné požadavky (např. více hodin než dostupných slotů).
  - Nabídnout alternativní časy nebo učebny.
- **Uložení a audit**
  - Umožnit uložení neúplného návrhu jako konceptu.
  - Uložit požadavky do databáze.
  - Uchovat historii změn a návrhů.
  - Odeslat komisi pro další zpracování.

---

### Feature: Schválení předmětu (Manager)

**User story**  
Jakožto manažer potřebuji schválit předmět navržený učitelem, aby mohl učitel vypsat časové možnosti a Scheduling committee předmět rozvrhnout.

**Feature breakdown**

1. Manager otevře detail žádosti o vypsání předmětu
2. Systém ověří přihlášení managera.
3. Manager schválí nebo zamítne předmět.
4. Učitel je upozorněn na schválení nebo zamítnutí předmětu.

**Responsibilities**

- **Autorizace a role**
  - Ověřit roli „manager“ a přístup k dané žádosti.
- **Zpracování schválení**
  - Ověřit schválení, zda zpracovává existující předmět, který ještě nebyl schválen
  - Propsat do databáze
- **Notifikace**
  - Informovat učitele a další role o výsledku rozhodnutí.
- **Historie a dohledatelnost**
  - Uložit rozhodnutí, změny stavů a uživatele, který akci provedl.


---

### Feature: Zobrazení grafického rozhraní pro rozvrhování předmětů a uložení změn (Scheduling committee)

**User story**  
Jakožto Scheduling committee potřebuji zobrazit grafické rozhraní na rozvrhování předmětů, abych postavil předmět, a useři si mohli zobrazit rozvrhy.

**Feature breakdown**

1. Scheduling otevře rozhraní pro rozvrhování předmětů.
2. Systém ověří přihlášení Scheduling committee.
3. Scheduling committee má zobrazené předměty a jejich časové a prostorové nároky a časové možnosti učeben.
4. Pomocí grafického rozhraní Scheduling committee rozvrhne předmět.
5. Uloží rozvržení předmětu.

**Responsibilities**

- **Oprávnění a přístup**
  - Ověřit členství v Scheduling committee a příslušná práva.
- **Načtení dat**
  - Načíst požadavky předmětů, dostupnost učeben, kapacity a stávající kolize.
- **Interaktivní plánování**
  - Poskytnout drag & drop rozhraní, zoom, mřížku a přichytávání ke slotům.
  - Inline validace kolizí a kapacit v reálném čase.
- **Uložení, verze a audit**
  - Uložit návrh i publikovanou verzi; verzování a možnost revertu.
  - Auditovat změny (kdo/kdy/co) s komentáři.

---

### Feature: Přihlášení pomocí grafického rozhraní (User)

**User story**  
Jakožto uživatel se potřebuji přihlásit ke svému účtu, aby mi systém zobrazil správná data, která potřebuju. (A nezobrazil data, která nejsou pro mě)

**Feature breakdown**

1. Uživatel otevře formulář pro přihlášení.
2. Zadá přihlašovací údaje.
3. Systém ověří přihlašovací údaje, pokud jsou platné, potvrdí a redirektuje na správnou stránku.

**Responsibilities**

- **Autentizace**
  - Zpracovat přihlášení (formulář/SSO), bezpečně ověřit uživatele.
- **Validace a chybové stavy**
  - Validovat formát vstupů; zobrazit srozumitelné chyby bez prozrazení detailů.
- **UX a navigace**
  - Podporovat „zapamatovat si mě“, přesměrování dle role/kontextu.
- **Logování a audit**
  - Logovat přihlášení/odhlášení, neúspěšné pokusy, zamykání účtu.
- **Spojení dat s uživatelem a přesměrování na stránku**
  - Podle role uživatele přesměrovat na správnou stránku.

---

### Feature: Zobrazení rozvrhů předmětů (Student)

**User story**  
Jakožto student potřebuju být schopný najít rozvrh konkrétních předmětů, abych si mohl naplánovat rozvrh.

**Feature breakdown**

1. Vyhledání předmětu podle názvu/kódu/fakulty.
2. Zobrazení dostupných skupin a jejich časů/místností/kapacit.
3. Možnost porovnat skupiny mezi sebou.
4. Přidání vybraných skupin do Košíku.

**Responsibilities**

- **Vyhledávání a filtrování**
  - Fulltext a filtry (fakulta, obor, semestr, vyučující).
- **Zobrazení detailu předmětu**
  - Sloty, místnosti, kapacity, případné poznámky/kolize.
- **Integrace s Košíkem**
  - Rychlé přidání skupiny; předběžná kontrola kolizí.

---

### Feature: Export rozvrhu (Student)

**User story**  
Jako student potřebuji exportovat svůj rozvrh do PDF, abych si ho mohl vytisknout a připnout na nástěnku na koleji.

**Feature breakdown**

1. Generovat tisknutelný týdenní přehled (PDF).
2. Volby vzhledu (barvy předmětů, skrytí detailů, velikost písma).
3. Možnost exportu rozvrhu z Košíku nebo finálního zápisu.

**Responsibilities**

- **Formát a šablony**
  - Tiskové styly, škálování na A4, podpora češtiny/slovenštiny.
- **Datová konzistence**
  - Export z aktuálního stavu (Košík vs. oficiální rozvrh).
- **Dostupnost**
  - Stažení souboru, uložení do profilu, sdílení odkazu.

---

### Feature: Zobrazení rozvrhu učebny (Student)

**User story**  
Jako student potřebuji zobrazit rozvrh jednotlivých učeben na fakultě, abych si mohl naplánovat, do které místnosti mohu jít studovat.

**Feature breakdown**

1. Vyhledání učebny podle budovy/čísla/kapacity/výbavy.
2. Zobrazení týdenního obsazení a volných slotů.
3. Indikace, kdy je místnost volná pro samostudium.

**Responsibilities**

- **Katalog učeben**
  - Evidovat typ, kapacitu, vybavení (projektor, zásuvky, ticho).
- **Obsazenost**
  - Zobrazit plánované výuky/zkoušky; odhad volných slotů.
- **Srozumitelnost**
  - Barevné značky pro „obsazeno/volno“, rychlé filtry.

---

### Feature: Zobrazení rozvrhu učeben (Teacher)

**User story**  
Jako učitel potřebuji zobrazit rozvrh učeben, abych mohl přizpůsobit plánování výuky, konzultací nebo zkoušek.

**Feature breakdown**

1. Vyhledání a filtrování místností dle kapacity/výbavy/budovy.
2. Přehled kolizí s plánovanou výukou.
3. Návrh alternativních místností.

**Responsibilities**

- **Dostupnost a přidělení**
  - Aktuální obsazenost učeben; návrhy náhrad.
- **Integrace s požadavky**
  - Propojení s „Vypsání časových a prostorových požadavků“.
- **Přístupová práva**
  - Zohlednit roli učitele a jeho předměty.

---

### Feature: Upozornění na kolize (Scheduling committee)

**User story**  
Jakožto komise, potřebuju dostat upozornění, pokud bude jeden učitel vyučovat v jednom slotu vícekrát, abych zabránil nemožnost vyučovat.

**Feature breakdown**

1. Pravidelný i ad-hoc běh detekce kolizí (učitel, učebna, čas).
2. Agregace nalezených kolizí do přehledů a priorit.
3. Notifikace komise s odkazy na konfliktní záznamy.
4. Návrh automatických alternativ (jiný čas/učebna/skupina).

**Responsibilities**

- **Detekční pravidla**
  - „Stejný učitel ve stejném čase na více místech“, „dvě akce v jedné učebně“.
- **Prioritizace a workflow**
  - Označit kritičnost; přiřadit řešitele; sledovat stav.
- **Notifikace a audit**
  - Upozornit komisi; logovat změny a rozhodnutí.

---

### Feature: Report o obsazenosti předmětů (Managers)

**User story**  
Jako manažer potřebuji vidět, kolik studentů se přihlásilo do jednotlivých předmětů, abych mohl rozhodnout o otevření či sloučení skupin.

**Feature breakdown**

1. Přehled registrací vs. kapacity po předmětech/skupinách.
2. Trendy v čase (nápor registrací, čekací listiny).
3. Doporučení na otevření/sloučení/zavření skupin.

**Responsibilities**

- **Datová analytika**
  - Sbírat a konsolidovat registrace, kapacity, limity.
- **Vizualizace a export**
  - Tabulky a grafy; export CSV/PDF.
- **Rozhodovací podpora**
  - Pravidla a prahy pro doporučení;
