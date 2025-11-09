workspace "Schedules (SCH)" "Scheduling software system by team SCH2" {

    !identifiers hierarchical

    model {
        student = person "Student" "Views schedules; manages Basket."
        teacher = person "Teacher" "Creates and modifies subjects and schedules."
        committee = person "Scheduling Committee Member" "Validates subjects and schedules."
        manager = person "Manager" "Oversees schedules and reports; reviews analytics."
        user = person "SCH User" "Aggregated actor for shared web UX (Student/Teacher/Committee/Manager)."

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
                    scheduleViewer = component "Schedule Viewer" "Read-only queries & projections for timetable/basket UI."
                    scheduleTransformer = component "Schedule Transformer" "Builds ScheduleSnapshot (canonical DTO)."
                    scheduleExporter = component "Schedule Exporter" "Renders ScheduleSnapshot to requested format (ics/pdf/csv)."
                    scheduleUpdater = component "Schedule Updater" "Applies timetable and basket changes."
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

            student -> user "Is a" {
                tags "Is a"
            }
            teacher -> user "Is a" {
                tags "Is a"
            }
            committee -> user "Is a" {
                tags "Is a"
            }
            manager -> user "Is a" {
                tags "Is a"
            }

            user -> sch "Uses"
            student -> sch "View schedules"
            teacher -> sch "Create/modify subjects and schedules; View schedules"
            committee -> sch "Validate subjects and schedules; View schedules"
            manager -> sch "Review reports and analytics; View schedules"

            teacher -> sch.subjectsHtml "Course management; Management of schedule preferences"
            teacher -> sch.schedulingHtml "Scheduling"
            committee -> sch.subjectsHtml "Validate subjects"
            committee -> sch.schedulingHtml "Scheduling"
            manager -> sch.reportHtml "Review reports & analytics"
            
            user -> sch.loginHtml "Sign in"
            user -> sch.scheduleHtml "View timetable; manage basket"

            subjectsHtml -> subjectsBusiness "Requests"
            schedulingHtml -> schedulingBusiness "Requests"
            scheduleHtml -> scheduleBusiness "Requests"
            loginHtml -> authBusiness "Requests"
            reportHtml -> reportingBusiness "Requests"
            
            schedulingBusiness -> subjectsBusiness "Read subject catalog; evaluate subject policies"

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
            scheduleHtml -> scheduleBusiness.scheduleViewer   "Load timetable; basket"
            scheduleHtml -> scheduleBusiness.scheduleExporter "Export (format param)"
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
            schedulingBusiness.scheduleValidator -> subjectsBusiness.subjectValidator "Subject invariants"

            scheduleBusiness.scheduleUpdater -> scheduleBusiness.scheduleRepository "Read/Write"
            scheduleBusiness.scheduleExporter  -> scheduleBusiness.scheduleTransformer "Build snapshot"
            scheduleBusiness.scheduleViewer     -> scheduleBusiness.scheduleRepository "Read"
            scheduleBusiness.scheduleTransformer -> scheduleBusiness.scheduleRepository "Read"
            scheduleBusiness.scheduleViewer -> schedulingBusiness.scheduleValidator "Collisions/availability (read)"

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
        calendars -> sch.scheduleBusiness.scheduleExporter "Fetch iCal"
        
        // --- Deployment model: Development ---
        deploymentEnvironment "Development" {
        
          deploymentNode "Dev Laptop" "Developer machine" "Windows/macOS/Linux" {
            deploymentNode "Docker Desktop" "Local container runtime" "Docker" {
        
              // UI containers
              deploymentNode "web" "Static/dev servers" "Node/Nginx" {
                containerInstance sch.subjectsHtml
                containerInstance sch.schedulingHtml
                containerInstance sch.scheduleHtml
                containerInstance sch.loginHtml
                containerInstance sch.reportHtml
              }
        
              // Backend containers
              deploymentNode "app" "Backend services" ".NET/Java/Python" {
                containerInstance sch.subjectsBusiness
                containerInstance sch.schedulingBusiness
                containerInstance sch.scheduleBusiness
                containerInstance sch.authBusiness
                containerInstance sch.reportingBusiness
                containerInstance sch.authorizer
              }
        
              // Databases (local Postgres schemas/instances)
              deploymentNode "db" "Local database" "PostgreSQL" {
                containerInstance sch.dbSubjects
                containerInstance sch.dbSchedules
                containerInstance sch.dbUsers
                containerInstance sch.dbReports
              }
            }
          }
        
          // Externals (test/stub)
          deploymentNode "External - University SSO (Test)" "Test IdP / sandbox" "OIDC Provider" {
            softwareSystemInstance idp
          }
          deploymentNode "External - Notification Service (Stub)" "MailHog/mock" "SMTP/HTTP" {
            softwareSystemInstance notif
          }
          deploymentNode "External - Calendar Client" "Apple/Outlook/Thunderbird" "iCal Client" {
            softwareSystemInstance calendars
          }
        }
        
        // --- Deployment model: Production ---
        deploymentEnvironment "Production" {
        
          deploymentNode "EU Region" "Primary production region" "Cloud" {
            deploymentNode "Kubernetes Cluster" "Container orchestration" "Kubernetes" {
        
              // Static web front-ends
              deploymentNode "web" "Static front-ends" "Nginx/SPA" {
                containerInstance sch.subjectsHtml
                containerInstance sch.schedulingHtml
                containerInstance sch.scheduleHtml
                containerInstance sch.loginHtml
                containerInstance sch.reportHtml
              }
        
              // Backend services
              deploymentNode "app" "Backend services" ".NET/Java/Python" {
                containerInstance sch.subjectsBusiness
                containerInstance sch.schedulingBusiness
                containerInstance sch.scheduleBusiness
                containerInstance sch.authBusiness
                containerInstance sch.reportingBusiness
                containerInstance sch.authorizer
              }
        
              // Databases
              deploymentNode "db" "Managed database cluster" "PostgreSQL" {
                containerInstance sch.dbSubjects
                containerInstance sch.dbSchedules
                containerInstance sch.dbUsers
                containerInstance sch.dbReports
              }
            }
          }
        
          // Externals (production)
          deploymentNode "External - University SSO" "University IdP (production)" "OIDC Provider" {
            softwareSystemInstance idp
          }
          deploymentNode "External - Notification Service" "Email/workflow (production)" "SMTP/HTTP" {
            softwareSystemInstance notif
          }
          deploymentNode "External - Calendar Clients" "End-user calendar apps" "iCal Clients" {
            softwareSystemInstance calendars
          }
        }
    }

    views {
        systemContext sch "L1-SystemContext" {
            include *
            autolayout lr 520 320 240
        }

        container sch "L2-Grouped" {
            include *
            include student
            include teacher
            include committee
            include manager
            autolayout lr 650 340 260
        }

        component sch.subjectsBusiness "L3-Subjects" {
            include *
            autolayout lr 600 320 220
        }

        component sch.schedulingBusiness "L3-Scheduling" {
            include *
            include sch.subjectsBusiness.subjectValidator
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
        
        component sch.subjectsHtml "L3-Subjects-HTML" {
            include sch.subjectsBusiness.subjectCreator
            include sch.subjectsBusiness.subjectValidator
            autolayout lr 600 320 220
        }
        
        component sch.schedulingHtml "L3-Scheduling-HTML" {
            include sch.schedulingBusiness.schedulePlanner
            include sch.schedulingBusiness.scheduleValidator
            autolayout lr 600 320 220
        }
        
        component sch.scheduleHtml "L3-Schedule-HTML" {
            include sch.scheduleBusiness.scheduleViewer
            include sch.scheduleBusiness.scheduleUpdater
            include sch.scheduleBusiness.scheduleExporter
            include calendars
            autolayout lr 600 320 220
        }
        
        component sch.loginHtml "L3-Login-HTML" {
            include sch.authBusiness.userValidator
            include idp
            autolayout lr 600 320 220
        }
        
        component sch.reportHtml "L3-Report-HTML" {
            include sch.reportingBusiness.reportGenerator
            include sch.reportingBusiness.reportExporter
            autolayout lr 600 320 220
        }
        
        deployment sch "Development" {
            title "D1-Dev-Local"
            include *
            autolayout lr 800 480 280
        }
        
        deployment sch "Production" {
            title "D2-Production"
            include *
            autolayout lr 900 520 300
        }
        
        dynamic sch "F1-Student-ViewSchedule" {
            title "Zobrazení rozvrhu (Student)"
            
            student -> user "Is a"
            user    -> sch.scheduleHtml     "Open Schedule"
            
            user    -> sch.loginHtml        "If not signed in: Sign in"
            sch.loginHtml -> sch.authBusiness "Authenticate"
            
            sch.scheduleHtml -> sch.scheduleBusiness "Load timetable"
            sch.scheduleBusiness -> sch.dbSchedules  "Read"
            
            sch.scheduleHtml -> sch.scheduleBusiness "Render/refresh UI"
            
            autolayout lr 700 360 240
        }
        
        dynamic sch "F2-Student-Basket" {
            title "Košík (Student)"
            
            student -> user "Is a"
            user    -> sch.scheduleHtml       "Open Basket"
            
            user    -> sch.loginHtml          "If not signed in: Sign in"
            sch.loginHtml -> sch.authBusiness "Authenticate / check session"
            
            sch.scheduleHtml -> sch.scheduleBusiness "Load page"
            sch.scheduleBusiness -> sch.dbSchedules  "Read subjects + slots (projection)"
            
            user -> sch.scheduleHtml          "Select subjects"
            sch.scheduleHtml -> sch.scheduleBusiness "Add to basket"
            sch.scheduleBusiness -> sch.dbSchedules  "Write basket"
            
            sch.scheduleBusiness -> sch.schedulingBusiness "Check collisions"
            sch.schedulingBusiness -> sch.dbSchedules      "Read"
            sch.scheduleBusiness -> sch.schedulingBusiness "Request alternatives on conflict"
            
            sch.scheduleHtml -> sch.scheduleBusiness "Refresh timetable"
            
            autolayout lr 700 360 240
        }
        
        dynamic sch "F3-Teacher-Subjects" {
            title "Vypsání předmětu (Teacher)"
            
            teacher -> sch.subjectsHtml "Open Subject form"
            
            teacher -> user "Is a"
            user    -> sch.loginHtml        "If not signed in: Sign in"
            sch.loginHtml -> sch.authBusiness "Authenticate"
            
            sch.subjectsHtml -> sch.subjectsBusiness "Submit subject"
            
            sch.subjectsHtml -> sch.subjectsBusiness "Validate data"
            sch.subjectsBusiness -> sch.authorizer   "Authorize"
            
            autolayout lr 700 360 240
        }
        
        dynamic sch "F4-Teacher-ViewSchedule" {
            title "Zobrazení rozvrhu (Teacher)"
            
            teacher -> user "Is a"
            user    -> sch.scheduleHtml     "Open Schedule"
            
            user    -> sch.loginHtml        "If not signed in: Sign in"
            sch.loginHtml -> sch.authBusiness "Authenticate"
            
            sch.scheduleHtml -> sch.scheduleBusiness "Load timetable"
            sch.scheduleBusiness -> sch.dbSchedules  "Read"
            
            sch.scheduleHtml -> sch.scheduleBusiness "Render/refresh UI"
            
            autolayout lr 700 360 240
        }
        
        dynamic sch "F5-Teacher-Reqs" {
            title "Vypsání časových a prostorových požadavků (Teacher)"
            
            teacher -> sch.schedulingHtml            "Open requirements form"
            
            teacher -> user "Is a"
            user    -> sch.loginHtml                  "If not signed in: Sign in"
            sch.loginHtml -> sch.authBusiness         "Authenticate"
            
            sch.schedulingHtml -> sch.schedulingBusiness  "Load subject list"
            sch.schedulingBusiness -> sch.subjectsBusiness "Fetch teacher's subjects & policies"
            
            teacher -> sch.schedulingHtml                 "Enter time/day/length/frequency"
            sch.schedulingHtml -> sch.schedulingBusiness  "Submit time preferences"
            
            teacher -> sch.schedulingHtml                 "Enter room type & capacity"
            sch.schedulingHtml -> sch.schedulingBusiness  "Submit room requirements"
            
            teacher -> sch.schedulingHtml                 "Add special requirements"
            sch.schedulingHtml -> sch.schedulingBusiness  "Submit special requirements"
            
            sch.schedulingHtml -> sch.schedulingBusiness  "Validate availability & realism"
            sch.schedulingBusiness -> sch.subjectsBusiness "Policy checks"
            
            sch.schedulingHtml -> sch.schedulingBusiness  "Check collisions; request alternatives"
            
            sch.schedulingHtml -> sch.schedulingBusiness  "Confirm & submit"
            sch.schedulingBusiness -> sch.authorizer      "Authorize / record submission"
            committee -> sch.schedulingHtml               "Review submitted requirements"
            
            autolayout lr 700 360 240
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
            relationship "Is a" {
                color #F97316
                dashed false
                thickness 2
            }
        }
    }

    configuration {
        scope softwaresystem
    }
}
