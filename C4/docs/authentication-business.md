## Authentication Business

**Purpose**  
Owns authentication flows, session management, and integration with enterprise identity services.

**Main responsibilities**
- Verify user credentials or federated assertions and issue application sessions.
- Maintain account status, security policies, and expiry rules within the system of record.

**Collaborations**
- Receives sign-in requests from `Login HTML` and returns outcomes or challenges.
- Persists user and session data through `Users DB`.
- Validates identity assertions with `University SSO`.

