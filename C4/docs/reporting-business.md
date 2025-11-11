## Reporting Business

**Purpose**  
Produces management insights by aggregating scheduling and registration data.

**Main responsibilities**
- Collect, transform, and store report data for reuse and historical analysis.
- Prepare exportable artefacts for managers.

**Collaborations**
- Retrieves source data from `Schedules DB`.
- Persists computed insights within `Reports DB`.
- Serves `Report HTML` with datasets and export payloads.
- Consults the `Authorizer` to ensure only entitled roles access sensitive reports.

