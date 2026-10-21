# Task 3 — Multi-account IAM

Configure Account A and Account B profiles and IDs in `terraform.tfvars`. Account A contains the `engine`, `ci`, and `human-users` groups, their users, `roleA`, and `roleC`; Account B contains `roleB`. `roleB` has permission to assume `roleC`, and `roleC` trusts the exact roleB ARN and accesses only the configured S3 bucket.

`engine-bot` and `ci-bot` are programmatic-only in that no console login profiles are created. `developer1` and `operator1` are IAM users intended for console and CLI use; credentials are deliberately provisioned outside Terraform so passwords/access keys are not stored in state or this repository. Replace all example account IDs and bucket names. The broad `roleA` requirement is implemented as all actions except IAM actions; this is assessment-specific, not a general production recommendation.
