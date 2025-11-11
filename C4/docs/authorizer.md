## Authorizer

**Purpose**  
Provides a central authorisation decision point for backend services.

**Main responsibilities**
- Evaluate requested actions against role policies and contextual rules.
- Record authorisation outcomes for audit and monitoring.
- Deliver consistent allow/deny responses to callers.

**Collaborations**
- Invoked by `Subjects Business`, `Scheduling Business`, and `Reporting Business` before privileged changes.
- Relies on `Authentication Business` for verified identity and role information.
- Reads account roles and policy metadata from `Users DB`.

