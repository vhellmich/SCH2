# Assignment of the responsibilities to containers and components

## UIPresenter

1. Present currently enrolled courses.
2. Present available courses.
3. Presents the current state of the courses.
4. User inputs that they want to leave a course.
5. User inputs what course they want to enroll in.
6. User inputs that they want to make an action over multiple students.
7. Presents message confirming the course has been left.
8. Present message confirming the students have been handled.
9. Presents message confirming the course has been joined.
10. Simple front-end validation for all requests

### TeacherEnrollment

1. Presents the current state of the courses.
2. User inputs that they want to make an action over multiple students.
3. Present message confirming the students have been handled.

Allows the teacher to find multiple students and make an action over them.
Such action can be removing them from the course or signing them in.
After the request has been done, the teacher is shown confirming message and the state of the course changes.

### StudentEnrollment

1. Present currently enrolled courses.
2. Present available courses.
3. User inputs that they want to leave a course.
4. User inputs what course they want to enroll.
5. Presents message confirming the course has been left.
6. Presents message confirming the course has been joined.

Student can browse the courses they are enrolled in and courses that they could possibly join.
The student can input, by pressing buttons, that they want to leave or join a course.
The student is presented a confirmation when request has been fulfilled.


## LogicHandler

1. Gather data.
2. Validate the request.
3. Send request for each student.
4. Writes results into the database.
5. Logs the request taking action.
6. Notify each student.

### DataManager

1. Gather data.
2. Writes results into the database.

Gathers data necessary for following validation and processing.
Later writes the request results into database, such as enrolling student to a course.

### Validation

1. Validate the request.

Validates the request depending on the type of the request.
When trying to enroll a student, some information need to be validated, such as whether that student is still studying, whether they have not finished that course already and so on.


### Logger

1. Logs the request taking action.

Writes log report to a database.
Stores information such as when, who and what happened.

### EnrollmentsRequestBatchProcessor

1. Sends request for each student.
2. Notify each student.

When multiple students are inputted by a teacher, they will be handled one by one.
Requests a notification on the notification module for each student to be notified.


---

## StatisticsUI

Responsibilities breakdown:

1. Load input from the user.
2. Validate the input.
3. Send request for statistical processing
4. Present the results
5. Show graphs

### QueryUI

1. Load input from the user.
2. Validate the input.
3. Send request for statistical processing

This component allows the user to comfortably choose what data they want to process.
It allows them to input filers and the way they want to see the data.
Basic validation is provided and the user is notified when invalid input was provided.


### AnalysisUI

1. Present the results
2. Show graphs

Presents the results in the desired format, possibly allows for the data to be downloaded.


## StatisticalModule

Responsibilities breakdown:  

1. Communicate with StatisticsUI
2. Communicate with the database
3. Run statistical analysis
4. Send results back to StatisticsUI

### DataManager

1. Communicate with the database

Asks the databases to provide the desired data.

### StatisticalEngine

1. Communicate with StatisticsUI
2. Run statistical analysis
3. Send results back to StatisticsUI

Processes the data into the requested format and return in back to the UI.

---

## NotificationModule

1. Notify the student.

### AlertDispatcher

1. Forward notification request.

Further dispatches the notification.

### EmailSender

1. Send notification.

Sends an email notification to the user.
