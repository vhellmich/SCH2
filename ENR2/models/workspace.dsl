workspace "Enrollments Workspace" "This workspace documents the architecture of the enrollments module and its integration into the whole sis." {
    !identifiers hierarchical

    model {
        admin = person "Administrative worker" "Analyses enrollment trends"
        student = person "Student" "Uses the Enrollments application to manage their courses."
        teacher = person "Teacher" "Uses the Enrollments application to manage the students enrolled or to be enrolled in their course."

        enrollments = softwareSystem "Enrollments" {            
            /* UI presentation module
            */
            UI_presenter = container "UIPresenter" "Provides a web-based user interface" {
                tags "Web Front-End"

                student_enrollment = component "StudentEnrollment" "Allows students to enroll in or leave courses"{
                    tags "Web Front-End"
                }
                teacher_enrollment = component "TeacherEnrollment" "Allows teachers to manage student enrollments"{
                    tags "Web Front-End"
                }
            }

            /* Operation logic module
            */
            enrollments_logic = container "EnrollmentsModule" "Oversees request to its completition" {
                request_interface = component "RequestInterface" "Interface for communication with the UI presenter (bott requests and responses)"
                batch = component "EnrollmentRequestBatchProcessor" "Processes enrollment requests in batch"
                subjects = component "Subjects" "Manages data about subjects"
                enrollments = component "Enrollments" "Manages logic of enrollment requests (enroll in/enroll out)"
                validation = component "Validation" "Manages validation of enrollment requests"
                data_manager = component "DataManager" "Manages communication with data storages"
                logger = component "Logger" "Manages logging of operations"
            }

            /* Enrollment database 
            */
            enrollment_database = container "EnrollmentDatabase" "Maintains data about student enrollment" {
                tags "Database"

                enrollments_table = component "EnrollmentsTable" "Stores data about which students are enrolled in which courses" {
                    tags "Database"
                }

                archive = component "Archive" "Stores logs of operations permanently for future reference" {
                    tags "Database"
                }
            }


            /* Graph making module
            */
            data_analysis = container "StatisticalModule" "Data analysis module" {
                statistical_engine = component "StatisticalEngine" "Module for statistical data processing"
                data_manager = component "DataManager" "Manages communication with data storages"
            }

            statistics_ui = container "StatisticsUI"{
                tags "Web Front-End"

                query_ui = component "QueryUI" "Supplies UI for data queries"{
                    tags "Web Front-End"
                }

                analysis_ui = component "AnalysisUI" "Supplies UI for analyzing queried data"{
                    tags "Web Front-End"
                }

                filters = component "Filters" "Module for filter management"
                graphs = component "VisualizationEngine" "Module for interactive graph generation"
            }

            /* Notification module
            */
            notifier = container "NotificationModule" "Provides users with notifications" {
                alert_dispatcher = component "Alert dispatcher" "Alerts the appropriate user"
                email_sender = component "Email sender" "Sends an email"
            }
        }

        sis = softwareSystem "SIS" "The rest of the student information system containing other functional modules and databases" {
            tags "Existing System"            
        }
        

        
        // student enrollment
        student -> enrollments.UI_presenter.student_enrollment "Joins or leaves a course."
        enrollments.UI_presenter.student_enrollment -> student "Returns enrollment interface"

        // teacher enrollment
        teacher -> enrollments.UI_presenter.teacher_enrollment "Access teacher enrollment management"
        enrollments.UI_presenter.teacher_enrollment -> teacher "Returns teacher enrollment management interface"

        // user notification
        // enrollments.enrollments_logic -> enrollments.UI_presenter "Display status change confirmation"
        // enrollments.enrollments_logic -> enrollments.notifier "Request a notification to be sent"
        // enrollments.notifier -> student "Provide the user with status change notification"
        // enrollments.notifier -> teacher "Provide the user with status change notification"
        

        // statistical data
        admin -> enrollments.statistics_ui.query_ui "Queries statistical data about enrollments"
        enrollments.statistics_ui.analysis_ui -> admin "Presents reports on selected data"

        // Dont know if these are desired, definitelly make the L2 kind of ugly
        // Also not necessary
        #admin -> enrollments.UI_presenter.teacher_enrollment "Access teacher enrollment management"
        #enrollments.UI_presenter.teacher_enrollment -> admin "Returns teacher enrollment management interface"

        /* data_analysis components
        */
        enrollments.statistics_ui.query_ui -> enrollments.statistics_ui.filters "Sends filter data"
        enrollments.statistics_ui.filters -> enrollments.statistics_ui.query_ui "Returns filter data"
        enrollments.statistics_ui.query_ui -> enrollments.data_analysis.statistical_engine "Sends statistical data requests"

        // data
        enrollments.data_analysis.statistical_engine -> enrollments.data_analysis.data_manager "Requests data"

            // data reads and returns
            enrollments.data_analysis.data_manager -> enrollments.enrollment_database.enrollments_table "Reads enrollment data from data storage"
            enrollments.enrollment_database.enrollments_table -> enrollments.data_analysis.data_manager "Returns enrollment data from data storage"

            enrollments.data_analysis.data_manager -> sis "Reads data from SIS data storage"
            sis -> enrollments.data_analysis.data_manager "Returns data from SIS data storage"

            enrollments.data_analysis.data_manager -> enrollments.enrollment_database.archive "Reads enrollment data from data archive"
            enrollments.enrollment_database.archive -> enrollments.data_analysis.data_manager "Returns enrollment data from data archive"

        enrollments.data_analysis.data_manager -> enrollments.data_analysis.statistical_engine "Returns data for statistical processing"
        
        // presenting data
        enrollments.data_analysis.statistical_engine -> enrollments.statistics_ui.analysis_ui "Sends data to be displayed"
        enrollments.statistics_ui.analysis_ui -> enrollments.statistics_ui.graphs "Requests graphs generation"
        enrollments.statistics_ui.graphs -> enrollments.statistics_ui.analysis_ui "Returns graphs for presentation"

        /* UI_presenter components
        */
        enrollments.UI_presenter.student_enrollment -> enrollments.enrollments_logic.request_interface "Sends student enrollment requests"
        enrollments.enrollments_logic.request_interface -> enrollments.UI_presenter.student_enrollment "Responds to student enrollment requests"
        enrollments.UI_presenter.teacher_enrollment -> enrollments.enrollments_logic.request_interface "Sends teacher enrollment requests"
        enrollments.enrollments_logic.request_interface -> enrollments.UI_presenter.teacher_enrollment "Responds to teacher enrollment requests"
        enrollments.UI_presenter.teacher_enrollment -> enrollments.enrollments_logic.batch "Sends enrollment requests in batch"
        enrollments.enrollments_logic.batch -> enrollments.UI_presenter.teacher_enrollment "Responds to batch enrollment requests"

        /* Operation logic module components
        */
        enrollments.enrollments_logic.request_interface -> enrollments.enrollments_logic.enrollments "Sends enrollment requests"
        enrollments.enrollments_logic.enrollments -> enrollments.enrollments_logic.request_interface "Sends enrollment responses"
        enrollments.enrollments_logic.enrollments -> enrollments.enrollments_logic.validation "Sends validation requests"
        enrollments.enrollments_logic.validation -> enrollments.enrollments_logic.enrollments "Sends validation responses"
        enrollments.enrollments_logic.request_interface -> enrollments.enrollments_logic.subjects "Requests subject data"
        enrollments.enrollments_logic.subjects -> enrollments.enrollments_logic.request_interface "Returns subject data"
        enrollments.enrollments_logic.batch -> enrollments.enrollments_logic.enrollments "Sends individaul enrollment requests"
        enrollments.enrollments_logic.enrollments -> enrollments.enrollments_logic.batch "Sends responses for individual requests" 
        enrollments.enrollments_logic.data_manager -> enrollments.enrollments_logic.subjects "Returns subject data from data storage"
        enrollments.enrollments_logic.subjects -> enrollments.enrollments_logic.data_manager "Requests subject data from data storage"
        enrollments.enrollments_logic.data_manager -> enrollments.enrollments_logic.validation "Returns validation data from data storage"
        enrollments.enrollments_logic.validation -> enrollments.enrollments_logic.data_manager "Requests validation data from data storage"
        enrollments.enrollments_logic.data_manager -> enrollments.enrollments_logic.logger "Requests logging of operations"
        enrollments.enrollments_logic.data_manager -> enrollments.enrollment_database.enrollments_table "Reads data"
        enrollments.enrollment_database.enrollments_table -> enrollments.enrollments_logic.data_manager "Returns data"
        enrollments.enrollments_logic.logger -> enrollments.enrollment_database.archive "Logs permanently"
        enrollments.enrollments_logic.data_manager -> sis "Reads data"
        sis -> enrollments.enrollments_logic.data_manager "Returns data"

        enrollments.enrollments_logic.enrollments -> enrollments.enrollments_logic.data_manager "Reads from and writes to database using ..."
        enrollments.enrollments_logic.data_manager -> enrollments.enrollments_logic.enrollments "Returns data and confirms data modification."

        enrollments.enrollments_logic.batch -> enrollments.notifier.alert_dispatcher "Requests a notification."
        enrollments.enrollments_logic.enrollments -> enrollments.notifier.alert_dispatcher "Requests a notification."

        /* Notification module
        */
        enrollments.enrollments_logic -> enrollments.notifier.alert_dispatcher "Requests an alert"
        enrollments.notifier.alert_dispatcher ->  enrollments.notifier.email_sender "Request an email notification"
        enrollments.notifier.email_sender -> student "Emails the student"
        enrollments.notifier.email_sender -> teacher "Emails the teacher"

        // sis
        enrollments -> sis "Integrates into"

        /* Deployment
        */
        deploymentEnvironment "Production" {
            deploymentNode "Student's web browser" "" "" {
                UIPresenterStudentInstance = containerInstance enrollments.UI_presenter "Presents student UIPresenter HTML interface with HTML/CSS/JS"
            }
            deploymentNode "Teacher's web browser" "" "" {
                UIPresenterTeacherInstance = containerInstance enrollments.UI_presenter "Presents teacher UIPresenter HTML interface with HTML/CSS/JS"
            }

            
            deploymentNode "Admin's web browser" "" ""{
                UIPresenterTeacherInstance = containerInstance enrollments.statistics_ui "Presents teacher UIPresenter HTML interface with HTML/CSS/JS"
            }
            deploymentNode "Application server" "AWS hosted virtual computer" "AWS" "" {
                // AWS EC2 is a web service that provides resizable compute capacity in the cloud.
                deploymentNode "AWS EC2" "Main application server" "Ubuntu"{
                    EnrolmentsModuleInstance = containerInstance enrollments.enrollments_logic "Runs the whole enrollments logic"
                    // Notifier is not that heavy on resources, therefore it can run on the same server as the main module
                    NotifierInstance = containerInstance enrollments.notifier "Runs the notification module"
                }
                // This statistical node should be separated from the main application server for performance reasons
                // AWS Lambda is a serverless compute service that runs code in response to events and automatically manages the underlying compute resources.
                deploymentNode "AWS lambda service" "Statistical analysis server" "Ubuntu; Docker Desktop; Python" {
                    StatisticalModuleInstance = containerInstance enrollments.data_analysis "Runs the statistical data analysis module"
                }
            }
            deploymentNode "Database server" "Cloud database instance" "AWS"{
                deploymentNode "AWS ERD" "Relational database" "MySQL"{
                    EnrollmentDatabaseInstance = containerInstance enrollments.enrollment_database "Stores enrollment data"
                }
            }
        }
        deploymentEnvironment "Front-end Development" {
                deploymentNode "Developer's Computer" "Local development environment" "Windows 11, Docker Desktop, Visual Studio Code" {
                    deploymentNode  "Frontend Node" "Serves static web UI locally on different ports" "localhost; Node.js" {
                    UIPresenterStudentInstance = containerInstance enrollments.UI_presenter "Student UI (runs on localhost)"
                    UIPresenterTeacherInstance = containerInstance enrollments.UI_presenter "Teacher UI (runs on localhost)"
                    StatisticsUIInstance = containerInstance enrollments.statistics_ui "Statistics UI (runs on localhost)"

                }
                deploymentNode "Backend" "Handles API requests locally" "Docker Desktop; Python" {
                    EnrolmentsModuleInstance = containerInstance enrollments.enrollments_logic "Runs local instance of main logic"
                    NotifierInstance = containerInstance enrollments.notifier "Local notifier testing"
                    StatisticalModuleInstance = containerInstance enrollments.data_analysis "Runs local data analysis"
                }

                deploymentNode "Development Database" "Database instance" "Docker; MySQL" {
                    EnrollmentDatabaseInstance = containerInstance enrollments.enrollment_database "Stores local development data"
                }
            }
        }
    }

    views {
        /* Systems
        */
        systemContext enrollments "systemContextDiagram" {
            include *
        }

        /* Containersfv
        */
        container enrollments "ContaintersDiagram" {
            include *
        }

  

        /* Components
        */
        component enrollments.UI_presenter "UIPresenter"{
            include *
        }

        component enrollments.enrollments_logic "EnrollmentsModule" {
            include *
        }

        component enrollments.data_analysis "StatisticalModule"{
            include *
        }
        
        component enrollments.statistics_ui "StatisticsUI"{
            include *
        }

        component enrollments.notifier "NotificationModule"{
            include *
        }

        component enrollments.enrollment_database "EnrollmentDatabase"{
            include *
        }

        deployment enrollments "Production" "Production_deployment" {
            include *
        }


        deployment enrollments "Front-end Development" "Development_deployment" {
            include *
        }

        theme default

        styles {
            element "*" {
                background #8FBDE0
            }

            element "Person" {
                background #AE2E7B   
                stroke #62053D               
            }

            element "Container" {
                background #8FBDE0
                stroke  #3E7DAD
            }

            element "Software System" {
                stroke #8FBDE0
                background  #3E7DAD
            }

            element "Existing System" {
                background #888888  
                stroke #555555
                color #FFFFFF
            }

            element "Web Front-End" {
                shape WebBrowser
                background #D38AB6 
                color #FFFFFF
                stroke #AE2E7B 
            }

            element "Database" {
                shape Cylinder
                background #87C6C0   
                stroke #3E7E77
            }

            /* Relationship lines: gentle rose, orthogonal routing */
            relationship "*" {
                color #E48AB1
                thickness 2
                routing Orthogonal
                fontSize 24
            }
        }

        dynamic enrollments.enrollments_logic "Feature1" "Student enrolls into a course" {
            title "Dynamic diagram: Student enrolls themselves"

            // sending request
            student -> enrollments.UI_presenter "Selects a course and enrolls"
            enrollments.UI_presenter -> enrollments.enrollments_logic.request_interface "Sends enrollment request"
            enrollments.enrollments_logic.request_interface -> enrollments.enrollments_logic.enrollments "Forwards enrollment request"

            // validation
            enrollments.enrollments_logic.enrollments -> enrollments.enrollments_logic.validation "Sends validation request"
            enrollments.enrollments_logic.validation -> enrollments.enrollments_logic.data_manager "Requests validation data"

                // request data for validation
                enrollments.enrollments_logic.data_manager -> enrollments.enrollment_database.enrollments_table "Requests data"
                enrollments.enrollment_database.enrollments_table -> enrollments.enrollments_logic.data_manager "Supplies data"
                enrollments.enrollments_logic.data_manager -> sis "Requests data"
                sis -> enrollments.enrollments_logic.data_manager "Supplies data"

            enrollments.enrollments_logic.data_manager -> enrollments.enrollments_logic.validation "Returns validation data"
            enrollments.enrollments_logic.validation -> enrollments.enrollments_logic.enrollments "Answers validation request"

            // data update
            enrollments.enrollments_logic.enrollments -> enrollments.enrollments_logic.data_manager "Sends data update request"
            
            enrollments.enrollments_logic.data_manager -> enrollments.enrollment_database.enrollments_table "Writes data"
            enrollments.enrollment_database.enrollments_table -> enrollments.enrollments_logic.data_manager "Confirms writing new data"

            enrollments.enrollments_logic.data_manager -> enrollments.enrollments_logic.logger "Logs writing new data"
            enrollments.enrollments_logic.logger -> enrollments.enrollment_database.archive "Logs writing new data"

            enrollments.enrollments_logic.data_manager -> enrollments.enrollments_logic.enrollments "Forwards confirmation"

            // notification and confirmation
            enrollments.enrollments_logic.enrollments -> enrollments.notifier.alert_dispatcher "Sends notification request"
            enrollments.notifier.alert_dispatcher -> enrollments.notifier.email_sender "Requests an e-mail notification"
            enrollments.notifier.email_sender -> student "Confirms/denies enrollment via e-mail"

            enrollments.enrollments_logic.enrollments -> enrollments.enrollments_logic.request_interface "Answers enrollment request"
            enrollments.enrollments_logic.request_interface -> enrollments.UI_presenter "Forwards request answer"
            enrollments.UI_presenter -> student "Displays status change to the student."
        }

        dynamic enrollments.enrollments_logic "Feature2" "Teacher enrolls a group of students into a course." {
            title "Dynamic diagram: Teacher enrolls multiple students"

            // sending request
            teacher -> enrollments.UI_presenter "Selects a course and students to enroll"
            enrollments.UI_presenter -> enrollments.enrollments_logic.batch "Sends batch enrollment request"
            enrollments.enrollments_logic.batch -> enrollments.enrollments_logic.enrollments "Begin transaction: forwards each enrollment request"

            // validation
            enrollments.enrollments_logic.enrollments -> enrollments.enrollments_logic.validation "Sends validation for each request"
            enrollments.enrollments_logic.validation -> enrollments.enrollments_logic.data_manager "Requests validation data"

                // request data for validation
                enrollments.enrollments_logic.data_manager -> enrollments.enrollment_database "Requests data"
                enrollments.enrollment_database -> enrollments.enrollments_logic.data_manager "Supplies data"
                enrollments.enrollments_logic.data_manager -> sis "Requests data"
                sis -> enrollments.enrollments_logic.data_manager "Supplies data"

            enrollments.enrollments_logic.data_manager -> enrollments.enrollments_logic.validation "Returns validation data"
            enrollments.enrollments_logic.validation -> enrollments.enrollments_logic.enrollments "Answers validation request"

            enrollments.enrollments_logic.enrollments -> enrollments.enrollments_logic.batch "Forwards each validation"
            enrollments.enrollments_logic.batch -> enrollments.enrollments_logic.enrollments "Finalize tranaction: write data and notify"

            // data update
            enrollments.enrollments_logic.enrollments -> enrollments.enrollments_logic.data_manager "Sends data update request"
            enrollments.enrollments_logic.data_manager -> enrollments.enrollment_database "Writes data"
            enrollments.enrollment_database -> enrollments.enrollments_logic.data_manager "Confirms writing new data"
            enrollments.enrollments_logic.data_manager -> enrollments.enrollments_logic.enrollments "Forwards confirmation"

            // notification
            enrollments.enrollments_logic.enrollments -> enrollments.notifier.alert_dispatcher "Sends notification request"
            enrollments.notifier.alert_dispatcher -> enrollments.notifier.email_sender "Requests an e-mail notification"
            enrollments.notifier.email_sender -> student "Alerts about the enrollment via e-mail"

            enrollments.enrollments_logic.enrollments -> enrollments.enrollments_logic.batch "Confirms transaction completion"
            enrollments.enrollments_logic.batch -> enrollments.notifier.alert_dispatcher "Sends notification request"
            enrollments.notifier.alert_dispatcher -> enrollments.notifier.email_sender "Requests an e-mail notification"
            enrollments.notifier.email_sender -> teacher "Alerts about the enrollments via e-mail"

            enrollments.enrollments_logic.batch -> enrollments.UI_presenter "Answers request"
            enrollments.UI_presenter -> teacher "Displays status change to the teacher"
        }
        
        dynamic enrollments.enrollments_logic "Feature3" "Student quits a course" {
            title "Dynamic diagram: Student quits a course"

            // sending request
            student -> enrollments.UI_presenter "Quits a course"
            enrollments.UI_presenter -> enrollments.enrollments_logic.request_interface "Sends withdrawal request"
            enrollments.enrollments_logic.request_interface -> enrollments.enrollments_logic.enrollments "Forwards request"

            // validation
            enrollments.enrollments_logic.enrollments -> enrollments.enrollments_logic.validation "Sends validation request"
            enrollments.enrollments_logic.validation -> enrollments.enrollments_logic.data_manager "Requests validation data"

            enrollments.enrollments_logic.data_manager -> enrollments.enrollment_database "Requests data"
            enrollments.enrollment_database -> enrollments.enrollments_logic.data_manager "Supplies data"
            enrollments.enrollments_logic.data_manager -> sis "Requests data"
            sis -> enrollments.enrollments_logic.data_manager "Supplies data"

            enrollments.enrollments_logic.data_manager -> enrollments.enrollments_logic.validation "Returns validation data"
            enrollments.enrollments_logic.validation -> enrollments.enrollments_logic.enrollments "Answers validation request"

            // data update
            enrollments.enrollments_logic.enrollments -> enrollments.enrollments_logic.data_manager "Sends data update request"
            
            enrollments.enrollments_logic.data_manager -> enrollments.enrollment_database "Writes data"
            enrollments.enrollment_database -> enrollments.enrollments_logic.data_manager "Confirms writing new data"

            enrollments.enrollments_logic.data_manager -> enrollments.enrollments_logic.enrollments "Forwards confirmation"

            // notification and confirmation
            enrollments.enrollments_logic.enrollments -> enrollments.notifier.alert_dispatcher "Sends notification request"
            enrollments.notifier.alert_dispatcher -> enrollments.notifier.email_sender "Requests an e-mail notification"
            enrollments.notifier.email_sender -> student "Confirms/denies withdrawal via e-mail"
            enrollments.notifier.email_sender -> teacher "Informs about student withdrawal via e-mail if in a certain time period"

            enrollments.enrollments_logic.enrollments -> enrollments.enrollments_logic.request_interface "Answers withdrawal request"
            enrollments.enrollments_logic.request_interface -> enrollments.UI_presenter "Forwards request answer"
            enrollments.UI_presenter -> student "Displays status change to the student."
        }

        dynamic enrollments.data_analysis "Feature4" "Admin analyzes enrollment data" {
            title "Dynamic diagram: Admin analyzes enrollment data"

            admin -> enrollments.statistics_ui.query_ui "Query data to be analyzed"
            enrollments.statistics_ui.query_ui -> enrollments.data_analysis.statistical_engine "Request data analysis"
            enrollments.data_analysis.statistical_engine -> enrollments.data_analysis.data_manager "Retrieve the queired data from database"

            enrollments.data_analysis.data_manager -> enrollments.enrollment_database "Request data"
            enrollments.enrollment_database -> enrollments.data_analysis.data_manager "Supply data"

            enrollments.data_analysis.data_manager -> sis "Request data"
            sis -> enrollments.data_analysis.data_manager "Supply data"

            enrollments.data_analysis.data_manager -> enrollments.data_analysis.statistical_engine "Return data to be processed"
            enrollments.data_analysis.statistical_engine -> enrollments.statistics_ui.analysis_ui "Return processed data"
            enrollments.statistics_ui.analysis_ui ->  enrollments.statistics_ui.graphs "Request graph generation"
            enrollments.statistics_ui.graphs -> enrollments.statistics_ui.analysis_ui "Supply graphs"
            enrollments.statistics_ui.analysis_ui -> admin "Present the data overview to the user"
        }
    }

    # This enabled did not work for me. Error based on defining multiple softwareSystems.
    configuration {
        scope softwareSystem
    }
}