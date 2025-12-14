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
