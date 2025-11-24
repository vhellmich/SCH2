workspace "Schedules (SCH)" "Scheduling software system by team SCH2" {

    !identifiers hierarchical

    model {
        student = person "Student" "Views schedules; manages Basket."
        teacher = person "Teacher" "Creates and modifies subjects and schedules."
        committee = person "Scheduling Committee Member" "Validates subjects and schedules."
        manager = person "Manager" "Oversees schedules and reports; reviews analytics."
        user = person "SCH User" "Aggregated actor for shared web UX (Student/Teacher/Committee/Manager)."

        sch = softwareSystem "Schedules (SCH)" "Course management, scheduling, preferences, viewing, and reports." {
            !docs docs/schedules.md

            group "Subjects" {
                subjectsHtml = container "Subjects HTML" "Subjects UI in the browser." "HTML/JS" "HTML" {
                    subjectForm = component "Subject Form" "UI for creating and editing subjects."
                    validationUI = component "Validation UI" "UI for submitting and tracking subject validation."
                    !docs docs/subjects-html.md
                }
                subjectsBusiness = container "Subjects Business" "Create/modify subjects; request validation." "Business" {
                    subjectCreator = component "Subject Creator" "Creates and updates subject data and concepts."
                    subjectValidator = component "Subject Validator" "Runs subject validation workflow."
                    subjectRepository = component "Subject Repository" "CRUD for subjects and validation history."
                    
                    !docs docs/subjects-business.md
                    
                }
                subjectsBusinessMock = container "Subjects Business Mock" "Mock subjects business for testing." "Node.js/Express" "Mock API" {
                    mockSubjectData = component "Mock Subject Data" "In-memory static subject data."
                }
                subjectsHtmlMockBackend = container "Subjects HTML Mock Backend" "Mock backend with static data for development." "Node.js/Express" "Mock API" {
                    mockDataStore = component "Mock Data Store" "In-memory static data for subjects."
                }
            }

            group "Scheduling" {
                schedulingHtml = container "Scheduling HTML" "Scheduling UI in the browser." "HTML/JS" "HTML" {
                    planningUI = component "Planning UI" "UI for creating and adjusting schedule plans."
                    validationUI = component "Validation UI" "UI for validating scheduling constraints."
                    !docs docs/scheduling-html.md
                }
                schedulingBusiness = container "Scheduling Business" "Plan schedules." "Business" {
                    !docs docs/scheduling-business.md
                    schedulePlanner = component "Schedule Planner" "Creates and adjusts plans."
                    scheduleValidator = component "Schedule Validator" "Validates scheduling constraints."
                    schedulingRepository = component "Scheduling Repository" "CRUD for planning data and prefs."
                }
                schedulingMockBackend = container "Scheduling Mock Backend" "Mock backend with static data for development." "Node.js/Express" "Mock API" {
                    mockDataStore = component "Mock Data Store" "In-memory static data for scheduling."
                }
            }

            group "Schedules" {
                scheduleHtml = container "Schedule HTML" "Timetable/Basket UI in the browser." "HTML/JS" "HTML" {
                    timetableView = component "Timetable View" "UI for displaying and viewing schedules."
                    basketManager = component "Basket Manager" "UI for managing subject basket."
                    exportUI = component "Export UI" "UI for exporting schedules to various formats."
                    !docs docs/schedule-html.md
                }
                scheduleBusiness = container "Schedule Business" "Timetable view, basket, collisions." "Business" {
                    !docs docs/schedule-business.md
                    scheduleViewer = component "Schedule Viewer" "Read-only queries & projections for timetable/basket UI."
                    scheduleTransformer = component "Schedule Transformer" "Builds ScheduleSnapshot (canonical DTO)."
                    scheduleExporter = component "Schedule Exporter" "Renders ScheduleSnapshot to requested format (ics/pdf/csv)."
                    scheduleUpdater = component "Schedule Updater" "Applies timetable and basket changes."
                    scheduleRepository = component "Schedule Repository" "CRUD for schedules, basket, and preferences."
                }
                scheduleHtmlMockBackend = container "Schedule HTML Mock Backend" "Mock backend with static data for development." "Node.js/Express" "Mock API" {
                    mockDataStore = component "Mock Data Store" "In-memory static data for schedules."
                }
            }

            group "Authentication" {
                loginHtml = container "Login HTML" "Sign-in UI in the browser." "HTML/JS" "HTML" {
                    loginForm = component "Login Form" "UI for user authentication and sign-in."
                    !docs docs/login-html.md
                }
                authBusiness = container "Authentication Business" "Login logic." "Business" {
                    !docs docs/authentication-business.md
                    userValidator = component "User Validator" "Validates user identity and tokens."
                    sessionManager = component "Session Manager" "Manages sessions and tokens."
                    userRepository = component "User Repository" "CRUD for users and credentials."
                }
                loginHtmlMockBackend = container "Login HTML Mock Backend" "Mock backend with static data for development." "Node.js/Express" "Mock API" {
                    mockDataStore = component "Mock Data Store" "In-memory static data for authentication."
                }
            }

            group "Reporting" {
                reportHtml = container "Report HTML" "Reports UI in the browser." "HTML/JS" "HTML" {
                    analyticsDashboard = component "Analytics Dashboard" "UI for viewing analytics and statistics."
                    reportDownload = component "Report Download" "UI for downloading report files."
                    !docs docs/report-html.md
                }
                reportingBusiness = container "Reporting Business" "Generate and export reports." "Business" {
                    !docs docs/reporting-business.md
                    reportGenerator = component "Report Generator" "Computes statistics and analytics."
                    reportExporter = component "Report Exporter" "Generates downloadable report files."
                    reportRepository = component "Report Repository" "CRUD for reports and aggregates."
                }
                reportHtmlMockBackend = container "Report HTML Mock Backend" "Mock backend with static data for development." "Node.js/Express" "Mock API" {
                    mockDataStore = component "Mock Data Store" "In-memory static data for reports."
                }
            }

            group "Datastores" {
                dbSubjects = container "Subjects DB" "Subjects and validation history." "Relational DB" "Database" {
                    !docs docs/subjects-db.md
                }
                dbSchedules = container "Schedules DB" "Schedules, basket, preferences." "Relational DB" "Database" {
                    !docs docs/schedules-db.md
                }
                dbUsers = container "Users DB" "Users and credentials." "Relational DB" "Database" {
                    !docs docs/users-db.md
                }
                dbReports = container "Reports DB" "Reports and analytics data." "Relational DB" "Database" {
                    !docs docs/reports-db.md
                }
            }

            authorizer = container "Authorizer" {
                !docs docs/authorizer.md
            }
            authorizerMock = container "Authorizer Mock" "Mock authorizer for testing." "Node.js/Express" "Mock API" {
                mockAuthData = component "Mock Auth Data" "In-memory static auth data."
            }
            idpMockContainer = container "SSO Mock" "Mock OIDC provider for testing." "Node.js/Express" "Mock API" {
                mockOidcData = component "Mock OIDC Data" "In-memory static OIDC data."
            }
            notifMockContainer = container "Notification Mock" "Mock notification service for testing." "Node.js/Express" "Mock API" {
                mockNotifData = component "Mock Notification Data" "In-memory static notification data."
            }

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

            teacher -> sch.subjectsHtml.subjectForm "Course management; Management of schedule preferences"
            teacher -> sch.subjectsHtml.validationUI "Submit subjects for validation"
            manager -> sch.subjectsHtml.validationUI "Validate subjects"
            teacher -> sch.schedulingHtml.planningUI "Scheduling"
            teacher -> sch.schedulingHtml.validationUI "Validate schedules"
            committee -> sch.schedulingHtml.planningUI "Scheduling"
            committee -> sch.schedulingHtml.validationUI "Validate schedules"
            manager -> sch.reportHtml.analyticsDashboard "Review reports & analytics"
            manager -> sch.reportHtml.reportDownload "Download reports"
            
            user -> sch.loginHtml.loginForm "Sign in"
            user -> sch.scheduleHtml.timetableView "View timetable"
            user -> sch.scheduleHtml.basketManager "Manage basket"
            user -> sch.scheduleHtml.exportUI "Export schedules"

            subjectsHtml.subjectForm -> subjectsBusiness "Create/modify subjects"
            subjectsHtml.validationUI -> subjectsBusiness "Validate subjects"
            subjectsHtml -> subjectsHtmlMockBackend "Uses (mock)"
            schedulingHtml.planningUI -> schedulingBusiness "Plan schedules"
            schedulingHtml.validationUI -> schedulingBusiness "Validate schedules"
            schedulingHtml -> schedulingMockBackend "Uses (mock)"
            scheduleHtml.timetableView -> scheduleBusiness "Load timetable"
            scheduleHtml.basketManager -> scheduleBusiness "Modify basket"
            scheduleHtml.basketManager -> scheduleBusiness "Load basket"
            scheduleHtml.exportUI -> scheduleBusiness "Export (format param)"
            scheduleHtml -> scheduleHtmlMockBackend "Uses (mock)"
            loginHtml.loginForm -> authBusiness "Authenticate"
            loginHtml -> loginHtmlMockBackend "Uses (mock)"
            reportHtml.analyticsDashboard -> reportingBusiness "Request analytics"
            reportHtml.reportDownload -> reportingBusiness "Download reports"
            reportHtml -> reportHtmlMockBackend "Uses (mock)"
            
            schedulingBusiness -> subjectsBusiness "Read subject catalog; evaluate subject policies"
            schedulingBusiness -> subjectsBusinessMock "Read subject catalog (mock)"

            subjectsBusiness.subjectRepository -> dbSubjects "Read/Write"
            schedulingBusiness.schedulingRepository -> dbSchedules "Read/Write"
            scheduleBusiness.scheduleRepository -> dbSchedules "Read/Write"
            authBusiness.userRepository -> dbUsers "Read/Write"
            reportingBusiness.reportRepository -> dbReports "Read/Write"
            reportingBusiness.reportGenerator -> dbSchedules "Read"

            subjectsBusiness -> authorizer "Authorize"
            subjectsBusiness -> authorizerMock "Authorize (mock)"
            subjectsBusiness -> notifMockContainer "Send notifications (mock)"
            schedulingBusiness -> authorizer "Authorize"
            schedulingBusiness -> authorizerMock "Authorize (mock)"
            reportingBusiness -> authorizer "Authorize"
            reportingBusiness -> authorizerMock "Authorize (mock)"

            authorizer -> sch.dbUsers "Read/Write"

            subjectsBusiness.subjectCreator -> subjectsBusiness.subjectRepository "Read/Write"
            subjectsBusiness.subjectValidator -> subjectsBusiness.subjectRepository "Read/Write"

            schedulingBusiness.schedulePlanner -> schedulingBusiness.schedulingRepository "Read/Write"
            schedulingBusiness.scheduleValidator -> schedulingBusiness.schedulingRepository "Read"
            schedulingBusiness.scheduleValidator -> subjectsBusiness.subjectValidator "Subject invariants"
            schedulingBusiness.scheduleValidator -> subjectsBusinessMock "Subject invariants (mock)"

            scheduleBusiness.scheduleUpdater -> scheduleBusiness.scheduleRepository "Read/Write"
            scheduleBusiness.scheduleExporter -> scheduleBusiness.scheduleTransformer "Build snapshot"
            scheduleBusiness.scheduleViewer -> scheduleBusiness.scheduleRepository "Read"
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
        
        idpMock = softwareSystem "Mock SSO" "Mock OIDC provider for testing." "External"
        notifMock = softwareSystem "Mock Notification Service" "Mock notification service for testing." "External"

        sch -> idp "SSO/JWT"
        sch -> notif "Notify"

        sch.authBusiness.userValidator -> idp "OIDC/JWT validation"
        sch.authBusiness.userValidator -> sch.idpMockContainer "OIDC/JWT validation (mock)"
        sch.subjectsBusiness.subjectValidator -> notif "Send validation notifications"
        sch.subjectsBusiness.subjectValidator -> sch.notifMockContainer "Send validation notifications (mock)"
        calendars -> sch.scheduleBusiness.scheduleExporter "Fetch iCal"
        
        // --- Deployment model: Development ---
        deploymentEnvironment "Development" {
        
            // Client-side
            deploymentNode "Developer's Test Browser" "Developer's local web browser for testing" "Chrome/Firefox/Safari/Edge" {
                containerInstance sch.subjectsHtml
                containerInstance sch.schedulingHtml
                containerInstance sch.scheduleHtml
                containerInstance sch.loginHtml
                containerInstance sch.reportHtml
            }
        
            // Server-side
            deploymentNode "Company Local Development Environment" "Internal development infrastructure running locally" "Local/Docker" {
                deploymentNode "Development Application Server" "Backend services for testing" "Docker/.NET/Java/Python" {
                    containerInstance sch.subjectsBusiness
                    containerInstance sch.schedulingBusiness
                    containerInstance sch.scheduleBusiness
                    containerInstance sch.authBusiness
                    containerInstance sch.reportingBusiness
                    containerInstance sch.authorizer
                }
        
                deploymentNode "Development Test Database Server" "Local test databases with sample data" "PostgreSQL" {
                    containerInstance sch.dbSubjects
                    containerInstance sch.dbSchedules
                    containerInstance sch.dbUsers
                    containerInstance sch.dbReports
                }
                
                deploymentNode "Development Mock Services" "Local mock services for external dependencies" "Node.js/Express" {
                    containerInstance sch.idpMockContainer
                    containerInstance sch.notifMockContainer
                }
            }
        
            // Externals (test/mock)
            deploymentNode "External - Calendar Client" "Apple/Outlook/Thunderbird" "iCal Client" {
                softwareSystemInstance calendars
            }
        }
        
        // --- Deployment model: Production ---
        deploymentEnvironment "Production" {
        
            // Client-side
            deploymentNode "Client's Web Browser" "User's web browser" "Chrome/Firefox/Safari/Edge" {
                containerInstance sch.subjectsHtml
                containerInstance sch.schedulingHtml
                containerInstance sch.scheduleHtml
                containerInstance sch.loginHtml
                containerInstance sch.reportHtml
            }
        
            // Server-side
            deploymentNode "Production Infrastructure" "Production hosting environment" "Cloud" {
                deploymentNode "Production Application Server" "Backend services" "Kubernetes/.NET/Java/Python" {
                    containerInstance sch.subjectsBusiness
                    containerInstance sch.schedulingBusiness
                    containerInstance sch.scheduleBusiness
                    containerInstance sch.authBusiness
                    containerInstance sch.reportingBusiness
                    containerInstance sch.authorizer
                }
        
                deploymentNode "Production Database Server" "Managed database cluster" "PostgreSQL" {
                    containerInstance sch.dbSubjects
                    containerInstance sch.dbSchedules
                    containerInstance sch.dbUsers
                    containerInstance sch.dbReports
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
        
        // --- Deployment model: Development - Mock Backend ---
        deploymentEnvironment "Development - Mock" {
        
            deploymentNode "Dev Browser" "Developer's browser" "Chrome/Firefox/Safari" {
                containerInstance sch.schedulingHtml
            }
            
            deploymentNode "Dev Machine" "Developer machine" "Windows/macOS/Linux" {
                deploymentNode "Local Server" "Local development server" "Node.js" {
                    containerInstance sch.schedulingMockBackend
                }
            }
        }
        
        // --- Deployment model: Development - Subjects HTML Mock ---
        deploymentEnvironment "Development - Subjects HTML Mock" {
        
            deploymentNode "Dev Browser" "Developer's browser" "Chrome/Firefox/Safari" {
                containerInstance sch.subjectsHtml
            }
            
            deploymentNode "Dev Machine" "Developer machine" "Windows/macOS/Linux" {
                deploymentNode "Local Server" "Local development server" "Node.js" {
                    containerInstance sch.subjectsHtmlMockBackend
                }
            }
        }
        
        // --- Deployment model: Development - Schedule HTML Mock ---
        deploymentEnvironment "Development - Schedule HTML Mock" {
        
            deploymentNode "Dev Browser" "Developer's browser" "Chrome/Firefox/Safari" {
                containerInstance sch.scheduleHtml
            }
            
            deploymentNode "Dev Machine" "Developer machine" "Windows/macOS/Linux" {
                deploymentNode "Local Server" "Local development server" "Node.js" {
                    containerInstance sch.scheduleHtmlMockBackend
                }
            }
        }
        
        // --- Deployment model: Development - Login HTML Mock ---
        deploymentEnvironment "Development - Login HTML Mock" {
        
            deploymentNode "Dev Browser" "Developer's browser" "Chrome/Firefox/Safari" {
                containerInstance sch.loginHtml
            }
            
            deploymentNode "Dev Machine" "Developer machine" "Windows/macOS/Linux" {
                deploymentNode "Local Server" "Local development server" "Node.js" {
                    containerInstance sch.loginHtmlMockBackend
                }
            }
        }
        
        // --- Deployment model: Development - Report HTML Mock ---
        deploymentEnvironment "Development - Report HTML Mock" {
        
            deploymentNode "Dev Browser" "Developer's browser" "Chrome/Firefox/Safari" {
                containerInstance sch.reportHtml
            }
            
            deploymentNode "Dev Machine" "Developer machine" "Windows/macOS/Linux" {
                deploymentNode "Local Server" "Local development server" "Node.js" {
                    containerInstance sch.reportHtmlMockBackend
                }
            }
        }
        
        // --- Deployment model: Development - Schedule Business Testing ---
        deploymentEnvironment "Development - Schedule Business Test" {
        
            deploymentNode "Dev Machine" "Developer machine" "Windows/macOS/Linux" {
                deploymentNode "Local Application Server" "Local test server" ".NET/Java/Python" {
                    containerInstance sch.scheduleBusiness
                }
                
                deploymentNode "Local Test Database" "Local test database" "PostgreSQL/SQLite" {
                    containerInstance sch.dbSchedules
                }
            }
        }
        
        // --- Deployment model: Development - Subjects Business Testing ---
        deploymentEnvironment "Development - Subjects Business Test" {
        
            deploymentNode "Dev Machine" "Developer machine" "Windows/macOS/Linux" {
                deploymentNode "Local Application Server" "Local test server" ".NET/Java/Python" {
                    containerInstance sch.subjectsBusiness
                    containerInstance sch.authorizerMock
                }
                
                deploymentNode "Local Mock Services" "Local mock services" "Node.js/Express" {
                    containerInstance sch.notifMockContainer
                }
                
                deploymentNode "Local Test Database" "Local test database" "PostgreSQL/SQLite" {
                    containerInstance sch.dbSubjects
                }
            }
        }
        
        // --- Deployment model: Development - Scheduling Business Testing ---
        deploymentEnvironment "Development - Scheduling Business Test" {
        
            deploymentNode "Dev Machine" "Developer machine" "Windows/macOS/Linux" {
                deploymentNode "Local Application Server" "Local test server" ".NET/Java/Python" {
                    containerInstance sch.schedulingBusiness
                    containerInstance sch.subjectsBusinessMock
                    containerInstance sch.authorizerMock
                }
                
                deploymentNode "Local Test Database" "Local test database" "PostgreSQL/SQLite" {
                    containerInstance sch.dbSchedules
                }
            }
        }
        
        // --- Deployment model: Development - Auth Business Testing ---
        deploymentEnvironment "Development - Auth Business Test" {
        
            deploymentNode "Dev Machine" "Developer machine" "Windows/macOS/Linux" {
                deploymentNode "Local Application Server" "Local test server" ".NET/Java/Python" {
                    containerInstance sch.authBusiness
                }
                
                deploymentNode "Local Mock Services" "Local mock services" "Node.js/Express" {
                    containerInstance sch.idpMockContainer
                }
                
                deploymentNode "Local Test Database" "Local test database" "PostgreSQL/SQLite" {
                    containerInstance sch.dbUsers
                }
            }
        }
        
        // --- Deployment model: Development - Reporting Business Testing ---
        deploymentEnvironment "Development - Reporting Business Test" {
        
            deploymentNode "Dev Machine" "Developer machine" "Windows/macOS/Linux" {
                deploymentNode "Local Application Server" "Local test server" ".NET/Java/Python" {
                    containerInstance sch.reportingBusiness
                    containerInstance sch.authorizerMock
                }
                
                deploymentNode "Local Test Database" "Local test database" "PostgreSQL/SQLite" {
                    containerInstance sch.dbReports
                    containerInstance sch.dbSchedules
                }
            }
        }
    }

    views {
        systemContext sch "L1-SystemContext" {
            include *
            exclude sch.subjectsBusinessMock
            exclude sch.subjectsHtmlMockBackend
            exclude sch.schedulingMockBackend
            exclude sch.scheduleHtmlMockBackend
            exclude sch.loginHtmlMockBackend
            exclude sch.reportHtmlMockBackend
            exclude sch.authorizerMock
            exclude sch.idpMockContainer
            exclude sch.notifMockContainer
            exclude idpMock
            exclude notifMock
            autolayout lr 520 320 240
        }

        container sch "L2-Grouped" {
            include *
            include student
            include teacher
            include committee
            include manager
            exclude sch.subjectsBusinessMock
            exclude sch.subjectsHtmlMockBackend
            exclude sch.schedulingMockBackend
            exclude sch.scheduleHtmlMockBackend
            exclude sch.loginHtmlMockBackend
            exclude sch.reportHtmlMockBackend
            exclude sch.authorizerMock
            exclude sch.idpMockContainer
            exclude sch.notifMockContainer
            exclude idpMock
            exclude notifMock
            autolayout lr 650 340 260
        }

        component sch.subjectsBusiness "L3-Subjects" {
            include *
            include sch.subjectsHtml
            exclude sch.subjectsBusinessMock
            exclude sch.subjectsHtmlMockBackend
            exclude sch.authorizerMock
            exclude sch.notifMockContainer
            exclude notifMock
            autolayout lr 600 320 220
        }

        component sch.schedulingBusiness "L3-Scheduling" {
            include *
            include sch.subjectsBusiness.subjectValidator
            include sch.schedulingHtml
            exclude sch.schedulingMockBackend
            exclude sch.subjectsBusinessMock
            exclude sch.authorizerMock
            autolayout lr 600 320 220
        }

        component sch.scheduleBusiness "L3-Schedules" {
            include *
            include sch.scheduleHtml
            exclude sch.scheduleHtmlMockBackend
            autolayout lr 600 320 220
        }

        component sch.authBusiness "L3-Authentication" {
            include *
            include sch.loginHtml
            exclude sch.loginHtmlMockBackend
            exclude sch.idpMockContainer
            exclude idpMock
            autolayout lr 600 320 220
        }

        component sch.reportingBusiness "L3-Reporting" {
            include *
            include sch.reportHtml
            exclude sch.reportHtmlMockBackend
            exclude sch.authorizerMock
            autolayout lr 600 320 220
        }
        
        component sch.subjectsHtml "L3-Subjects-HTML" {
            include teacher
            include manager
            include sch.subjectsHtml.subjectForm
            include sch.subjectsHtml.validationUI
            include sch.subjectsBusiness
            exclude sch.subjectsHtmlMockBackend
            exclude sch.subjectsBusinessMock
            autolayout lr 600 320 220
        }
        
        component sch.schedulingHtml "L3-Scheduling-HTML" {
            include teacher
            include committee
            include sch.schedulingHtml.planningUI
            include sch.schedulingHtml.validationUI
            include sch.schedulingBusiness
            exclude sch.schedulingMockBackend
            autolayout lr 600 320 220
        }
        
        component sch.scheduleHtml "L3-Schedule-HTML" {
            include user
            include sch.scheduleHtml.timetableView
            include sch.scheduleHtml.basketManager
            include sch.scheduleHtml.exportUI
            include sch.scheduleBusiness
            include calendars
            exclude sch.scheduleHtmlMockBackend
            autolayout lr 600 320 220
        }
        
        component sch.loginHtml "L3-Login-HTML" {
            include user
            include sch.loginHtml.loginForm
            include sch.authBusiness
            include idp
            exclude sch.loginHtmlMockBackend
            exclude sch.idpMockContainer
            exclude idpMock
            autolayout lr 600 320 220
        }
        
        component sch.reportHtml "L3-Report-HTML" {
            include manager
            include sch.reportHtml.analyticsDashboard
            include sch.reportHtml.reportDownload
            include sch.reportingBusiness
            exclude sch.reportHtmlMockBackend
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
        
        deployment sch "Development - Mock" {
            title "D3a-Dev-Mock-Scheduling"
            include *
            autolayout lr 600 400 200
        }
        
        deployment sch "Development - Subjects HTML Mock" {
            title "D3b-Dev-Mock-Subjects-HTML"
            include *
            autolayout lr 600 400 200
        }
        
        deployment sch "Development - Schedule HTML Mock" {
            title "D3c-Dev-Mock-Schedule-HTML"
            include *
            autolayout lr 600 400 200
        }
        
        deployment sch "Development - Login HTML Mock" {
            title "D3d-Dev-Mock-Login-HTML"
            include *
            autolayout lr 600 400 200
        }
        
        deployment sch "Development - Report HTML Mock" {
            title "D3e-Dev-Mock-Report-HTML"
            include *
            autolayout lr 600 400 200
        }
        
        deployment sch "Development - Schedule Business Test" {
            title "D4-Dev-Schedule-Business-Test"
            include *
            autolayout lr 600 400 200
        }
        
        deployment sch "Development - Subjects Business Test" {
            title "D5-Dev-Subjects-Business-Test"
            include *
            autolayout lr 600 400 200
        }
        
        deployment sch "Development - Scheduling Business Test" {
            title "D6-Dev-Scheduling-Business-Test"
            include *
            autolayout lr 600 400 200
        }
        
        deployment sch "Development - Auth Business Test" {
            title "D7-Dev-Auth-Business-Test"
            include *
            autolayout lr 600 400 200
        }
        
        deployment sch "Development - Reporting Business Test" {
            title "D8-Dev-Reporting-Business-Test"
            include *
            autolayout lr 600 400 200
        }
        
        dynamic sch "F1-Student-ViewSchedule" {
            title "Zobrazení rozvrhu (Student)"
            
            student -> user "Is a"
            user -> sch.scheduleHtml "Open Schedule"
            
            user -> sch.loginHtml "If not signed in: Sign in"
            sch.loginHtml -> sch.authBusiness "Authenticate"
            
            sch.scheduleHtml -> sch.scheduleBusiness "Load timetable"
            sch.scheduleBusiness -> sch.dbSchedules "Read"
            
            sch.scheduleBusiness -> sch.scheduleHtml "Returns data"
            
            autolayout lr 700 360 240
        }
        
        dynamic sch "F2-Student-Basket" {
            title "Košík (Student)"
            
            student -> user "Is a"
            user -> sch.scheduleHtml "Open Basket"
            
            user -> sch.loginHtml "If not signed in: Sign in"
            sch.loginHtml -> sch.authBusiness "Authenticate / check session"
            
            sch.scheduleHtml -> sch.scheduleBusiness "Load page"
            sch.scheduleBusiness -> sch.dbSchedules "Read subjects + slots (projection)"
            
            user -> sch.scheduleHtml "Select subjects"
            sch.scheduleHtml -> sch.scheduleBusiness "Add to basket"
            sch.scheduleBusiness -> sch.dbSchedules "Write basket"
            
            sch.scheduleBusiness -> sch.schedulingBusiness "Check collisions"
            sch.schedulingBusiness -> sch.dbSchedules "Read"
            sch.scheduleBusiness -> sch.schedulingBusiness "Request alternatives on conflict"
            
            sch.scheduleHtml -> sch.scheduleBusiness "Refresh timetable"
            
            autolayout lr 700 360 240
        }
        
        dynamic sch "F3-Teacher-Subjects" {
            title "Vypsání předmětu (Teacher)"
            
            teacher -> sch.subjectsHtml "Open Subject form"
            
            teacher -> user "Is a"
            user -> sch.loginHtml "If not signed in: Sign in"
            sch.loginHtml -> sch.authBusiness "Authenticate"
            
            sch.subjectsHtml -> sch.subjectsBusiness "Submit subject"
            
            sch.subjectsHtml -> sch.subjectsBusiness "Validate data"
            sch.subjectsBusiness -> sch.authorizer "Authorize"

            sch.subjectsBusiness -> notif "Send validation notifications"
            
            autolayout lr 700 360 240
        }
        
        dynamic sch "F4-Teacher-ViewSchedule" {
            title "Zobrazení rozvrhu (Teacher)"
            
            teacher -> user "Is a"
            user -> sch.scheduleHtml "Open Schedule"
            
            user -> sch.loginHtml "If not signed in: Sign in"
            sch.loginHtml -> sch.authBusiness "Authenticate"
            
            sch.scheduleHtml -> sch.scheduleBusiness "Load timetable"
            sch.scheduleBusiness -> sch.dbSchedules "Read"
            
            sch.scheduleHtml -> sch.scheduleBusiness "Render/refresh UI"
            
            autolayout lr 700 360 240
        }
        
        dynamic sch "F5-Teacher-Reqs" {
            title "Vypsání časových a prostorových požadavků (Teacher)"
            
            teacher -> sch.schedulingHtml "Open requirements form"
            
            teacher -> user "Is a"
            user -> sch.loginHtml "If not signed in: Sign in"
            sch.loginHtml -> sch.authBusiness "Authenticate"
            
            sch.schedulingHtml -> sch.schedulingBusiness "Load subject list"
            sch.schedulingBusiness -> sch.subjectsBusiness "Fetch teacher's subjects & policies"
            sch.subjectsBusiness -> sch.dbSubjects "Read subjects" 

            teacher -> sch.schedulingHtml "Enter time/day/length/frequency"
            sch.schedulingHtml -> sch.schedulingBusiness "Submit time preferences"
            
            teacher -> sch.schedulingHtml "Enter room type & capacity"
            sch.schedulingHtml -> sch.schedulingBusiness "Submit room requirements"
            
            teacher -> sch.schedulingHtml "Add special requirements"
            sch.schedulingHtml -> sch.schedulingBusiness "Submit special requirements"
            
            sch.schedulingHtml -> sch.schedulingBusiness "Validate availability & realism"
            sch.schedulingBusiness -> sch.subjectsBusiness "Policy checks"
            
            sch.schedulingHtml -> sch.schedulingBusiness "Check collisions; request alternatives"
            
            sch.schedulingHtml -> sch.schedulingBusiness "Confirm & submit"
            sch.schedulingBusiness -> sch.authorizer "Authorize / record submission"
            committee -> sch.schedulingHtml "Review submitted requirements"
            
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
            element "Mock API" {
                shape roundedbox
                background #FCD34D
                color #1F2937
                stroke #FCD34D
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
