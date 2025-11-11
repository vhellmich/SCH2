## Scheduling Business

**Purpose**  
Handles planning logic, conflict checking, and storage of scheduling proposals.

**Main responsibilities**
- Create and adjust schedule plans based on user requirements.
- Validate schedules for collisions, capacity, and policy alignment.
- Store approved plans and keep historical context.

**Collaborations**
- Receives data from `Scheduling HTML` and returns validation feedback.
- Exchanges policy insights with `Subjects Business`.
- Provides collision checks to `Schedule Business`.
- Persists planning artefacts in `Schedules DB`.
- Consults the `Authorizer` before recording protected changes.

