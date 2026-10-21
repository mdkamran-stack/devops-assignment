# Task 1 notes

`prod-db-01` is protected with `lifecycle { prevent_destroy = true }` because it represents a production database and accidental deletion could cause downtime or data loss. Terraform lifecycle meta-arguments must be static, so the module separates this instance from the other four using filtered maps and two resource blocks. All five instances still come from the single `instances` input variable. This is not a backup and does not prevent deletion outside Terraform. Ensure the key pairs exist in the selected region and validate AWS IOPS/volume-size limits before applying.
