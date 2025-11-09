workspace "Schedules (SCH)" "Scheduling software system by team SCH2" {

    !identifiers hierarchical

    model {
        student = person "Student" "Views schedules; manages Basket."
        teacher = person "Teacher" "Creates and modifies subjects and schedules."
        committee = person "Scheduling Committee Member" "Validates subjects and schedules."
        manager = person "Manager" "Oversees schedules and reports; reviews analytics."

        sch = softwareSystem "Schedules (SCH)" "Course management, scheduling, preferences, viewing, and reports." {

            group "Subjects" {
                subjectsHtml = container "Subjects HTML" "Subjects UI in the browser." "HTML/JS" "HTML"
                subjectsBusiness = container "Subjects Business" "Create/modify subjects; request validation." "Business" {
                    subjectCreator = component "Subject Creator" "Creates and updates subject data and concepts."
                    subjectValidator = component "Subject Validator" "Runs subject validation workflow."
                    subjectRepository = component "Subject Repository" "CRUD for subjects and validation history."
                }
            }

            group "Scheduling" {
                schedulingHtml = container "Scheduling HTML" "Scheduling UI in the browser." "HTML/JS" "HTML"
                schedulingBusiness = container "Scheduling Business" "Plan schedules." "Business" {
                    schedulePlanner = component "Schedule Planner" "Creates and adjusts plans."
                    scheduleValidator = component "Schedule Validator" "Validates scheduling constraints."
                    schedulingRepository = component "Scheduling Repository" "CRUD for planning data and prefs."
                }
            }

            group "Schedules" {
                scheduleHtml = container "Schedule HTML" "Timetable/Basket UI in the browser." "HTML/JS" "HTML"
                scheduleBusiness = container "Schedule Business" "Timetable view, basket, collisions." "Business" {
                    scheduleUpdater = component "Schedule Updater" "Applies timetable and basket changes."
                    collisionChecker = component "Schedule Collision Validator" "Detects collisions and alternatives."
                    scheduleExporter = component "Schedule Exporter" "Produces export data for calendars and printouts."
                    scheduleRepository = component "Schedule Repository" "CRUD for schedules, basket, and preferences."
                }
            }

            group "Authentication" {
                loginHtml = container "Login HTML" "Sign-in UI in the browser." "HTML/JS" "HTML"
                authBusiness = container "Authentication Business" "Login logic." "Business" {
                    userValidator = component "User Validator" "Validates user identity and tokens."
                    sessionManager = component "Session Manager" "Manages sessions and tokens."
                    userRepository = component "User Repository" "CRUD for users and credentials."
                }
            }

            group "Reporting" {
                reportHtml = container "Report HTML" "Reports UI in the browser." "HTML/JS" "HTML"
                reportingBusiness = container "Reporting Business" "Generate and export reports." "Business" {
                    reportGenerator = component "Report Generator" "Computes statistics and analytics."
                    reportExporter = component "Report Exporter" "Generates downloadable report files."
                    reportRepository = component "Report Repository" "CRUD for reports and aggregates."
                }
            }

            group "Datastores" {
                dbSubjects = container "Subjects DB" "Subjects and validation history." "Relational DB" "Database"
                dbSchedules = container "Schedules DB" "Schedules, basket, preferences." "Relational DB" "Database"
                dbUsers = container "Users DB" "Users and credentials." "Relational DB" "Database"
                dbReports = container "Reports DB" "Reports and analytics data." "Relational DB" "Database"
            }

            authorizer = container "Authorizer"

            student -> sch "View schedules"
            teacher -> sch "Create/modify subjects and schedules; View schedules"
            committee -> sch "Validate subjects and schedules; View schedules"
            manager -> sch "Review reports and analytics; View schedules"

            student -> sch.scheduleHtml "View schedule; manage basket"
            teacher -> sch.subjectsHtml "Course management; Management of schedule preferences"
            teacher -> sch.schedulingHtml "Scheduling"
            committee -> sch.subjectsHtml "Validate subjects"
            committee -> sch.schedulingHtml "Scheduling"
            manager -> sch.reportHtml "Review reports & analytics"

            subjectsHtml -> subjectsBusiness "Requests"
            schedulingHtml -> schedulingBusiness "Requests"
            scheduleHtml -> scheduleBusiness "Requests"
            loginHtml -> authBusiness "Requests"
            reportHtml -> reportingBusiness "Requests"

            subjectsBusiness.subjectRepository -> dbSubjects "Read/Write"
            schedulingBusiness.schedulingRepository -> dbSchedules "Read/Write"
            scheduleBusiness.scheduleRepository -> dbSchedules "Read/Write"
            authBusiness.userRepository -> dbUsers "Read/Write"
            reportingBusiness.reportRepository -> dbReports "Read/Write"
            reportingBusiness.reportGenerator -> dbSchedules "Read"

            subjectsHtml -> subjectsBusiness.subjectCreator "Create/modify subjects"
            subjectsHtml -> subjectsBusiness.subjectValidator "Validate subjects"
            schedulingHtml -> schedulingBusiness.schedulePlanner "Plan schedules"
            schedulingHtml -> schedulingBusiness.scheduleValidator "Validate schedules"
            scheduleHtml -> scheduleBusiness.scheduleUpdater "Modify timetable; basket"
            scheduleHtml -> scheduleBusiness.collisionChecker "Check collisions"
            scheduleHtml -> scheduleBusiness.scheduleExporter "Export"
            loginHtml -> authBusiness.userValidator "Authenticate"
            reportHtml -> reportingBusiness.reportGenerator "Request analytics"
            reportHtml -> reportingBusiness.reportExporter "Download reports"

            subjectsBusiness -> authorizer "Authorize"
            schedulingBusiness -> authorizer "Authorize"
            reportingBusiness -> authorizer "Authorize"

            subjectsBusiness.subjectCreator -> subjectsBusiness.subjectRepository "Read/Write"
            subjectsBusiness.subjectValidator -> subjectsBusiness.subjectRepository "Read/Write"

            schedulingBusiness.schedulePlanner -> schedulingBusiness.schedulingRepository "Read/Write"
            schedulingBusiness.scheduleValidator -> schedulingBusiness.schedulingRepository "Read"

            scheduleBusiness.scheduleUpdater -> scheduleBusiness.scheduleRepository "Read/Write"
            scheduleBusiness.collisionChecker -> scheduleBusiness.scheduleRepository "Read"
            scheduleBusiness.scheduleExporter -> scheduleBusiness.scheduleRepository "Read"

            reportingBusiness.reportGenerator -> reportingBusiness.reportRepository "Read/Write"
            reportingBusiness.reportExporter -> reportingBusiness.reportRepository "Read"

            authBusiness.userValidator -> authBusiness.userRepository "Read/Write"
            authBusiness.sessionManager -> authBusiness.userRepository "Read/Write"
        }

        idp = softwareSystem "University SSO" "OIDC provider for authentication." "External"
        notif = softwareSystem "Notification Service" "Email and workflow notifications." "External"
        calendars = softwareSystem "Calendar Clients" "External calendar apps consuming iCal feeds." "External"

        sch -> idp "SSO/JWT"
        sch -> notif "Notify"

        sch.authBusiness.userValidator -> idp "OIDC/JWT validation"
        sch.subjectsBusiness.subjectValidator -> notif "Send validation notifications"
        sch.scheduleBusiness.scheduleExporter -> calendars "Publish iCal/printables"
    }

    views {
        systemContext sch "L1-SystemContext" {
            include *
            autolayout lr 520 320 240
        }

        container sch "L2-Grouped" {
            include *
            autolayout lr 650 340 260
        }

        component sch.subjectsBusiness "L3-Subjects" {
            include *
            autolayout lr 600 320 220
        }

        component sch.schedulingBusiness "L3-Scheduling" {
            include *
            autolayout lr 600 320 220
        }

        component sch.scheduleBusiness "L3-Schedules" {
            include *
            autolayout lr 600 320 220
        }

        component sch.authBusiness "L3-Authentication" {
            include *
            autolayout lr 600 320 220
        }

        component sch.reportingBusiness "L3-Reporting" {
            include *
            autolayout lr 600 320 220
        }

        styles {
            element "Person" {
                shape person
                background #0B579F
                color #ffffff
            }
            element "Software System" {
                shape roundedbox
                background #1967D2
                color #ffffff
                stroke #1967D2
            }
            element "HTML" {
                shape webbrowser
                background #93C5FD
                color #1F2937
                stroke #93C5FD
            }
            element "Container" {
                shape roundedbox
                background #60A5FA
                color #0B1F44
                stroke #60A5FA
            }
            element "Database" {
                shape cylinder
                background #1A73E8
                color #ffffff
                stroke #1A73E8
            }
            element "External" {
                background #6B7280
                color #ffffff
            }
            element "Boundary" {
                strokeWidth 2
            }
            element "Component" {
                shape roundedbox
                background #60A5FA
                color #0B1F44
                stroke #60A5FA
            }
                relationship "Relationship" {
                thickness 2
            }
        }
    }

    configuration {
        scope softwaresystem
    }
}
