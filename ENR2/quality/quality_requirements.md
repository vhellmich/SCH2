# Quality Requirements for Enrollments Module (ENR2)

## QR1 - Availability (External Dependency)
**Scenario:**
Student requests to Enroll -> Enrollments Module -> SIS Database.
* **Target dependency:** `Enrollments` -> `SIS` (External System Database)
* **Premise:** The `Enrollments` module reads directly from the external `SIS` database. If the main `SIS` goes down for maintenance or fails, the `Enrollments` module becomes unusable.
* **Requirement:** The Enrollments module must remain available for read-operations even if the core SIS is down.
* **Proposed Solution:** Implement simple module to cache necessary SIS data locally within the `EnrollmentDatabase`. If SIS is down, serve cached data to allow read-only access.
---

## QR2 - Availability (Single Point of Failure)
**Scenario:**
Data Center Failure (AWS Availability Zone goes down) -> Database Server.

* **Target dependency:** `EnrollmentsModule` -> `EnrollmentDatabaseInstance`
* **Premise:** The deployment diagram shows a single `EnrollmentDatabaseInstance` in the Production environment.
* **Requirement:** System must recover from a zone failure within a couple of minutes.
* **Verdict:** **Fails.** If the instance dies, manual intervention or long restart times occur.
* **Proposed Solution:** Deploy the MySQL database in **Multi-AZ** (Availability Zone) mode. If the primary instance fails, AWS automatically fails over to the standby instance.

---

## QR3 - Availability (Application Server Failure)
**Scenario:**
EC2 Instance Failure -> EnrollmentsModule & NotificationModule -> Student/Teacher requests.

* **Target dependency:** `UIPresenter` (client-side) -> `EnrollmentsModuleInstance` (on AWS EC2)
* **Premise:** The deployment diagram shows a single EC2 instance hosting both `EnrollmentsModuleInstance` and `NotifierInstance`. The client-side UIPresenter (running in browsers) depends on the server-side EnrollmentsModule for all enrollment operations. If this EC2 instance crashes, experiences hardware failure, or needs maintenance, the entire enrollment system becomes unavailable to all users, and notifications cannot be sent.
* **Requirement:** The system must remain available for enrollment operations even if the primary application server fails.
* **Verdict:** **Fails.** A single EC2 instance represents a single point of failure. If it goes down, manual intervention is required to restart or replace it, causing significant downtime for both enrollment operations and notifications.
* **Proposed Solution:** Deploy multiple EC2 instances behind a load balancer with auto-scaling. If one instance fails, traffic is automatically routed to healthy instances.

---

## QR4 - Performance (Enrollment Request Response Time)
**Scenario:**
Student requests to Enroll -> EnrollmentsModule -> Multiple database queries -> Response.

* **Target dependency:** `EnrollmentsModule` -> `EnrollmentDatabase` & `SIS`
* **Premise:** When a student enrolls in a course, the system must perform validation by querying both the `EnrollmentDatabase` (to check existing enrollments) and the external `SIS` database (to verify student eligibility and course prerequisites). These multiple database queries, combined with validation logic and logging operations, can result in slow response times, especially during peak enrollment periods when the database is under load.
* **Requirement:** Enrollment requests must complete and return a response to the user within 2 seconds under normal load conditions.
* **Verdict:** **May fail.** The current design performs multiple database queries to both `EnrollmentDatabase` and `SIS`, followed by write operations and logging. Under load, these operations may exceed the 2-second target, leading to poor user experience and potential timeouts. Performance should be monitored and optimized if response times exceed the target.
* **Proposed Solution:** Use parallel database queries where possible, add indexes on key fields (student ID, course ID), implement connection pooling, and cache frequently accessed SIS data. Use asynchronous logging to avoid blocking responses.

---

## QR5 - Availability (Archive System Failure)
**Scenario:**
Student enrolls -> EnrollmentsModule -> Logger -> Archive -> Logs operation.

* **Target dependency:** `EnrollmentsModule.logger` -> `EnrollmentDatabase.archive`
* **Premise:** The `Logger` component writes operation logs to the `Archive` component for permanent storage.
* **Requirement:** Enrollment operations must complete successfully even if the Archive system is temporarily unavailable. Logging failures should not prevent enrollments.
* **Verdict:** **May fail.** If logging to the Archive is synchronous and required, enrollment operations will fail when the Archive is unavailable.
* **Proposed Solution:** Make logging to the Archive asynchronous and non-blocking. Use a local log buffer to store logs temporarily. If the Archive is unavailable, keep logs in the buffer and retry writing to the Archive periodically until it recovers.

---

## QR6 - Performance (Statistical Query Response Time)
**Scenario:**
Admin queries enrollment statistics for multiple semesters -> StatisticsUI -> StatisticalModule -> Queries EnrollmentDatabase, Archive, and SIS -> Processes large datasets -> Generates graphs -> Response.

* **Target dependency:** `StatisticalModule` -> `EnrollmentDatabase`, `Archive`, and `SIS` (querying and processing large datasets)
* **Premise:** Statistical analysis queries large volumes of data from `EnrollmentDatabase`, `Archive`, and `SIS`, then processes the results and generates graphs. For multi-year datasets with thousands of enrollments, these operations can be slow if queries are not optimized or processed synchronously.
* **Requirement:** Statistical queries must return results within 10 seconds for datasets covering up to 2 years of enrollment data under normal load conditions.
* **Verdict:** **May fail.** Querying multiple large data sources (EnrollmentDatabase, Archive, SIS) synchronously, processing the results, and generating visualizations may exceed the 10-second target for multi-year datasets. The current design appears to perform these operations sequentially, which compounds latency.
* **Proposed Solution:**
  * Pre-compute common statistics in materialized views or analytics tables, updated as enrollments occur
  * Add database indexes on date ranges, student IDs, course IDs, and other frequently queried fields
  * Use parallel database queries for raw data requests

---