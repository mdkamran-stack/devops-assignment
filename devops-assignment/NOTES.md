# Assessment notes

- **Task 1:** `prod-db-01` is protected with `prevent_destroy` because accidental deletion of a production database can cause downtime/data loss. This is not a backup or protection from out-of-band deletion.
- **Task 2:** Local state can diverge across users, be overwritten, or be lost; shared S3 state with versioning/encryption and DynamoDB locking supports team workflows.
- **Task 3:** `roleB` must be allowed to call `sts:AssumeRole` on roleC, and roleC must trust roleB. roleC access is scoped to one bucket. `roleA` excludes IAM actions but remains broad.
- **Task 4:** CI permissions are custom and resource-scoped where supported; no broad administrator policy is used.
- **Task 5:** Use a role ARN and scope S3 bucket/object resources rather than `s3:*` on `*`.
