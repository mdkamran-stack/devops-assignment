# Task 2 — Remote state

Local state is risky for teams because users can have divergent copies, overwrite updates, lose state if a workstation fails, or run concurrent applies without shared locking. The bootstrap root creates an encrypted, versioned S3 bucket and DynamoDB lock table. Apply `bootstrap/` first, then copy `workload-example/backend.hcl.example` to `backend.hcl` and initialize the workload using `terraform init -backend-config=backend.hcl`. Keep the bootstrap state protected; do not destroy the backend while state still depends on it.
