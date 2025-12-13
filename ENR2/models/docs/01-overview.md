> -----------------------------------------
> **Team: ENR2**
>
> **Members:**
>
> - Anna Kmentová (L2, L3, presenation)
> - Hynek Mach (L1, L2, L3, documentation)
> - Zuzana Černohousová (L1, L2, dynamic diagrams)
> - Patrícia Sotáková (deployment diagrams, documentation)
>
> -----------------------------------------



The **Enrollments** system is a core module of the Student Information System (SIS).  
Its primary purpose is to support:

- Student course enrollment
- Teacher management of enrollment lists
- Recording enrollment data
- Statistical analysis and visualization
- Notifications for enrollment-related events



The system consists of the following high-level containers:

- **UIPresenter** – Web-based front-end for enrollment operations  
    *RESPONSIBILITIES:*
    1. Present currently enrolled courses
    2. Present available courses
    3. Present the current state of the courses
    4. User inputs that they want to leave a course
    5. User inputs what course they want to enroll in
    6. Teacher user inputs that they want to make an action over multiple students
    7. Present message confirming the course has been left
    8. Present message confirming the students have been handled
    9. Present message confirming the course has been joined
    10. Simple front-end validation for all requests

- **StatisticsUI** – User interface for analytics and visualization  
    *RESPONSIBILITIES:*
    1. Provide query interface
    2. Load input from the user
    3. Validate the input
    4. Send request for statistical processing
    5. Present the results
    6. Show graphs

- **StatisticalModule** – Performs statistical calculations on stored data  
    *RESPONSIBILITIES:*
    1. Communicate with StatisticsUI
    2. Communicate with the database
    3. Run statistical analysis
    4. Send results back to StatisticsUI

- **EnrollmentsModule** – Core request handling and business logic  
    *RESPONSIBILITIES:*
    1. Forward subject-related data
    2. Handle status-change requests
    3. Handle batch requests
    4. Validate requests
    5. Write results into the database
    6. Log the request taking action
    7. Notify users about status changes using the NotificationModule

- **EnrollmentDatabase** – Storage for enrollments and archival logs  
    *RESPONSIBILITIES:*
    1. Store current enrolment data
    2. Store historical data changes in enrollment
    3. Provide data manipulation interface

- **NotificationModule** – Dispatches notifications to users (emails)
    *RESPONSIBILITIES:*
    1. Notify students about status changes

An external system, **SIS**, provides additional functional modules and a shared database.

![](embed:systemContextDiagram)

<!-- This is too detailed for overview
![](embed:ContaintersDiagram)     -->