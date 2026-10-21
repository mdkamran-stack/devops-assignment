# Task 5 — Debug trust and S3 permissions

A role ARN must use `arn:aws:iam::<account-id>:role/roleB`, not `...:user/roleB`. The broad policy `s3:*` with `Resource: *` is replaced with separate bucket-level and object-level permissions scoped to the required bucket.
