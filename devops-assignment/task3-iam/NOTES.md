# Task 3 security notes

- `engine` and `ci` users have no console login profiles created. No credentials are stored in Terraform.
- `developer1` and `operator1` are IAM users in `human-users`; provision console passwords and CLI access keys using an approved secure workflow.
- `roleA` uses `NotAction: iam:*` and `Resource: *` to meet the broad assessment requirement. This is intentionally powerful and should be tightened for production.
- Cross-account assumption requires both roleB's identity policy allowing `sts:AssumeRole` and roleC's trust policy trusting roleB.
- roleC's S3 policy separates bucket-level list actions from object-level actions and scopes both to one bucket.
- Tighten roleB's trust policy to exact trusted principals in production.
