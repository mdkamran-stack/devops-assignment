# Task 4 — CI least-privilege policy

The custom policy avoids `AdministratorAccess`. It permits ECR authentication and push to one repository, ECS deployment operations, `iam:PassRole` only for specified ECS task roles, and read-only access to one artifact bucket. Replace sample account IDs/ARNs and test the exact actions needed by your pipeline.
