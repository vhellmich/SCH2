<details>
<summary><strong>🇨🇿 Original (Czech)</strong></summary>
# Features

### Student

#### Prezentace a vyhledávání předmětů

Jako student chci mít možnost vyhledávat a procházet předměty, abych měl přehled jaké předměty se vyučují.

#### Přihlašování na předměty

Jako student si potřebuji zapsat předmět na který chci docházet, abych ho mohl vystudovat a dostat za něj kredity.

#### Prezentace zapsaných předmětů

Jako student chci vidět všechny své zapsané předměty, abych věděl kde a kdy mám být na vyučování.

#### Odhlašování z předmětů

Jako student potřebuji mít možnost si předmět odepsat, protože se můžu rozhodnout že už na předmět nechci docházet.

---

### Vyučující

#### Manuální organizace studentů zapsaných na předmětu

Jako vyučující potřebuji mít možnost přihlásit studenta manuálně na svůj předmět, abych mohl lépe organizovat svůj předmět a případně pomoct studentům.

#### Zobrazení zapsaných studentů

Jako vyučující musím mít možnost zobrazit všechny zapsané studenty, abych měl přehled a mohl se studenty případně komunikovat.

#### Zobrazit vyučované předměty

Jako vyučující chci mít možnost zobrazit všechny mnou vyučované předměty, abych měl přehled o tom kde budu učit.

---

### Zaměstnanec studijního oddělení

#### Manuální zapisování studentů

Jako zaměstnanec studijního oddělení potřebuji mít možnost manuálně přihlásit studenta na předmět, abych tak studentům mohl pomoci.

#### Zobrazení historických dat

Jako zaměstnanec studijního oddělení potřebuji mít přístup k zobrazení historických dat, pro potřeby statistiky či organizace.

# Core features

### Přihlašování na předměty

#### User story

1. Student otevře nabídku vyhledávání předmětů.
2. Student vyhledá předmět, který si chce zapsat.
3. Student si vybere předmět a zapíše předmět.
4. Systém zkontroluje požadavky předmětu na studenta.
5. Studentovi jsou zobrazeny výsledky.
   1. Kontrola proběhla úspěšně, předmět byl zapsán.
   2. Kontrola proběhla neúspěšně, studentovi jsou zobrazeny důvody, předmět nebyl zapsán.
6. Student potvrdí a je vrácen na vyhledávání předmětů.

#### Break down

1. Získání vstupu od studenta.
2. Vyhledání předmětů v databázi.
3. Čtení vstupu od studenta, klikání na tlačítko zápisu.
4. Kontrola požadavku.
5. Zobrazení výsledku studentovi.
6. Čtení vstupu od studenta, potvrzení.
7. Zapsání do databáze.

#### Responsibilities

1. Získání vstupu od studenta.

   1. Integrace do celého systému, tak aby se student mohl dostat na vyhledávání předmětů
   2. Načtení dat od studenta podle kterých se má vyhledávat.

2. Vyhledání předmětů v databázi.

   1. Hledání odpovídajících předmětů v databázi.
   2. Zobrazení nalezených výsledků.

3. Čtení vstupu od studenta, klikání na tlačítko zápisu.

   1. Načtení události od uživatele.

4. Kontrola požadavku.

   1. Kontrola celo systémových informací, jestli student může vůbec právě teď zapisovat.
   2. Požadavek na databázi studentů.
   3. Kontrola informací o studentovi, jestli stále studuje.
   4. Kontrola pravidel předmětu vůči studentovi.

5. Zobrazení výsledku studentovi.

   1. Vygenerovat oznámení jak dopadla kontrola.

6. Čtení vstupu od studenta, potvrzení.

   1. Načtení eventu od studenta.
   2. Kontrola jestli student souhlasí.

7. Zapsání do databáze.
   1. Vložení nového zápisu do databáze.



#### Refined responsibilities

1. Presents available courses.
2. User inputs what course they want to enroll.
3. Validate the request.
4. Write the results into database.
5. Logs the request.
6. Presents the results.

---

### Manuální organizace studentů zapsaných na předmětu vyučujícím

Jako vyučující potřebuji mít možnost přihlásit studenta manuálně na svůj předmět, abych mohl lépe organizovat svůj předmět a případně pomoct studentům.

#### User story

1. Vyučující otevře menu s předměty, na jejichž organizaci se podílí
2. Vyučující klikne na daný předmět
3. Zobrazí se detail daného předmětu
4. Vyučující přejde na seznam studentů přihlášených k danému předmětu
5. Vyučující

   a. zvolí přihlášeného studenta

   b. vyhledá dosud nepřihlášeného studenta stiskem tlačítka +

6. Zobrazí se detail o daném studentovi a jeho vztahu k danému předmětu
7. Vyučující stiskem daného tlačítka zvolí akci, kterou chce a kterou je možné provést

   a. změna paralelky

   1. Zobrazí se menu s paralelkami
   2. Vyučující zvolí novou paralelku
   3. Vyučující potvrdí volbu nové paralelky
   4. Zobrazí se zpráva o úspěšné/neúspěšné změně paralelky

   b. odepsání z předmětu

   1. Vyučující je vyzván k potvrzení odepsání daného studenta z předmětu, jsou zrekapitulovány informace o předmětu i o studentovi
   2. Vyučující potvrdí volbu nebo přejde zpět
   3. Zobrazí se zpráva o úspěšném/neúspěšném odhlášení studenta z předmětu

   c. zapsání na předmět

   1. Vyučující je vyzván k potvrzení zapsání daného studenta na předmět, jsou zrekapitulovány informace o předmětu i o studentovi
   2. Vyučující potvrdí volbu nebo přejde zpět
   3. Zobrazí se zpráva o úspěšném/neúspěšném zapsání studenta z předmětu

8. Student je notifikován o kterékoliv akci, která se ho týká, případně je vyzván k potvrzení akce

#### Breakdown

1. Aplikace zná informace o vyučujícím a dokáže získat seznam předmětů, které vyučuje
2. Aplikace zobrazí interaktivní menu s předměty a posléze s detaily předmětů
3. V detailu předmětu aplikace poskytne seznam přihlášených studentů a jeho editaci včetně vyhledání nepřihlášeného studenta
4. Aplikace umožní zvolení studenta, zobrazí detail o studentovi a proveditelné akce
5. V případě změny paralelky aplikace umožní volbu jiné paralelky
6. Po zvolení akce aplikace zobrazí rekapitulaci a žádá potvrzení dané akce
7. Po potvrzení akce aplikace informuje uživatele o stavu a notifikuje uživatele, kterého se daná akce týká, tedy studenta

#### Responsibilities

1. Aplikace zná informace o vyučujícím a dokáže získat seznam předmětů, které vyučuje
   1. Aplikace udržuje informace o přihlášeném užuvateli
   2. Na základě ID/dat o vyučujícím aplikace komunikuje s databází a získá seznam předmětů, k jejichž editaci má vyučující oprávnění
   3. Tyto předměty aplikace zobrazí v přehledné formě
2. Aplikace zobrazí interaktivní menu s předměty a posléze s detaily předmětů
   1. Aplikace komunikuje s databází a získá detail předmětu, který zobrazí
3. V detailu předmětu aplikace poskytne seznam přihlášených studentů a jeho editaci včetně vyhledání nepřihlášeného studenta
   1. Aplikace umožňuje vyhledávání studentů v databázi všech studentů
4. Aplikace umožní zvolení studenta, zobrazí detail o studentovi a proveditelné akce
   1. Aplikace komunikuje s databází a pokytne detail o studentovi
   2. Aplikace zná status studenta a podle něj upravuje, které akce je a které není možné provést
5. V případě změny paralelky aplikace umožní volbu jiné paralelky
   1. Aplikace udržuje data o upravovaném předmětu v paměti, zobrazí paralelky
6. Po zvolení akce aplikace zobrazí rekapitulaci a žádá potvrzení dané akce
   1. Aplikace udržuej data o upravovaném předmětu a studentovi
7. Po potvrzení akce aplikace informuje uživatele o stavu a notifikuje uživatele, kterého se daná akce týká, tedy studenta
   1. Aplikace validuje žádost o změnu údajů
   2. Aplikace komunikuje s databází, zapisuje nová data
   3. Aplikace čeká na odpověď databáze, poskytne zpětnou vazbu uživateli
   4. Aplikace notifikuje studenta, jemuž byl upraven rozvrh, e-mailem


#### Refined responsibilities

1. Presents the current state of the courses.
2. User inputs that they want to make an action over multiple students.
3. Send request for each student.
4. Present the results.



---

### Odhlašování z předmětů (student)

#### User story

1. Student otevře "enrollment" část informačního systému.
2. Student si zobrazí všechny rozvrhové lístky, na kterých je přihlášený
3. Student si rozklikne konkrétní předmět, ze kterého se chce odhlásit.
4. Pokud stále běží perioda, kdy se studenti mohou sami odhlašovat, tak zde uvidí možnost odhlásit se.
5. Student ručně klikne na možnost odhlásit se.
6. Systém zpracuje odhlášení a student již není přihlášen na tento rozvrhový lístek a další rozvrhové lístky s ním spojené (př. cviko, přednáška...)

#### Breakdown

1. Aplikace načte z databáze všechny předměty a konkrétní rozvrhové lístky, na kterých je student přihlášený
2. Po rozkliknutí konkrétního předmětu aplikace načte podrobné informace o rozvrhovém lístku z databáze a taktéž načte informace o ostatních rozvrhových lsítcích spojených s tímto předmětem, kde je student zapsán.
3. Aplikace zkontroluje, zda je možné, aby se student sám odhlásil (např. zkontroluje čas, popř. jiné podmínky)
4. Po kliknutí od uživatele aplikace pošle požadavek na databázi, aby byla upravena tak, že je student odepsaný ze všech rozvrhových lístků (popř. z celého předmětu) + na daných lístcích se uvolní místo pro nějakého dalšího studenta

#### Responsibilities

1. Aplikace poskytuje frontend prostředí pro zobrazení všech předmětů
2. Aplikace naváže spojení s databází pro zobrazení předmětů a rozvrhových lístků studenta
3. Aplikace z databáze získá podrobné informace o rozvrhovém lístku a dokáže ho spojit i s ostatními rozvhrovými lístky ze stejného předmětu
4. Aplikace kontroluje podmínky odhlašování
5. Aplikace uloží informace o odhlášení studenta do databáze + inforamce o uvolněném místu


#### Refined responsibilities

1. Present all currently enrolled courses.
2. User inputs that they want to leave a course.
3. Validate the request.
4. Writes results into the database.
5. Logs the request taking action.
6. Presents message confirming the course has been left.


---

### Zobrazení historických dat

#### User story

1. Zaměstnanec studijního oddělení se dostane do sekce "Enrollements - historická data"
2. Zaměstnanec uvidí možnost filtrování historických dat - sledované období, forma studia (bakalář/magistr, dálkové/normální, ročník,...), vlastnosti studentů (pohlaví, věk, typ předchozího vzdělání,...), předměty
3. Na základě vybraných filtrů se Zaměstnanci zobrazí metriky na základě dat (počet otevřených předmětů, počet naplněných kapacit, počet odhlašování,...)

#### Breakdown

1. Aplikace musí zobrazit dostupné filtry, které jsou kompatibilní se zbytkem systému
2. Na základě vybraných filtrů aplikace musí poslat požadavky do archivovaných a aktálních dat, ale také spolupracvoat s ostatními částmi systému, aby mohla např. napárovat studenty na základě jejich charakteristik
3. Aplikace vypočítá požadované metriky
4. Požadované metriky jsou zobrazené v lidsky čitelném zobrazení (tzn. čísla pro jednoduché výsledky, grafy pro komplikovanější)

#### Responsibities

1. Aplikace musí mít grafické rozhraní pro jednoduchou manipulaci s filtry
2. Fitry by měly být naprogramované tak, aby nové šly jednoduše přidat
3. Aplikace musí komunikovat i s dalšími částmi systému, aby mohla filtrovat data podle jejich charakteristik
4. Aplikace musí vyfiltrovat data z databáze na základě filtrů
5. Data musí být uložena tak, aby bylo možné rychlé filtrování na základě klíčových parametrů (student, vyučující, datum)
6. Do databáze musíme ukládat všechny důležité informace (tzn. i např. o tom, že student byl přihlášen na předmět, ze kterého se pak odhlásil)
7. Aplikace musí správně spočítat požadované metriky
8. Aplikace musí spočítané metriky přehledně zobrazit


#### Refined responsiblities

1. Load input from the user.
2. Validate the input.
3. Gather data from the databases.
4. Preprocess the data.
5. Present the results.

---

Core features

- Zobrazení historických dat
- odhlašování z předmětu student
- Přihlašování na předměty
- Manuální organizace studentů zapsaných na předmětu vyučujícím

</details>

---

<details>
<summary><strong>🇬🇧 Translation (English) </strong></summary>
# Features

### Student

#### Presentation and searching of courses

As a student I want to be able to search and browse courses so that I have an overview of which courses are taught.

#### Enrolling in courses

As a student I need to enroll in a course I want to attend so that I can complete it and receive credits.

#### Presentation of enrolled courses

As a student I want to see all my enrolled courses so I know where and when I need to be for classes.

#### Dropping courses

As a student I need to have the option to drop a course because I may decide that I no longer want to attend the course.

---

### Instructor

#### Manual organization of students enrolled in a course

As an instructor I need to be able to manually enroll a student in my course so that I can better organize my course and possibly help students.

#### Displaying enrolled students

As an instructor I must be able to display all enrolled students so I have an overview and can communicate with students if needed.

#### Displaying the courses I teach

As an instructor I want to be able to display all the courses I teach so that I have an overview of where I will be teaching.

---

### Study department employee

#### Manual enrollment of students

As a study department employee I need to be able to manually enroll a student in a course so that I can help students.

#### Displaying historical data

As a study department employee I need access to display historical data for statistical or organizational purposes.

# Core features

### Enrolling in courses

#### User story

1. The student opens the course search menu.
2. The student searches for the course they want to enroll in.
3. The student selects the course and enrolls in it.
4. The system checks the course requirements for the student.
5. The results are displayed to the student.
   1. The check was successful, the course was enrolled.
   2. The check failed, the student is shown the reasons, the course was not enrolled.
6. The student confirms and is returned to the course search.

#### Break down

1. Getting input from the student.
2. Searching courses in the database.
3. Reading input from the student, clicking the enroll button.
4. Requirement validation.
5. Displaying the result to the student.
6. Reading input from the student, confirmation.
7. Writing into the database.

#### Responsibilities

1. Getting input from the student.

   1. Integration into the whole system so that the student can access the course search.
   2. Loading data from the student based on which the search should be performed.

2. Searching courses in the database.

   1. Finding matching courses in the database.
   2. Displaying the found results.

3. Reading input from the student, clicking the enroll button.

   1. Capturing the user event.

4. Requirement validation.

   1. Checking system-wide information whether the student can enroll at this time.
   2. Requesting the student database.
   3. Checking student information to see if they are still studying.
   4. Checking the course rules against the student.

5. Displaying the result to the student.

   1. Generating a notification about how the validation went.

6. Reading input from the student, confirmation.

   1. Capturing the student event.
   2. Checking whether the student agrees.

7. Writing into the database.
   1. Inserting the new enrollment into the database.



#### Refined responsibilities

1. Presents available courses.
2. User inputs what course they want to enroll in.
3. Validate the request.
4. Write the results into database.
5. Logs the request.
6. Presents the results.

---

### Manual organization of students enrolled in a course (instructor)

As an instructor I need to be able to manually enroll a student in my course so that I can better organize my course and possibly help students.

#### User story

1. The instructor opens the menu with the courses they participate in organizing
2. The instructor clicks on the specific course
3. The details of the course are displayed
4. The instructor goes to the list of students enrolled in the course
5. The instructor

   a. selects an enrolled student

   b. searches for a not-yet-enrolled student by pressing the + button

6. Details about the student and their relation to the course are displayed
7. By pressing the given button the instructor selects the action they want and that can be performed

   a. change of parallel group

   1. A menu with parallel groups is shown
   2. The instructor selects a new parallel group
   3. The instructor confirms the choice of the new parallel group
   4. A message about successful/unsuccessful change of the parallel group is displayed

   b. dropping from the course

   1. The instructor is prompted to confirm removal of the student from the course; information about the course and the student is summarized
   2. The instructor confirms the choice or goes back
   3. A message about successful/unsuccessful unenrollment of the student from the course is displayed

   c. enrolling in the course

   1. The instructor is prompted to confirm enrolling the student in the course; information about the course and the student is summarized
   2. The instructor confirms the choice or goes back
   3. A message about successful/unsuccessful enrollment of the student in the course is displayed

8. The student is notified about any action that concerns them and may be prompted to confirm the action

#### Breakdown

1. The application knows information about the instructor and can obtain the list of courses they teach
2. The application displays an interactive menu with courses and then the course details
3. In the course detail the application provides the list of enrolled students and editing including searching for a non-enrolled student
4. The application allows choosing a student, displays the student detail and executable actions
5. In case of changing the parallel group the application allows choosing a different parallel group
6. After choosing the action the application displays a recap and asks for confirmation of the action
7. After confirmation the application informs the user about the state and notifies the affected user, i.e., the student

#### Responsibilities

1. The application knows information about the instructor and can obtain the list of courses they teach
   1. The application maintains information about the logged-in user
   2. Based on the instructor ID/data the application communicates with the database and gets the list of courses the instructor has permission to edit
   3. The application displays these courses in a clear form
2. The application displays an interactive menu with courses and then the course details
   1. The application communicates with the database and gets the course detail to display
3. In the course detail the application provides the list of enrolled students and editing including searching for a non-enrolled student
   1. The application enables searching students in the database of all students
4. The application allows choosing a student, displays the student detail and executable actions
   1. The application communicates with the database and provides the student detail
   2. The application knows the student's status and, based on it, adjusts which actions are possible and which are not
5. In case of changing the parallel group the application allows choosing another parallel group
   1. The application keeps data about the edited course in memory and displays the parallel groups
6. After choosing the action the application displays a recap and asks for confirmation of the action
   1. The application keeps data about the edited course and the student
7. After confirmation the application informs the user about the state and notifies the affected user, i.e., the student
   1. The application validates the data-change request
   2. The application communicates with the database, writes new data
   3. The application waits for the database response and provides feedback to the user
   4. The application notifies the student whose schedule was changed by email


#### Refined responsibilities

1. Presents the current state of the courses.
2. User inputs that they want to make an action over multiple students.
3. Send request for each student.
4. Present the results.



---

### Dropping courses (student)

#### User story

1. The student opens the "enrollment" part of the information system.
2. The student displays all timetable entries they are enrolled in.
3. The student opens the specific course they want to drop.
4. If the period when students can drop themselves is still running, they will see the option to drop here.
5. The student manually clicks on the option to drop.
6. The system processes the dropping and the student is no longer enrolled in this timetable entry and other timetable entries connected to it (e.g. exercise, lecture...)

#### Breakdown

1. The application loads from the database all courses and specific timetable entries the student is enrolled in
2. After opening the specific course the application loads detailed information about the timetable entry from the database and also loads information about other timetable entries related to this course where the student is enrolled
3. The application checks whether it is possible for the student to drop themselves (e.g., checks time or other conditions)
4. After the user's click the application sends a request to the database so that the student is unenrolled from all timetable entries (or the whole course) + frees places on those entries for other students

#### Responsibilities

1. The application provides a frontend environment for displaying all courses
2. The application establishes connection to the database to display the student's courses and timetable entries
3. The application retrieves detailed timetable entry information from the database and can link it with other timetable entries from the same course
4. The application checks the dropping conditions
5. The application stores the student's drop in the database + information about freed place


#### Refined responsibilities

1. Present all currently enrolled courses.
2. User inputs that they want to leave a course.
3. Validate the request.
4. Writes results into the database.
5. Logs the request taking action.
6. Presents message confirming the course has been left.


---

### Displaying historical data

#### User story

1. The study department employee gets to the section "Enrollments - historical data"
2. The employee sees options to filter historical data - observed period, study form (bachelor/master, distance/on-site, year...), student attributes (gender, age, type of previous education...), courses
3. Based on selected filters the employee is shown metrics based on the data (number of opened courses, number of filled capacities, number of drops...)

#### Breakdown

1. The application must display available filters that are compatible with the rest of the system
2. Based on selected filters the application must send requests to archived and current data, but also cooperate with other parts of the system so that it can e.g. match students based on their characteristics
3. The application calculates the required metrics
4. The required metrics are displayed in a human-readable view (i.e., numbers for simple results, graphs for more complex ones)

#### Responsibities

1. The application must have a graphical interface for easy manipulation with filters
2. Filters should be programmed so that new ones can be added easily
3. The application must also communicate with other parts of the system so it can filter data by their characteristics
4. The application must filter data from the database based on the filters
5. Data must be stored so that fast filtering is possible based on key parameters (student, instructor, date)
6. We must store all important information in the database (i.e., e.g., that a student was enrolled in a course that they later dropped)
7. The application must correctly compute required metrics
8. The application must display the computed metrics clearly


#### Refined responsiblities

1. Load input from the user.
2. Validate the input.
3. Gather data from the databases.
4. Preprocess the data.
5. Present the results.

---

Core features

- Displaying historical data
- dropping from a course (student)
- Enrolling in courses
- Manual organization of students enrolled in a course by the instructor

</details>