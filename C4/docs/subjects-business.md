## Subjects Business

**Purpose**  
Manages the lifecycle of subjects, from initial creation to validation and publication.

**Main responsibilities**
- Create and update subject records.
- Check subject data before it moves forward.
- Keep the history of changes and approvals.
- Notify managers or teachers about subject status changes.

**Collaborations**
- Coordinates with `Subjects HTML` to process user-initiated changes.
- Persists subject records through `Subjects DB`.
- Shares policy constraints with `Scheduling Business`.
- Consults the `Authorizer` before committing protected changes.
- Sends validation updates to `Notification Service`.

