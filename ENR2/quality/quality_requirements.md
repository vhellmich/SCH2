# Quality Requirements for Enrollments Module (ENR2)

## QR1 - Availability (External Dependency)

**Scenario:**
Student requests to Enroll -> Enrollments Module -> SIS Database.

- **Target dependency:** `Enrollments` -> `SIS` (External System Database)
- **Premise:** The `Enrollments` module reads directly from the external `SIS` database. If the main `SIS` goes down for maintenance or fails, the `Enrollments` module becomes unusable.
- **Requirement:** The Enrollments module must remain available for read-only operations even if the core SIS is down for up to 24 hours. Read-only requests must be served using cached data with a response time of ≤ 500 ms for 95% of requests, and the system must switch to cached data within 100 ms after SIS unavailability is detected. Cached data must not be older than 24 hours.
- **Proposed Solution:** Implement simple module to cache necessary SIS data locally within the `EnrollmentDatabase`. If SIS is down, serve cached data to allow read-only access.

---

## QR2 - Availability (Single Point of Failure)

**Scenario:**
Data Center Failure (AWS Availability Zone goes down) -> Database Server.

- **Target dependency:** `EnrollmentsModule` -> `EnrollmentDatabaseInstance`
- **Premise:** The deployment diagram shows a single `EnrollmentDatabaseInstance` in the Production environment.
- **Requirement:** System must recover from a zone failure within 2 minutes, and must not lose more than 1 minute of committed data.
- **Verdict:** **Fails.** If the instance dies, manual intervention or long restart times occur.
- **Proposed Solution:** Deploy the MySQL database in **Multi-AZ** (Availability Zone) mode. If the primary instance fails, AWS automatically fails over to the standby instance.

---

## QR3 - Availability (Application Server Failure)

**Scenario:**
EC2 Instance Failure -> EnrollmentsModule & NotificationModule -> Student/Teacher requests.

- **Target dependency:** `UIPresenter` (client-side) -> `EnrollmentsModuleInstance` (on AWS EC2)
- **Premise:** The deployment diagram shows a single EC2 instance hosting both `EnrollmentsModuleInstance` and `NotifierInstance`. The client-side UIPresenter (running in browsers) depends on the server-side EnrollmentsModule for all enrollment operations. If this EC2 instance crashes, experiences hardware failure, or needs maintenance, the entire enrollment system becomes unavailable to all users, and notifications cannot be sent.
- **Requirement:** The system must remain available for enrollment operations even if the primary application server fails, with automatic failover within 1 minute.
- **Verdict:** **Fails.** A single EC2 instance represents a single point of failure. If it goes down, manual intervention is required to restart or replace it, causing significant downtime for both enrollment operations and notifications.
- **Proposed Solution:** Deploy multiple EC2 instances behind a load balancer with auto-scaling. If one instance fails, traffic is automatically routed to healthy instances.

---

## QR4 - Performance (Enrollment Request Response Time)

**Scenario:**
Student requests to Enroll -> EnrollmentsModule -> Multiple database queries -> Response.

- **Target dependency:** `EnrollmentsModule` -> `EnrollmentDatabase` & `SIS`
- **Premise:** When a student enrolls in a course, the system must perform validation by querying both the `EnrollmentDatabase` (to check existing enrollments) and the external `SIS` database (to verify student eligibility and course prerequisites). These multiple database queries, combined with validation logic and logging operations, can result in slow response times, especially during peak enrollment periods when the database is under load.
- **Requirement:** Enrollment requests must complete and return a response to the user within 2 seconds under normal load conditions (up to 100 concurrent enrollment requests).
- **Verdict:** **May fail.** The current design performs multiple database queries to both `EnrollmentDatabase` and `SIS`, followed by write operations and logging. Under load, these operations may exceed the 2-second target, leading to poor user experience and potential timeouts. Performance should be monitored and optimized if response times exceed the target.
- **Proposed Solution:** Use parallel database queries where possible, add indexes on key fields (student ID, course ID), implement connection pooling, and cache frequently accessed SIS data. Use asynchronous logging to avoid blocking responses.

---

## QR5 - Availability (Archive System Failure)

**Scenario:**
Student enrolls -> EnrollmentsModule -> Logger -> Archive -> Logs operation.

- **Target dependency:** `EnrollmentsModule.logger` -> `EnrollmentDatabase.archive`
- **Premise:** The `Logger` component writes operation logs to the `Archive` component for permanent storage.
- **Requirement:** Enrollment operations must complete successfully even if the Archive system is temporarily unavailable for up to 24 hours. Logging failures should not prevent enrollments.
- **Verdict:** **May fail.** If logging to the Archive is synchronous and required, enrollment operations will fail when the Archive is unavailable.
- **Proposed Solution:** Make logging to the Archive asynchronous and non-blocking. Use a local log buffer to store logs temporarily. If the Archive is unavailable, keep logs in the buffer and retry writing to the Archive periodically until it recovers.

---

## QR6 - Performance (Statistical Query Response Time)

**Scenario:**
Admin queries enrollment statistics for multiple semesters -> StatisticsUI -> StatisticalModule -> Queries EnrollmentDatabase, Archive, and SIS -> Processes large datasets -> Generates graphs -> Response.

- **Target dependency:** `StatisticalModule` -> `EnrollmentDatabase`, `Archive`, and `SIS` (querying and processing large datasets)
- **Premise:** Statistical analysis queries large volumes of data from `EnrollmentDatabase`, `Archive`, and `SIS`, then processes the results and generates graphs. For multi-year datasets with thousands of enrollments, these operations can be slow if queries are not optimized or processed synchronously.
- **Requirement:** Statistical queries must return results within 10 seconds for datasets covering up to 2 years of enrollment data under normal load conditions (up to 10 concurrent statistical queries).
- **Verdict:** **May fail.** Querying multiple large data sources (EnrollmentDatabase, Archive, SIS) synchronously, processing the results, and generating visualizations may exceed the 10-second target for multi-year datasets. The current design appears to perform these operations sequentially, which compounds latency.
- **Proposed Solution:**
  - Pre-compute common statistics in materialized views or analytics tables, updated as enrollments occur
  - Add database indexes on date ranges, student IDs, course IDs, and other frequently queried fields
  - Use parallel database queries for raw data requests

---

## QR7 - Security (Unauthorized Enrollment Access)

**Scenario:** Malicious user attempts to enroll in courses on behalf of another student -> `EnrollmentsModule` -> `EnrollmentsTable`.

- **Target dependency:** `UIPresenter` -> `EnrollmentsModule` (`RequestInterface`)
- **Premise:** The `EnrollmentsModule` exposes enrollment API (`RequestInterface`) that presumably accept student identifiers. If authorization checks are weak or missing, a user could manipulate request parameters to enroll or drop courses for another student.
- **Requirement:** Only authenticated users may perform enrollment actions, and users may only enroll or modify enrollments for their own student account unless explicitly authorized (e.g., admin role).
- **Verdict:** **May fail.** The design shows no authentication at all. Not on the UI level, nor is there an explicit mention of server-side authorization checks within the `EnrollmentsModule`.
- **Proposed Solution:**
  - Enforce role-based access control (RBAC) in the `EnrollmentsModule`
  - Validate that the authenticated user’s identity matches the target student ID
  - Reject any enrollment requests that violate authorization rules

---

## QR8 - Testability (Deterministic Validation & Sandbox)

**Scenario:**
A QA Engineer or automated script verifies complex business rules (e.g., prerequisites, credit limits) without affecting production data or depending on external SIS availability.

- **Target dependency:** `EnrollmentsModule.validation` -> `EnrollmentsModule.data_manager`
- **Premise:** Validation logic is currently tightly coupled with database reads and the external SIS state. This makes tests slow, flaky (unreliable due to external factors), and requires complex data seeding/cleanup for every test case.
- **Requirement:** The `Validation` component must be testable in complete isolation via a dedicated `Sandbox API`. 100% of business rules must be verifiable using simulated input states without triggering any database writes or network calls to SIS. The validation response in the sandbox must return within 200 ms.
- **Verdict:** **Fails.** Current design implies direct DB dependency in the validation logic.
- **Proposed Solution:**
  - **Dependency Inversion:** Inject a `DataAccessor` interface into the validator so it can be swapped for a `MockDataManager` during testing.
  - **Pure Functions:** Refactor validation logic to be stateless (Input: Data + Rule -> Output: Result).
  - **Sandbox Endpoint:** Expose `POST /api/test/validate` which accepts a "Simulated Student State" payload along with the request.

---

## QR9 - Modifiability (Decoupling Notification Providers)

**Scenario:**
The university decides to switch from Email notifications to a Push Notification service (e.g., Firebase) or add a Slack integration for teachers.

- **Target dependency:** `NotificationModule.alert_dispatcher` -> `NotificationModule.email_sender`
- **Premise:** The `NotificationModule` currently depends directly on the `Email Sender`. Adding a new channel (e.g., SMS, Slack) would require modifying the core `Alert Dispatcher` logic and potentially redeploying the main `EnrollmentsModule`.
- **Requirement:** Adding a new notification channel must be possible by adding a new class/component without modifying or recompiling the `EnrollmentsModule` or the `Alert Dispatcher`.
- **Verdict:** **May fail.** The current design explicitly models `Email sender` as a fixed component.
- **Proposed Solution:** Implement the Strategy Pattern. Define a generic `INotificationChannel` interface. The `Alert Dispatcher` iterates through a list of registered providers. Configuration (not code) determines which channels are active.

---

## QR10 - Testability (Observability for Batch Processing)

**Scenario:**
A teacher submits a batch enrollment for 50 students. 47 succeed, but 3 fail. The developer needs to diagnose why specific students failed.

- **Target dependency:** `EnrollmentsModule.batch` -> `EnrollmentsModule.logger`
- **Premise:** Batch processing is often opaque ("black box"). Without detailed tracing, finding the root cause for a specific item failure within a large transaction is time-consuming and difficult to reproduce.
- **Requirement:** The system must support a "Dry-Run" mode that simulates processing and returns predicted results without modifying data. In production, logs must allow tracing the lifecycle of a single student's request within a batch of 100+ items within 1 minute of log analysis.
- **Verdict:** **Fails.** Current logging is generic and likely aggregates results.
- **Proposed Solution:**
  - **Correlation IDs:** Generate a unique `BatchID` for the group and a `RequestID` for each student item. Pass these IDs to the Logger.
  - **Structured Logging:** Ensure the Logger outputs structured data (JSON) containing input state, validation result, and error codes for every individual item, not just the batch summary.

---

## QR11 - Modifiability (Pluggable Statistical Visualizations)

**Scenario:**
The Admin wants to visualize enrollment trends using a new chart type (e.g., "Heatmap") that is not currently supported by the UI.

- **Target dependency:** `StatisticsUI.VisualizationEngine` (internals)
- **Premise:** Currently, the `StatisticalEngine` (Backend) might be formatting data specifically for existing charts (e.g., formatting dates for a Line Chart). Adding a new chart type would require changes in both the Backend (Python/Lambda) and Frontend (JS).
- **Requirement:** The `VisualizationEngine` must allow adding new graph types by modifying only the Frontend configuration. The Backend must remain data-agnostic. A new visualization must be deployable without touching the AWS Lambda `StatisticalEngine`.
- **Verdict:** **May fail.** Depends on API design, but often backends are coupled to frontend views.
- **Proposed Solution:**
  - **Data Agnosticism:** The Backend returns raw "Tidy Data" (arrays of objects), not pre-formatted chart data.
  - **Adapter Pattern:** The Frontend `VisualizationEngine` acts as a Registry. New charts are added as plugins with an "Adapter" that maps the raw data columns to the specific chart library's requirements (e.g., x-axis, y-axis, color).

---

## QR12 - Testability (Integration Testing with SIS)

**Scenario:**
The core SIS team deploys a new version of their database or API. A field name changes (e.g., `student_id` becomes `matriculation_number`), breaking the Enrollments module.

- **Target dependency:** `EnrollmentsModule.data_manager` -> `SIS`
- **Premise:** The Enrollments module relies on the external SIS schema. Enrollments team has no control over SIS release cycles. Breaking changes in SIS are often discovered only after they cause runtime errors in Production.
- **Requirement:** Incompatibilities between the Enrollments Module and SIS must be detected automatically during the CI/CD build process, preventing deployment if the contract is broken.
- **Verdict:** **Fails.** No automated contract verification is defined.
- **Proposed Solution:** Implement Consumer-Driven Contract (CDC) Testing (e.g., using Pact). The Enrollments team defines a "Contract" (expected schema/behavior). This contract is verified against the SIS staging environment (or a SIS mock provided by the SIS team) before every deployment.
