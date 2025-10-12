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
- Student otevře zobrazení rozvrhu.  
- Systém zjistí, zda je student přihlášený.  
- Systém načte správná data z databáze.  
- Systém zobrazí data graficky.

**Responsibilities**
- **Autentizace a autorizace**
  - Umožnit přihlášení studenta.  
  - Ověřit přihlášení.
- **Získání a výběr dat**
  - Identifikovat správná data pro daného studenta.  
  - Najít data v databázi (předměty, skupiny, místnosti, vyučující).
- **Prezentace**
  - Graficky interpretovat týdenní přehled (časová mřížka, barvy, konflikty/kapacity).

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
- **Workflow a notifikace**
  - Vytvořit žádost o schválení pro manažera.  
  - Zaslat notifikace zainteresovaným rolím.  
  - Uchovat historii verzí a schvalovacích kroků.

---

### Feature: Zobrazení rozvrhu (Teacher) — **CORE**

**User story**  
Jakožto učitel potřebuju přehledně zobrazit týdenní rozvrh, abych si mohl naplánovat dny.

**Feature breakdown**
- Učitel otevře zobrazení rozvrhu.  
- Systém zjistí, zda je učitel přihlášený.  
- Systém načte správná data z databáze (jeho předměty, konzultace, zkoušky).  
- Systém zobrazí data graficky.

**Responsibilities**
- **Autentizace a rozsah dat**
  - Ověřit přihlášení učitele a jeho přiřazené předměty.  
- **Datová projekce**
  - Konsolidovat výuku, konzultační hodiny, zkoušky.  
- **Prezentace**
  - Zobrazit týdenní rozvrh s přehledným označením místností a kolizí.

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
  - Zajistit přístup k jeho přiřazeným předmětům; ověřit právo upravovat.
- **Vstupy a validace**
  - Poskytnout rozhraní pro časy/dny/délku/typ místnosti/kapacitu/speciální požadavky.  
  - Validovat rozsah hodin, formát času, kapacitu; povolit uložení jako koncept.
- **Dostupnost a kolize**
  - Ověřit nekolidující časy vůči rozvrhu učitele a ostatním předmětům.  
  - Ověřit dostupnost učeben v daném čase; detekovat nereálné požadavky.  
  - Nabídnout alternativní časy nebo učebny.
- **Uložení a audit**
  - Uložit požadavky do databáze; uchovat historii změn a návrhů.  
  - Odeslat komisi pro další zpracování.

---

### Feature: Zobrazení rozvrhů předmětů (Student)

**User story**  
Jakožto student potřebuju být schopný najít rozvrh konkrétních předmětů, abych si mohl naplánovat rozvrh.

**Feature breakdown**
- Vyhledání předmětu podle názvu/kódu/fakulty.  
- Zobrazení dostupných skupin a jejich časů/místností/kapacit.  
- Možnost porovnat skupiny mezi sebou.  
- Přidání vybraných skupin do Košíku.

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
- Generovat tisknutelný týdenní přehled (PDF).  
- Volby vzhledu (barvy předmětů, skrytí detailů, velikost písma).  
- Možnost exportu rozvrhu z Košíku nebo finálního zápisu.

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
- Vyhledání učebny podle budovy/čísla/kapacity/výbavy.  
- Zobrazení týdenního obsazení a volných slotů.  
- Indikace, kdy je místnost volná pro samostudium.

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
- Vyhledání a filtrování místností dle kapacity/výbavy/budovy.  
- Přehled kolizí s plánovanou výukou.  
- Návrh alternativních místností.

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
- Pravidelný i ad-hoc běh detekce kolizí (učitel, učebna, čas).  
- Agregace nalezených kolizí do přehledů a priorit.  
- Notifikace komise s odkazy na konfliktní záznamy.  
- Návrh automatických alternativ (jiný čas/učebna/skupina).

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
- Přehled registrací vs. kapacity po předmětech/skupinách.  
- Trendy v čase (nápor registrací, čekací listiny).  
- Doporučení na otevření/sloučení/zavření skupin.

**Responsibilities**
- **Datová analytika**
  - Sbírat a konsolidovat registrace, kapacity, limity.  
- **Vizualizace a export**
  - Tabulky a grafy; export CSV/PDF.  
- **Rozhodovací podpora**
  - Pravidla a prahy pro doporučení; 

