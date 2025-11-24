# University Scheduling System

## Core features and responsibilities

Core features (5):

1. Create subjects (Teacher)
2. Approve subject (Manager)
3. Define time and space requirements (Teacher)
4. Display graphical interface for scheduling subjects (Scheduling committee)
5. View schedule (Student)

---

### Feature: Create subjects (Teacher) — **CORE**

**User story**  
As a teacher, I need to create a subject and information about it (name, syllabus, description...), so managers can decide whether the subject is sufficiently useful.

**Feature breakdown**

1. Teacher opens the form to create a subject.
2. Fills out the form and submits.
3. System checks data correctness.
4. System sends a notification to the manager with a request to create the subject.
5. … (continues with approval workflow according to faculty rules)

**Responsibilities**

- **Authentication and authorization**
  - Verify "teacher" role.
- **Content validation and management**
  - Validate name, description, syllabus, credits, etc.
  - Allow saving a draft and subsequent edits.
  - Verify required fields (name, code, scope, language).
- **Notifications and workflow**
  - Create an approval request for the manager.
  - Send notifications to involved roles.
  - Maintain version history and approval steps.
  - Allow cancellation or withdrawal of request before approval.
- **User interaction**
  - Provide a clear form interface.
  - Display real-time validations (e.g., error messages on fields).
  - Confirm successful submission of request.

---

### Feature: Approve subject (Manager) — **CORE**

**User story**  
As a manager, I need to approve a subject proposed by a teacher, so the teacher can define time options and the Scheduling committee can schedule the subject.

**Feature breakdown**

1. Manager opens the detail of subject creation request
2. System verifies manager login.
3. Manager approves or rejects the subject.
4. Teacher is notified of subject approval or rejection.

**Responsibilities**

- **Authentication and authorization**
  - Verify "manager" role and access to the given request.
- **Approval processing**
  - Verify approval, whether processing an existing subject that has not yet been approved
  - Propagate to database
- **Notifications and workflow**
  - Inform teacher and other roles about the decision result.
- **Storage and audit**
  - Store decision, state changes and the user who performed the action.


---

### Feature: Define time and space requirements (Teacher) — **CORE**

**User story**  
As a teacher, I need to define the time and space requirements of a subject, so that the scheduling committee can schedule it.

**Feature breakdown**

1. Teacher opens the form for defining requirements.
2. System verifies teacher login.
3. Teacher selects their subject from the list.
4. Teacher enters preferred times, days, duration and frequency of teaching.
5. Teacher enters required room type and capacity.
6. Teacher can add special requirements (e.g., projector).
7. System verifies slot availability and realistic options.
8. System alerts on possible collisions with other subjects or teachers.
9. After confirmation, system saves requirements and sends them to the committee.

**Responsibilities**

- **Authentication and authorization**
  - Verify that the user has the teacher role.
  - Ensure access to their assigned subjects.
  - Verify the right to edit the given subject.
- **Inputs and validation**
  - Provide interface for times/days/duration/room type/capacity/special requirements.
  - Validate hour range, time format, capacity; allow saving as draft.
- **Availability and collisions**
  - Verify non-colliding times against teacher's schedule and other subjects.
  - Verify classroom availability at the given time.
  - Detect unrealistic requirements (e.g., more hours than available slots).
  - Offer alternative times or classrooms.
- **Storage and audit**
  - Allow saving incomplete proposal as draft.
  - Save requirements to database.
  - Maintain history of changes and proposals.
  - Send to committee for further processing.

---

### Feature: Display graphical interface for scheduling subjects and save changes (Scheduling committee) — **CORE**

**User story**  
As a Scheduling committee, I need to view a graphical interface for scheduling subjects, so I can schedule a subject and users can view schedules.

**Feature breakdown**

1. Scheduling opens the interface for scheduling subjects.
2. System verifies Scheduling committee login.
3. Scheduling committee has displayed subjects and their time and space requirements and time options of classrooms.
4. Using the graphical interface, Scheduling committee schedules the subject.
5. Saves the subject schedule.

**Responsibilities**

- **Authentication and authorization**
  - Verify membership in Scheduling committee and appropriate rights.
- **Data retrieval and selection**
  - Load subject requirements, classroom availability, capacities and existing collisions.
- **Interactive planning**
  - Provide drag & drop interface, zoom, grid and snapping to slots.
  - Inline validation of collisions and capacities in real time.
- **Storage and audit**
  - Save both draft and published version; versioning and revert capability.
  - Audit changes (who/when/what) with comments.

---

### Feature: View schedule (Student) — **CORE**

**User story**  
As a student, I need to clearly display a weekly schedule so I can plan my days.

**Feature breakdown**

 1. Student opens the schedule view.
 2. System checks if the student is logged in.
 3. System loads the correct data from the database.
 4. System displays the data graphically.

**Responsibilities**

- **Authentication and authorization**
  - Allow student login.
  - Verify login.
- **Data retrieval and selection**
  - Identify correct data for the given student.
  - Find data in the database (subjects, groups, rooms, teachers).
  - Load metadata about subjects (e.g., capacity, duration, time slots).
  - Merge data from multiple sources (e.g., schedule, changes).
- **Presentation**
  - Graphically interpret weekly overview (time grid, colors, conflicts/capacity).
  - Display interactive elements (tooltips, subject details).
  - Adapt display to different devices (mobile, desktop).
- **Error and exception handling**
  - Catch errors during data loading or processing.
  - Display a clear error message to the user.
  - Log technical errors for system administrators.
- **User interaction and export**
  - Allow switching between weeks or semesters.
  - Allow schedule export (PDF, iCal, CSV).
  - Offer a printable version of the schedule.

---

### Feature: Basket (Student)

**User story**  
As a student, I need to be able to create a provisional, graphically clear schedule of subjects so I can plan my schedule without having to enroll in subjects.

**Feature breakdown**

1. Student opens "Basket".
2. System checks if the student is logged in.
3. System loads a list of all available subjects and their schedule slots.
4. Student selects desired subjects and adds them to the basket.
5. System checks if selected slots do not overlap.
6. If a collision occurs, the system alerts and offers alternatives.
7. System displays the current schedule graphically.

**Responsibilities**

- **Identity and study context**
  - Verify that the user is a logged-in student.
  - Ensure that study program data matches the active profile.
  - Update data when semester or faculty changes.
- **Working with offerings and metadata**
  - Load a list of available subjects and their time slots.
  - Store metadata about capacities and teachers.
- **Basket operations**
  - Add/Remove subject.
  - Save current basket state and allow loading after re-login.
- **Collision checking and suggestions**
  - Compare slot times between subjects.
  - Identify collisions (classroom, time, day) and provide alternative groups.
- **Visualization**
  - Graphically render subjects in weekly overview.
  - Display warnings or highlight conflicting hours.

---

### Feature: View schedule (Teacher)

**User story**  
As a teacher, I need to clearly display a weekly schedule so I can plan my days.

**Feature breakdown**

 1. Teacher opens the schedule view.
 2. System checks if the teacher is logged in.
 3. System loads correct data from the database (their subjects, consultations, exams).
 4. System displays the data graphically.

**Responsibilities**

- **Authentication and authorization**
  - Verify teacher login and their assigned subjects.
  - Limit display to only courses where they have the role of teacher or guarantor.
- **Data retrieval and selection**
  - Load teaching, consultations, exams, service events.
  - Update records when schedule or exam period changes.
- **Presentation**
  - Graphically interpret weekly overview (time grid, colors, conflicts/capacity).
  - Display detailed information on click (subject, group, room, number of students).
  - Adapt display for different devices (mobile, desktop).
- **Error and exception handling**
  - Catch errors during data loading or processing.
  - Display a clear error message to the user.
- **User interaction and export**
  - Allow switching between weeks or semesters.
  - Allow schedule export (PDF, iCal, CSV).
  - Offer a printable version of the schedule.

---

### Feature: Login using graphical interface (User)

**User story**  
As a user, I need to log in to my account, so the system displays the correct data I need. (And does not display data that is not for me)

**Feature breakdown**

1. User opens the login form.
2. Enters login credentials.
3. System verifies login credentials, if valid, confirms and redirects to the correct page.

**Responsibilities**

- **Authentication and authorization**
  - Process login (form/SSO), securely verify user.
- **Error and exception handling**
  - Validate input format; display clear errors without revealing details.
- **User interaction and export**
  - Support "remember me", redirect based on role/context.
- **Storage and audit**
  - Log login/logout, failed attempts, account locking.
- **Linking data with user and redirecting to page**
  - Redirect to the correct page according to user role.

---

### Feature: View subject schedules (Student)

**User story**  
As a student, I need to be able to find the schedule of specific subjects, so I can plan my schedule.

**Feature breakdown**

1. Search for subject by name/code/faculty.
2. Display available groups and their times/rooms/capacities.
3. Option to compare groups with each other.
4. Add selected groups to Basket.

**Responsibilities**

- **Search and filtering**
  - Fulltext and filters (faculty, field, semester, teacher).
- **Subject detail display**
  - Slots, rooms, capacities, possible notes/collisions.
- **Basket integration**
  - Quick group addition; preliminary collision check.

---

### Feature: Export schedule (Student)

**User story**  
As a student, I need to export my schedule to PDF, so I can print it and pin it on the dormitory wall.

**Feature breakdown**

1. Generate printable weekly overview (PDF).
2. Appearance options (subject colors, hide details, font size).
3. Option to export schedule from Basket or final enrollment.

**Responsibilities**

- **Format and templates**
  - Print styles, scaling to A4, support for Czech/Slovak.
- **Data consistency**
  - Export from current state (Basket vs. official schedule).
- **Availability**
  - File download, save to profile, share link.

---

### Feature: View classroom schedule (Student)

**User story**  
As a student, I need to display the schedule of individual classrooms at the faculty, so I can plan which room I can go to study.

**Feature breakdown**

1. Search for classroom by building/number/capacity/equipment.
2. Display weekly occupancy and free slots.
3. Indication when the room is free for self-study.

**Responsibilities**

- **Classroom catalog**
  - Record type, capacity, equipment (projector, outlets, quiet).
- **Occupancy**
  - Display planned teaching/exams; estimate free slots.
- **Clarity**
  - Color markers for "occupied/free", quick filters.

---

### Feature: View classroom schedules (Teacher)

**User story**  
As a teacher, I need to display classroom schedules, so I can adapt planning of teaching, consultations or exams.

**Feature breakdown**

1. Search and filter rooms by capacity/equipment/building.
2. Overview of collisions with planned teaching.
3. Suggestion of alternative rooms.

**Responsibilities**

- **Availability and allocation**
  - Current classroom occupancy; replacement suggestions.
- **Integration with requirements**
  - Connection with "Define time and space requirements".
- **Authentication and authorization**
  - Consider teacher role and their subjects.

---

### Feature: Collision alerts (Scheduling committee)

**User story**  
As a committee, I need to receive an alert if one teacher will teach in one slot multiple times, so I can prevent the impossibility of teaching.

**Feature breakdown**

1. Regular and ad-hoc collision detection runs (teacher, classroom, time).
2. Aggregation of found collisions into overviews and priorities.
3. Committee notification with links to conflicting records.
4. Suggestion of automatic alternatives (different time/classroom/group).

**Responsibilities**

- **Detection rules**
  - "Same teacher at the same time in multiple places", "two events in one classroom".
- **Prioritization and workflow**
  - Mark criticality; assign resolver; track status.
- **Notifications and audit**
  - Alert committee; log changes and decisions.

---

### Feature: Report on subject occupancy (Managers)

**User story**  
As a manager, I need to see how many students have enrolled in individual subjects, so I can decide on opening or merging groups.

**Feature breakdown**

1. Overview of registrations vs. capacity by subjects/groups.
2. Trends over time (registration load, waitlists).
3. Recommendations for opening/merging/closing groups.

**Responsibilities**

- **Data analytics**
  - Collect and consolidate registrations, capacities, limits.
- **Visualization and export**
  - Tables and charts; CSV/PDF export.
- **Decision support**
  - Rules and thresholds for recommendations;
